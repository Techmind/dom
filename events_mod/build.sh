cat events.txt events_p*.txt | grep -v "id\sname" | sort | uniq > events_full.txt
python3 generate_dm.py
python3 counts.py
