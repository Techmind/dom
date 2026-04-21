#!/usr/bin/env python3
"""
Generate a Dominions 6 .map + .tga debug map.

Defaults:
- generated_ring_grid.map
- generated_ring_grid.tga

Layout rules:
- configurable player count
- each player gets a 4x4 block
- inside each 4x4 block, coordinates are row-major in image space:
    row 0: p1_0_0 p1_1_0 p1_2_0 p1_3_0
    row 1: p1_0_1 p1_1_1 p1_2_1 p1_3_1
    row 2: p1_0_2 p1_1_2 p1_2_2 p1_3_2
    row 3: p1_0_3 p1_1_3 p1_2_3 p1_3_3
- start province is inside the 2x2 center
- west-east player ring wrap:
  right edge of player N connects to left edge of player N+1
- internal neighbours are 4-directional by default
- output image is a debug TGA with flat colors
- per-block role layout is slightly randomized
- start and thrones are never neighbours (including diagonals)
- 1 sea province is included in each 4x4 block
- colors are by province TYPE/role, not by player

Important:
- #imagefile is written WITHOUT quotes
- province names are written with #landname for debugging
- province IDs are assigned in image-scan order matching the observed
  Dominions behavior: bottom-to-top, right-to-left
"""

import argparse
import math
import random
import struct
from dataclasses import dataclass

# -----------------------------
# Dominions terrain bitmasks
# -----------------------------
SMALL = 1
LARGE = 2
SEA = 4
FRESHWATER = 8
SWAMP = 32
WASTE = 64
FARM = 256
CAVE = 4096
HOLY_SITE = 4194304
MOUNTAIN = 8388608
GOOD_THRONE = 33554432
GOOD_START = 67108864

# -----------------------------
# Layout constants
# -----------------------------
BLOCK = 4

CELL_W = 56
CELL_H = 56
INTRA_GAP = 6

BLOCK_GAP_X = 72
BLOCK_GAP_Y = 72
MARGIN = 30

MAP_TITLE = "Generated Ring Grid"

ROLE_COLORS = {
    "plain": (120, 170, 90),
    "farm": (190, 190, 70),
    "mountain": (120, 120, 120),
    "cave": (90, 70, 60),
    "swamp": (60, 110, 80),
    "waste": (170, 130, 80),
    "sea": (70, 120, 200),
    "start": (60, 180, 220),
    "throne": (180, 80, 180),
    "holy": (220, 220, 220),
}


@dataclass
class Province:
    pid: int
    player: int
    x: int
    y: int
    left: int
    top: int
    right: int
    bottom: int
    role: str
    terrain: int

    @property
    def name(self) -> str:
        return f"p{self.player}_{self.x}_{self.y}"


def sanitize_imagefile_name(imagefile: str) -> str:
    imagefile = imagefile.strip().strip('"').strip("'")
    if " " in imagefile:
        raise ValueError("Dominions map filenames should not contain spaces.")
    return imagefile


def tga_write(path: str, width: int, height: int, pixels: list[list[tuple[int, int, int]]]) -> None:
    """Write uncompressed 24-bit TGA."""
    with open(path, "wb") as f:
        header = struct.pack(
            "<BBBHHBHHHHBB",
            0,   # id length
            0,   # color map type
            2,   # image type = uncompressed true-color
            0, 0, 0,  # color map spec
            0, 0,     # x/y origin
            width,
            height,
            24,  # pixel depth
            0,   # image descriptor
        )
        f.write(header)

        # TGA pixel rows are written bottom-up
        for y in range(height - 1, -1, -1):
            row = pixels[y]
            for x in range(width):
                r, g, b = row[x]
                f.write(bytes((b, g, r)))


def choose_macro_cols(players: int, macro_cols: int | None) -> int:
    if macro_cols is not None and macro_cols > 0:
        return macro_cols
    return max(1, math.ceil(math.sqrt(players)))


def is_neighbour(a: tuple[int, int], b: tuple[int, int]) -> bool:
    """Chebyshev adjacency: includes diagonals."""
    return max(abs(a[0] - b[0]), abs(a[1] - b[1])) <= 1


def choose_non_neighbour_cells(
    candidates: list[tuple[int, int]],
    forbidden: tuple[int, int],
    count: int,
    rng: random.Random,
) -> list[tuple[int, int]]:
    pool = [c for c in candidates if not is_neighbour(c, forbidden)]
    rng.shuffle(pool)
    if len(pool) < count:
        raise ValueError("Not enough non-neighbour cells available.")
    return pool[:count]


def random_role_layout(rng: random.Random) -> dict[tuple[int, int], tuple[str, int]]:
    """
    Slightly random per 4x4 block.

    Guarantees:
    - 1 start in center 2x2
    - 2 throne provinces
    - start is NOT adjacent to either throne
    - 1 holy province
    - 2 farms
    - 2 mountain provinces (one large)
    - 1 cave
    - 1 swamp
    - 1 waste
    - 1 sea
    - 1 additional large plain
    - at least 1 explicit small plain
    - everything else defaults to small plain
    """
    all_cells = [(x, y) for y in range(BLOCK) for x in range(BLOCK)]
    center_2x2 = [(1, 1), (2, 1), (1, 2), (2, 2)]

    start_cell = rng.choice(center_2x2)

    throne_cells = choose_non_neighbour_cells(
        [c for c in all_cells if c != start_cell],
        forbidden=start_cell,
        count=2,
        rng=rng,
    )

    used = {start_cell, *throne_cells}

    def pick_one(cands: list[tuple[int, int]]) -> tuple[int, int]:
        pool = [c for c in cands if c not in used]
        if not pool:
            raise ValueError("No free cells left for role placement.")
        cell = rng.choice(pool)
        used.add(cell)
        return cell

    def pick_many(cands: list[tuple[int, int]], n: int) -> list[tuple[int, int]]:
        pool = [c for c in cands if c not in used]
        if len(pool) < n:
            raise ValueError("Not enough free cells left for role placement.")
        picks = rng.sample(pool, n)
        used.update(picks)
        return picks

    layout: dict[tuple[int, int], tuple[str, int]] = {}

    layout[start_cell] = ("start", SMALL | GOOD_START)
    for cell in throne_cells:
        layout[cell] = ("throne", SMALL | GOOD_THRONE)

    # Holy: prefer center-ish, but any free cell is fine
    holy_pref = [(1, 1), (2, 1), (1, 2), (2, 2), (1, 0), (2, 0), (1, 3), (2, 3)]
    holy_cell = pick_one(holy_pref + all_cells)
    layout[holy_cell] = ("holy", SMALL | HOLY_SITE)

    # 2 farms: prefer outer rows
    farm_pref = [(0, 0), (1, 0), (2, 0), (3, 0), (0, 3), (1, 3), (2, 3), (3, 3)]
    for cell in pick_many(farm_pref + all_cells, 2):
        layout[cell] = ("farm", SMALL | FARM)

    # 2 mountains: prefer edges; one is large
    mountain_pref = [(3, 0), (3, 1), (3, 2), (3, 3), (0, 0), (0, 1), (0, 2), (0, 3)]
    mountain_cells = pick_many(mountain_pref + all_cells, 2)
    layout[mountain_cells[0]] = ("mountain", SMALL | MOUNTAIN)
    layout[mountain_cells[1]] = ("mountain", LARGE | MOUNTAIN)

    # Cave / swamp / waste / sea: prefer edges
    edge_pref = [(0, 1), (0, 2), (3, 1), (3, 2), (1, 0), (2, 0), (1, 3), (2, 3)]
    cave_cell = pick_one(edge_pref + all_cells)
    layout[cave_cell] = ("cave", SMALL | CAVE)

    swamp_cell = pick_one(edge_pref + all_cells)
    layout[swamp_cell] = ("swamp", SMALL | SWAMP)

    waste_cell = pick_one(edge_pref + all_cells)
    layout[waste_cell] = ("waste", SMALL | WASTE)

    sea_cell = pick_one(edge_pref + all_cells)
    layout[sea_cell] = ("sea", SMALL | SEA)

    # 1 additional large plain
    large_plain_cell = pick_one(all_cells)
    layout[large_plain_cell] = ("plain", LARGE)

    # 1 guaranteed explicit small plain
    plain_cell = pick_one(all_cells)
    layout[plain_cell] = ("plain", SMALL)

    return layout


def build_provinces(players: int, macro_cols: int, seed: int) -> list[Province]:
    provinces: list[Province] = []
    master_rng = random.Random(seed)

    for player_index in range(players):
        player = player_index + 1
        block_col = player_index % macro_cols
        block_row = player_index // macro_cols

        block_left = MARGIN + block_col * (BLOCK * (CELL_W + INTRA_GAP) + BLOCK_GAP_X)
        block_top = MARGIN + block_row * (BLOCK * (CELL_H + INTRA_GAP) + BLOCK_GAP_Y)

        block_rng = random.Random(master_rng.randint(0, 10**9))
        roles = random_role_layout(block_rng)

        for y in range(BLOCK):
            for x in range(BLOCK):
                # IMPORTANT: row-major image layout, no Y flip
                left = block_left + x * (CELL_W + INTRA_GAP)
                top = block_top + y * (CELL_H + INTRA_GAP)
                right = left + CELL_W
                bottom = top + CELL_H

                role, terrain = roles.get((x, y), ("plain", SMALL))

                provinces.append(
                    Province(
                        pid=0,  # assigned later in observed image scan order
                        player=player,
                        x=x,
                        y=y,
                        left=left,
                        top=top,
                        right=right,
                        bottom=bottom,
                        role=role,
                        terrain=terrain,
                    )
                )

    return provinces


def assign_ids_by_image_scan(provinces: list[Province]) -> list[Province]:
    """
    Match the observed Dominions behavior:
    provinces numbered from bottom row upward,
    and within a row from right to left.
    """
    sorted_provs = sorted(provinces, key=lambda p: (-p.top, p.left))
    for i, p in enumerate(sorted_provs, start=1):
        p.pid = i
    return sorted_provs


def build_neighbours(
    provinces: list[Province],
    players: int,
    diagonal_neighbours: bool = False
) -> list[tuple[int, int]]:
    by_player: dict[int, dict[tuple[int, int], int]] = {}
    for p in provinces:
        by_player.setdefault(p.player, {})
        by_player[p.player][(p.x, p.y)] = p.pid

    if diagonal_neighbours:
        dirs = [
            (-1, 0), (1, 0), (0, -1), (0, 1),
            (-1, -1), (-1, 1), (1, -1), (1, 1),
        ]
    else:
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    neighbour_pairs: set[tuple[int, int]] = set()

    # Internal neighbours inside each 4x4 block
    for player in range(1, players + 1):
        for y in range(BLOCK):
            for x in range(BLOCK):
                a = by_player[player][(x, y)]
                for dx, dy in dirs:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < BLOCK and 0 <= ny < BLOCK:
                        b = by_player[player][(nx, ny)]
                        neighbour_pairs.add(tuple(sorted((a, b))))

    # Player ring wrap: right edge of player N to left edge of player N+1
    for player in range(1, players + 1):
        other = player + 1
        if other > players:
            other = 1
        for y in range(BLOCK):
            a = by_player[player][(3, y)]
            b = by_player[other][(0, y)]
            neighbour_pairs.add(tuple(sorted((a, b))))

    return sorted(neighbour_pairs)


def write_map(
    path: str,
    imagefile: str,
    provinces: list[Province],
    neighbours: list[tuple[int, int]],
    width: int,
    height: int
) -> None:
    imagefile = sanitize_imagefile_name(imagefile)

    with open(path, "w", encoding="utf-8") as f:
        f.write(f'#dom2title "{MAP_TITLE}"\n')
        f.write(f"#imagefile {imagefile}\n")
        f.write(f"#mapsize {width} {height}\n")
        f.write("#domversion 600\n")
        f.write('\n')
        f.write('#description "Generated 4x4-per-player ring grid debug map."\n')
        f.write("\n")

        for p in provinces:
            f.write(f"#terrain {p.pid} {p.terrain}\n")

        f.write("\n")

        for p in provinces:
            f.write(f'#landname {p.pid} "{p.name}"\n')

        f.write("\n")

        for p in provinces:
            if p.role == "start":
                f.write(f"#start {p.pid}\n")

        f.write("\n")

        for a, b in neighbours:
            f.write(f"#neighbour {a} {b}\n")


def draw_debug_tga(path: str, provinces: list[Province]) -> tuple[int, int]:
    width = max(p.right for p in provinces) + MARGIN
    height = max(p.bottom for p in provinces) + MARGIN

    pixels: list[list[tuple[int, int, int]]] = [
        [(0, 0, 0) for _ in range(width)]
        for _ in range(height)
    ]

    for p in provinces:
        fill = ROLE_COLORS.get(p.role, ROLE_COLORS["plain"])

        for yy in range(p.top, p.bottom):
            row = pixels[yy]
            for xx in range(p.left, p.right):
                row[xx] = fill

        # black border
        for xx in range(p.left, p.right):
            pixels[p.top][xx] = (0, 0, 0)
            pixels[p.bottom - 1][xx] = (0, 0, 0)

        for yy in range(p.top, p.bottom):
            pixels[yy][p.left] = (0, 0, 0)
            pixels[yy][p.right - 1] = (0, 0, 0)

        # large province inset border
        if p.terrain & LARGE:
            inset = 5
            if p.left + inset < p.right - inset and p.top + inset < p.bottom - inset:
                for xx in range(p.left + inset, p.right - inset):
                    pixels[p.top + inset][xx] = (20, 20, 20)
                    pixels[p.bottom - inset - 1][xx] = (20, 20, 20)
                for yy in range(p.top + inset, p.bottom - inset):
                    pixels[yy][p.left + inset] = (20, 20, 20)
                    pixels[yy][p.right - inset - 1] = (20, 20, 20)

        # one pure-white province center pixel only
        cx = (p.left + p.right) // 2
        cy = (p.top + p.bottom) // 2
        pixels[cy][cx] = (255, 255, 255)

        # optional tiny non-white marker accents
        if p.role == "start":
            for dx in (-1, 1):
                if 0 <= cx + dx < width:
                    pixels[cy][cx + dx] = (0, 255, 255)
            for dy in (-1, 1):
                if 0 <= cy + dy < height:
                    pixels[cy + dy][cx] = (0, 255, 255)

        elif p.role == "throne":
            for dx, dy in [(-1, -1), (-1, 1), (1, -1), (1, 1)]:
                if 0 <= cx + dx < width and 0 <= cy + dy < height:
                    pixels[cy + dy][cx + dx] = (255, 0, 255)

        elif p.role == "holy":
            if cy - 1 >= 0:
                pixels[cy - 1][cx] = (255, 255, 180)
            if cy + 1 < height:
                pixels[cy + 1][cx] = (255, 255, 180)

        elif p.role == "sea":
            # tiny darker blue cross so sea is easy to spot in debug image
            dark = (30, 70, 150)
            if cx - 1 >= 0:
                pixels[cy][cx - 1] = dark
            if cx + 1 < width:
                pixels[cy][cx + 1] = dark
            if cy - 1 >= 0:
                pixels[cy - 1][cx] = dark
            if cy + 1 < height:
                pixels[cy + 1][cx] = dark

    tga_write(path, width, height, pixels)
    return width, height


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--players", type=int, default=6, help="Number of players / 4x4 blocks.")
    parser.add_argument("--macro-cols", type=int, default=None, help="How many player blocks per row. Default: auto.")
    parser.add_argument("--seed", type=int, default=12345, help="Random seed for per-block role layout.")
    parser.add_argument("--diagonal-neighbours", action="store_true", help="Use 8-direction internal neighbours instead of 4-direction.")
    parser.add_argument("--output-map", default="generated_ring_grid.map")
    parser.add_argument("--output-tga", default="generated_ring_grid.tga")
    parser.add_argument("--imagefile", default="generated_ring_grid.tga", help="Filename written into #imagefile, no quotes.")
    return parser.parse_args()
    
def write_debug_mapping(path: str, provinces: list[Province]) -> None:
    with open(path, "w", encoding="utf-8") as f:
        for p in sorted(provinces, key=lambda q: q.pid):
            cx = (p.left + p.right) // 2
            cy = (p.top + p.bottom) // 2
            f.write(
                f"{p.pid}\t{p.name}\trole={p.role}\tterrain={p.terrain}\tcx={cx}\tcy={cy}\n"
            )    


def main() -> None:
    args = parse_args()

    if args.players < 1:
        raise ValueError("--players must be at least 1")

    macro_cols = choose_macro_cols(args.players, args.macro_cols)
    provinces = build_provinces(args.players, macro_cols, args.seed)
    provinces = assign_ids_by_image_scan(provinces)
    neighbours = build_neighbours(
        provinces,
        args.players,
        diagonal_neighbours=args.diagonal_neighbours,
    )
    width, height = draw_debug_tga(args.output_tga, provinces)
    write_map(args.output_map, args.imagefile, provinces, neighbours, width, height)
    write_debug_mapping("generated_ring_grid_debug.txt", provinces)

    print(f"Generated: {args.output_map}")
    print(f"Generated: {args.output_tga}")


if __name__ == "__main__":
    main()
