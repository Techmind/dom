import re
import os

# SETTINGS
PRINT_BROKEN_LINES = True 

# Mapping Tables
GEM_MAP = {'F': '0', 'A': '1', 'W': '2', 'E': '3', 'S': '4', 'D': '5', 'N': '6', 'G': '7', 'B': '8', 'ALL': '53'}
SCALE_CONVERSION = {
    'turmoil': (0, True), 'chaos': (0, True), 'order': (0, False),
    'sloth': (1, True), 'lazy': (1, True), 'prod': (1, False), 'productivity': (1, False),
    'cold': (2, True), 'heat': (2, False), 'death': (3, True), 'growth': (3, False),
    'misfortune': (4, True), 'unluck': (4, True), 'luck': (4, False),
    'drain': (5, True), 'unmagic': (5, True), 'magic': (5, False)
}

# Boost to Requirement Mapping
BOOST_TO_REQ = {
    'fireboost': 'req_pathfire',
    'airboost': 'req_pathair',
    'waterboost': 'req_pathwater',
    'earthboost': 'req_pathearth',
    'astralboost': 'req_pathastral',
    'deathboost': 'req_pathdeath',
    'natureboost': 'req_pathnature',
    'glamourboost': 'req_pathglamour',
    'bloodboost': 'req_pathblood',
    'holyboost': 'req_pathholy'
}

def is_valid_integer(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

def translate_gem_shorthand(value):
    parts = value.split()
    if len(parts) > 0 and parts[-1].upper() in GEM_MAP:
        parts[-1] = GEM_MAP[parts[-1].upper()]
        return " ".join(parts)
    return value

def handle_scale_cmd(key, val):
    match = re.match(r'^(world)?(inc|dec)scale([23])?$', key.lower())
    if not match or is_valid_integer(val): return key, val
    prefix, direction, strength = match.groups()
    scale_key = val.lower()
    if scale_key in SCALE_CONVERSION:
        target_id, is_neg = SCALE_CONVERSION[scale_key]
        f_dir = direction if is_neg else ('dec' if direction == 'inc' else 'inc')
        return f"{(prefix or '')}{f_dir}scale{(strength or '')}", str(target_id)
    return key, val

def parse_complex_column(content, prefix=""):
    if not content or content.strip() == "": return []
    results = []
    for p in re.split(r'[|;]', content):
        p = p.strip()
        if not p: continue
        match = re.match(r'^([a-zA-Z0-9_]+)\s*(.*)$', p)
        if match:
            key, val = match.groups()
            key_l, val_s = key.lower(), val.strip()
            if key_l == "newsite" and val_s == "-1": continue
            if key_l == "newsite": key = "addsite"
            key, val_s = handle_scale_cmd(key, val_s)
            p_proc = translate_gem_shorthand(f"{key} {val_s}")
            m2 = re.match(r'^([a-zA-Z0-9_]+)\s*(.*)$', p_proc)
            if m2:
                fk, fv = m2.groups()
                if prefix == "req_" and not fk.startswith("req_"): fk = f"req_{fk}"
                results.append((fk, fv))
        else:
            results.append((p, ""))
    return results

def convert_txt_to_dm(input_file, output_file):
    seen_ids = set()
    written, skipped, broken, rarity_err = 0, 0, 0, 0

    with open(input_file, 'r', encoding='utf-8') as f_in, open(output_file, 'w', encoding='utf-8') as f_out:
        f_out.write('#modname "Scales 3/4/5 Balancing Mod v0.5"\n')
        f_out.write('#description "Balancing: Fort/Gold Turn checks & Auto Path Requirements for boosts."\n#version 0.5\n\n')

        for line_num, line in enumerate(f_in, 1):
            cols = line.strip('\n').split('\t')
            if len(cols) < 4 or not cols[0].strip():
                if line.strip(): broken += 1
                continue

            event_id, rarity_val = cols[0].strip(), cols[2].strip()
            if not is_valid_integer(rarity_val):
                rarity_err += 1
                continue
            if event_id in seen_ids:
                skipped += 1
                continue
            seen_ids.add(event_id)

            req_list = parse_complex_column(cols[4] if len(cols) > 4 else "", prefix="req_")
            eff_list = parse_complex_column(cols[5] if len(cols) > 5 else "")

            # BALANCING LOGIC: Turn Requirements
            min_turn = 0
            for ek, ev in eff_list:
                if ek.lower() == "fort" and ev == "0": min_turn = max(min_turn, 15)
                if any(x in ek.lower() for x in ["gold", "exactgold"]) and is_valid_integer(ev):
                    if int(ev) <= -1001: min_turn = max(min_turn, 20)

            if min_turn > 0:
                found_turn = False
                new_reqs = []
                for rk, rv in req_list:
                    if rk == "req_turn" and is_valid_integer(rv):
                        new_reqs.append(("req_turn", str(max(int(rv), min_turn))))
                        found_turn = True
                    else: new_reqs.append((rk, rv))
                if not found_turn: new_reqs.append(("req_turn", str(min_turn)))
                req_list = new_reqs

            # BALANCING LOGIC: Path Requirements for Boosts
            for ek, ev in eff_list:
                boost_key = ek.lower()
                if boost_key in BOOST_TO_REQ:
                    target_req = BOOST_TO_REQ[boost_key]
                    if not any(rk == target_req for rk, rv in req_list):
                        req_list.append((target_req, "1"))

            # WRITE TO FILE
            f_out.write(f"#newevent\n#id {event_id}\n#rarity {rarity_val}\n")
            for rk, rv in req_list: f_out.write(f"#{rk} {rv}\n".strip() + "\n")
            f_out.write(f'#msg "{cols[3].strip()}"\n')
            for ek, ev in eff_list: f_out.write(f"#{ek} {ev}\n".strip() + "\n")
            f_out.write("#end\n\n")
            written += 1

    print(f"Conversion Complete. Written: {written}, Skipped: {skipped}")

if __name__ == "__main__":
    convert_txt_to_dm('events_full.txt', 'eventsmod.dm')
