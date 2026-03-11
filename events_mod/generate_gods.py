import csv

def generate_pretender_mod(input_csv, output_dm):
    # Mapping paths to scale influences
    # format: {path_header: {scale_command: modifier_value}}
    PATH_INFLUENCE = {
        'F': {'moreheat': 1},
        'A': {'moremagic': 1, 'moreheat': -1},
        'W': {'moreheat': -1},
        'E': {'moreprod': 1, 'moremagic': -1},
        'S': {'moreorder': 1, 'moremagic': 1},
        'D': {'moregrowth': -1},
        'N': {'moregrowth': 1, 'moreprod' : -1},
        'G': {'moremagic': 1, 'moreluck': 1},
        'B': {'moreluck': -1, 'moreorder': -1}
    }

    # Pretender type multipliers based on startdom
    # 1: Rainbow, 2: Monster, 3: Titan, 4: Immobile
    TYPE_MULTIPLIER = {
        '1': 1,
        '2': 1,
        '3': 2,
        '4': 2
    }

    mod_lines = [
        '#modname "Pretender Scale Limits Expansion"',
        '#description "Adjusts pretender scale limits based on their magical nature and pretender type."',
        '#version 1.0\n'
    ]

    try:
        with open(input_csv, mode='r', encoding='utf-8') as f:
            # Using DictReader to handle columns by name
            reader = csv.DictReader(f, delimiter='\t')
            
            for row in reader:
                startdom = row.get('startdom', '0')
                
                # Only process pretenders (startdom 1-4)
                if startdom not in TYPE_MULTIPLIER:
                    continue
                
                unit_id = row['id']
                unit_name = row['name']
                multiplier = TYPE_MULTIPLIER[startdom]
                
                # Dictionary to track influences on each scale
                # We store as: scale -> [(path_level, modifier)]
                scale_tally = {
                    'moreorder': [],
                    'moreprod': [],
                    'moreheat': [],
                    'moregrowth': [],
                    'moreluck': [],
                    'moremagic': []
                }

                # Check each path
                for path, influences in PATH_INFLUENCE.items():
                    level_str = row.get(path, '0')
                    try:
                        level = int(level_str)
                    except ValueError:
                        level = 0
                    
                    if level > 0:
                        for scale, mod in influences.items():
                            scale_tally[scale].append((level, mod))

                # Resolve conflicts using "Take biggest value" logic
                final_scales = {}
                for scale, mods in scale_tally.items():
                    if not mods:
                        continue
                    
                    # Sort by path level descending
                    mods.sort(key=lambda x: x[0], reverse=True)
                    
                    # Take the modifier from the path with the highest level
                    # If levels are tied, this logic takes the first one found
                    best_mod = mods[0][1]
                    
                    calc_val = best_mod * multiplier
                    if calc_val != 0:
                        final_scales[scale] = calc_val

                # If the unit has any changes, write them to the mod
                if final_scales:
                    mod_lines.append(f'#selectmonster {unit_id} -- {unit_name}')
                    for scale_cmd, value in final_scales.items():
                        # Dominions mods use positive for "increase possible" 
                        # but moregrowth -1 correctly represents more death
                        mod_lines.append(f'#{scale_cmd} {value}')
                    mod_lines.append('#end\n')

        # Write to file
        with open(output_dm, 'w', encoding='utf-8') as f_out:
            f_out.write('\n'.join(mod_lines))
        
        print(f"Successfully generated {output_dm}")

    except FileNotFoundError:
        print("Error: BaseU.csv not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    # Change these filenames as needed
    generate_pretender_mod('../dom6inspector/gamedata/BaseU.csv', 'PretenderScales.dm')
