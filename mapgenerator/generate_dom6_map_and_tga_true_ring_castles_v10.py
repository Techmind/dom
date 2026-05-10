#!/usr/bin/env python3
"""
Generate a Dominions 6 .map + .tga map using external terrain sprites.

Defaults:
- generated_true_ring.map
- generated_true_ring.tga

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
- start_ring_overlay.png (fallback if no castle sprites are found/used)
- castles/*.png (optional random start overlays; pass --castle-dir)

Optional decorative art:
- --center-image path/to/image.png
- --center-corner-image path/to/corner.png
- --outer-corner-image path/to/corner.png

Rules:
- configurable player count
- each player gets a 4x4 province section by default
- supported layouts:
    ring        - true circular ring split into N player sectors; each sector is
                  split into 4x4 annular quadrilateral provinces
    grid        - old behavior: player blocks in a line / rectangular grid
    square-ring - old square-perimeter behavior kept for compatibility
- role layout is slightly randomized per block
- start is in center 2x2
- start and thrones are not neighbours
- includes per player block:
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
- province IDs for grid/square-ring keep the old observed scan order:
  bottom-to-top, left-to-right within each row
- province IDs for true ring use the actual TGA byte scan order.
  Pillow writes these TGA files with bottom-left origin, so the scan order in
  normal image coordinates is bottom-to-top, left-to-right among white pixels

Dependencies:
- Pillow
"""

import argparse
import csv
import math
import os
import random
from dataclasses import dataclass
from PIL import Image, ImageDraw, ImageOps

# -----------------------------
# Dominions terrain bitmasks
# -----------------------------
SMALL = 1
LARGE = 2
SEA = 4
FRESHWATER = 8
HIGHLAND = 16   # unused here
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

MAP_TITLE = "Generated True Ring"

# True circular ring defaults. The final image size is roughly
# 2 * outer_radius + 2 * margin.
RING_INNER_RADIUS = 170
RING_OUTER_RADIUS = 470
RING_MARGIN = 40


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
    # For true-ring layout this stores the 4 polygon corners.
    # For old grid/square-ring layouts it stays None and left/top/right/bottom are used.
    points: tuple[tuple[int, int], tuple[int, int], tuple[int, int], tuple[int, int]] | None = None
    display_name: str | None = None

    @property
    def name(self) -> str:
        return f"p{self.player}_{self.x}_{self.y}"

    @property
    def landname(self) -> str:
        return self.display_name or self.name

    @property
    def cx(self) -> int:
        if self.points:
            return round(sum(pt[0] for pt in self.points) / len(self.points))
        return (self.left + self.right) // 2

    @property
    def cy(self) -> int:
        if self.points:
            return round(sum(pt[1] for pt in self.points) / len(self.points))
        return (self.top + self.bottom) // 2


@dataclass(frozen=True)
class PlayerBlock:
    player: int
    col: int
    row: int


def sanitize_imagefile_name(imagefile: str) -> str:
    imagefile = imagefile.strip().strip('"').strip("'")
    if " " in imagefile:
        raise ValueError("Dominions map filenames should not contain spaces.")
    return imagefile


def choose_macro_cols(players: int, macro_cols: int | None) -> int:
    if macro_cols is not None and macro_cols > 0:
        return macro_cols
    return max(1, math.ceil(math.sqrt(players)))


def ring_capacity(side: int) -> int:
    """Number of block slots on the perimeter of a side x side square."""
    if side < 1:
        raise ValueError("ring side must be at least 1")
    if side == 1:
        return 1
    return 4 * side - 4


def choose_ring_side(players: int, ring_side: int | None) -> int:
    """Choose the smallest square side that can hold all players on its edge."""
    if ring_side is not None:
        if ring_side < 1:
            raise ValueError("--ring-side must be at least 1")
        cap = ring_capacity(ring_side)
        if cap < players:
            raise ValueError(
                f"--ring-side={ring_side} has only {cap} edge slots, "
                f"but --players={players}"
            )
        return ring_side

    side = 1
    while ring_capacity(side) < players:
        side += 1
    return side


def clockwise_ring_coords(side: int) -> list[tuple[int, int]]:
    """
    Macro-block coordinates clockwise around a square edge.

    side=3 gives:
        (0,0) (1,0) (2,0)
        (0,1)       (2,1)
        (0,2) (1,2) (2,2)

    Returned order:
    top left->right, right top->bottom, bottom right->left,
    left bottom->top.
    """
    if side < 1:
        raise ValueError("side must be at least 1")
    if side == 1:
        return [(0, 0)]

    coords: list[tuple[int, int]] = []

    # Top edge: left -> right
    for x in range(side):
        coords.append((x, 0))

    # Right edge: top -> bottom, excluding already-added top-right corner
    for y in range(1, side):
        coords.append((side - 1, y))

    # Bottom edge: right -> left, excluding already-added bottom-right corner
    for x in range(side - 2, -1, -1):
        coords.append((x, side - 1))

    # Left edge: bottom -> top, excluding both corners
    for y in range(side - 2, 0, -1):
        coords.append((0, y))

    return coords


def macro_block_origin(block_col: int, block_row: int) -> tuple[int, int]:
    block_left = MARGIN + block_col * (BLOCK * (CELL_W + INTRA_GAP) + BLOCK_GAP_X)
    block_top = MARGIN + block_row * (BLOCK * (CELL_H + INTRA_GAP) + BLOCK_GAP_Y)
    return block_left, block_top


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


def build_player_blocks_grid(players: int, macro_cols: int) -> list[PlayerBlock]:
    blocks: list[PlayerBlock] = []
    for player_index in range(players):
        player = player_index + 1
        block_col = player_index % macro_cols
        block_row = player_index // macro_cols
        blocks.append(PlayerBlock(player=player, col=block_col, row=block_row))
    return blocks


def build_player_blocks_square_ring(players: int, ring_side: int) -> list[PlayerBlock]:
    coords = clockwise_ring_coords(ring_side)[:players]
    return [
        PlayerBlock(player=i + 1, col=col, row=row)
        for i, (col, row) in enumerate(coords)
    ]


def build_provinces_from_blocks(blocks: list[PlayerBlock], seed: int) -> list[Province]:
    provinces: list[Province] = []
    master_rng = random.Random(seed)

    for block in blocks:
        block_left, block_top = macro_block_origin(block.col, block.row)

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
                        player=block.player,
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


def polar_point(cx: int, cy: int, radius: float, angle: float) -> tuple[int, int]:
    """Convert polar coordinates to image coordinates."""
    return (round(cx + radius * math.cos(angle)), round(cy + radius * math.sin(angle)))


def ring_polygon_for_cell(
    center_x: int,
    center_y: int,
    inner_radius: float,
    outer_radius: float,
    player_index: int,
    players: int,
    angular_index: int,
    radial_index: int,
    angular_cells: int = BLOCK,
    radial_cells: int = BLOCK,
) -> tuple[tuple[int, int], tuple[int, int], tuple[int, int], tuple[int, int]]:
    """
    Return the four corners of one annular-quadrilateral province.

    x/``angular_index`` moves clockwise inside a player's sector.
    y/``radial_index`` moves from inner ring to outer ring.
    """
    # Start at 12 o'clock and move clockwise around the image.
    full = math.tau
    player_start = -math.pi / 2 + full * (player_index / players)
    player_end = -math.pi / 2 + full * ((player_index + 1) / players)

    a0 = player_start + (player_end - player_start) * (angular_index / angular_cells)
    a1 = player_start + (player_end - player_start) * ((angular_index + 1) / angular_cells)

    r0 = inner_radius + (outer_radius - inner_radius) * (radial_index / radial_cells)
    r1 = inner_radius + (outer_radius - inner_radius) * ((radial_index + 1) / radial_cells)

    # Clockwise polygon: inner-left, inner-right, outer-right, outer-left.
    return (
        polar_point(center_x, center_y, r0, a0),
        polar_point(center_x, center_y, r0, a1),
        polar_point(center_x, center_y, r1, a1),
        polar_point(center_x, center_y, r1, a0),
    )


def bbox_for_points(points: tuple[tuple[int, int], ...]) -> tuple[int, int, int, int]:
    xs = [p[0] for p in points]
    ys = [p[1] for p in points]
    # right/bottom are exclusive-ish, matching PIL resize dimensions.
    return min(xs), min(ys), max(xs) + 1, max(ys) + 1


def build_player_blocks_true_ring(players: int) -> list[PlayerBlock]:
    """
    Compatibility helper for debug output.

    There are no macro square blocks in the true-ring layout, so col is just the
    clockwise player index and row is always 0.
    """
    return [PlayerBlock(player=i + 1, col=i, row=0) for i in range(players)]


def build_province_centers_true_ring(
    players: int,
    inner_radius: int = RING_INNER_RADIUS,
    outer_radius: int = RING_OUTER_RADIUS,
) -> list[Province]:
    """
    Build only the neutral true-ring geometry first.

    Important pipeline for --layout ring:
    1. Generate all province centers / polygons with no player and no role.
    2. Assign province IDs from the white-marker scan order.
    3. Find neighbours from province center pixel coordinates.
    4. Assign provinces to players by angular sector.
    5. Assign province terrain/roles inside each player's 4x4 sector.

    During this first geometry pass:
    - player is temporarily 0
    - role is temporarily "plain"
    - terrain is temporarily SMALL
    - x stores the GLOBAL angular column, 0..players*BLOCK-1
    - y stores the radial band, 0..BLOCK-1, inner to outer
    """
    if players < 1:
        raise ValueError("players must be at least 1")
    if inner_radius < 1:
        raise ValueError("inner radius must be positive")
    if outer_radius <= inner_radius:
        raise ValueError("outer radius must be larger than inner radius")

    center_x = RING_MARGIN + outer_radius
    center_y = RING_MARGIN + outer_radius
    angular_cells = players * BLOCK
    provinces: list[Province] = []

    for global_x in range(angular_cells):
        for y in range(BLOCK):
            player_index = global_x // BLOCK
            local_x = global_x % BLOCK
            points = ring_polygon_for_cell(
                center_x=center_x,
                center_y=center_y,
                inner_radius=inner_radius,
                outer_radius=outer_radius,
                player_index=player_index,
                players=players,
                angular_index=local_x,
                radial_index=y,
            )
            left, top, right, bottom = bbox_for_points(points)

            provinces.append(
                Province(
                    pid=0,
                    player=0,
                    x=global_x,
                    y=y,
                    left=left,
                    top=top,
                    right=right,
                    bottom=bottom,
                    role="plain",
                    terrain=SMALL,
                    points=points,
                )
            )

    return provinces


def assign_true_ring_provinces_to_players(provinces: list[Province], players: int) -> None:
    """
    Assign each neutral ring province to a player after geometry/neighbours exist.

    This mutates provinces in place. It converts x from a global angular column
    into the player's local 0..3 angular coordinate.
    """
    if players < 1:
        raise ValueError("players must be at least 1")

    max_global_x = players * BLOCK - 1
    for p in provinces:
        if not (0 <= p.x <= max_global_x):
            raise ValueError(f"Ring province global angular index out of range: x={p.x}")
        p.player = p.x // BLOCK + 1
        p.x = p.x % BLOCK


def assign_true_ring_province_types(provinces: list[Province], players: int, seed: int) -> None:
    """
    Assign terrain/roles after provinces have been assigned to players.

    This keeps the original per-player 4x4 role rules, but applies them only
    after ring geometry, marker scan IDs, neighbour generation, and player
    ownership are already stable.
    """
    master_rng = random.Random(seed)
    by_player: dict[int, dict[tuple[int, int], Province]] = {}
    for p in provinces:
        if p.player < 1 or p.player > players:
            raise ValueError("Ring province types require player assignment first.")
        by_player.setdefault(p.player, {})[(p.x, p.y)] = p

    for player in range(1, players + 1):
        cells = by_player.get(player, {})
        expected = {(x, y) for y in range(BLOCK) for x in range(BLOCK)}
        missing = expected - set(cells.keys())
        if missing:
            raise ValueError(f"Player {player} is missing ring cells: {sorted(missing)}")

        block_rng = random.Random(master_rng.randint(0, 10**9))
        roles = random_role_layout(block_rng)
        for cell, province in cells.items():
            role, terrain = roles.get(cell, ("plain", SMALL))
            province.role = role
            province.terrain = terrain


def build_provinces_true_ring(
    players: int,
    seed: int,
    inner_radius: int = RING_INNER_RADIUS,
    outer_radius: int = RING_OUTER_RADIUS,
) -> list[Province]:
    """
    Compatibility wrapper for callers outside main().

    New ring-generation order is implemented explicitly in main(), but this
    returns fully assigned provinces for older direct imports/tests.
    """
    provinces = build_province_centers_true_ring(players, inner_radius, outer_radius)
    provinces = assign_ids_by_tga_marker_scan(provinces)
    assign_true_ring_provinces_to_players(provinces, players)
    assign_true_ring_province_types(provinces, players, seed)
    return provinces

def assign_ids_by_image_scan(provinces: list[Province]) -> list[Province]:
    # Old observed scan order for rectangular grid/square-ring maps:
    # bottom row -> top row, left -> right within row.
    sorted_provs = sorted(provinces, key=lambda p: (-p.top, p.left))
    for i, p in enumerate(sorted_provs, start=1):
        p.pid = i
    return sorted_provs


def assign_ids_by_tga_marker_scan(provinces: list[Province]) -> list[Province]:
    """
    Assign province IDs in the marker scan order Dominions sees in the TGA.

    Important: the .tga files written by Pillow here have image descriptor 0,
    meaning bottom-left origin. If the game scans the TGA pixel stream directly,
    the visual/Pillow coordinate order is therefore:

        bottom-to-top, left-to-right within each row

    That is different from ordinary screen intuition like "top-right first".
    Use marker centers instead of polygon bounding boxes because the single
    white marker pixel is what Dominions reads as the province center.
    """
    sorted_provs = sorted(provinces, key=lambda p: (-p.cy, p.cx, p.player, p.y, p.x))
    for i, p in enumerate(sorted_provs, start=1):
        p.pid = i
    return sorted_provs


# Backwards-compatible alias for old imports/tests. This name used to imply a
# top-right visual scan, but that did not match real TGA/Dominions assignment.
def assign_ids_by_top_right_marker_scan(provinces: list[Province]) -> list[Province]:
    return assign_ids_by_tga_marker_scan(provinces)


def add_internal_block_neighbours(
    edges: set[tuple[int, int]],
    by_player: dict[int, dict[tuple[int, int], int]],
    players: int,
    diagonal_neighbours: bool = False,
) -> None:
    if diagonal_neighbours:
        dirs = [
            (-1, 0), (1, 0), (0, -1), (0, 1),
            (-1, -1), (-1, 1), (1, -1), (1, 1),
        ]
    else:
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    for player in range(1, players + 1):
        for y in range(BLOCK):
            for x in range(BLOCK):
                a = by_player[player][(x, y)]
                for dx, dy in dirs:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < BLOCK and 0 <= ny < BLOCK:
                        b = by_player[player][(nx, ny)]
                        edges.add(tuple(sorted((a, b))))


def connect_player_blocks_by_side(
    edges: set[tuple[int, int]],
    by_player: dict[int, dict[tuple[int, int], int]],
    player_a: int,
    player_b: int,
    dcol: int,
    drow: int,
) -> None:
    """
    Connect two adjacent 4x4 player blocks along their touching sides.

    dcol/drow describe where B is relative to A in macro-block coordinates:
    - B right of A: dcol=1, drow=0
    - B left of A:  dcol=-1, drow=0
    - B below A:   dcol=0, drow=1
    - B above A:   dcol=0, drow=-1
    """
    if (dcol, drow) == (1, 0):
        # A east edge -> B west edge
        for y in range(BLOCK):
            edges.add(tuple(sorted((by_player[player_a][(BLOCK - 1, y)], by_player[player_b][(0, y)]))))
    elif (dcol, drow) == (-1, 0):
        # A west edge -> B east edge
        for y in range(BLOCK):
            edges.add(tuple(sorted((by_player[player_a][(0, y)], by_player[player_b][(BLOCK - 1, y)]))))
    elif (dcol, drow) == (0, 1):
        # A south edge -> B north edge
        for x in range(BLOCK):
            edges.add(tuple(sorted((by_player[player_a][(x, BLOCK - 1)], by_player[player_b][(x, 0)]))))
    elif (dcol, drow) == (0, -1):
        # A north edge -> B south edge
        for x in range(BLOCK):
            edges.add(tuple(sorted((by_player[player_a][(x, 0)], by_player[player_b][(x, BLOCK - 1)]))))
    else:
        raise ValueError(f"Player blocks are not side-adjacent: dcol={dcol}, drow={drow}")


def build_neighbours_grid(
    provinces: list[Province],
    players: int,
    diagonal_neighbours: bool = False,
) -> list[tuple[int, int]]:
    by_player: dict[int, dict[tuple[int, int], int]] = {}
    for p in provinces:
        by_player.setdefault(p.player, {})
        by_player[p.player][(p.x, p.y)] = p.pid

    edges: set[tuple[int, int]] = set()
    add_internal_block_neighbours(edges, by_player, players, diagonal_neighbours)

    # Old behavior: ring-wrap east edge of player N to west edge of player N+1.
    for player in range(1, players + 1):
        other = player + 1 if player < players else 1
        connect_player_blocks_by_side(edges, by_player, player, other, dcol=1, drow=0)

    return sorted(edges)


def build_neighbours_square_ring(
    provinces: list[Province],
    blocks: list[PlayerBlock],
    diagonal_neighbours: bool = False,
) -> list[tuple[int, int]]:
    by_player: dict[int, dict[tuple[int, int], int]] = {}
    for p in provinces:
        by_player.setdefault(p.player, {})
        by_player[p.player][(p.x, p.y)] = p.pid

    players = len(blocks)
    edges: set[tuple[int, int]] = set()
    add_internal_block_neighbours(edges, by_player, players, diagonal_neighbours)

    # Connect player N to player N+1 clockwise. The final player wraps to player 1.
    for i, block_a in enumerate(blocks):
        block_b = blocks[(i + 1) % len(blocks)]
        dcol = block_b.col - block_a.col
        drow = block_b.row - block_a.row

        # This should normally be side-adjacent. If the user creates a partial ring,
        # the closing connection may jump across empty slots. In that case, we keep
        # the old conceptual ring behavior by connecting closest matching sides.
        if abs(dcol) + abs(drow) == 1:
            connect_player_blocks_by_side(edges, by_player, block_a.player, block_b.player, dcol, drow)
        elif dcol > 0 and drow == 0:
            connect_player_blocks_by_side(edges, by_player, block_a.player, block_b.player, 1, 0)
        elif dcol < 0 and drow == 0:
            connect_player_blocks_by_side(edges, by_player, block_a.player, block_b.player, -1, 0)
        elif drow > 0 and dcol == 0:
            connect_player_blocks_by_side(edges, by_player, block_a.player, block_b.player, 0, 1)
        elif drow < 0 and dcol == 0:
            connect_player_blocks_by_side(edges, by_player, block_a.player, block_b.player, 0, -1)
        else:
            # Diagonal/complex closing jump. Pick the dominant axis.
            if abs(dcol) >= abs(drow):
                connect_player_blocks_by_side(edges, by_player, block_a.player, block_b.player, 1 if dcol > 0 else -1, 0)
            else:
                connect_player_blocks_by_side(edges, by_player, block_a.player, block_b.player, 0, 1 if drow > 0 else -1)

    return sorted(edges)


def build_neighbours_ring_by_topology(
    provinces: list[Province],
    players: int,
) -> list[tuple[int, int]]:
    """
    Build neighbours for true-ring layout from annular grid topology.

    For the true ring, each province belongs to a regular logical grid:
    - x = global angular column, 0 .. players*BLOCK-1
    - y = radial band, 0 inner .. BLOCK-1 outer

    Neighbours should follow this grid, with angular wraparound across the full
    ring:
    - every province connects to the previous and next angular column on the
      same radial band
    - inner boundary (y == 0) also connects outward to (x, 1)      => 3 total
    - outer boundary (y == BLOCK-1) also connects inward to (x, BLOCK-2) => 3
    - middle bands connect both inward and outward                 => 4 total

    This fixes the earlier bug where outer provinces could connect to a wrong
    same-band cell like p1_2_3 instead of the intended radial neighbour p1_0_2.
    """
    if not provinces:
        return []
    if players < 1:
        raise ValueError("players must be at least 1")

    angular_cells = players * BLOCK
    by_cell: dict[tuple[int, int], Province] = {}
    for p in provinces:
        if not (0 <= p.x < angular_cells):
            raise ValueError(
                "Ring neighbour generation must run before x is converted "
                "from global angular index to local player x."
            )
        by_cell[(p.x, p.y)] = p

    expected = {(x, y) for x in range(angular_cells) for y in range(BLOCK)}
    missing = expected - set(by_cell.keys())
    if missing:
        raise ValueError(f"Missing ring topology cells: {sorted(missing)[:8]}")

    def add_edge(edges: set[tuple[int, int]], a: Province, b: Province) -> None:
        if a.pid == b.pid:
            return
        edges.add(tuple(sorted((a.pid, b.pid))))

    edges: set[tuple[int, int]] = set()

    for x in range(angular_cells):
        for y in range(BLOCK):
            here = by_cell[(x, y)]

            # Angular neighbours with wraparound around the full ring.
            add_edge(edges, here, by_cell[((x - 1) % angular_cells, y)])
            add_edge(edges, here, by_cell[((x + 1) % angular_cells, y)])

            # Radial neighbours. Boundary bands get one, middle bands get two.
            if y > 0:
                add_edge(edges, here, by_cell[(x, y - 1)])
            if y < BLOCK - 1:
                add_edge(edges, here, by_cell[(x, y + 1)])

    return sorted(edges)


# Backwards-compatible name for older imports/tests. The implementation is no
# longer pure nearest-by-pixels because that caused wrong radial links on the
# curved boundary bands.
def build_neighbours_ring_nearest_by_pixels(
    provinces: list[Province],
    inner_or_outer_degree: int = 3,
    middle_degree: int = 4,
) -> list[tuple[int, int]]:
    inferred_players = max(1, len(provinces) // (BLOCK * BLOCK))
    return build_neighbours_ring_by_topology(provinces, inferred_players)



def validate_ring_neighbours(
    provinces: list[Province],
    neighbours: list[tuple[int, int]],
    players: int,
) -> None:
    """
    Fail fast if true-ring topology regresses.

    Validation runs before player assignment, while p.x is still the global
    angular column. Boundary bands must have 3 neighbours and middle bands 4.
    It also checks the reported bug class: a p1_0_3-style outer cell must be
    connected to its inward radial neighbour p1_0_2, and must *not* connect to
    the wrong same-sector cell p1_2_3.
    """
    if not provinces:
        return

    by_cell = {(p.x, p.y): p for p in provinces}
    degree = {p.pid: 0 for p in provinces}
    edge_set = {tuple(sorted(edge)) for edge in neighbours}

    for a, b in edge_set:
        degree[a] = degree.get(a, 0) + 1
        degree[b] = degree.get(b, 0) + 1

    for p in provinces:
        expected_degree = 3 if p.y in (0, BLOCK - 1) else 4
        actual_degree = degree.get(p.pid, 0)
        if actual_degree != expected_degree:
            raise ValueError(
                f"Ring topology validation failed for global cell ({p.x}, {p.y}) "
                f"pid={p.pid}: expected {expected_degree} neighbours, got {actual_degree}."
            )

    if players >= 1 and BLOCK >= 4:
        outer_y = BLOCK - 1
        a = by_cell[(0, outer_y)]
        radial = by_cell[(0, outer_y - 1)]
        wrong_same_sector = by_cell[(2, outer_y)]

        radial_edge = tuple(sorted((a.pid, radial.pid)))
        wrong_edge = tuple(sorted((a.pid, wrong_same_sector.pid)))

        if radial_edge not in edge_set:
            raise ValueError(
                "Ring topology validation failed: p1_0_3-style outer cell "
                "is not connected to radial inward cell p1_0_2."
            )
        if wrong_edge in edge_set:
            raise ValueError(
                "Ring topology validation failed: p1_0_3-style outer cell "
                "is incorrectly connected to wrong same-sector outer cell p1_2_3."
            )

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


def load_tiles(sprite_dir: str) -> dict[str, Image.Image]:
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

    return tiles


def resolve_castle_dir(sprite_dir: str, castle_dir: str | None) -> str | None:
    """Resolve the optional directory with random start castle/tower PNGs."""
    if castle_dir:
        if os.path.isdir(castle_dir):
            return castle_dir

        # Convenience: allow --castle-dir castles when the folder lives under --sprite-dir.
        under_sprite_dir = os.path.join(sprite_dir, castle_dir)
        if os.path.isdir(under_sprite_dir):
            return under_sprite_dir

        raise FileNotFoundError(f"Missing castle sprite directory: {castle_dir}")

    default_castle_dir = os.path.join(sprite_dir, "castles")
    if os.path.isdir(default_castle_dir):
        return default_castle_dir

    return None


def load_start_sprites(sprite_dir: str, castle_dir: str | None = None) -> list[Image.Image]:
    """
    Load start overlays.

    If a castle directory exists/is passed, every PNG in it can be used as a
    random start sprite. Otherwise this falls back to the old
    start_ring_overlay.png behavior.
    """
    resolved_castle_dir = resolve_castle_dir(sprite_dir, castle_dir)
    if resolved_castle_dir:
        paths = sorted(
            os.path.join(resolved_castle_dir, name)
            for name in os.listdir(resolved_castle_dir)
            if name.lower().endswith(".png")
        )
        if not paths:
            raise FileNotFoundError(f"No PNG files found in castle sprite directory: {resolved_castle_dir}")
        return [load_sprite(path, mode="RGBA") for path in paths]

    return [load_sprite(os.path.join(sprite_dir, "start_ring_overlay.png"), mode="RGBA")]


def make_start_sprite_picker(start_sprites: list[Image.Image], seed: int | None):
    """
    Return a picker that prefers unused castle sprites during one map generation.

    The picker starts with a shuffled deck of all available start sprites. Each
    start province receives one sprite from that deck. Once all sprites have
    been used at least once, later starts use a normal random choice.
    """
    if not start_sprites:
        raise ValueError("At least one start sprite is required.")

    rng = random.Random(seed) if seed is not None else random.Random()
    unused = list(start_sprites)
    rng.shuffle(unused)

    def pick() -> Image.Image:
        if unused:
            return unused.pop()
        return rng.choice(start_sprites)

    return pick


def draw_center_image_if_present(
    canvas: Image.Image,
    center_image_path: str | None,
    blocks: list[PlayerBlock],
) -> None:
    """
    Optional helper for square-ring maps.

    It pastes a decorative image into the empty macro-block rectangle inside the ring.
    This is purely visual and does not add provinces.
    """
    if not center_image_path:
        return
    if not os.path.exists(center_image_path):
        raise FileNotFoundError(f"Missing center image: {center_image_path}")

    min_col = min(b.col for b in blocks)
    max_col = max(b.col for b in blocks)
    min_row = min(b.row for b in blocks)
    max_row = max(b.row for b in blocks)

    # Need at least one empty macro slot inside the square.
    if max_col - min_col < 2 or max_row - min_row < 2:
        return

    inner_left_col = min_col + 1
    inner_top_row = min_row + 1
    inner_right_col = max_col - 1
    inner_bottom_row = max_row - 1

    left, top = macro_block_origin(inner_left_col, inner_top_row)
    right_origin, bottom_origin = macro_block_origin(inner_right_col, inner_bottom_row)
    right = right_origin + BLOCK * (CELL_W + INTRA_GAP) - INTRA_GAP
    bottom = bottom_origin + BLOCK * (CELL_H + INTRA_GAP) - INTRA_GAP

    target_w = max(1, right - left)
    target_h = max(1, bottom - top)

    center = Image.open(center_image_path).convert("RGBA")
    center.thumbnail((target_w, target_h), Image.Resampling.LANCZOS)

    paste_x = left + (target_w - center.width) // 2
    paste_y = top + (target_h - center.height) // 2
    canvas.alpha_composite(center, (paste_x, paste_y))


def draw_center_image_in_ring_hole(
    canvas: Image.Image,
    center_image_path: str | None,
    center: tuple[int, int] | None,
    inner_radius: int | None,
) -> None:
    """Paste optional art into the circular empty hole of a true-ring map."""
    if not center_image_path or center is None or inner_radius is None:
        return
    if not os.path.exists(center_image_path):
        raise FileNotFoundError(f"Missing center image: {center_image_path}")

    cx, cy = center
    diameter = max(1, inner_radius * 2)
    art = Image.open(center_image_path).convert("RGBA")
    art.thumbnail((diameter, diameter), Image.Resampling.LANCZOS)

    paste_x = cx - art.width // 2
    paste_y = cy - art.height // 2

    # Circle mask so decorative art does not spill into provinces.
    mask = Image.new("L", art.size, 0)
    d = ImageDraw.Draw(mask)
    d.ellipse([0, 0, art.width - 1, art.height - 1], fill=255)
    canvas.paste(art, (paste_x, paste_y), mask)


def draw_center_corner_image_in_ring_hole(
    canvas: Image.Image,
    corner_image_path: str | None,
    center: tuple[int, int] | None,
    inner_radius: int | None,
) -> None:
    """
    Paste one decorative image into the circular ring hole as four mirrored
    quadrants.

    The input image is treated as the top-left quadrant. The other quadrants
    are generated from it:
    - top-right: mirrored horizontally
    - bottom-left: flipped vertically
    - bottom-right: mirrored horizontally and flipped vertically

    The result is clipped by the same circular hole mask so it does not spill
    into provinces.
    """
    if not corner_image_path or center is None or inner_radius is None:
        return
    if not os.path.exists(corner_image_path):
        raise FileNotFoundError(f"Missing center corner image: {corner_image_path}")

    cx, cy = center
    diameter = max(1, inner_radius * 2)
    half = max(1, diameter // 2)

    src = Image.open(corner_image_path).convert("RGBA")
    src = src.resize((half, half), Image.Resampling.LANCZOS)

    top_left = src
    top_right = ImageOps.mirror(src)
    bottom_left = ImageOps.flip(src)
    bottom_right = ImageOps.flip(ImageOps.mirror(src))

    hole_layer = Image.new("RGBA", (diameter, diameter), (0, 0, 0, 0))
    hole_layer.alpha_composite(top_left, (0, 0))
    hole_layer.alpha_composite(top_right, (diameter - half, 0))
    hole_layer.alpha_composite(bottom_left, (0, diameter - half))
    hole_layer.alpha_composite(bottom_right, (diameter - half, diameter - half))

    mask = Image.new("L", (diameter, diameter), 0)
    d = ImageDraw.Draw(mask)
    d.ellipse([0, 0, diameter - 1, diameter - 1], fill=255)

    canvas.paste(hole_layer, (cx - inner_radius, cy - inner_radius), mask)



def resolve_corner_image_paths(path: str | None, label: str) -> dict[str, str] | None:
    """Resolve corner art from either one PNG path or a directory of PNGs.

    - If a single file path is passed, that file is used as the top-left corner
      source and mirrored/flipped for the other corners (old behavior).
    - If a directory is passed, PNGs are sorted by filename and then assigned
      deterministically to tl/tr/bl/br. This keeps the same corner art across
      runs instead of changing each time.
    """
    if not path:
        return None

    if os.path.isdir(path):
        candidates = [
            os.path.join(path, name)
            for name in sorted(os.listdir(path))
            if name.lower().endswith('.png')
        ]
        if not candidates:
            raise FileNotFoundError(f"No PNG files found in {label} directory: {path}")

        picked = [candidates[i % len(candidates)] for i in range(4)]
        return {
            "tl": picked[0],
            "tr": picked[1],
            "bl": picked[2],
            "br": picked[3],
        }

    return {
        "tl": path,
        "tr": path,
        "bl": path,
        "br": path,
    }


def draw_outer_corner_image_outside_ring(
    canvas: Image.Image,
    outer_corner_image_path: str | None,
    center: tuple[int, int] | None,
    outer_radius: int | None,
) -> None:
    """
    Fill the empty square corners outside the outer circular ring.

    The input image is treated as the top-left quadrant. The other quadrants
    are generated from it:
    - top-right: mirrored horizontally
    - bottom-left: flipped vertically
    - bottom-right: mirrored horizontally and flipped vertically

    The result is clipped to the area OUTSIDE the outer ring circle, so it does
    not cover ring provinces. It is drawn before province sprites, so province
    polygons still win visually even if there is minor antialias/rounding overlap.
    """
    if not outer_corner_image_path or center is None or outer_radius is None:
        return

    resolved_corner_paths = resolve_corner_image_paths(outer_corner_image_path, "outer corner image")
    if not resolved_corner_paths:
        return
    for corner_key, corner_path in resolved_corner_paths.items():
        if not os.path.exists(corner_path):
            raise FileNotFoundError(f"Missing outer corner image for {corner_key}: {corner_path}")

    width, height = canvas.size
    cx, cy = center

    # Four quadrants around the ring center. This covers all outside-circle
    # space; the mask below keeps only the area outside the outer ring.
    quad_boxes = {
        "tl": (0, 0, cx, cy),
        "tr": (cx, 0, width, cy),
        "bl": (0, cy, cx, height),
        "br": (cx, cy, width, height),
    }

    use_direct_corner_images = os.path.isdir(outer_corner_image_path)
    if use_direct_corner_images:
        variants = {
            key: Image.open(path).convert("RGBA")
            for key, path in resolved_corner_paths.items()
        }
    else:
        src = Image.open(resolved_corner_paths["tl"]).convert("RGBA")
        variants = {
            "tl": src,
            "tr": ImageOps.mirror(src),
            "bl": ImageOps.flip(src),
            "br": ImageOps.flip(ImageOps.mirror(src)),
        }

    layer = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    for key, box in quad_boxes.items():
        left, top, right, bottom = box
        w = max(1, right - left)
        h = max(1, bottom - top)
        art = variants[key].resize((w, h), Image.Resampling.LANCZOS)
        layer.alpha_composite(art, (left, top))

    # Keep only pixels outside the outer ring circle.
    mask = Image.new("L", (width, height), 255)
    d = ImageDraw.Draw(mask)
    d.ellipse(
        [cx - outer_radius, cy - outer_radius, cx + outer_radius, cy + outer_radius],
        fill=0,
    )

    canvas.paste(layer, (0, 0), mask)

def paste_tile_clipped_to_polygon(
    canvas: Image.Image,
    tile: Image.Image,
    polygon: tuple[tuple[int, int], ...],
    bbox: tuple[int, int, int, int],
) -> None:
    left, top, right, bottom = bbox
    target_w = max(1, right - left)
    target_h = max(1, bottom - top)

    tile_resized = tile.resize((target_w, target_h), Image.Resampling.NEAREST)
    shifted = [(x - left, y - top) for x, y in polygon]
    mask = Image.new("L", (target_w, target_h), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.polygon(shifted, fill=255)
    canvas.paste(tile_resized, (left, top), mask)



def parse_hex_rgba(value: str | None) -> tuple[int, int, int, int] | None:
    """Parse #RRGGBB or RRGGBB into an opaque RGBA tuple."""
    if value is None:
        return None

    value = value.strip()
    if not value:
        return None
    if value.startswith("#"):
        value = value[1:]

    if len(value) != 6:
        raise ValueError("Hex color must use RRGGBB format, for example #2b2418.")

    try:
        r = int(value[0:2], 16)
        g = int(value[2:4], 16)
        b = int(value[4:6], 16)
    except ValueError as exc:
        raise ValueError("Hex color must contain only hexadecimal digits, for example #2b2418.") from exc

    return (r, g, b, 255)


def get_visible_content_center(image: Image.Image) -> tuple[float, float]:
    """Return the center of the visible (non-transparent) sprite content.

    This is based on the alpha-channel bounding box, so PNGs with uneven
    transparent padding are aligned by their actual visible castle/tower area
    instead of the full image canvas.
    """
    alpha = image.getchannel("A")
    bbox = alpha.getbbox()
    if bbox is None:
        return (image.width / 2.0, image.height / 2.0)

    left, top, right, bottom = bbox
    return ((left + right) / 2.0, (top + bottom) / 2.0)

def get_most_common_visible_color(image: Image.Image) -> tuple[int, int, int, int] | None:
    """Return the most common visible RGB color from a sprite as opaque RGBA.

    Fully transparent pixels are ignored. This is used as the default fill
    color behind castle/tower sprites when --castle-fill-color is not passed.
    """
    rgba = image.convert("RGBA")
    counts: dict[tuple[int, int, int], int] = {}

    for r, g, b, a in rgba.getdata():
        if a <= 0:
            continue
        key = (r, g, b)
        counts[key] = counts.get(key, 0) + 1

    if not counts:
        return None

    color = max(counts.items(), key=lambda item: item[1])[0]
    return (color[0], color[1], color[2], 255)

def paste_overlay_centered_clipped(
    canvas: Image.Image,
    overlay: Image.Image,
    bbox: tuple[int, int, int, int],
    polygon: tuple[tuple[int, int], ...] | None = None,
    fill_color: tuple[int, int, int, int] | None = None,
    center: tuple[int, int] | None = None,
    scale_percent: float = 100.0,
) -> None:
    """Paste a start overlay centered in a province, preserving aspect ratio.

    If fill_color is set, the whole province area under the start sprite is
    first filled with that color. This avoids ugly transparent/black-looking
    gaps when the castle keeps its aspect ratio inside a non-square polygon.

    If center is provided, the sprite is aligned so its *visible* content
    center matches the province marker pixel exactly. This makes castle
    placement line up with the white province-center pixel even when the PNG
    has uneven transparent padding around the art.

    scale_percent is applied after the normal fit-to-province calculation.
    100 means the current behavior. Values below 100 shrink the castle so it
    fits a little more loosely inside the province.
    """
    left, top, right, bottom = bbox
    target_w = max(1, right - left)
    target_h = max(1, bottom - top)

    if scale_percent <= 0:
        raise ValueError("castle scale percent must be > 0")

    fit_scale = min(target_w / overlay.width, target_h / overlay.height)
    scale = fit_scale * (scale_percent / 100.0)
    resized_w = max(1, round(overlay.width * scale))
    resized_h = max(1, round(overlay.height * scale))
    resized = overlay.resize((resized_w, resized_h), Image.Resampling.NEAREST)

    layer = Image.new("RGBA", (target_w, target_h), fill_color or (0, 0, 0, 0))

    if center is None:
        paste_x = (target_w - resized_w) // 2
        paste_y = (target_h - resized_h) // 2
    else:
        center_x, center_y = center
        local_cx = center_x - left
        local_cy = center_y - top

        visible_cx_src, visible_cy_src = get_visible_content_center(overlay)
        visible_cx = visible_cx_src * scale
        visible_cy = visible_cy_src * scale

        paste_x = round(local_cx - visible_cx)
        paste_y = round(local_cy - visible_cy)

    layer.alpha_composite(resized, (paste_x, paste_y))

    if polygon:
        polygon_mask = Image.new("L", (target_w, target_h), 0)
        shifted = [(x - left, y - top) for x, y in polygon]
        ImageDraw.Draw(polygon_mask).polygon(shifted, fill=255)

        if fill_color is None:
            # No background fill requested: only paste actual non-transparent
            # castle pixels, clipped to the province polygon.
            alpha_mask = layer.getchannel("A")
            mask = Image.new("L", (target_w, target_h), 0)
            mask.paste(alpha_mask, (0, 0), polygon_mask)
        else:
            # Background fill requested: fill the whole province polygon, then
            # draw the aspect-ratio-preserved castle on top.
            mask = polygon_mask
    else:
        mask = Image.new("L", (target_w, target_h), 255) if fill_color is not None else layer.getchannel("A")

    canvas.paste(layer, (left, top), mask)


def draw_map_with_sprites(
    path: str,
    provinces: list[Province],
    sprite_dir: str,
    draw_debug_role_markers: bool = False,
    center_image: str | None = None,
    center_corner_image: str | None = None,
    outer_corner_image: str | None = None,
    castle_dir: str | None = None,
    castle_fill_color: str | None = None,
    castle_scale_percent: float = 100.0,
    start_sprite_seed: int | None = None,
    blocks: list[PlayerBlock] | None = None,
    ring_center: tuple[int, int] | None = None,
    ring_inner_radius: int | None = None,
    ring_outer_radius: int | None = None,
) -> tuple[int, int]:
    width = max(p.right for p in provinces) + MARGIN
    height = max(p.bottom for p in provinces) + MARGIN

    canvas = Image.new("RGBA", (width, height), (0, 0, 0, 255))
    draw = ImageDraw.Draw(canvas)
    tiles = load_tiles(sprite_dir)
    start_sprites = load_start_sprites(sprite_dir, castle_dir)
    pick_start_sprite = make_start_sprite_picker(start_sprites, start_sprite_seed)
    parsed_castle_fill_color = parse_hex_rgba(castle_fill_color)
    if castle_scale_percent <= 0:
        raise ValueError("--castle-scale-percent must be greater than 0.")

    if blocks is not None:
        draw_center_image_if_present(canvas, center_image, blocks)

    # For true-ring maps, --outer-corner-image fills the empty square corners
    # outside the outer circular ring. It is drawn before provinces.
    draw_outer_corner_image_outside_ring(
        canvas,
        outer_corner_image,
        ring_center,
        ring_outer_radius,
    )

    # For true-ring maps, --center-corner-image can be used as a mirrored
    # background/filler for the circular empty hole. --center-image is then
    # pasted on top, so both options can be combined.
    draw_center_corner_image_in_ring_hole(
        canvas,
        center_corner_image,
        ring_center,
        ring_inner_radius,
    )
    draw_center_image_in_ring_hole(canvas, center_image, ring_center, ring_inner_radius)

    for p in provinces:
        tile_key = get_tile_key(p)
        tile = tiles[tile_key]

        target_w = p.right - p.left
        target_h = p.bottom - p.top

        if p.points:
            paste_tile_clipped_to_polygon(canvas, tile, p.points, (p.left, p.top, p.right, p.bottom))

            # Start ring only. Holy/throne intentionally have no special visual.
            if p.role == "start":
                start_sprite = pick_start_sprite()
                effective_fill_color = parsed_castle_fill_color
                if effective_fill_color is None:
                    effective_fill_color = get_most_common_visible_color(start_sprite)
                paste_overlay_centered_clipped(
                    canvas,
                    start_sprite,
                    (p.left, p.top, p.right, p.bottom),
                    polygon=p.points,
                    fill_color=effective_fill_color,
                    center=(p.cx, p.cy),
                    scale_percent=castle_scale_percent,
                )

            # polygon border
            draw.polygon(list(p.points), outline=(0, 0, 0, 255))
        else:
            tile_resized = tile.resize((target_w, target_h), Image.Resampling.NEAREST)
            canvas.alpha_composite(tile_resized, (p.left, p.top))

            # Start ring only. Holy/throne intentionally have no special visual.
            if p.role == "start":
                start_sprite = pick_start_sprite()
                effective_fill_color = parsed_castle_fill_color
                if effective_fill_color is None:
                    effective_fill_color = get_most_common_visible_color(start_sprite)
                paste_overlay_centered_clipped(
                    canvas,
                    start_sprite,
                    (p.left, p.top, p.right, p.bottom),
                    fill_color=effective_fill_color,
                    center=(p.cx, p.cy),
                    scale_percent=castle_scale_percent,
                )

            # border
            draw.rectangle([p.left, p.top, p.right - 1, p.bottom - 1], outline=(0, 0, 0, 255), width=1)

        # exactly one white province marker
        cx = p.cx
        cy = p.cy
        if 0 <= cx < width and 0 <= cy < height:
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



def escape_map_string(value: str) -> str:
    """Escape a value for Dominions .map quoted strings."""
    return value.replace("\\", "\\\\").replace('"', r'\"')


def load_province_names_from_csv(path: str) -> list[str]:
    """
    Load province names from a CSV file.

    Uses the first non-empty cell in each row. If the first loaded value looks
    like a header ("name", "province_name", etc.), it is skipped.
    """
    if not os.path.exists(path):
        raise FileNotFoundError(f"Missing province names CSV: {path}")

    names: list[str] = []
    with open(path, newline="", encoding="utf-8-sig") as f:
        reader = csv.reader(f)
        for row in reader:
            name = next((cell.strip() for cell in row if cell.strip()), "")
            if name:
                names.append(name)

    if names and names[0].strip().lower() in {
        "name",
        "names",
        "province",
        "province_name",
        "province name",
        "landname",
        "land name",
    }:
        names = names[1:]

    if not names:
        raise ValueError(f"No usable province names found in CSV: {path}")

    return names


def assign_province_names_from_csv(
    provinces: list[Province],
    csv_path: str | None,
    seed: int,
) -> None:
    """Assign random unique CSV names to provinces, if csv_path is provided."""
    if not csv_path:
        return

    names = load_province_names_from_csv(csv_path)
    if len(names) < len(provinces):
        raise ValueError(
            f"Province names CSV has {len(names)} usable names, "
            f"but the map has {len(provinces)} provinces."
        )

    rng = random.Random(seed)
    selected_names = rng.sample(names, len(provinces))
    for province, display_name in zip(provinces, selected_names):
        province.display_name = display_name


def write_map(
    path: str,
    imagefile: str,
    provinces: list[Province],
    neighbours: list[tuple[int, int]],
    width: int,
    height: int,
    description: str,
) -> None:
    imagefile = sanitize_imagefile_name(imagefile)

    with open(path, "w", encoding="utf-8") as f:
        f.write(f'#dom2title "{MAP_TITLE}"\n')
        f.write(f"#imagefile {imagefile}\n")
        f.write(f"#mapsize {width} {height}\n")
        f.write("#domversion 600\n\n")
        f.write(f'#description "{description}"\n\n')

        for p in provinces:
            f.write(f"#terrain {p.pid} {p.terrain}\n")

        f.write("\n")

        for p in provinces:
            f.write(f'#landname {p.pid} "{escape_map_string(p.landname)}"\n')

        f.write("\n")

        for p in provinces:
            if p.role == "start":
                f.write(f"#start {p.pid}\n")

        f.write("\n")

        for a, b in neighbours:
            f.write(f"#neighbour {a} {b}\n")


def write_debug_mapping(path: str, provinces: list[Province], blocks: list[PlayerBlock]) -> None:
    block_by_player = {b.player: b for b in blocks}
    with open(path, "w", encoding="utf-8") as f:
        f.write("# pid is assigned from the white marker pixel scan order used for the .map file.\n")
        f.write("# For true-ring TGA output from Pillow, visual coordinate scan is bottom-to-top, left-to-right.\n")
        f.write("# pid\tgenerated_name\tlandname\tplayer_block_col\tplayer_block_row\trole\tterrain\tcx\tcy\n")
        for p in sorted(provinces, key=lambda q: q.pid):
            cx = p.cx
            cy = p.cy
            block = block_by_player[p.player]
            f.write(
                f"{p.pid}\t{p.name}\t{p.landname}\t"
                f"block_col={block.col}\tblock_row={block.row}\t"
                f"role={p.role}\tterrain={p.terrain}\tcx={cx}\tcy={cy}\n"
            )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--players", type=int, default=6)
    parser.add_argument("--macro-cols", type=int, default=6)
    parser.add_argument("--seed", type=int, default=12345)
    parser.add_argument(
        "--province-names-csv",
        default=None,
        help=(
            "Optional CSV with province names. The first non-empty cell from each row is used; "
            "names are randomly assigned uniquely to provinces, and the CSV must contain at least "
            "as many usable names as the generated map has provinces."
        ),
    )
    parser.add_argument("--diagonal-neighbours", action="store_true")
    parser.add_argument("--sprite-dir", default=".")
    parser.add_argument(
        "--castle-dir",
        default=None,
        help=(
            "Optional directory with PNG castle/tower start sprites. "
            "If omitted, the script auto-uses <sprite-dir>/castles when it exists; "
            "otherwise it falls back to start_ring_overlay.png."
        ),
    )
    parser.add_argument(
        "--castle-fill-color",
        default=None,
        help=(
            "Optional hex color used as background under castle/tower start sprites, "
            "for example #2b2418. If omitted, the script auto-uses the most common "
            "visible color from the selected castle sprite."
        ),
    )
    parser.add_argument(
        "--castle-scale-percent",
        type=float,
        default=100.0,
        help=(
            "Scale for castle/tower start sprites after normal fit-to-province sizing. "
            "100 = current behavior, 85 = slightly smaller."
        ),
    )
    parser.add_argument(
        "--castle-seed",
        type=int,
        default=None,
        help=(
            "Optional seed for reproducible castle sprite selection. "
            "If omitted, castle choices are randomized every run."
        ),
    )
    parser.add_argument("--output-map", default="generated_true_ring.map")
    parser.add_argument("--output-tga", default="generated_true_ring.tga")
    parser.add_argument("--imagefile", default="generated_true_ring.tga")
    parser.add_argument("--debug-mapping", default="generated_true_ring_debug.txt")
    parser.add_argument("--debug-role-markers", action="store_true")

    parser.add_argument(
        "--layout",
        choices=["ring", "grid", "square-ring"],
        default="ring",
        help="ring creates a true circular annular map; grid/square-ring keep old compatibility layouts.",
    )
    parser.add_argument(
        "--ring-side",
        type=int,
        default=None,
        help="Square side in player-block slots for --layout square-ring. Auto-chosen if omitted.",
    )
    parser.add_argument(
        "--center-image",
        default=None,
        help="Optional decorative image pasted into the empty center for --layout ring or square-ring.",
    )
    parser.add_argument(
        "--center-corner-image",
        default=None,
        help=(
            "Optional image pasted into the true-ring circular hole as four "
            "mirrored/flipped quadrants. Useful as symmetric filler."
        ),
    )
    parser.add_argument(
        "--outer-corner-image",
        default=None,
        help=(
            "Optional image or directory of PNG images used to fill the empty square corners outside "
            "the outer circular ring. If a single image is passed, it is mirrored/flipped per quadrant. "
            "If a directory is passed, PNGs are sorted by filename and assigned deterministically to "
            "tl/tr/bl/br corners (reusing from the start if fewer than 4 images exist)."
        ),
    )
    parser.add_argument(
        "--ring-inner-radius",
        type=int,
        default=RING_INNER_RADIUS,
        help="Inner radius in pixels for --layout ring.",
    )
    parser.add_argument(
        "--ring-outer-radius",
        type=int,
        default=RING_OUTER_RADIUS,
        help="Outer radius in pixels for --layout ring.",
    )

    return parser.parse_args()


def main() -> None:
    args = parse_args()

    if args.players < 1:
        raise ValueError("--players must be at least 1")

    ring_center = None
    ring_inner_radius = None
    ring_outer_radius = None

    if args.layout == "ring":
        blocks = build_player_blocks_true_ring(args.players)

        # Ring pipeline is intentionally ordered this way:
        # 1) neutral province centers/polygons, no players/roles yet
        # 2) Dominions marker-scan IDs
        # 3) neighbours from ring topology indices, not center-pixel distances
        # 4) player assignment by angular sector
        # 5) role/terrain assignment inside each player's 4x4 sector
        provinces = build_province_centers_true_ring(
            args.players,
            inner_radius=args.ring_inner_radius,
            outer_radius=args.ring_outer_radius,
        )
        provinces = assign_ids_by_tga_marker_scan(provinces)
        neighbours = build_neighbours_ring_by_topology(provinces, args.players)
        validate_ring_neighbours(provinces, neighbours, args.players)
        assign_true_ring_provinces_to_players(provinces, args.players)
        assign_true_ring_province_types(provinces, args.players, args.seed)

        description = (
            f"Generated true annular ring map. "
            f"The ring is split into {args.players} equal player sectors; "
            f"each sector is split into {BLOCK * BLOCK} four-sided ring provinces."
        )
        ring_center = (RING_MARGIN + args.ring_outer_radius, RING_MARGIN + args.ring_outer_radius)
        ring_inner_radius = args.ring_inner_radius
        ring_outer_radius = args.ring_outer_radius
    elif args.layout == "square-ring":
        ring_side = choose_ring_side(args.players, args.ring_side)
        blocks = build_player_blocks_square_ring(args.players, ring_side)
        provinces = build_provinces_from_blocks(blocks, args.seed)
        description = (
            f"Generated 4x4-per-player square-ring map. "
            f"Players are placed clockwise on a {ring_side}x{ring_side} block perimeter."
        )
    else:
        macro_cols = choose_macro_cols(args.players, args.macro_cols)
        blocks = build_player_blocks_grid(args.players, macro_cols)
        provinces = build_provinces_from_blocks(blocks, args.seed)
        description = "Generated 4x4-per-player ring grid map using terrain sprites."

    if args.layout != "ring":
        provinces = assign_ids_by_image_scan(provinces)

        if args.layout == "square-ring":
            neighbours = build_neighbours_square_ring(
                provinces,
                blocks,
                diagonal_neighbours=args.diagonal_neighbours,
            )
        else:
            neighbours = build_neighbours_grid(
                provinces,
                args.players,
                diagonal_neighbours=args.diagonal_neighbours,
            )

    assign_province_names_from_csv(
        provinces,
        args.province_names_csv,
        seed=args.seed + 24681357,
    )

    width, height = draw_map_with_sprites(
        args.output_tga,
        provinces,
        args.sprite_dir,
        draw_debug_role_markers=args.debug_role_markers,
        center_image=args.center_image,
        center_corner_image=args.center_corner_image,
        outer_corner_image=args.outer_corner_image,
        castle_dir=args.castle_dir,
        castle_fill_color=args.castle_fill_color,
        castle_scale_percent=args.castle_scale_percent,
        start_sprite_seed=args.castle_seed,
        blocks=blocks if args.layout == "square-ring" else None,
        ring_center=ring_center,
        ring_inner_radius=ring_inner_radius,
        ring_outer_radius=ring_outer_radius,
    )

    write_map(
        args.output_map,
        args.imagefile,
        provinces,
        neighbours,
        width,
        height,
        description=description,
    )

    write_debug_mapping(args.debug_mapping, provinces, blocks)

    print(f"Generated: {args.output_map}")
    print(f"Generated: {args.output_tga}")
    print(f"Generated: {args.debug_mapping}")
    if args.layout == "ring":
        print("Layout: ring")
        print(f"Ring radii: inner={args.ring_inner_radius}, outer={args.ring_outer_radius}")
        print(f"Players: {args.players}; provinces per player: {BLOCK * BLOCK}")
    elif args.layout == "square-ring":
        print("Layout: square-ring")
        print(f"Player block coords: {[(b.player, b.col, b.row) for b in blocks]}")


if __name__ == "__main__":
    main()
