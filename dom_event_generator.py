import os
import csv

def read_unit_gold_costs(file_path):
    """Reads the gcost.csv and returns a dictionary of unit gold costs."""
    unit_costs = {}
    with open(file_path, 'r') as csvfile:
        reader = csv.DictReader(csvfile, delimiter='\t')
        #skip header
        next(reader, None)
        for row in reader:
            unit_id = int(float(row['id']))
            if not row['goldcost']:
                gold_cost = 0
            else:
                gold_cost = int(row['goldcost'])
            unit_costs[unit_id] = gold_cost
    return unit_costs


def get_unit_cost(unit_id, unit_costs):
    """Get gold cost of the unit."""
    return unit_costs.get(unit_id, 0)


def read_fort_troop_types(file_path):
    """Reads the fort troop types CSV and returns a dictionary."""
    nation_troops = {}
    with open(file_path, 'r') as csvfile:
        reader = csv.DictReader(csvfile, delimiter='\t')
        for row in reader:
            nation_id = int(row['nation_number'])
            monster_id = int(row['monster_number'])
            if nation_id not in nation_troops:
                nation_troops[nation_id] = []
            nation_troops[nation_id].append(monster_id)
    return nation_troops


def generate_event_code(nation_id, commander_ids, unit_data, add_strikeunits=True, province_id=1, month=1):
    """Generates the event code string for a specific nation."""
    
    #commander_id = commander_ids[0]
    
    event_code = f"""#newevent
#rarity 5
#req_indepok 1
#req_pop0ok
#req_nation {nation_id}
#nation {nation_id}
#req_capital 0
#req_unique 1
#defence -100
"""

    if add_strikeunits:
        event_code += f"#strikeunits 999\n"
        # use as marker for used province
        event_code += f"#req_nomonster \"Spy\"\n#stealthcom \"Spy\"\n"

        event_code += f"#req_code 0\n"
        event_code += f"#code -{province_id}\n"
        
    else:
        event_code += f"#req_code -{province_id}\n#req_monster \"Spy\"\n"
        # clean marker and code
        event_code += f"#codedelay 0\n#killcom \"Spy\""

    for commander_id in commander_ids:
        event_code += f"#com {commander_id}\n"

	
    for unit_id, count in unit_data:
        d6 = (count // 8)
        
        while d6 >= 15:
            d6 -= 15
            event_code += f"#15d6units {unit_id}\n"  # Add 15d6 for each ~80 units


        if d6 > 0:  # Check if there's a remainder greater than 0
            event_code += f"#{d6}d6units {unit_id}\n"  # Add 1d6 for each 10 units

    event_code += f'#msg "Army from nation {nation_id} has arrived at province {province_id}."\n'
    event_code += "#end\n"
    return event_code

def generate_arena_events(nation1_id, nation2_id, nation_troops, file_path, commanders1, commanders2, unit_costs, total_gold_cost = 2000):
    """Generates fight events for all combinations of unit pairings."""

    nation1_units = nation_troops.get(nation1_id, [])
    nation2_units = nation_troops.get(nation2_id, [])

    mod_code = f"""#modname "Test Event Mod"
#description "Mod to create 1 to 1 arena event that spawns all combinations of units from both nations and make them fight with gold cost scaling"
"""
    province_counter = 1
    for unit1_id in nation1_units:
        for unit2_id in nation2_units:        	
            unit1_cost = get_unit_cost(unit1_id, unit_costs)
            unit2_cost = get_unit_cost(unit2_id, unit_costs)
            unit1_count = max(1,total_gold_cost // max(1, unit1_cost))
            unit2_count = max(1,total_gold_cost // max(1, unit2_cost))

            # Spawn nation1 army
            mod_code += generate_event_code(nation1_id, commanders1, [(unit1_id, unit1_count)], add_strikeunits=True, province_id=province_counter, month=1)
             # Spawn nation 2 army
            mod_code += generate_event_code(nation2_id, commanders2, [(unit2_id, unit2_count)], add_strikeunits=False, province_id=province_counter, month=2)
            province_counter += 1
   
 	# Ensure the directory exists
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, "w") as f:
        f.write(mod_code)
    print(f"Mod file created at: {file_path}")


def create_mod_file(nation1, commanders1, nation2, commanders2, file_path, nation_troops, unit_costs):
    generate_arena_events(nation1, nation2, nation_troops, file_path, commanders1, commanders2, unit_costs)


if __name__ == "__main__":
    # Example Data
    nation1_id = 5  # Arcoscephale
    nation1_commanders = [559]

    nation2_id = 6  # Mekone
    nation2_commanders = [559]

    output_file_path = "/home/ilya/.dominions6/mods/testventmod/testeventmod.dm"
    troop_file_path = "dom6inspector/gamedata/fort_troop_types_by_nation.csv"
    gcost_file_path = "gcost.csv"

    unit_costs = read_unit_gold_costs(gcost_file_path)

    nation_troops = read_fort_troop_types(troop_file_path)


    create_mod_file(
        nation1_id, nation1_commanders,
        nation2_id, nation2_commanders,
        output_file_path, nation_troops, unit_costs
    )