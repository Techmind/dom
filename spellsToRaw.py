import csv

def analyze_spells(spells_file, effects_file, output_file):
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
            effects_data[int(row['record_id'])] = int(row['effect_number'])  # Store effect_number

    summoning_spells = []
    with open(spells_file, 'r', encoding='utf-8') as infile:
        reader = csv.DictReader(infile, delimiter='\t')
        for row in reader:
            try:
                # Get the effect_record_id and look up the actual effect_number
                effect_record_id = int(row['effect_record_id'])
                if effect_record_id not in effects_data:
                    # print(f"Skipping spell {row['id']} ({row['name']}): Effect record ID {effect_record_id} not found in effects file.") #debug print
                    continue  # Skip if effect_record_id is not found
                effect_number = effects_data[effect_record_id]


                # Check if the spell is a summoning spell (effect 1 or 21)
                if effect_number in (1, 21):
                    # Check for invalid/dummy entries and negative unit ids.
                    if int(row['damage']) <= 0: # Skip spells without a valid unit ID.
                        continue

                    # Extract relevant data
                    name = row['name']
                    num_units = int(row['effects_count'])
                    unit_id = int(row['damage'])
                    gemcost = int(row['gemcost'])
                    path1 = int(row['path1'])

                    if gemcost <= 0:
                        continue

                    summoning_spells.append({
                        'summoning_spell': name,
                        'number_of_units': num_units,
                        'unit_id': unit_id,
                        'cost_in_gems': gemcost,
                        'gempath': path1
                    })

            except ValueError:
                print(f"Skipping row due to ValueError: {row}")  # Handle potential errors
                continue
            except KeyError as e:
                print(f"Skipping row: Missing key {e} in row: {row}")
                continue

    # Write the results
    with open(output_file, 'w', newline='', encoding='utf-8') as outfile:
        fieldnames = ['summoning_spell', 'number_of_units', 'unit_id', 'cost_in_gems', 'gempath']
        writer = csv.DictWriter(outfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(summoning_spells)

    print(f"Summoning spell data written to {output_file}")
    print(f"Number of identified summoning spells is {len(summoning_spells)}")


if __name__ == "__main__":
    spells_csv_file = 'dom6inspector/gamedata/spells.csv'
    effects_csv_file = 'dom6inspector/gamedata/effects_spells.csv'
    output_csv_file = 'summoning_spells_output.csv'
    analyze_spells(spells_csv_file, effects_csv_file, output_csv_file)
