import os
import csv

def read_unit_names(file_path):
    """Reads the BaseU.csv and returns a dictionary of unit names by id."""
    unit_names = {}
    with open(file_path, 'r', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile, delimiter='\t')
        for row in reader:
            unit_id = int(row['id'])
            unit_name = row['name']
            unit_names[unit_id] = {'name': unit_name, 'holy' : row['holy'], 'wpn1' : row['wpn1'], 'wpn2': row['wpn2']}
    return unit_names

def read_ranged_weapons(file_path, only_ranged=False):
    """Reads the weapons.csv and returns a dictionary of ranged weapons by id.
    
    Args:
        file_path (str): The path to the weapons.csv file.
        only_tanged (bool): If True, filters only tanged weapons (ammo > 0).
    
    Returns:
        dict: A dictionary of ranged weapons by id.
    """
    weapons = {}
    with open(file_path, 'r', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile, delimiter='\t')
        for row in reader:
            ammo = int(row['ammo'])
            if ammo > 0 and (not only_ranged or (only_ranged and ammo > 0)):
                weapon_id = int(row['id'])
                weapon_name = row['name']
                weapons[weapon_id] = {
                    'name': weapon_name,
                    'ammo': ammo,
                    'att': int(row['att']),
                    'def': int(row['def']),
                    'len': int(row['len']),
                    'nratt': int(row['nratt']),
                    'secondaryeffect': int(row['secondaryeffect']),
                    'secondaryeffectalways': int(row['secondaryeffectalways']),
                    'rcost': int(row['rcost']),
                    'weapon': int(row['weapon'])
                }
    return weapons

def get_nation_units_with_cap_sites(fort_troop_file, attributes_file, magic_sites_file):
    """
    Adds units from the capital magic site to a nation's unit pool.

    Args:
        fort_troop_file: Path of fort_troop_types_by_nation.csv file
        attributes_file: Path of attributes_by_nation.csv file
        magic_sites_file: Path of MagicSites.csv file

    Returns:
      dict: A dictionary of nation ID with it's respective troops and commanders.
    """

    nation_troops = {}
    with open(fort_troop_file, 'r') as csvfile:
        reader = csv.DictReader(csvfile, delimiter='\t')
        for row in reader:
             nation_id_from_file = int(row['nation_number'])
             monster_id = int(row['monster_number'])
             if nation_id_from_file not in nation_troops:
               nation_troops[nation_id_from_file] = {"monsters":[], "commanders":[]}
             nation_troops[nation_id_from_file]["monsters"].append(monster_id)
    
    # Read attributes to get the capital sites of all nations.
    nation_attributes = {}
    with open(attributes_file, 'r') as csvfile:
        reader = csv.DictReader(csvfile, delimiter='\t')
        for row in reader:
            nation_id_from_file = int(row['nation_number'])
            attribute_id = int(row['attribute'])
            if attribute_id == 52: # Capital site attribute.
              if nation_id_from_file not in nation_attributes:
                 nation_attributes[nation_id_from_file] = []
              nation_attributes[nation_id_from_file].append(int(row["raw_value"])) # Append the capital site id.
    
     # Read magic sites.
    magic_sites_dict = {}
    with open(magic_sites_file, 'r') as csvfile:
      reader = csv.DictReader(csvfile, delimiter='\t')
      for row in reader:
        site_id = int(row['id'])
        magic_sites_dict[site_id] = row

    # Iterate through all nations to add units from their capital sites.
    for nation_id, capital_site_ids in nation_attributes.items():
      if nation_id not in nation_troops:
          nation_troops[nation_id] = {"monsters":[], "commanders":[]}
      for capital_site_id in capital_site_ids:
         magic_site = magic_sites_dict.get(capital_site_id)
         if magic_site:

              unit_ids_from_site = [
                  magic_site.get('hmon1'),
                  magic_site.get('hmon2'),
                  magic_site.get('hmon3'),
                  magic_site.get('hmon4'),
                  magic_site.get('hmon5'),
                  magic_site.get('natmon'),
              ]
              for unit_id in unit_ids_from_site:
                if unit_id is not None and unit_id.strip():
                  unit_id = int(unit_id)
                  if unit_id not in nation_troops[nation_id]["monsters"]:
                     nation_troops[nation_id]["monsters"].append(unit_id)

              commander_ids_from_site = [
                  magic_site.get('hcom1'),
                  magic_site.get('hcom2'),
                  magic_site.get('hcom3'),
                  magic_site.get('hcom4'),
                   magic_site.get('hcom5'),
              ]

              for commander_id in commander_ids_from_site:
                if commander_id is not None and commander_id.strip():
                    commander_id = int(commander_id)
                    if commander_id not in nation_troops[nation_id]["commanders"]:
                       nation_troops[nation_id]["commanders"].append(commander_id)
    
    return nation_troops

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


def generate_event_code(nation_id, commander_ids, unit_data, unit_names, add_strikeunits=True, province_id=1, month=1):
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
        event_code += f"#codedelay 0\n#killcom \"Spy\"\n"

    for commander_id in commander_ids:
        event_code += f"#com {commander_id}\n"

    
    for unit_id, count in unit_data:
        d6 = round(count / 3.5)
        
        while d6 >= 15:
            d6 -= 15
            event_code += f"#15d6units {unit_id}\n"  # Add 15d6 for each ~80 units


        if d6 > 0:  # Check if there's a remainder greater than 0
            event_code += f"#{d6}d6units {unit_id}\n"  # Add 1d6 for each 10 units
            
    comms = len(commander_ids)
    
    unit_name = unit_names[unit_id]['name']
    event_code += f'#header 2\n'
    event_code += f'#msg "Frm: {nation_id}:{unit_id}:{unit_name} {comms} coms at ##landname## {province_id} ."\n'
    event_code += f'#extramsg {nation_id}."\n'
    
    event_code += "#end\n"
    return event_code
    
    
def modify_spells(spells_file, target_school, max_research_level):
    """
    Modifies spells of a specific school, reducing their fatigue cost and research level.

    Args:
       spells_file (str): Path to the spells.csv file.
        target_school (int): The school ID to modify.
        max_research_level (int):  Max research level for a spell to be modified.

    Returns:
        str:  A string of spell modifications in Dominions mod format.
    """
    modified_spells_str = ""
    with open(spells_file, 'r') as csvfile:
        reader = csv.DictReader(csvfile, delimiter='\t')
        for row in reader:
            spell_id = int(row['id'])
            spell_school = int(row['school'])
            research_level = int(row['researchlevel'])
            fatigue_cost = int(row['fatiguecost'])

            if spell_school == target_school and research_level <= max_research_level:
              modified_spells_str += f"""#selectspell {spell_id}
#researchlevel 0
#fatiguecost {min(fatigue_cost, 99)}
#end
"""

    return modified_spells_str    

def create_mod_file(nation1_id, nation2_id, nation_troops, file_path, commanders1, commanders2, unit_costs, unit_names, ranged_weapons, 
                    only_sacreds_1, only_sacreds_2, only_melee_1 = False, only_melee_2 = False, total_gold_cost = 2500):
    """Generates fight events for all combinations of unit pairings."""

    nation1_units_all = nation_troops[nation1_id].get("monsters", [])
    nation2_units_all = nation_troops[nation2_id].get("monsters", [])
    
    #print(nation1_units)

    mod_code = f"""#modname "Test Event Mod"
#description "Mod to create 1 to 1 arena event that spawns all combinations of units from both nations and make them fight with gold cost scaling"
"""

    # Function to filter out non-sacred units
    def filter_sacreds(unit_list, unit_names):
      sacred_units = []
      for unit_id in unit_list:
          unit_data = unit_names.get(unit_id)
          if unit_data and unit_data.get("holy") == '1':
              sacred_units.append(unit_id)
      return sacred_units
    
    def filter_outranged(unit_list, unit_names, ranged_weapons):
        ranged_units = []
        for unit_id in unit_list:
            unit_data = unit_names.get(unit_id)
            if unit_data and not (unit_data.get("wpn2") in ranged_weapons):
                ranged_units.append(unit_id)
        return ranged_units

    nation1_units = nation1_units_all if not only_sacreds_1 else filter_sacreds(nation1_units_all, unit_names)
    nation2_units = nation2_units_all if not only_sacreds_2 else filter_sacreds(nation2_units_all, unit_names)

    nation1_units = nation1_units if not only_melee_1 else filter_outranged(nation1_units, unit_names, ranged_weapons)
    nation2_units = nation2_units if not only_melee_2 else filter_outranged(nation2_units, unit_names, ranged_weapons)

    # for each nation unit sort them by their gcost
    nation1_units.sort(key=lambda unit_id: -unit_costs.get(unit_id, unit_costs))
    nation2_units.sort(key=lambda unit_id: -unit_costs.get(unit_id, unit_costs))

    province_counter = 1
    
    spending_strategies = [
        ("all_units", 1.0, 0.0),  # All gold on units
#        ("half_units", 0.5, 0.5),  # Half gold on units
#        ("20p_units", 0.2, 0.8),  # 20% of gold on units, 80% on commanders
    ]

    for unit1_id in nation1_units:
        for unit2_id in nation2_units:
            for strat1_name, unit1_ratio, com1_ratio in spending_strategies:
                #for strat2_name, unit2_ratio, com2_ratio in spending_strategies:
                    unit1_cost = get_unit_cost(unit1_id, unit_costs)
                    unit2_cost = get_unit_cost(unit2_id, unit_costs)

                    unit1_count = max(1, int((total_gold_cost * unit1_ratio) // max(1, unit1_cost)))
                    unit2_count = max(1, int((total_gold_cost * 1) // max(1, unit2_cost)))

                    commander1_ids = []
                    commander2_ids = []

                    available_commanders = commanders1                     
                    remaining_gold = total_gold_cost * com1_ratio
                    while remaining_gold > 0:
                        clean = []
                        #print(f"remaining_gold: {remaining_gold}\n ")
                        for commander_id in available_commanders:
                            commander_cost = get_unit_cost(commander_id, unit_costs)
                            if commander_cost <= remaining_gold:
                                commander1_ids.append(commander_id)
                                if (commander_cost > 0):
                                    clean.append(commander_id)
                                remaining_gold -= commander_cost
                            else:
                                unit1_count += (remaining_gold // unit1_cost) 
                                remaining_gold = 0 
                                break
                                
                        # do not duplicate sleepers/h3's
                        available_commanders = clean

                        if len(clean) == 0:
                            break;
                                
                    if not commander1_ids:
                        commander1_ids = commanders1
                        
                    commander2_ids = commanders2    

                    # Spawn nation1 army
                    mod_code += generate_event_code(nation1_id, commander1_ids, [(unit1_id, unit1_count)], unit_names,
                                                    add_strikeunits=True, province_id=province_counter)
                    # Spawn nation 2 army
                    mod_code += generate_event_code(nation2_id, commanders2, [(unit2_id, unit2_count)], unit_names,
                                                    add_strikeunits=False, province_id=province_counter)
                    province_counter += 1
   
    spells_file = "dom6inspector/gamedata/spells.csv"
    target_school = 2  # evo
    max_research_level = 3
    modified_spells_str = modify_spells(spells_file, target_school, max_research_level)

    mod_code += modified_spells_str
   
     # Ensure the directory exists
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, "w") as f:
        f.write(mod_code)
    print(f"Mod file created at: {file_path}")



if __name__ == "__main__":
    # Example Data
    nation1_id = 60 # 60 - ulm, 51 - phelgra
    nation1_commanders = [559, 177] #Sleepers as coms <

    nation2_id = 68 #bandar
    nation2_commanders = [559, 177]

    output_file_path = "/home/ilya/.dominions6/mods/testventmod/testeventmod.dm"
    troop_file_path = "dom6inspector/gamedata/fort_troop_types_by_nation.csv"
    gcost_file_path = "gcost.csv"

    unit_costs = read_unit_gold_costs(gcost_file_path)

    fort_troop_file = "dom6inspector/gamedata/fort_troop_types_by_nation.csv"
    attributes_file = "dom6inspector/gamedata/attributes_by_nation.csv"
    magic_sites_file = "dom6inspector/gamedata/MagicSites.csv"
    fort_troop_file = "dom6inspector/gamedata/fort_troop_types_by_nation.csv"
    attributes_file = "dom6inspector/gamedata/attributes_by_nation.csv"
    weapons_file = "dom6inspector/gamedata/weapons.csv"

    nation_troops = get_nation_units_with_cap_sites(fort_troop_file, attributes_file, magic_sites_file)
    
    baseu_file_path = "dom6inspector/gamedata/BaseU.csv"

    unit_names = read_unit_names(baseu_file_path)

    ranged_weapons = read_ranged_weapons(weapons_file, True)
    
    #print(nation_troops)

    create_mod_file(nation1_id, nation2_id, nation_troops, output_file_path, 
                    nation1_commanders, nation2_commanders, unit_costs, unit_names, ranged_weapons, 
                    False, True, True, True)

