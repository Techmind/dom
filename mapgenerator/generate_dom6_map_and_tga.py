#!/usr/bin/env python3
"""
Generate a Dominions 6 .map + .tga map using external terrain sprites.

Defaults:
- generated_ring_grid.map
- generated_ring_grid.tga

Sprite pack expected in current directory (or pass custom paths):
- plain_small.png
- plain_large.png
- forest_small.png
- forest_large.png
- mountain_small.png
- mountain_large.png
- swamp_small.png
- swamp_large.png
- waste_small.png
- waste_large.png
- farm_small.png
- farm_large.png
- cave_small.png
- cave_large.png
- sea_small.png
- start_ring_overlay.png

Rules:
- configurable player count
- each player gets a 4x4 block
- row-major inside block:
    row 0: p1_0_0 p1_1_0 p1_2_0 p1_3_0
    row 1: p1_0_1 p1_1_1 p1_2_1 p1_3_1
    row 2: p1_0_2 p1_1_2 p1_2_2 p1_3_2
    row 3: p1_0_3 p1_1_3 p1_2_3 p1_3_3
- role layout is slightly randomized per block
- start is in center 2x2
- start and thrones are not neighbours
- includes:
    2 farms
    2 forests
    2 mountains (one large)
    1 cave
    1 swamp
    1 waste
    1 sea
    1 holy
    2 thrones
    1 start
    1 additional large plain
    rest plains
- holy/throne have NO special visuals
- start uses underlying terrain visual + ring overlay
- province IDs assigned in observed Dominions scan order:
  bottom-to-top, left-to-right within each row

Dependencies:
- Pillow
"""

import argparse
import math
import os
import random
from dataclasses import dataclass
from PIL import Image, ImageDraw

# -----------------------------
# Dominions terrain bitmasks
# -----------------------------
SMALL = 1
LARGE = 2
SEA = 4
FRESHWATER = 8
HIGHLAND = 16   # we will use this as "forest visual slot" only if desired? No.
SWAMP = 32
WASTE = 64
FOREST = 128
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


def choose_macro_cols(players: int, macro_cols: int | None) -> int:
    if macro_cols is not None and macro_cols > 0:
        return macro_cols
    return max(1, math.ceil(math.sqrt(players)))


def is_neighbour(a: tuple[int, int], b: tuple[int, int]) -> bool:
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
    - 2 thrones
    - start is not adjacent to either throne
    - 1 holy
    - 2 farms
    - 2 forests
    - 2 mountains (one large)
    - 1 cave
    - 1 swamp
    - 1 waste
    - 1 sea
    - 1 additional large plain
    - remaining cells default to small plain
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
    layout: dict[tuple[int, int], tuple[str, int]] = {}

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

    layout[start_cell] = ("start", SMALL | GOOD_START)
    for cell in throne_cells:
        layout[cell] = ("throne", SMALL | GOOD_THRONE)

    holy_pref = [(1, 1), (2, 1), (1, 2), (2, 2), (1, 0), (2, 0), (1, 3), (2, 3)]
    holy_cell = pick_one(holy_pref + all_cells)
    layout[holy_cell] = ("holy", SMALL | HOLY_SITE)

    farm_pref = [(0, 0), (1, 0), (2, 0), (3, 0), (0, 3), (1, 3), (2, 3), (3, 3)]
    for cell in pick_many(farm_pref + all_cells, 2):
        layout[cell] = ("farm", SMALL | FARM)

    forest_pref = [(0, 0), (3, 0), (0, 3), (3, 3), (1, 0), (2, 0), (1, 3), (2, 3)]
    for cell in pick_many(forest_pref + all_cells, 2):
        layout[cell] = ("forest", SMALL | FOREST)

    mountain_pref = [(3, 0), (3, 1), (3, 2), (3, 3), (0, 0), (0, 1), (0, 2), (0, 3)]
    mountain_cells = pick_many(mountain_pref + all_cells, 2)
    layout[mountain_cells[0]] = ("mountain", SMALL | MOUNTAIN)
    layout[mountain_cells[1]] = ("mountain", LARGE | MOUNTAIN)

    edge_pref = [(0, 1), (0, 2), (3, 1), (3, 2), (1, 0), (2, 0), (1, 3), (2, 3)]
    cave_cell = pick_one(edge_pref + all_cells)
    layout[cave_cell] = ("cave", SMALL | CAVE)

    swamp_cell = pick_one(edge_pref + all_cells)
    layout[swamp_cell] = ("swamp", SMALL | SWAMP)

    waste_cell = pick_one(edge_pref + all_cells)
    layout[waste_cell] = ("waste", SMALL | WASTE)

    sea_cell = pick_one(edge_pref + all_cells)
    layout[sea_cell] = ("sea", SMALL | SEA)

    large_plain_cell = pick_one(all_cells)
    layout[large_plain_cell] = ("plain", LARGE)

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
                left = block_left + x * (CELL_W + INTRA_GAP)
                top = block_top + y * (CELL_H + INTRA_GAP)
                right = left + CELL_W
                bottom = top + CELL_H

                role, terrain = roles.get((x, y), ("plain", SMALL))

                provinces.append(
                    Province(
                        pid=0,
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
    # Observed Dominions scan order for this map layout:
    # bottom row -> top row, left -> right within row.
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

    edges: set[tuple[int, int]] = set()

    for player in range(1, players + 1):
        for y in range(BLOCK):
            for x in range(BLOCK):
                a = by_player[player][(x, y)]
                for dx, dy in dirs:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < BLOCK and 0 <= ny < BLOCK:
                        b = by_player[player][(nx, ny)]
                        edges.add(tuple(sorted((a, b))))

    # ring wrap east edge of player N to west edge of player N+1
    for player in range(1, players + 1):
        other = player + 1 if player < players else 1
        for y in range(BLOCK):
            a = by_player[player][(3, y)]
            b = by_player[other][(0, y)]
            edges.add(tuple(sorted((a, b))))

    return sorted(edges)


def get_visual_base_type(terrain: int) -> str:
    if terrain & SEA:
        return "sea"
    if terrain & CAVE:
        return "cave"
    if terrain & SWAMP:
        return "swamp"
    if terrain & WASTE:
        return "waste"
    if terrain & FARM:
        return "farm"
    if terrain & FOREST:
        return "forest"
    if terrain & MOUNTAIN:
        return "mountain"
    return "plain"


def get_visual_size(terrain: int) -> str:
    return "large" if (terrain & LARGE) else "small"


def get_tile_key(province: Province) -> str:
    base = get_visual_base_type(province.terrain)
    size = get_visual_size(province.terrain)

    if base == "sea":
        return "sea_small"

    return f"{base}_{size}"


def load_sprite(path: str, mode: str = "RGBA") -> Image.Image:
    if not os.path.exists(path):
        raise FileNotFoundError(f"Missing sprite: {path}")
    return Image.open(path).convert(mode)


def load_tiles(sprite_dir: str) -> tuple[dict[str, Image.Image], Image.Image]:
    tile_names = [
        "plain_small",
        "plain_large",
        "forest_small",
        "forest_large",
        "mountain_small",
        "mountain_large",
        "swamp_small",
        "swamp_large",
        "waste_small",
        "waste_large",
        "farm_small",
        "farm_large",
        "cave_small",
        "cave_large",
        "sea_small",
    ]

    tiles: dict[str, Image.Image] = {}
    for name in tile_names:
        tiles[name] = load_sprite(os.path.join(sprite_dir, f"{name}.png"), mode="RGBA")

    start_ring = load_sprite(os.path.join(sprite_dir, "start_ring_overlay.png"), mode="RGBA")
    return tiles, start_ring


def draw_map_with_sprites(
    path: str,
    provinces: list[Province],
    sprite_dir: str,
    draw_debug_role_markers: bool = False,
) -> tuple[int, int]:
    width = max(p.right for p in provinces) + MARGIN
    height = max(p.bottom for p in provinces) + MARGIN

    canvas = Image.new("RGBA", (width, height), (0, 0, 0, 255))
    draw = ImageDraw.Draw(canvas)
    tiles, start_ring = load_tiles(sprite_dir)

    for p in provinces:
        tile_key = get_tile_key(p)
        tile = tiles[tile_key]

        target_w = p.right - p.left
        target_h = p.bottom - p.top

        tile_resized = tile.resize((target_w, target_h), Image.Resampling.NEAREST)
        canvas.alpha_composite(tile_resized, (p.left, p.top))

        # Start ring only. Holy/throne intentionally have no special visual.
        if p.role == "start":
            ring_resized = start_ring.resize((target_w, target_h), Image.Resampling.NEAREST)
            canvas.alpha_composite(ring_resized, (p.left, p.top))

        # border
        draw.rectangle([p.left, p.top, p.right - 1, p.bottom - 1], outline=(0, 0, 0, 255), width=1)

        # exactly one white province marker
        cx = (p.left + p.right) // 2
        cy = (p.top + p.bottom) // 2
        canvas.putpixel((cx, cy), (255, 255, 255, 255))

        if draw_debug_role_markers:
            marker = {
                "start": (0, 255, 255, 255),
                "throne": (255, 0, 255, 255),
                "holy": (255, 255, 180, 255),
                "sea": (40, 80, 170, 255),
            }.get(p.role)
            if marker:
                for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    xx, yy = cx + dx, cy + dy
                    if 0 <= xx < width and 0 <= yy < height:
                        canvas.putpixel((xx, yy), marker)

    canvas.convert("RGB").save(path)
    return width, height


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
        f.write("#domversion 600\n\n")
        f.write('#description "Generated 4x4-per-player ring grid map using terrain sprites."\n\n')

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


def write_debug_mapping(path: str, provinces: list[Province]) -> None:
    with open(path, "w", encoding="utf-8") as f:
        for p in sorted(provinces, key=lambda q: q.pid):
            cx = (p.left + p.right) // 2
            cy = (p.top + p.bottom) // 2
            f.write(
                f"{p.pid}\t{p.name}\trole={p.role}\tterrain={p.terrain}\tcx={cx}\tcy={cy}\n"
            )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--players", type=int, default=6)
    parser.add_argument("--macro-cols", type=int, default=6)
    parser.add_argument("--seed", type=int, default=12345)
    parser.add_argument("--diagonal-neighbours", action="store_true")
    parser.add_argument("--sprite-dir", default=".")
    parser.add_argument("--output-map", default="generated_ring_grid.map")
    parser.add_argument("--output-tga", default="generated_ring_grid.tga")
    parser.add_argument("--imagefile", default="generated_ring_grid.tga")
    parser.add_argument("--debug-mapping", default="generated_ring_grid_debug.txt")
    parser.add_argument("--debug-role-markers", action="store_true")
    return parser.parse_args()


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

    width, height = draw_map_with_sprites(
        args.output_tga,
        provinces,
        args.sprite_dir,
        draw_debug_role_markers=args.debug_role_markers,
    )

    write_map(
        args.output_map,
        args.imagefile,
        provinces,
        neighbours,
        width,
        height,
    )

    write_debug_mapping(args.debug_mapping, provinces)

    print(f"Generated: {args.output_map}")
    print(f"Generated: {args.output_tga}")
    print(f"Generated: {args.debug_mapping}")


if __name__ == "__main__":
    main()
