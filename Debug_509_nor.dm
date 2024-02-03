#modname "Debug Mod 1.1"
#description "This mod is intended for debugging the behaviour of Dominions 6. It removes level restrictions for all spells and magic items. In addition, the mod introduces five new spells to help debug. The new spells are Super Wish, Super GoR, Super Divine Name, Contact Debug Sensei and Eyes of Debug. Non AI players also get a bunch of commanders with extremely high magic paths, including some mounted commanders for testing mounted interactions, and sites which give a large amount of gems, income, resources. Based on the Dominions 3 version by ryo_akashi.

Compatibility: Uses monster IDs 9001, 9002. This mod is only for debugging and testing purposes, but should be compatible with most other mods should you wish to use it to test them."
#version 1.1
#icon "Debug.tga"

--- Version 1.1

-- AI nations no longer get any of the debug mod income or commander benefits (but still benefit from every spell and item being researched)


------
--New Monster
#newmonster 9001
#copystats 941
#copyspr 941
#hp 250
#name "Debug Sensei"
#descr "The Sensei is an almighty being, well versed in all magic. He warns you sternly to use him only for debugging the mysteries of Dominions."
#nametype 133
#clearmagic
#magicskill 0 9
#magicskill 1 9
#magicskill 2 9
#magicskill 3 9
#magicskill 4 9
#magicskill 5 9
#magicskill 6 9
#magicskill 7 9
#magicskill 8 9
#magicskill 9 9
#startage 100
#mapmove 25
#spy
#forgebonus 80
#stealthy 30
#supplybonus 999
#healer 999
#amphibian
#gcost 0
#nobadevents 100
#researchbonus 9999
#end

------
--New Spells
#newspell
#copyspell "Gift of Reason"
#name "Super GoR"
#descr "A cheaper Gift of Reason, costing one astral pearl."
#path 0 4
#school 0
#researchlevel 0
#pathlevel 0 1
#fatiguecost 100
#end

#newspell
#copyspell "Divine Name"
#name "Super Divine Name"
#descr "A cheaper Divine Name, costing one astral pearl."
#path 0 4
#school 0
#researchlevel 0
#pathlevel 0 1
#fatiguecost 100
#end

#newspell
#copyspell "Wish"
#name "Super Wish"
#descr "A cheaper Wish, costing one astral pearl."
#path 0 4
#school 0
#researchlevel 0
#pathlevel 0 1
#fatiguecost 100
#end

#newspell
#name "Contact Debug Sensei"
#descr "Contacts the Debug Sensei, an almighty being who is well versed in all magic."
#path 0 4
#school 0
#researchlevel 0
#pathlevel 0 1
#fatiguecost 100
#effect 10021
#damage 3401
#spec 8388608
#end

--- START
--- END

#end
