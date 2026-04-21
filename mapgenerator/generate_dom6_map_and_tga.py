#!/usr/bin/env python3
"""
Generate a Dominions 6 west-east wrap map as both:
- a .map file with terrain + neighbour data
- a flat color-coded .tga image suitable as a first-pass map graphic

Current image strategy
----------------------
- Each province is drawn as a colored rectangular cell.
- A single 1x1 pure-white pixel is placed at the province center so Dominions
  can detect province locations when creating/editing the map.
- No other pixel is allowed to be pure white, because every white pixel would
  be treated as a separate province marker.
- Black borders separate province cells for easy later import into the editor.

This is intentionally ugly-but-usable. The logical topology is the important
part; visuals can be replaced later without changing province ids or links.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, Iterable, List, Set, Tuple


# Dominions 6 terrain mask bits from the manual.
SMALL = 1
LARGE = 2
SWAMP = 32
WASTE = 64
FARM = 256
CAVE = 4096
MOUNTAINS = 8388608
GOOD_THRONE = 33554432
GOOD_START = 67108864
HOLY_SITE = 4194304


@dataclass
class Province:
    pid: int
    player_idx: int
    local_x: int
    local_y: int
    global_x: int
    x: int
    y: int
    left: int
    top: int
    right: int
    bottom: int
    tags: Set[str] = field(default_factory=set)
    neighbours: Set[int] = field(default_factory=set)

    def terrain_mask(self) -> int:
        mask = SMALL
        if "large" in self.tags:
            mask |= LARGE
            mask &= ~SMALL
        if "swamp" in self.tags:
            mask |= SWAMP
        if "waste" in self.tags:
            mask |= WASTE
        if "farm" in self.tags:
            mask |= FARM
        if "cave" in self.tags:
            mask |= CAVE
        if "mountain" in self.tags:
            mask |= MOUNTAINS
        if "throne" in self.tags:
            mask |= GOOD_THRONE
        if "start" in self.tags:
            mask |= GOOD_START
        if "holy" in self.tags:
            mask |= HOLY_SITE
        return mask

    def color_key(self) -> str:
        # Priority order for temporary debug coloring.
        for key in ("start", "throne", "holy", "cave", "swamp", "waste", "farm", "mountain"):
            if key in self.tags:
                return key
        return "plain"


def local_id(x: int, y: int) -> int:
    return y * 4 + x


def make_player_template() -> Dict[int, Set[str]]:
    template: Dict[int, Set[str]] = {i: set() for i in range(16)}

    template[local_id(1, 1)].add("start")

    # Thrones must not connect to the start province.
    template[local_id(3, 0)].update({"throne", "mountain"})
    template[local_id(3, 3)].update({"throne", "large"})

    template[local_id(0, 3)].add("holy")

    template[local_id(0, 0)].add("farm")
    template[local_id(1, 0)].add("farm")
    template[local_id(2, 0)].add("mountain")
    template[local_id(0, 1)].add("cave")
    template[local_id(2, 1)].add("waste")
    template[local_id(3, 1)].add("large")
    template[local_id(0, 2)].add("swamp")

    return template


def build_provinces(players: int, cell_w: int, cell_h: int, margin: int, row_gap: int) -> List[Province]:
    provinces: List[Province] = []
    template = make_player_template()
    pid = 1

    for p in range(players):
        for y in range(4):
            for x in range(4):
                gx = p * 4 + x
                left = margin + gx * cell_w
                top = margin + y * (cell_h + row_gap)
                right = left + cell_w - 1
                bottom = top + cell_h - 1
                cx = (left + right) // 2
                cy = (top + bottom) // 2
                provinces.append(
                    Province(
                        pid=pid,
                        player_idx=p,
                        local_x=x,
                        local_y=y,
                        global_x=gx,
                        x=cx,
                        y=cy,
                        left=left,
                        top=top,
                        right=right,
                        bottom=bottom,
                        tags=set(template[local_id(x, y)]),
                    )
                )
                pid += 1

    return provinces


def grid_lookup(provinces: Iterable[Province]) -> Dict[Tuple[int, int], Province]:
    return {(p.global_x, p.local_y): p for p in provinces}


def add_neighbour_edges(provinces: List[Province], players: int) -> None:
    total_cols = players * 4
    lut = grid_lookup(provinces)

    for p in provinces:
        for dy in (-1, 0, 1):
            for dx in (-1, 0, 1):
                if dx == 0 and dy == 0:
                    continue
                nx = (p.global_x + dx) % total_cols
                ny = p.local_y + dy
                if not (0 <= ny < 4):
                    continue
                q = lut[(nx, ny)]
                if q.pid != p.pid:
                    p.neighbours.add(q.pid)
                    q.neighbours.add(p.pid)


def validate(provinces: List[Province], players: int) -> None:
    required_counts = {
        "mountain": 2,
        "cave": 1,
        "swamp": 1,
        "waste": 1,
        "farm": 2,
        "large": 2,
        "start": 1,
        "throne": 2,
        "holy": 1,
    }

    by_player: Dict[int, List[Province]] = {p: [] for p in range(players)}
    for prov in provinces:
        by_player[prov.player_idx].append(prov)

    for player_idx, plist in by_player.items():
        counts = {k: 0 for k in required_counts}
        plain_count = 0
        start_prov = None
        throne_provs: List[Province] = []

        for p in plist:
            tagged = False
            for tag in required_counts:
                if tag in p.tags:
                    counts[tag] += 1
                    tagged = True
            if "start" in p.tags:
                start_prov = p
            if "throne" in p.tags:
                throne_provs.append(p)
            if not tagged:
                plain_count += 1

        for tag, expected in required_counts.items():
            if counts[tag] != expected:
                raise ValueError(f"Player {player_idx + 1}: expected {expected} {tag}, got {counts[tag]}")

        if plain_count < 1:
            raise ValueError(f"Player {player_idx + 1}: expected at least 1 plain province")

        assert start_prov is not None
        for throne in throne_provs:
            if throne.pid in start_prov.neighbours:
                raise ValueError(
                    f"Player {player_idx + 1}: throne province {throne.pid} is connected to start {start_prov.pid}"
                )


def compute_canvas(players: int, cell_w: int, cell_h: int, margin: int, row_gap: int) -> Tuple[int, int]:
    width = margin * 2 + players * 4 * cell_w
    height = margin * 2 + 4 * cell_h + 3 * row_gap
    return width, height


def map_header(title: str, imagefile: str, width: int, height: int) -> List[str]:
    return [
        f'#dom2title "{title}"',
        '#domversion 600',
        f'#imagefile "{imagefile}"',
        f'#mapsize {width} {height}',
        '#description "Generated west-east wrap map with 4x4 blocks per player."',
        '#nodeepcaves',
        '#nodeepchoice',
        '#maptextcol 1.0 1.0 1.0 1.0',
        '#mapdomcol 255 255 255 80',
        '',
        '-- Province centers for later image generation:',
    ]


def emit_map(provinces: List[Province], title: str, imagefile: str, width: int, height: int) -> str:
    lines = map_header(title, imagefile, width, height)

    for p in provinces:
        tag_text = ", ".join(sorted(p.tags)) if p.tags else "plain"
        lines.append(
            f'-- Province {p.pid}: center=({p.x},{p.y}) rect=({p.left},{p.top})-({p.right},{p.bottom}) '
            f'player={p.player_idx + 1} local=({p.local_x},{p.local_y}) tags=[{tag_text}]'
        )

    lines.append('')
    lines.append('-- Terrain definitions')
    for p in provinces:
        lines.append(f'#terrain {p.pid} {p.terrain_mask()}')

    lines.append('')
    lines.append('-- Start locations')
    for p in provinces:
        if "start" in p.tags:
            lines.append(f'#start {p.pid}')

    lines.append('')
    lines.append('-- Province names')
    for p in provinces:
        lines.append(f'#landname {p.pid} "P{p.player_idx + 1}_{p.local_x}_{p.local_y}"')

    lines.append('')
    lines.append('-- Neighbor links')
    emitted: Set[Tuple[int, int]] = set()
    for p in provinces:
        for n in sorted(p.neighbours):
            edge = (min(p.pid, n), max(p.pid, n))
            if edge not in emitted:
                lines.append(f'#neighbour {edge[0]} {edge[1]}')
                emitted.add(edge)

    lines.append('')
    lines.append('-- End of generated map')
    return "\n".join(lines) + "\n"


class Image:
    def __init__(self, width: int, height: int, bg: Tuple[int, int, int]) -> None:
        self.width = width
        self.height = height
        self.pixels: List[List[Tuple[int, int, int]]] = [
            [bg for _ in range(width)] for _ in range(height)
        ]

    def put(self, x: int, y: int, color: Tuple[int, int, int]) -> None:
        if 0 <= x < self.width and 0 <= y < self.height:
            self.pixels[y][x] = color

    def fill_rect(self, left: int, top: int, right: int, bottom: int, color: Tuple[int, int, int]) -> None:
        left = max(0, left)
        top = max(0, top)
        right = min(self.width - 1, right)
        bottom = min(self.height - 1, bottom)
        for y in range(top, bottom + 1):
            row = self.pixels[y]
            for x in range(left, right + 1):
                row[x] = color

    def rect_outline(self, left: int, top: int, right: int, bottom: int, color: Tuple[int, int, int], thickness: int = 1) -> None:
        for t in range(thickness):
            l, r = left + t, right - t
            u, d = top + t, bottom - t
            if l > r or u > d:
                return
            for x in range(l, r + 1):
                self.put(x, u, color)
                self.put(x, d, color)
            for y in range(u, d + 1):
                self.put(l, y, color)
                self.put(r, y, color)

    def save_tga(self, path: Path) -> None:
        header = bytearray(18)
        header[2] = 2  # uncompressed true-color image
        header[12] = self.width & 0xFF
        header[13] = (self.width >> 8) & 0xFF
        header[14] = self.height & 0xFF
        header[15] = (self.height >> 8) & 0xFF
        header[16] = 24  # bits per pixel
        header[17] = 0x20  # top-left origin

        with path.open("wb") as f:
            f.write(header)
            for y in range(self.height):
                for x in range(self.width):
                    r, g, b = self.pixels[y][x]
                    f.write(bytes((b, g, r)))


def province_fill_color(province: Province) -> Tuple[int, int, int]:
    base = {
        "plain": (170, 150, 110),
        "farm": (210, 180, 80),
        "mountain": (120, 120, 120),
        "cave": (70, 70, 95),
        "swamp": (80, 120, 70),
        "waste": (185, 125, 70),
        "holy": (200, 170, 210),
        "throne": (170, 90, 170),
        "start": (90, 170, 220),
    }[province.color_key()]

    # Give each player a subtle tint so the block structure is visible.
    player_tints = [
        (18, 0, 0),
        (0, 18, 0),
        (0, 0, 18),
        (18, 18, 0),
        (18, 0, 18),
        (0, 18, 18),
        (12, 8, 0),
        (0, 12, 8),
    ]
    tint = player_tints[province.player_idx % len(player_tints)]
    return tuple(min(250, c + t) for c, t in zip(base, tint))


def draw_map_image(width: int, height: int, provinces: List[Province], players: int) -> Image:
    img = Image(width, height, bg=(35, 35, 40))
    black = (0, 0, 0)
    white = (255, 255, 255)
    player_sep = (40, 40, 55)

    # Slight player block backplates.
    for p in range(players):
        left = min(pr.left for pr in provinces if pr.player_idx == p) - 6
        top = min(pr.top for pr in provinces if pr.player_idx == p) - 6
        right = max(pr.right for pr in provinces if pr.player_idx == p) + 6
        bottom = max(pr.bottom for pr in provinces if pr.player_idx == p) + 6
        img.fill_rect(left, top, right, bottom, player_sep)

    for prov in provinces:
        fill = province_fill_color(prov)
        img.fill_rect(prov.left, prov.top, prov.right, prov.bottom, fill)
        img.rect_outline(prov.left, prov.top, prov.right, prov.bottom, black, thickness=2)

        # Large provinces get an extra inset outline.
        if "large" in prov.tags:
            img.rect_outline(prov.left + 10, prov.top + 10, prov.right - 10, prov.bottom - 10, (245, 245, 245), thickness=2)

        # Visual role markers.
        if "start" in prov.tags:
            img.fill_rect(prov.x - 7, prov.y - 7, prov.x + 7, prov.y + 7, (30, 210, 255))
        if "throne" in prov.tags:
            img.fill_rect(prov.x - 10, prov.y - 3, prov.x + 10, prov.y + 3, (220, 70, 220))
            img.fill_rect(prov.x - 3, prov.y - 10, prov.x + 3, prov.y + 10, (220, 70, 220))
        if "holy" in prov.tags:
            img.fill_rect(prov.x - 9, prov.y - 1, prov.x + 9, prov.y + 1, (235, 210, 255))
            img.fill_rect(prov.x - 1, prov.y - 9, prov.x + 1, prov.y + 9, (235, 210, 255))

        # The province marker Dominions should detect.
        img.put(prov.x, prov.y, white)

    return img


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate a Dominions 6 west-east wrap .map and debug .tga.")
    parser.add_argument("--players", type=int, default=6, help="Number of players / 4x4 blocks.")
    parser.add_argument("--title", default="Generated Ring Grid", help="Map title.")
    parser.add_argument("--imagefile", default="generated_ring_grid.tga", help="Referenced TGA image filename.")
    parser.add_argument("--output-map", default="generated_ring_grid.map", help="Output .map path.")
    parser.add_argument("--output-tga", default="generated_ring_grid.tga", help="Output .tga path.")
    parser.add_argument("--cell-width", type=int, default=96, help="Province cell width in pixels.")
    parser.add_argument("--cell-height", type=int, default=96, help="Province cell height in pixels.")
    parser.add_argument("--row-gap", type=int, default=12, help="Extra vertical spacing between rows.")
    parser.add_argument("--margin", type=int, default=48, help="Canvas margin in pixels.")
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if args.players < 2:
        raise SystemExit("players must be >= 2")

    width, height = compute_canvas(args.players, args.cell_width, args.cell_height, args.margin, args.row_gap)
    provinces = build_provinces(args.players, args.cell_width, args.cell_height, args.margin, args.row_gap)
    add_neighbour_edges(provinces, args.players)
    validate(provinces, args.players)

    map_text = emit_map(provinces, args.title, Path(args.imagefile).name, width, height)
    Path(args.output_map).write_text(map_text, encoding="utf-8")

    image = draw_map_image(width, height, provinces, args.players)
    image.save_tga(Path(args.output_tga))

    print(f"Wrote map: {args.output_map}")
    print(f"Wrote tga: {args.output_tga}")
    print(f"Players: {args.players}")
    print(f"Provinces: {len(provinces)}")
    print(f"Canvas: {width}x{height}")
    print("Start provinces:", ", ".join(str(p.pid) for p in provinces if "start" in p.tags))


if __name__ == "__main__":
    main()
