import collections
import re

# Known scale keywords in Dominions 6
SCALES = {
    'magic', 'unmagic', 'drain', 'luck', 'unluck', 'order', 'chaos', 
    'prod', 'lazy', 'sloth', 'growth', 'death', 'heat', 'cold'
}

def get_natural_sort_key(scale_str):
    """Splits 'luck 5' into ('luck', 5) for proper numerical sorting."""
    if scale_str == "none":
        return ("zzz", 0) # Put 'none' at the bottom
    match = re.match(r"([a-z]+)\s+(-?\d+)", scale_str)
    if match:
        return (match.group(1), int(match.group(2)))
    return (scale_str, 0)

def analyze_and_sort_events(file_path):
    # Dictionary to store counts: {(scale1, scale2): [total, good, bad]}
    pivot = collections.defaultdict(lambda: [0, 0, 0])

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line in f:
                parts = line.strip().split('\t')
                if len(parts) < 5:
                    continue
                
                # Extract rarity for Good/Bad categorization
                try:
                    rarity = int(parts[2])
                    reqs_str = parts[4].lower()
                except (ValueError, IndexError):
                    continue 

                # Find all scale requirements
                found_reqs = []
                chunks = reqs_str.split('|')
                for chunk in chunks:
                    subparts = chunk.strip().split(' ')
                    if len(subparts) >= 2:
                        name, val = subparts[0], subparts[1]
                        if name in SCALES:
                            found_reqs.append(f"{name} {val}")
                
                # Normalize the pair
                found_reqs = sorted(list(set(found_reqs)))
                
                if not found_reqs:
                    pair = ("none", "none")
                elif len(found_reqs) == 1:
                    pair = (found_reqs[0], "none")
                else:
                    # Take first two alphabetically
                    pair = (found_reqs[0], found_reqs[1])

                # Increment counts
                pivot[pair][0] += 1
                if rarity < 0:
                    pivot[pair][1] += 1 # Good
                else:
                    pivot[pair][2] += 1 # Bad

    except FileNotFoundError:
        print(f"Error: {file_path} not found.")
        return

    # Sort the results: By Scale 1 Name, then Value, then Scale 2 Name, then Value
    sorted_items = sorted(
        pivot.items(), 
        key=lambda x: (get_natural_sort_key(x[0][0]), get_natural_sort_key(x[0][1]))
    )

    # Print Table
    header = f"{'Scale 1':<15} | {'Scale 2':<15} | {'Count':<6} | {'Good':<5} | {'Bad':<5}"
    print(header)
    print("-" * len(header))
    
    for (s1, s2), counts in sorted_items:
        print(f"{s1:<15} | {s2:<15} | {counts[0]:<6} | {counts[1]:<5} | {counts[2]:<5}")

if __name__ == "__main__":
    analyze_and_sort_events('events_full.txt')
