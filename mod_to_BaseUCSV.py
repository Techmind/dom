import re
import csv
import copy

def parse_mod_file(mod_file_path, base_units):
    """
    Parses a Dominions 6 mod file and extracts unit data.

    Args:
        mod_file_path (str): The path to the .dm mod file.

    Returns:
        list: A list of dictionaries, where each dictionary represents a unit
              and its attributes.  Returns an empty list if no units are found
              or if an error occurs.
    """

    units = base_units
    current_unit = {}
    try:
        line_no = 0
        with open(mod_file_path, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                line_no = line_no + 1

                # Handle comments and empty lines
                if line.startswith('--') or not line:
                    continue

                match = re.match(r"#selectmonster\s+\"([^\"]+)\"|#selectmonster\s+(\d+)", line)
                if match:
                  if current_unit:
                      units.append(current_unit)
                      current_unit = {}

                  

                  if match.group(1): #name
                    current_unit['name'] = match.group(1)
                    current_unit['id'] = -1   # Placeholder, as it's name based.
                  elif match.group(2): #number                      # Start a new unit
                    id = int(match.group(2))
                    if (not id in units):
                        units[id] = {'id' : id}
                    current_unit = units[id]
                    current_unit['id'] = match.group(2)
                    continue

                  current_unit = {'line' : line_no}

                match = re.match(r"#newmonster(?:\s+(\d+))?", line)
                if match:
                    if current_unit:
                        units[id] = current_unit

                    current_unit = {'id': -1, 'name': 'UNKNOWN', 'line' : line_no} # Placeholder
                    if match.group(1):  # If a number is provided                            
                       id = int(match.group(1))
                       #print(id)
                       current_unit['id'] = id

                    continue


                match = re.match(r"#(\w+)\s*(-?[^-]*)(\-\-\s?.*)?", line) # all other commands, ex: #name "testname"
                if match:
                  command = match.group(1)
                  argument = match.group(2).strip()

                  #print(['XX', current_unit, match, command, argument])

                  if not current_unit:
                      continue
                  elif command == 'name':
                      current_unit['name'] = argument.replace('"', '').strip() # Remove quotes
                  elif command == 'spr1' or command == "spr2":
                      if 'graphics' not in current_unit:
                        current_unit['graphics'] = []
                      current_unit['graphics'].append((command,argument.replace('"', '').strip())) # Remove quotes
                  elif command == 'copystats':
                    # copy existing stats from unit by id
                    current_unit['copystats'] = argument
                    id_copy = int(argument)
                    if (id_copy in units):
                      current_unit = copy.deepcopy(units[id_copy])
                    else:
                      print(f"Failed to copystats {id_copy} to {id}")
                    current_unit['id'] = id
                    current_unit['line_no'] = line_no
                  elif command == "fixedname":
                    current_unit['fixedname'] = argument.replace('"', '').strip() # Remove quotes
                  elif command == "descr":
                    current_unit['descr'] = argument.replace('"', '').strip() # Remove quotes
                  elif command in ("gcost", "rcost", "hp", "str", "att", "def", "prec", "mr", "mor", "enc", "mapmove", "ap", "size", "ressize"):
                      try:
                          current_unit[command] = int(argument) # Convert numerical arguments to int
                      except ValueError:
                          print(f"Warning: Invalid integer value for {command}: {argument}")
                  elif command == 'montag':
                    if 'montag' not in current_unit:
                      current_unit['montag'] = ""
                    #print('MONTAG', line_no, argument)
                    current_unit['montag'] = int(argument)

                  elif command == 'weapon':
                      # Handle weapon command (can have name or number)
                      weapon_arg = argument.replace('"', '').strip()
                      if 'weapon' not in current_unit:
                          current_unit['weapon'] = []
                      current_unit['weapon'].append(weapon_arg)

                  elif command == 'armor':
                      armor_arg = argument.replace('"', '').strip()
                      if 'armor' not in current_unit:
                        current_unit['armor'] = []
                      #print(f"BEF line_no: {line_no}", current_unit)
                      current_unit['armor'].append(armor_arg)
                      #print(f"AFT line_no: {line_no}", current_unit)
                  elif command == 'startitem':
                      # Handle weapon command (can have name or number)
                      startitem_arg = argument.replace('"', '').strip()
                      if 'startitem' not in current_unit or current_unit['startitem'] == '':
                          current_unit['startitem'] = []
                      if isinstance(current_unit['startitem'], str):
                        current_unit['startitem'] = [current_unit['startitem']]
                      current_unit['startitem'].append(startitem_arg)
                  elif command == 'itemslots':
                      current_unit['itemslots'] = argument
                  elif command == 'shapechange':
                    current_unit['shapechange'] = argument.replace('"', '').strip()
                  elif command == "homerealm":
                    current_unit['homerealm'] = argument.replace('"', '').strip()
                  elif command == 'nametype':
                    current_unit['nametype'] = argument.replace('"', '').strip()
                  elif command == 'pathcost':
                    current_unit['pathcost'] = argument
                  elif command == "startdom":
                      current_unit['startdom'] = argument
                  elif command.startswith("magicskill"):
                        parts = argument.split()
                        if len(parts) == 2:
                            path, level = parts
                            if 'magicskill' not in current_unit:
                                current_unit['magicskill'] = {}
                            current_unit['magicskill'][path] = int(level)

                  elif command == 'end':
                      #print(f"endmonster {line_no}")
                      if current_unit:
                          #print(current_unit)
                          units[current_unit['id']] = current_unit
                          current_unit = {}
                      continue  # Skip adding #end as a command
                  continue

                match = re.match(r"#(\w+)", line) #Commands without argument.
                if match:
                  command = match.group(1)
                  #print(f"#{line_no}:{command}:{line}")
                  if command == 'end':
                        #print(f"endmonster {line_no}")
                        if current_unit:
                            units[id] = current_unit
                            current_unit = {}
                        continue  # Skip adding #end as a command
                  elif command == 'cleararmor':
                    current_unit['armor'] = []
                  elif command == 'clearweapons':
                    current_unit['weapons'] = []
                  #append command only to units
                  elif current_unit:
                    current_unit[command] = 1 # set to 1


            if current_unit: # Append the last unit if it exists
                units.append(current_unit)

    except FileNotFoundError:
        print(f"Error: Mod file not found at {mod_file_path}")
        return []
    except Exception as e:
        print(f"Error parsing mod file line_no {line_no}: {e}" + e.with_traceback())
        return []

    return units



def convert_to_csv(units, csv_file_path, baseu_weapon_map, baseu_armor_map):
    """Converts the extracted unit data into BaseU.csv format.

    Args:
        units (list): A list of unit dictionaries.
        csv_file_path (str): The path to the output CSV file.
        baseu_weapon_map (dict): weapon map dictionary
        baseu_armor_map (dict): armor map dictionary.
    """

    # BaseU.csv header
    fieldnames = ['id', 'name', 'wpn1', 'wpn2', 'wpn3', 'wpn4', 'wpn5', 'wpn6', 'wpn7',
                  'armor1', 'armor2', 'armor3', 'armor4', 'rt', 'reclimit', 'basecost', 'rcost',
                  'size', 'ressize', 'hp', 'prot', 'mr', 'mor', 'str', 'att', 'def', 'prec',
                  'enc', 'mapmove', 'ap', 'ambidextrous', 'mounted', 'mountmnr', 'skilledrider', 'reinvigoration',
                  'leader', 'undeadleader', 'magicleader', 'startage', 'maxage',
                  'hand', 'bow', 'head', 'body', 'foot', 'misc', 'crownonly',
                  'pathcost', 'startdom', 'bonusspells',
                  'F', 'A', 'W', 'E', 'S', 'D', 'N', 'G', 'B', 'H',
                  'rand1', 'nbr1', 'link1', 'mask1',
                  'rand2', 'nbr2', 'link2', 'mask2',
                  'rand3', 'nbr3', 'link3', 'mask3',
                  'rand4', 'nbr4', 'link4', 'mask4',
                  'holy', 'inquisitor', 'mind', 'inanimate', 'undead', 'demon', 'magicbeing',
                  'stonebeing', 'animal', 'coldblood', 'female', 'forestsurvival',
                  'mountainsurvival', 'wastesurvival', 'swampsurvival', 'cavesurvival',
                  'aquatic', 'amphibian', 'pooramphibian', 'float', 'flying', 'stormimmune',
                  'teleport', 'immobile', 'noriverpass', 'sailingshipsize', 'sailingmaxunitsize',
                  'stealthy', 'illusion', 'spy', 'assassin', 'patience', 'seduce',
                  'succubus', 'corrupt', 'heal', 'immortal', 'domimmortal', 'reinc', 'noheal',
                  'neednoteat', 'homesick', 'undisciplined', 'formationfighter', 'slave',
                  'standard', 'inspirational', 'taskmaster', 'beastmaster', 'bodyguard',
                  'waterbreathing', 'iceprot', 'invulnerable', 'slashres', 'bluntres',
                  'pierceres', 'shockres', 'fireres', 'coldres', 'poisonres', 'acidres',
                  'voidsanity', 'darkvision', 'blind', 'animalawe', 'awe', 'haltheretic',
                  'fear', 'berserk', 'cold', 'heat', 'fireshield', 'banefireshield',
                  'damagerev', 'poisoncloud', 'diseasecloud', 'slimer', 'mindslime',
                  'reform', 'regeneration', 'reanimator', 'poisonarmor', 'petrify',
                  'eyeloss', 'ethereal', 'ethtrue', 'deathcurse', 'trample', 'trampswallow',
                  'stormpower', 'firepower', 'coldpower', 'darkpower', 'chaospower',
                  'magicpower', 'winterpower', 'springpower', 'summerpower', 'fallpower',
                  'forgebonus', 'fixforgebonus', 'mastersmith', 'resources', 'autohealer',
                  'autodishealer', 'alch', 'nobadevents', 'event', 'insane',
                  'shatteredsoul', 'leper', 'taxcollector', 'gem', 'gemprod', 'chaosrec',
                  'pillagebonus', 'patrolbonus', 'castledef', 'siegebonus', 'incprovdef',
                  'supplybonus', 'incunrest', 'popkill', 'researchbonus', 'drainimmune',
                  'inspiringres', 'douse', 'adeptsacr', 'crossbreeder', 'makepearls',
                  'pathboost', 'allrange', 'voidsum', 'heretic', 'elegist', 'shapechange',
                  'firstshape', 'secondshape', 'secondtmpshape', 'landshape', 'watershape',
                  'forestshape', 'plainshape', 'xpshape', 'unique', 'fixedname', 'special',
                  'nametype', 'summon', 'n_summon', 'batstartsum1', 'batstartsum2',
                  'domsummon', 'domsummon2', 'domsummon20', 'raredomsummon', 'bloodvengeance',
                  'bringeroffortune', 'realm1', 'realm2', 'realm3',
                  'batstartsum3', 'batstartsum4', 'batstartsum5',
                  'batstartsum1d6', 'batstartsum2d6', 'batstartsum3d6', 'batstartsum4d6',
                  'batstartsum5d6', 'batstartsum6d6', 'turmoilsummon', 'coldsummon',
                  'scalewalls', 'deathfire', 'uwregen', 'shrinkhp', 'growhp', 'transformation',
                  'startingaff', 'fixedresearch', 'divineins', 'lamialord', 'preanimator',
                  'dreanimator', 'mummify', 'onebattlespell', 'fireattuned', 'airattuned',
                  'waterattuned', 'earthattuned', 'astralattuned', 'deathattuned',
                  'natureattuned', 'bloodattuned', 'magicboostF', 'magicboostA',
                  'magicboostW', 'magicboostE', 'magicboostS', 'magicboostD', 'magicboostN',
                  'magicboostALL', 'eyes', 'heatrec', 'coldrec', 'spreadchaos', 'spreaddeath',
                  'corpseeater', 'poisonskin', 'bug', 'uwbug', 'spreaddom', 'battlesum5',
                  'acidshield', 'drake', 'prophetshape', 'horror', 'enchrebate50p', 'latehero',
                  'sailsize', 'uwdamage', 'landdamage', 'rpcost', 'buffer',
                  'rand5', 'nbr5', 'link5', 'mask5',
                  'rand6', 'nbr6', 'link6', 'mask6',
                  'mummification', 'diseaseres', 'raiseonkill', 'raiseshape', 'sendlesserhorrormult',
                  'xploss', 'theftofthesunawe', 'incorporate', 'hpoverslow', 'blessbers',
                  'dragonlord', 'curseattacker', 'uwheat', 'slothresearch', 'horrordeserter',
                  'mindvessel', 'elementrange', 'sorceryrange', 'older', 'disbelieve',
                  'firerange', 'astralrange', 'landreinvigoration', 'naturerange', 'beartattoo',
                  'horsetattoo', 'reincarnation', 'wolftattoo', 'boartattoo', 'sleepaura',
                  'snaketattoo', 'appetite', 'astralfetters', 'foreignmagicboost', 'templetrainer',
                  'infernoret', 'kokytosret', 'addrandomage', 'unsurr', 'combatcaster',
                  'homeshape', 'speciallook', 'aisinglerec', 'nowish', 'bugreform', 'mason',
                  'onisummon', 'sunawe', 'spiritsight', 'ownblood', 'invisible', 'startaff',
                  'ivylord', 'spellsinger', 'magicstudy', 'triplegod', 'triplegodmag',
                  'unify', 'triple3mon', 'yearturn', 'fortkill', 'thronekill', 'digest',
                  'indepmove', 'unteleportable', 'reanimpriest', 'stunimmunity', 'entangle',
                  'alchemy', 'woundfend', 'singlebattle', 'falsearmy', 'summon5', 'ainorec',
                  'researchwithoutmagic', 'slaver', 'autocompete', 'deathparalyze', 'adventurers',
                  'cleanshape', 'reglab', 'reqtemple', 'horrormarked',
                  'changetargetgenderforseductionandseductionimmune',
                  'corpseconstruct', 'guardianspiritmodifier', 'isashah', 'isayazad', 'isadaeva',
                  'blessfly', 'plant', 'clockworklord', 'commaster', 'comslave',
                  'minsizeleader', 'snowmove', 'swimming', 'stupid', 'skirmisher', 'ironvul',
                  'heathensummon', 'unseen', 'powerofdeath', 'reformtime', 'immortalrespawn',
                  'nomovepen', 'wolf', 'dungeon', 'graphicsize', 'twiceborn', 'aboleth',
                  'tmpastralgems', 'localsun', 'tmpfiregems', 'defiler', 'mountedbeserk',
                  'lanceok', 'startheroab', 'minprison', 'uwfireshield', 'saltvul', 'landenc',
                  'plaguedoctor', 'curseluckshield', 'pathboostuw', 'pathboostland',
                  'noarmormapmovepenalty', 'farthronekill', 'hpoverflow', 'indepstay', 'polyimmune',
                  'horrormark', 'deathdisease', 'allret', 'percentpathreduction', 'aciddigest',
                  'beckon', 'slaverbonus', 'carcasscollector', 'mindcollar', 'labpromotion',
                  'mountainrec', 'indepspells', 'enchrebate50', 'summon1', 'randomspell',
                  'deathpower', 'deathrec', 'norange', 'insanify', 'reanimator', 'defector',
                  'nohof', 'batstartsum1d3', 'enchrebate10', 'undying', 'moralebonus',
                  'uncurableaffliction', 'autoblessed', 'wintersummon1d3', 'stygianguide',
                  'almostundead', 'truesight', 'smartmount', 'mobilearcher', 'reformingflesh',
                  'fearoftheflood', 'spiritform', 'chorusslave', 'chorusmaster', 'tightrein',
                  'corpsestitcher', 'reconstruction', 'nofriders', 'coridermnr', 'holycost',
                  'animatemnr', 'lich', 'glamourman', 'erastartageincrease', 'moreorder',
                  'moregrowth', 'moreprod', 'moreheat', 'moreluck', 'moremagic',
                  'nofmounts', 'divinebeing', 'falsedamagerecovery', 'uwpathboost',
                  'nofalldmg', 'randomitems', 'fireempower', 'airempower',
                  'waterempower', 'earthempower', 'popspy', 'capitalhome', 'deathslimeexpl',
                  'deathpoisonexpl', 'deathshockexpl', 'drawsize', 'clumsy',
                  'petrificationimmune', 'regainmount', 'nobarding', 'scarsouls', 'spikebarbs',
                  'pretenderstartsite', 'mountiscom', 'nothrowoff', 'offscriptresearch',
                  'bird', 'decayres', 'unmountedspr', 'cubmother', 'exhaustion', 'glamour', 'end']
    weapon_keys = ['wpn'+str(i) for i in range(1,8)]
    armor_keys =  ['armor'+str(i) for i in range(1,5)]
    
    
    with open(csv_file_path, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        for key in units:
            unit = units[key]
            csv_row = {fieldname: '' for fieldname in fieldnames}
            csv_row['id'] = key #unit.get('id', '')  # Use .get() for safety
            csv_row['name'] = unit.get('name', '')
            # Handle weapons
            if 'weapon' in unit:
                for i, weapon_ref in enumerate(unit['weapon']):
                    if i < 7:  # Limit to 7 weapons (wpn1-wpn7)
                        if weapon_ref.isdigit():  # if wpn is a number
                            csv_row[weapon_keys[i]] = weapon_ref
                        elif weapon_ref in baseu_weapon_map: # if wpn is a string, in dom6.
                          csv_row[weapon_keys[i]] = baseu_weapon_map[weapon_ref] #look up by weapon name
                        else:
                            csv_row[weapon_keys[i]] = "" #unknown weapon id
            # Handle armors
            if 'armor' in unit:
                for i, armor_ref in enumerate(unit['armor']):
                    if i < 4:
                      if armor_ref.isdigit():
                        csv_row[armor_keys[i]] = armor_ref #if number use that
                      elif armor_ref in baseu_armor_map:
                        csv_row[armor_keys[i]] = baseu_armor_map[armor_ref] # if name, search
                      else: #unknown item id
                        csv_row[armor_keys[i]] = ''
            
            # Handle other attributes
            for key, value in unit.items():
              if key in fieldnames:
                csv_row[key] = value
              elif key == 'magicskill':
                for path, level in value.items():
                        if path.isdigit():  # Numerical path
                            path_nbr = int(path)
                            if 0 <= path_nbr <= 8:  # F, A, W, E, S, D, N, B, H
                              csv_row['F' if path_nbr == 0 else 'A' if path_nbr == 1 else 'W' if path_nbr == 2 else 'E' if path_nbr == 3 else 'S' if path_nbr == 4 else 'D' if path_nbr == 5 else 'N' if path_nbr == 6 else 'B' if path_nbr == 8 else 'H'] = level
            writer.writerow(csv_row)

def load_baseu_maps(weapon_file, armor_file):

    # Load weapon map.
    baseu_weapon_map = {}
    try:
        with open(weapon_file, 'r') as f:
          for line in f:
            parts = line.split(' ', 1)
            if len(parts) == 2:
              weapon_name = parts[1].replace('"', '').strip() # remove trailing "\n" and usless "
              weapon_num = parts[0]
              if weapon_num.isdigit() : #only add correct weapons to map.
                baseu_weapon_map[weapon_name] = weapon_num

    except FileNotFoundError:
        print(f"Warning: Weapon file not found at {weapon_file}")


    baseu_armor_map = {}
    try:
        with open(armor_file, 'r') as f:
          for line in f:
            parts = line.split(' ', 1)
            if len(parts) == 2:
              armor_name = parts[1].replace('"', '').strip() # remove trailing "\n" and usless "
              armor_num = parts[0]
              if armor_num.isdigit() : #only add correct armors to map.
                baseu_armor_map[armor_name] = armor_num

    except FileNotFoundError:
        print(f"Warning: Armor file not found at {armor_file}")

    return baseu_weapon_map, baseu_armor_map

def main():
    #mod_file = "SCBM-clockwork_v1.065.dm.txt"  # Replace with your actual mod file path
    #csv_file = "scbmBaseU.csv"             # Replace with your desired output CSV file
    csv_file = "moddedBaseU.csv"
    mod_file = "/home/ilya/.dominions6/mods/DomEnhanced2_12_fixed_art-clockwork_v2.12/DomEnhanced2_12_fixed_art-clockwork_v2.12.dm"
    weapon_file = "dom6inspector/gamedata/weapons.csv"        # Repalce with your dom 6 weapons.txt file
    armor_file = "dom6inspector/gamedata/armors.csv"            # Repalce with your dom 6 armors.txt file
    baseu_weapon_map, baseu_armor_map = load_baseu_maps(weapon_file, armor_file)
    
    base_units = {}
    try:
        with open("dom6inspector/gamedata/BaseU.csv", 'r') as f:
            headers = f.readline().strip().split('\t')
            for line in f:
                values = line.strip().split('\t')
                unit_id = int(values[0].replace('"', '').strip())
                unit_stats = dict(zip(headers[1:], values[1:]))
                weapons = [unit_stats.get(f'wpn{i}', '') for i in range(1, 8)]
                unit_stats['weapons'] = weapons
                armors = [unit_stats.get(f'armor{i}', '') for i in range(1, 4)]
                unit_stats['armor'] = armors
                # Unset armor & wpn keys
                for i in range(1, 8):
                    unit_stats.pop(f'wpn{i}', None)
                    unit_stats.pop(f'armor{i}', None)
                
                base_units[unit_id] = unit_stats

    except FileNotFoundError:
        print("Warning: Base unit file not found at BaseU_10.csv")

    units = parse_mod_file(mod_file, base_units)
    #print(units)
    if units:
        convert_to_csv(units, csv_file, baseu_weapon_map, baseu_armor_map)
        print(f"Successfully converted {len(units)} units to {csv_file}")
    else:
        print("No units found or error during conversion.")

if __name__ == "__main__":
    main()
