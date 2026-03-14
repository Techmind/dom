#modname "Manual Firebird and Likho Summons"
#description "Directly summons Firebirds (1946) and Likho (1952) using manual spell effects to bypass national restrictions."
#version 1.3

-- 1. Summon Astral Firebird
-- Manual definition for Unit ID 1946
#newspell
#name "Summon Astral Firebird"
#descr "The caster calls forth a magical Firebird from the celestial spheres. The bird brings warmth and light, but is fragile."
#school 0      -- Conjuration
#researchlevel 3
#path 0 4      -- Astral Path
#pathlevel 0 1
#fatiguecost 300 -- 3 Astral Pearls
#effect 10001  -- Effect: Summon Monster (Regular Unit)
#nreff 1       -- Summons 1 unit
#damage 1946   -- Unit ID: Firebird
#end

-- 2. General Summon Likho (Conjuration Version)
-- Manual definition for Unit ID 1952
#newspell
#name "Likho Awakening"
#descr "The caster summons a Likho, an embodiment of misfortune and bad luck, to lead the undead or serve as a herald of doom."
#school 0      -- Conjuration
#researchlevel 4
#path 0 5      -- Death Path
#pathlevel 0 1
#fatiguecost 1000 -- 10 Death Gems
#effect 10021  -- Effect: Summon Commander
#nreff 1       -- Summons 1 unit
#damage 1952   -- Unit ID: Likho
#end

-- 3. Blood Summon Likho (Blood Version)
-- Manual definition for Unit ID 1952
#newspell
#name "Blood Likho"
#descr "Using the power of sacrifice, the caster binds a Likho to their service."
#school 6      -- Blood School
#researchlevel 4
#path 0 8      -- Blood Path
#pathlevel 0 1
#fatiguecost 2000 -- 20 Blood Slaves
#effect 10021  -- Effect: Summon Commander
#nreff 1       -- Summons 1 unit
#damage 1952   -- Unit ID: Likho
#end
