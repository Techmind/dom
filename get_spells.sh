cat log.txt | grep casts | sort | uniq | grep -v "creating " | sed "s/.*casts//" | sort | uniq > free_spells.txt
