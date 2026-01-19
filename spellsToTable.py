import re
import csv

def parse_summoning_spells(mod_file_path, spells):
    """
    Parses a Dominions 6 mod file and extracts summoning spell data.

    Args:
        mod_file_path (str): The path to the .dm mod file.

    Returns:
        list: A list of dictionaries, where each dictionary represents a
              summoning spell and its attributes. Returns an empty list
              if no summoning spells are found or if an error occurs.
    """

    summoning_spells = spells
    current_spell = {}

    try:
        with open(mod_file_path, 'r', encoding='utf-8') as f:
            line_no = -1
            for line in f:
                line_no = line_no + 1
                line = line.strip()

                # Handle comments and empty lines
                if line.startswith('--') or not line:
                    continue

                # New spell
                match = re.match(r"#newspell", line)
                if match:
                    if current_spell:  # Save the previous spell if any
                        #print([current_spell, line_no, match])
                        summoning_spells[current_spell['id']] = current_spell
                    current_spell = {'line_no': line_no, 'id' : 10000 + line_no}  # Reset for the new spell
                    continue
                
                # Select existing spell by name or number
                match = re.match(r"#selectspell\s+\"([^\"]+)\"|#selectspell\s+(\d+)", line)
                if match:
                    #print(match, line_no)
                    current_spell = {}
                    if match.group(1): #name
                        current_spell['name'] = match.group(1)
                        current_spell['id'] = match.group(1)
                        current_spell['line_no'] = line_no
                    elif match.group(2):#number
                        id = match.group(2)
                        if id in spells:
                            current_spell = spells[id]
                            current_spell['line_no'] = line_no
                        else:
                            #skip combat spells
                            current_spell = {}
                            continue
                        
                        #current_spell['name'] = f"UnknownSpell_{match.group(2)}"  # Use a placeholder name
                    continue
                
                match = re.match(r"#name\s+\"([^\"]+)\"", line) #Correct name if spell selected by id.
                if match and current_spell:
                   current_spell['name'] = match.group(1).strip()
                   continue
                
                # Parse other attributes
                match = re.match(r"#(\w+)\s+(.*)", line)

                if match and current_spell:
                    #print([line_no, match, match.groups()])
                    command, argument = match.groups()
                    argument = argument.strip()
                    if command == 'copyspells':
                        current_spell = spells[argument]
                        current_spell['line_no'] = line_no
                    elif command == 'effect':
                         if argument == '1' or argument == '21':
                              current_spell['effect'] = int(argument) # Save the effect
                         else: #reset current spell if another effect.
                              #if current_spell:
                              #     summoning_spells.append(current_spell)
                              #    current_spell = {}
                              continue
                    elif command == "damage" and 'effect' in current_spell:
                         current_spell['unit_id'] = argument
                    elif command == "nreff" and 'effect' in current_spell: #only for multi summons
                        if argument.isdigit():
                          current_spell['nreff'] = int(argument)
                        else: #For handling values with + (ex: 505)
                          parts = argument.split('+')
                          if all(part.isdigit() for part in parts):
                               current_spell['nreff'] = sum(int(part) for part in parts)
                          else:
                               current_spell['nreff'] = 0 # if invalid number use zero.
                               print("Warning: Invalid nreff.")
                        current_spell['number_of_units'] = current_spell['nreff']
                    elif command == "fatiguecost" and 'effect' in current_spell:
                        current_spell['cost_in_gems'] = int(argument / 100)
                    elif command == "path":
                        current_spell['gempath'] = int(argument.split()[0])
                    elif command == "end":
                        if current_spell:
                            summoning_spells[id] = current_spell
                            current_spell = {}
                        continue #skip appending

    except FileNotFoundError:
        print(f"Error: Mod file not found at {mod_file_path}")
        return []
    except Exception as e:
        print(f"Error parsing mod file: {e}", e.with_traceback())
        return []
    return summoning_spells


def convert_to_summoning_csv(spells, output_csv_path):
    """
    Converts extracted summoning spell data to the desired CSV format.

    Args:
        spells (list): A list of spell dictionaries.
        output_csv_path (str): Path to the output CSV file.
    """
    fieldnames = ["id", "name", "number_of_units", "unit_id", "cost_in_gems", 'gempath']

    with open(output_csv_path, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for id in spells:
            spell = spells[id]
            # Handle spells where name and id/effect given on the same line
            if 'id' in spell and 'unit_id' in spell:
              
              if 'number_of_units' not in spell:
                number_of_units = 1 #if no nr of summons given, assume its 1.
              else:
                number_of_units = spell['number_of_units']

              if number_of_units > 500:
                number_of_units = number_of_units % 500

              # 'summoning_spell', 'number_of_units', 'unit_id', 'cost_in_gems'
              writer.writerow({
                  'id' : spell['id'],
                  "name": spell.get('name', ''),
                  "number_of_units": number_of_units,
                  "unit_id": spell['unit_id'],
                  "cost_in_gems": spell.get('cost_in_gems', 0),
                  "gempath": spell
              })

import csv

def read_spells(spells_file, effects_file, output_file):
    """
    Analyzes spells and effects CSV files to extract summoning spell information,
    considering the effect_record_id referencing the effects_spells_100.csv.

    Args:
        spells_file: Path to the input spells CSV file.
        effects_file: Path to the effects CSV file.
        output_file: Path to the output CSV file.
    """

    # Load effects data into a dictionary for efficient lookup
    effects_data = {}
    with open(effects_file, 'r', encoding='utf-8') as infile:
        reader = csv.DictReader(infile, delimiter='\t')
        for row in reader:
            effects_data[int(row['record_id'])] = {'number' : int(row['effect_number']), 'ritual' : int(row['ritual'])}  # Store effect_number

    summoning_spells = {}
    with open(spells_file, 'r', encoding='utf-8') as infile:
        reader = csv.DictReader(infile, delimiter='\t')
        for row in reader:
            try:
                # Get the effect_record_id and look up the actual effect_number
                effect_record_id = int(row['effect_record_id'])
                if effect_record_id not in effects_data:
                    # print(f"Skipping spell {row['id']} ({row['name']}): Effect record ID {effect_record_id} not found in effects file.") #debug print
                    continue  # Skip if effect_record_id is not found
                effect_number = effects_data[effect_record_id]['number']
                ritual = effects_data[effect_record_id]['ritual']

                # Check if the spell is a summoning spell (effect 1 or 21)
                if effect_number in (1, 21) and ritual:
                    # Check for invalid/dummy entries and negative unit ids.
                    if int(row['damage']) <= 0: # Skip spells without a valid unit ID.
                        continue

                    # Extract relevant data
                    id = row['id']
                    name = row['name']
                    num_units = int(row['effects_count'])
                    unit_id = int(row['damage'])
                    gemcost = int(row['gemcost'])

                    if gemcost <= 0:
                        continue

                    summoning_spells[id] = {
                        'id' : id,
                        'name': name,
                        'number_of_units': num_units,
                        'unit_id': unit_id,
                        'cost_in_gems': gemcost
                    }

            except ValueError:
                print(f"Skipping row due to ValueError: {row}")  # Handle potential errors
                continue
            except KeyError as e:
                print(f"Skipping row: Missing key {e} in row: {row}")
                continue

    return summoning_spells

if __name__ == "__main__":
    spells_csv_file = 'dom6inspector/gamedata/spells.csv'
    effects_csv_file = 'dom6inspector/gamedata/effects_spells.csv'
    output_csv_file = 'summoning_spells_output.csv'
    spells = read_spells(spells_csv_file, effects_csv_file, output_csv_file)

    mod_file_path = '/home/ilya/.dominions6/mods/DomEnhanced2_12_fixed_art-clockwork_v2.12/DomEnhanced2_12_fixed_art-clockwork_v2.12.dm'  # Replace with the actual path to your mod file.
    base_spells_path = 'dom6inspector/gamedata/spells.csv'
    output_csv_path = 'summoning_spells_scbm.csv'
    spells_scbm = parse_summoning_spells(mod_file_path, spells)

    if spells_scbm:
        convert_to_summoning_csv(spells_scbm, output_csv_path)
        print(f"Summoning spell data written to {output_csv_path}")
    else:
        print("No summoning spells found or error during processing.")
