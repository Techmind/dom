#modname "Scales 3/4/5 Balancing Mod v0.5"
#description "Balancing: Fort/Gold Turn checks & Auto Path Requirements for boosts."
#version 0.5

#newevent
#id 4000
#rarity -2
#req_pop0ok 1
#req_magic 4
#req_land 1
#msg "Magic is overflowing the boundaries of this realm. The air crystallizes into magic."
#4d6vis 1
#end

#newevent
#id 4001
#rarity -2
#req_pop0ok 1
#req_magic 5
#req_land 1
#msg "Absolute magic has overwhelmed the realm, leaving behind clusters of pure aether."
#5d6vis 4
#end

#newevent
#id 4002
#rarity -2
#req_magic 4
#req_land 1
#msg "A mythical beast of pure mana has been slain. It leaves behind a wealth of magical gems!"
#2d6vis 53
#end

#newevent
#id 4003
#rarity -2
#req_magic 5
#req_land 1
#msg "An astral behemoth has been slain. Its crystalline heart shattered into a staggering amount of gems!"
#3d6vis 53
#end

#newevent
#id 4004
#rarity -1
#req_maxunrest 50
#req_magic 4
#req_luck 1
#msg "A potent artifact humming with power was found by local prospectors."
#magicitem 3
#1d6vis 4
#end

#newevent
#id 4005
#rarity -1
#req_maxunrest 50
#req_magic 5
#req_luck 1
#msg "An artifact of legends has been unearthed from a reality rift."
#magicitem 4
#1d6vis 4
#end

#newevent
#id 4006
#rarity -1
#req_magic 4
#req_luck 2
#req_land 1
#msg "A magical anomaly unearthed a hidden vault containing artifacts of forgotten power."
#magicitem 4
#end

#newevent
#id 4007
#rarity -1
#req_magic 5
#req_luck 2
#req_land 1
#msg "Reality warped, leaving behind artifacts of immense, forgotten power."
#magicitem 4
#magicitem 3
#end

#newevent
#id 4008
#rarity -2
#req_magic 4
#req_luck 3
#req_turn 15
#msg "Fortune revealed the lost armory of a Pantokrator."
#magicitem 4
#magicitem 3
#2d6vis 53
#end

#newevent
#id 4009
#rarity -2
#req_magic 5
#req_luck 3
#req_turn 15
#msg "Extreme fortune bestowed upon you the lost vault of an Archmage."
#gold 4000
#magicitem 4
#magicitem 4
#3d6vis 53
#end

#newevent
#id 4010
#rarity 1
#req_unmagic 4
#req_minpop 50
#req_lab 1
#msg "The populace has formed a fanatical mob and burned the lab to purge all magic."
#lab 0
#unrest 80
#kill 5
#end

#newevent
#id 4011
#rarity 2
#req_unmagic 5
#req_pop0ok 1
#req_lab 1
#msg "The absence of magic caused reality to collapse in the lab, destroying all magic items."
#lab 0
#gemloss 53
#magicitem -1
#magicitem -1
#end

#newevent
#id 4012
#rarity 2
#req_unluck 5
#req_pop0ok 1
#req_land 1
#req_turn 20
#msg "A massive meteor struck, destroying the province's infrastructure and treasury."
#kill 50
#gold -5000
#fort 0
#temple 0
#unrest 200
#end

#newevent
#id 4013
#rarity 2
#req_unluck 4
#req_unmagic 4
#req_land 1
#msg "A total drain of mystical wards allowed a terror to feed on the province."
#unrest 150
#com 308
#kill 20
#end

#newevent
#id 4014
#rarity 2
#req_unluck 5
#req_unmagic 3
#req_land 1
#req_turn 20
#msg "An anti-magic singularity and extreme bad luck has left nothing but ruin and madness."
#kill 75
#gold -10000
#lab 0
#temple 0
#fort 0
#unrest 300
#end

#newevent
#id 4020
#rarity 2
#req_lazy 3
#req_unluck 3
#req_land 1
#msg "The militia is apathetic. Guards sleep and walls degrade. Bandits sacked the armory."
#defence -15
#unrest 20
#gold -200
#end

#newevent
#id 4021
#rarity 2
#req_unmagic 4
#req_unluck 3
#req_land 1
#req_lab 1
#msg "A massive anti-magic riot burned your laboratory to the ground and looted all gems."
#lab 0
#gemloss 53
#unrest 60
#kill 3
#end

#newevent
#id 4022
#rarity 2
#req_lazy 4
#req_unluck 4
#req_lab 1
#req_land 1
#msg "Mages skipped ritual steps; a void horror slipped through the weakened barriers."
#lab 0
#kill 2
#unrest 30
#com 308
#end

#newevent
#id 4023
#rarity 2
#req_lazy 5
#req_unluck 4
#req_fort 1
#req_land 1
#req_turn 15
#msg "Extreme neglect has caused the fortress foundations to collapse."
#fort 0
#kill 2
#unrest 30
#end

#newevent
#id 4024
#rarity 2
#req_lazy 5
#req_unluck 5
#req_land 1
#msg "People refuse to work or eat and are dying in their sleep from extreme apathy."
#kill 20
#landprod -20
#landgold -20
#unrest 50
#end

#newevent
#id 4025
#rarity -2
#req_lazy 3
#req_luck 3
#req_land 1
#msg "A farmer fell asleep and tripped over a root, unearthing an ancient artifact."
#gold 300
#magicitem 2
#1d6vis 3
#end

#newevent
#id 4026
#rarity -2
#req_unmagic 4
#req_luck 3
#req_land 1
#msg "Free from mages, the mundane populace thrived and rooted out a rogue sorcerer for you."
#gold 1000
#magicitem 2
#1d6vis 6
#end

#newevent
#id 4027
#rarity -2
#req_unmagic 4
#req_luck 3
#req_land 1
#msg "Lucky hunters cornered a powerful cabal. The heretics' vast hoard of artifacts was secured."
#gold 1500
#magicitem 3
#magicitem 3
#end

#newevent
#id 4028
#rarity -2
#req_unmagic 5
#req_luck 3
#req_land 1
#msg "A lich withered away from lack of magic. Lucky heroes plundered his crypt for you."
#gold 1500
#magicitem 3
#1d6vis 5
#end

#newevent
#id 4029
#rarity -2
#req_lazy 5
#req_luck 5
#req_land 1
#msg "A celestial being, baffled by the province's laziness, left legendary artifacts as a pity-gift."
#gold 2000
#magicitem 4
#magicitem 3
#end

#newevent
#id 4030
#rarity -1
#req_heat 3
#req_order 3
#req_land 1
#msg "Heat and Order have allowed for the creation of masterful fire-tempered steel."
#gold 400
#magicitem 2
#end

#newevent
#id 4031
#rarity -1
#req_cold 3
#req_order 3
#req_land 1
#msg "Cold has been channeled into structured ice-fortifications."
#fort 3
#end

#newevent
#id 4032
#rarity 2
#req_lazy 4
#req_unluck 3
#req_lab 1
#req_land 1
#msg "Lazy mages allowed a void horror to slip through the province's weakened barriers."
#lab 0
#com 308
#kill 2
#unrest 30
#end

#newevent
#id 4033
#rarity 2
#req_lazy 5
#req_unluck 3
#req_fort 1
#req_land 1
#req_turn 15
#msg "Neglect has caused the local fortress foundations to completely collapse."
#fort 0
#kill 2
#unrest 30
#end

#newevent
#id 4034
#rarity 2
#req_heat 3
#req_death 3
#req_land 1
#msg "Heat and Death create a stifling, necrotic miasma."
#kill 5
#disease 5
#end

#newevent
#id 4035
#rarity -2
#req_lazy 3
#req_luck 3
#req_land 1
#msg "A lazy farmer unearthed an ancient artifact while napping under an oak tree."
#gold 300
#magicitem 2
#1d6vis 3
#end

#newevent
#id 4036
#rarity -2
#req_lazy 4
#req_luck 3
#req_land 1
#msg "A wall collapsed because no one maintained it, revealing a long-forgotten treasury!"
#gold 800
#magicitem 3
#end

#newevent
#id 4037
#rarity -2
#req_lazy 4
#req_luck 3
#req_land 1
#msg "Lazy hunters found a beast that died in the square, leaving a hoard of gems for you."
#gold 1000
#magicitem 3
#3d6vis 6
#end

#newevent
#id 4038
#rarity 2
#req_heat 3
#req_chaos 3
#req_land 1
#msg "Heat and Turmoil summon a demon lord to demand sacrifices."
#kill 10
#unrest 30
#end

#newevent
#id 4039
#rarity 2
#req_cold 3
#req_chaos 3
#req_land 1
#msg "Cold has driven the populace to violent rioting and looting."
#unrest 50
#gold -300
#end

#newevent
#id 4040
#rarity 2
#req_lazy 3
#req_chaos 3
#req_land 1
#msg "A mob was too lazy to rebel properly. They just stole some gold and went to bed."
#unrest 20
#gold -150
#landprod -5
#end

#newevent
#id 4041
#rarity 2
#req_heat 5
#req_land 1
#msg "Extreme heat has turned the province into a fire elemental breeding ground."
#kill 20
#com 3716
#unrest 60
#end

#newevent
#id 4042
#rarity -1
#req_heat 4
#req_prod 2
#req_land 1
#msg "Extreme heat melted sand into valuable art."
#gold 500
#landprod 10
#end

#newevent
#id 4043
#rarity 2
#req_heat 5
#req_growth -2
#req_land 1
#msg "Heat turned crops to ash."
#landprod -50
#unrest 40
#end

#newevent
#id 4044
#rarity 2
#req_lazy 4
#req_chaos 3
#req_land 1
#msg "Total societal collapse. The people sit in decaying ruins waiting to starve."
#kill 15
#landgold -15
#landprod -15
#unrest 80
#end

#newevent
#id 4045
#rarity 2
#req_cold 5
#req_death 2
#req_land 1
#msg "Cold woke horrors from permafrost."
#kill 15
#com 1201
#unrest 50
#end

#newevent
#id 4046
#rarity -1
#req_cold 4
#req_magic 2
#req_land 1
#msg "Cold concentrated minerals into gems."
#2d6vis 2
#1d6vis 1
#end

#newevent
#id 4047
#rarity 2
#req_cold 5
#req_land 1
#msg "Reality froze solid."
#kill 60
#landprod -100
#end

#newevent
#id 4048
#rarity 2
#req_lazy 4
#req_order 3
#req_land 1
#msg "All unauthorized labor is forbidden to ensure order. Nothing is getting done."
#unrest -50
#landprod -20
#landgold -10
#end

#newevent
#id 4049
#rarity -1
#req_cold 4
#req_prod 2
#req_land 1
#msg "Cold tempered superior steel."
#magicitem 2
#gold 300
#end

#newevent
#id 4050
#rarity -1
#req_growth 3
#req_order 3
#req_land 1
#msg "Order maximized fertility."
#gold 300
#landprod 10
#end

#newevent
#id 4051
#rarity -1
#req_growth 3
#req_order 2
#req_land 1
#msg "Strict quotas led to record yields."
#landprod 15
#end

#newevent
#id 4052
#rarity -2
#req_growth 4
#req_order 4
#req_land 1
#msg "Efficient administration created a massive surplus."
#landgold 15
#taxboost 50
#end

#newevent
#id 4053
#rarity -2
#req_growth 5
#req_order 5
#req_land 1
#msg "Growth and Order transformed the province into an empire breadbasket."
#landprod 30
#landgold 20
#end

#newevent
#id 4054
#rarity 1
#req_growth 3
#req_drain 3
#req_land 1
#msg "Growth drew dark spirits."
#gold 100
#gemloss 53
#end

#newevent
#id 4055
#rarity 1
#req_growth 4
#req_drain 4
#req_land 1
#msg "Crops drain magic from soil."
#gold 200
#gemloss 53
#end

#newevent
#id 4056
#rarity 2
#req_growth 4
#req_drain 5
#req_land 1
#msg "Necrotic orchard."
#gold 50
#disease 10
#gemloss 53
#end

#newevent
#id 4057
#rarity 2
#req_growth 5
#req_drain 5
#req_land 1
#msg "Fertility consumes all magic."
#gold 500
#gemloss 53
#end

#newevent
#id 4058
#rarity -1
#req_growth 4
#req_land 1
#msg "Soil yields gold."
#landgold 10
#end

#newevent
#id 4059
#rarity 1
#req_growth 5
#req_land 1
#msg "Nature fights back."
#unrest 20
#landprod -10
#end

#newevent
#id 4060
#rarity 2
#req_chaos 4
#req_unluck 3
#req_land 1
#req_mindef 10
#msg "The defense mutinied, killed their officers, and sacked the local armory."
#defence -20
#unrest 60
#kill 5
#end

#newevent
#id 4061
#rarity 2
#req_chaos 3
#req_unluck 4
#req_land 1
#msg "An unnatural tempest of glass ripped through the province, shredding the crops."
#kill 10
#landprod -10
#unrest 40
#end

#newevent
#id 4062
#rarity 2
#req_chaos 4
#req_unluck 3
#req_land 1
#req_temple 1
#msg "Absolute anarchy. Mobs burned the local temples and looted the treasury."
#temple 0
#gold -1000
#unrest 100
#end

#newevent
#id 4063
#rarity 2
#req_chaos 5
#req_unluck 3
#req_land 1
#req_fort 1
#req_turn 15
#msg "A warlord united the rabble into a horde and claimed the local fortress."
#fort 0
#com 147
#6d6units 140
#unrest 150
#end

#newevent
#id 4064
#rarity 2
#req_chaos 5
#req_unluck 3
#req_land 1
#req_turn 15
#msg "A rift to the Inferno opened, spewing fire and demons!"
#kill 40
#lab 0
#temple 0
#fort 0
#com 826
#4d6units 304
#end

#newevent
#id 4069
#rarity -2
#req_chaos 5
#req_luck 3
#req_land 1
#msg "Chaos result in a major threat dying and leaving artifacts."
#gold 2500
#magicitem 4
#magicitem 3
#2d6vis 53
#end

#newevent
#id 4070
#rarity 2
#req_chaos 3
#req_magic 3
#req_lab 1
#req_land 1
#msg "Lack of safety caused a lab explosion, releasing hostile fire elementals."
#lab 0
#kill 5
#unrest 40
#assassin 3716
#end

#newevent
#id 4071
#rarity -2
#req_chaos 3
#req_magic 3
#req_land 1
#msg "Rioting hedge wizards unleashed spells that accidentally created pure magical gems."
#unrest 30
#gold -200
#3d6vis 53
#end

#newevent
#id 4072
#rarity -2
#req_chaos 3
#req_magic 3
#req_land 1
#msg "A crazed conjurer lost control of a ritual. The beasts now bow to you!"
#unrest 40
#nation -2
#2com 1910
#10d6units 361
#end

#newevent
#id 4073
#rarity 2
#req_chaos 3
#req_magic 3
#req_land 1
#msg "Summoning circles broke in the anarchy, allowing demons to feed on the populace."
#unrest 60
#kill 10
#com 305
#2d6units 88
#end

#newevent
#id 4074
#rarity -2
#req_chaos 4
#req_magic 3
#req_land 1
#msg "Reality is glitching. Base metals are turning into gold and gems spontaneously."
#gold 1000
#2d6vis 53
#kill 5
#unrest 50
#end

#newevent
#id 4075
#rarity 2
#req_chaos 4
#req_magic 3
#req_land 1
#msg "A storm of wild magic warped and mutated many of the surviving inhabitants."
#kill 15
#unrest 70
#landprod -10
#end

#newevent
#id 4076
#rarity -2
#req_chaos 4
#req_magic 3
#req_land 1
#msg "An erratic wizard thrives in the anarchy. He pledged loyalty and brought artifacts."
#nation -2
#com 312
#magicitem 3
#magicitem 2
#end

#newevent
#id 4077
#rarity 2
#req_chaos 4
#req_magic 3
#req_land 1
#msg "A hole in reality opened. Astral horrors are pouring through to feed on the province."
#kill 20
#unrest 90
#com 308
#4d6units 88
#end

#newevent
#id 4078
#rarity -2
#req_chaos 5
#req_magic 3
#req_land 1
#msg "Artifacts of legendary power and gems materialized out of thin air in the chaos."
#magicitem 4
#magicitem 4
#4d6vis 53
#unrest 100
#end

#newevent
#id 4079
#rarity 2
#req_chaos 5
#req_magic 3
#req_lab 1
#req_land 1
#msg "Magical laws collapsed. Mages are insane and a Doom Horror has manifested."
#lab 0
#kill 30
#unrest 200
#com 2213
#end

#newevent
#id 4080
#rarity -1
#req_death 1
#req_luck 3
#req_land 1
#msg "A landslide opened a mound; lucky peasants recovered treasure before the dead rose."
#gold 400
#magicitem 2
#end

#newevent
#id 4081
#rarity -2
#req_death 2
#req_luck 3
#req_pathdeath 1
#msg "A necromancer, favored by luck, managed to bind a powerful wight as a loyal servant."
#nation -2
#com 197
#end

#newevent
#id 4082
#rarity -1
#req_death 2
#req_luck 3
#req_land 1
#msg "A surge of dark energy crystallized into rare death gems in a local graveyard."
#2d6vis 5
#end

#newevent
#id 4083
#rarity -2
#req_death 3
#req_luck 3
#req_land 1
#msg "A lich withered away from extreme misfortune, leaving his artifacts for you."
#gold 1500
#magicitem 4
#end

#newevent
#id 4084
#rarity -2
#req_death 3
#req_luck 3
#req_land 1
#msg "Through a freak occurrence, a fallen hero rose as a loyal undead champion for you."
#nation -2
#com 188
#end

#newevent
#id 4085
#rarity 1
#req_death 1
#req_magic 3
#req_lab 1
#msg "Death magic leaked into the lab, accidentally finishing a research project overnight."
#researchaff 0
#unrest 10
#end

#newevent
#id 4086
#rarity -2
#req_death 3
#req_magic 3
#req_lab 1
#msg "Mages siphoned essence from local graveyards to create a powerful spirit servant."
#nation -2
#com 533
#end

#newevent
#id 4087
#rarity -1
#req_death 3
#req_magic 3
#req_land 1
#msg "A mage concentrated the essence of a thousand ghosts into a perfect death gem."
#2d6vis 5
#end

#newevent
#id 4088
#rarity -2
#req_death 4
#req_magic 3
#req_unique 1
#req_pathdeath 1
#msg "An ancient tomb was opened, increasing your mages' death magic proficiency."
#deathboost 5
#end

#newevent
#id 4089
#rarity -2
#req_death 5
#req_magic 3
#req_unique 1
#msg "Your mastery of Death and Magic attracted a literal Lord of the Dead to you."
#nation -2
#com 181
#end

#newevent
#id 4090
#rarity -2
#req_order 3
#req_luck 3
#req_land 1
#msg "The combination of law and luck has brought the province to a golden age."
#gold 500
#taxboost 100
#end

#newevent
#id 4091
#rarity 1
#req_order 3
#req_unluck 3
#req_land 1
#msg "Strict laws enforced by bribery. The constant skimming hampers your treasury."
#taxboost -50
#unrest 10
#end

#newevent
#id 4092
#rarity 2
#req_order 2
#req_magic 3
#req_lab 1
#msg "Law-enforcing priests arrived to ensure your labs follow new statutes."
#unrest 15
#gainaff 4096
#end

#newevent
#id 4093
#rarity 1
#req_order 3
#req_unmagic 3
#req_lab 1
#msg "A decree mandates that magic experiments be filed in triplicate, stalling research."
#researchaff 0
#gold -50
#end

#newevent
#id 4094
#rarity -1
#req_order 2
#req_luck 3
#req_land 1
#msg "A lawful and lucky bailiff arrested a bandit ring and recovered their gold."
#gold 400
#unrest -10
#end

#newevent
#id 4095
#rarity 2
#req_order 2
#req_unluck 3
#req_land 1
#msg "Administrative errors and misfortune caused your tax records to catch fire."
#taxboost -50
#gold -200
#end

#newevent
#id 4096
#rarity -2
#req_order 2
#req_magic 3
#req_lab 1
#msg "A brilliant clerk discovered a loophole, entitling you to the mages' gems."
#1d6vis 53
#gold 100
#end

#newevent
#id 4097
#rarity 2
#req_order 3
#req_unmagic 3
#req_land 1
#msg "Citizens are using loopholes to avoid taxes. The law prevents you from pursuing."
#taxboost -100
#end

#newevent
#id 4098
#rarity -1
#req_order 3
#req_luck 2
#req_land 1
#msg "A court case was resolved justly, bringing prosperity and a donation to your cause."
#gold 300
#incdom 1
#end

#newevent
#id 4099
#rarity 1
#req_order 2
#req_unluck 3
#req_land 1
#msg "A court case was resolved for the highest bidder, causing minor civil unrest."
#unrest 20
#gold 100
#end

#newevent
#id 4100
#rarity -1
#req_prod 2
#req_land 1
#msg "Efficient labor and clear schedules have boosted regional production!"
#landprod 10
#landgold 5
#end

#newevent
#id 4101
#rarity 2
#req_prod 2
#req_order 3
#req_land 1
#msg "Excessive record-keeping and quotas have paralyzed the local economy."
#landprod -10
#unrest 10
#end

#newevent
#id 4102
#rarity 1
#req_prod 2
#req_drain 3
#req_land 1
#msg "Mystical decay is causing raw materials to wither before they can be processed."
#landprod -15
#landgold -5
#end

#newevent
#id 4103
#rarity 2
#req_prod 2
#req_death 3
#req_land 1
#msg "Unnatural death-energies have contaminated the mines, causing widespread sickness."
#landprod -20
#disease 5
#end

#newevent
#id 4104
#rarity -1
#req_prod 3
#req_land 1
#msg "Hard work salvaged valuable resources from previously abandoned ruins."
#landprod 20
#gold 100
#end

#newevent
#id 4110
#rarity 1
#req_death 4
#req_unrest 10
#msg "A ghastly sickness has arisen from local barrows."
#disease 10
#kill 20
#end

#newevent
#id 4111
#rarity 2
#req_death 4
#req_landprod 1
#msg "Crops in the field are turning to black mulch overnight."
#landprod -30
#kill 5
#end

#newevent
#id 4112
#rarity 2
#req_death 5
#req_unrest 30
#msg "The dead crawl from the soil to haunt the living."
#unrest 100
#kill 10
#end

#newevent
#id 4113
#rarity 2
#req_death 5
#req_growth 0
#msg "The very earth has died."
#landprod -50
#end

#newevent
#id 4114
#rarity 2
#req_death 4
#req_chaos 3
#msg "Chaos and Death created sentient, hateful swarms of undead that pillage the land."
#unrest 100
#4com 197
#end

#newevent
#id 4115
#rarity 1
#req_death 4
#req_chaos 3
#msg "The mob unearthed a crypt, and the spirits within turned them into ghouls."
#kill 5
#2d6units 198
#end

#newevent
#id 4118
#rarity 1
#req_death 4
#req_lazy 3
#msg "A wave of sloth allowed necrotic fungi to infest the local granaries."
#landprod -20
#kill 5
#end

#newevent
#id 4119
#rarity 1
#req_death 4
#req_lazy 3
#msg "The dead pile up; no one is bothered to bury them due to profound lethargy."
#disease 10
#unrest 20
#end

#newevent
#id 4122
#rarity 1
#req_death 4
#req_drain 3
#msg "The land is literally draining the life from the living to feed the tombs."
#kill 15
#incscale2 3
#end

#newevent
#id 4123
#rarity 1
#req_death 4
#req_drain 3
#msg "The local wells have become fonts of necrotic energy."
#disease 20
#kill 10
#end

#newevent
#id 4130
#rarity -1
#req_death 3
#req_luck 3
#req_land 1
#msg "A lucky find in an ancient tomb!"
#gold 400
#magicitem 2
#end

#newevent
#id 4131
#rarity -2
#req_death 4
#req_luck 3
#req_land 1
#msg "Good fortune binds a powerful wight as a servant."
#com 197
#unrest 10
#end

#newevent
#id 4132
#rarity -1
#req_death 4
#req_luck 3
#req_land 1
#msg "Concentrated death-magic crystallizes into gems!"
#2d6vis 5
#end

#newevent
#id 4133
#rarity -2
#req_death 5
#req_luck 3
#req_land 1
#msg "A lich's failed plans yield a great gold and artifact bounty!"
#gold 1500
#magicitem 4
#end

#newevent
#id 4135
#rarity -1
#req_death 3
#req_magic 3
#req_lab 1
#req_pathdeath 1
#msg "Siphoning necrotic essence empowers your mage."
#deathboost 2
#end

#newevent
#id 4136
#rarity -2
#req_death 4
#req_magic 3
#req_unique 1
#req_pathdeath 1
#msg "A rediscovered tomb reveals ancient necromantic arts and gems."
#deathboost 4
#2d6vis 5
#end

#newevent
#id 4138
#rarity 2
#req_death 4
#req_unluck 3
#req_land 1
#msg "The restless dead are stirring, unnerved by your necrotic proximity."
#unrest 60
#kill 10
#end

#newevent
#id 4200
#rarity -2
#req_heat 3
#req_growth 3
#req_land 1
#msg "The relentless sun caused the land to bloom with fire-infused crops."
#landprod 10
#1d6vis 0
#end

#newevent
#id 4201
#rarity 2
#req_heat 3
#req_lazy 3
#req_land 1
#msg "Brutal heat caused a wave of lethargy. No one wants to work."
#landprod -15
#landgold -10
#end

#newevent
#id 4202
#rarity -1
#req_heat 3
#req_magic 3
#req_land 1
#msg "A magical heatwave caused the ambient air to crystallize into fire rubies."
#1d6vis 0
#1d6vis 0
#end

#newevent
#id 4203
#rarity 2
#req_heat 3
#req_death 3
#req_land 1
#msg "Extreme heat is causing rapid decay in your undead armies."
#kill 5
#unrest 20
#end

#newevent
#id 4204
#rarity -1
#req_heat 3
#req_order 3
#req_land 1
#msg "Ordered society maintained perfect irrigation even during a drought."
#landprod 15
#unrest -10
#end

#newevent
#id 4210
#rarity -2
#req_cold 3
#req_growth 3
#req_land 1
#msg "Magical frost preserved the local harvest, creating a massive surplus."
#landprod 20
#end

#newevent
#id 4211
#rarity 2
#req_cold 3
#req_lazy 3
#req_land 1
#msg "Extreme cold frozen the flow of goods; trade has completely halted."
#landgold -20
#taxboost -50
#end

#newevent
#id 4212
#rarity -1
#req_cold 3
#req_magic 3
#req_land 1
#msg "Intense, magical cold concentrated into pure ice-essence gems."
#1d6vis 2
#1d6vis 2
#end

#newevent
#id 4213
#rarity 2
#req_cold 3
#req_death 3
#req_lab 1
#msg "Freezing temperatures are shattering your laboratory equipment."
#lab 0
#kill 1
#unrest 20
#end

#newevent
#id 4214
#rarity -1
#req_cold 3
#req_order 3
#req_land 1
#msg "Disciplined peasants prepared for winter efficiently, leaving a food surplus."
#taxboost 50
#unrest -10
#end

#newevent
#id 4250
#rarity -1
#req_heat 3
#req_order 3
#req_land 1
#msg "Extreme heat and order allowed for masterful fire-tempered steel."
#gold 400
#magicitem 2
#end

#newevent
#id 4251
#rarity -1
#req_cold 3
#req_order 3
#req_land 1
#msg "Cold has been channeled into structured ice-fortifications."
#fort 3
#end

#newevent
#id 4252
#rarity 2
#req_heat 3
#req_magic 3
#req_land 1
#msg "Intense heat and magic forced fire spirits to emerge in the province."
#com 3716
#1d6units 3716
#end

#newevent
#id 4253
#rarity 2
#req_cold 3
#req_magic 3
#req_land 1
#msg "Magical cold manifested sentient ice-sculptors that demand tribute."
#unrest 20
#4d6units 1202
#end

#newevent
#id 4254
#rarity 2
#req_heat 3
#req_death 3
#req_land 1
#msg "Heat and Death create a stifling, necrotic miasma across the province."
#kill 5
#disease 5
#end

#newevent
#id 4255
#rarity 2
#req_cold 3
#req_death 3
#req_land 1
#msg "Cold preserves the dead, causing them to animate and haunt the living."
#unrest 40
#kill 2
#end

#newevent
#id 4256
#rarity -1
#req_heat 3
#req_prod 3
#req_land 1
#msg "A production boom fueled by a geothermal heat source."
#landprod 20
#landgold 10
#end

#newevent
#id 4257
#rarity 2
#req_cold 3
#req_prod 3
#req_land 1
#msg "Production slowed as machinery freezes solid in the unyielding cold."
#landprod -30
#gold -200
#end

#newevent
#id 4258
#rarity 2
#req_heat 3
#req_chaos 3
#req_land 1
#msg "Heat and Turmoil summoned a minor demon lord to demand sacrifices."
#kill 10
#unrest 30
#end

#newevent
#id 4259
#rarity 2
#req_cold 3
#req_chaos 3
#req_land 1
#msg "Cold has driven the populace to violent rioting and looting."
#unrest 50
#gold -300
#end

#newevent
#id 4270
#rarity 2
#req_heat 4
#req_land 1
#msg "A surge of solar magic ignited the air in the province."
#kill 10
#unrest 20
#end

#newevent
#id 4271
#rarity 2
#req_heat 5
#req_land 1
#req_kill 20
#req_com 3716
#req_unrest 60
#msg "Extreme heat turned the province into a fire elemental breeding ground."
#end

#newevent
#id 4272
#rarity -1
#req_heat 4
#req_prod 3
#req_land 1
#msg "Heat melted sand into valuable artistic sculptures."
#gold 500
#landprod 10
#end

#newevent
#id 4273
#rarity 2
#req_heat 5
#req_growth 3
#req_land 1
#msg "Heat levels are so high that all crops have turned to ash."
#landprod -50
#unrest 40
#end

#newevent
#id 4274
#rarity 2
#req_cold 4
#req_land 1
#msg "A magical blizzard froze the ground solid, making farming impossible."
#landprod -40
#kill 5
#end

#newevent
#id 4275
#rarity 2
#req_cold 5
#req_death 3
#req_land 1
#msg "Intense cold woke horrors from beneath the permafrost."
#kill 15
#com 1201
#unrest 50
#end

#newevent
#id 4276
#rarity -1
#req_cold 4
#req_magic 3
#req_land 1
#msg "Extreme cold caused gems to crystallize in the soil."
#2d6vis 2
#1d6vis 1
#end

#newevent
#id 4277
#rarity 2
#req_cold 5
#req_land 1
#msg "Reality itself is freezing; the province is now an icy wasteland."
#kill 60
#landprod -100
#end

#newevent
#id 4278
#rarity 1
#req_heat 4
#req_dominion 3
#msg "Extreme Heat gave rise to a fanatical cult that worships the sun."
#incdom 3
#unrest 20
#end

#newevent
#id 4279
#rarity -1
#req_cold 4
#req_prod 3
#req_land 1
#msg "Master smiths used the cold to temper blades of unprecedented sharpness."
#magicitem 2
#gold 300
#end

#newevent
#id 4300
#rarity 2
#req_heat 4
#req_land 1
#msg "Heat is spiraling out of control. Everything is catching fire!"
#decscale2 2
#kill 10
#end

#newevent
#id 4301
#rarity 2
#req_heat 5
#req_land 1
#msg "The extreme heat has summoned fire demons to the province."
#com 3716
#2d6units 528
#end

#newevent
#id 4302
#rarity 2
#req_cold 4
#req_land 1
#msg "Cold is warping the local climate into a permanent deep-freeze."
#incscale2 2
#landprod -20
#end

#newevent
#id 4303
#rarity 2
#req_cold 5
#req_land 1
#msg "Frost giants are pouring out of the ice to purge the living."
#com 2231
#2d6units 3746
#end

#newevent
#id 4310
#rarity -2
#req_heat 5
#req_luck 3
#msg "Heat impressed a Firelord. He pledges his forces to you!"
#nation -2
#com 818
#addequip 9
#end

#newevent
#id 4311
#rarity -2
#req_cold 5
#req_luck 3
#msg "Cold attracted an Ice Prince who seeks a frozen realm to rule."
#nation -2
#com 844
#addequip 9
#end

#newevent
#id 4350
#rarity -1
#req_heat 3
#req_luck 3
#req_land 1
#msg "A pleasant summer yielded a surplus of hardy grains."
#landprod 5
#gold 100
#end

#newevent
#id 4351
#rarity -1
#req_cold 3
#req_luck 3
#req_land 1
#msg "A cold snap preserved fish stocks, resulting in lucrative trade."
#landgold 10
#end

#newevent
#id 4356
#rarity -1
#req_heat 4
#req_luck 3
#req_land 1
#msg "Heat and luck attracted disciplined desert warriors to your cause."
#nation -2
#1d6units 1565
#end

#newevent
#id 4357
#rarity -1
#req_cold 4
#req_luck 3
#req_land 1
#msg "Cold and luck attracted mountain scouts to your service."
#nation -2
#1d6units 141
#end

#newevent
#id 4358
#rarity 2
#req_heat 4
#req_unluck 3
#req_land 1
#msg "Moderate heat caused goods to spoil during transport."
#landgold -5
#end

#newevent
#id 4359
#rarity 2
#req_cold 4
#req_unluck 3
#req_land 1
#msg "Moderate cold slowed river navigation, reducing tax revenue."
#landgold -5
#end

#newevent
#id 4380
#rarity -1
#req_growth 3
#req_order 3
#req_land 1
#msg "A well-ordered society maximized the fertility of the land."
#gold 300
#landprod 10
#end

#newevent
#id 4381
#rarity -1
#req_growth 3
#req_order 3
#req_land 1
#msg "Strict agricultural quotas led to a record-breaking crop yield."
#landprod 15
#end

#newevent
#id 4382
#rarity -2
#req_growth 4
#req_order 3
#req_land 1
#msg "Efficient administration created a massive food surplus."
#landgold 15
#taxboost 50
#end

#newevent
#id 4383
#rarity -2
#req_growth 5
#req_order 3
#req_land 1
#msg "Growth and Order transformed the province into an empire breadbasket."
#landprod 30
#landgold 20
#end

#newevent
#id 4384
#rarity 1
#req_growth 3
#req_drain 3
#req_land 1
#msg "A sudden growth spurt drew the attention of dark spirits."
#gold 100
#gemloss 53
#end

#newevent
#id 4385
#rarity 1
#req_growth 4
#req_drain 3
#req_land 1
#msg "Crops are draining the very magic from the soil to grow."
#gold 200
#gemloss 53
#end

#newevent
#id 4386
#rarity 2
#req_growth 4
#req_drain 3
#req_land 1
#msg "The trees fruit with rot and necrotic energy."
#gold 50
#disease 10
#gemloss 53
#end

#newevent
#id 4387
#rarity 2
#req_growth 5
#req_drain 3
#req_land 1
#msg "Ferocious fertility consumes all magic to sustain itself."
#gold 500
#gemloss 53
#end

#newevent
#id 4388
#rarity -1
#req_growth 4
#req_land 1
#msg "The land is so fertile that nature itself seems to gift you gold."
#landgold 10
#end

#newevent
#id 4389
#rarity 1
#req_growth 5
#req_land 1
#msg "The forest has become aggressive and is encroaching upon the city."
#unrest 20
#landprod -10
#end

#newevent
#id 4400
#rarity 2
#req_magic 4
#req_unluck 3
#req_land 1
#msg "Magic and misfortune torn the veil. Horrors prowl the province."
#com 308
#unrest 60
#kill 10
#end

#newevent
#id 4401
#rarity 2
#req_magic 5
#req_unluck 3
#req_lab 1
#msg "A mage's discovery caused a catastrophic mana backlash."
#lab 0
#gainaff 4194304
#unrest 30
#end

#newevent
#id 4402
#rarity -2
#req_magic 4
#req_unluck 3
#req_land 1
#msg "A gem materialized that exists in two places at once."
#gold 500
#1d6vis 4
#end

#newevent
#id 4404
#rarity 2
#req_drain 4
#req_unluck 3
#req_land 1
#msg "The province is so drained that the government suspects everyone."
#unrest 50
#incdom -2
#end

#newevent
#id 4405
#rarity 2
#req_drain 5
#req_unluck 3
#req_land 1
#msg "The absolute absence of magic is causing the world to unravel."
#kill 40
#unrest 100
#landgold -50
#end

#newevent
#id 4406
#rarity -1
#req_drain 4
#req_luck 3
#req_land 1
#msg "A survivor of the Drain found a pocket of crystallized aether."
#gold 300
#1d6vis 4
#end

#newevent
#id 4407
#rarity -2
#req_drain 5
#req_luck 3
#req_land 1
#msg "Your mages found a safe void-well to harvest for gems."
#3d6vis 53
#end

#newevent
#id 4410
#rarity 1
#req_magic 4
#req_unluck 3
#req_land 1
#msg "An entity emerged from a mana rift to feed on local belief."
#incdom -4
#com 308
#unrest 20
#end

#newevent
#id 4411
#rarity 2
#req_magic 5
#req_unluck 3
#req_land 1
#msg "A sorcerer declared himself ruler; the populace follows him."
#revolt 1
#com 312
#4d6units 1983
#end

#newevent
#id 4412
#rarity 1
#req_magic 3
#req_unluck 3
#req_land 1
#msg "Unlucky magical residues condensed into a physical, warping mist."
#gainaff 4096
#disease 10
#kill 5
#end

#newevent
#id 4413
#rarity 2
#req_magic 4
#req_unluck 3
#req_land 1
#msg "A massive horror is draining your gems to sustain its form."
#gemloss 53
#gold -500
#com 2213
#kill 10
#end

#newevent
#id 4414
#rarity 2
#req_magic 5
#req_unluck 3
#req_land 1
#msg "Magical misfortune turned your priests into madmen."
#temple 0
#incdom -8
#unrest 100
#end

#newevent
#id 4420
#rarity -2
#req_magic 4
#req_luck 3
#req_unique 1
#req_pathfire 1
#msg "A ritual revealed the ultimate secret of Fire."
#fireboost 1
#2d6vis 0
#end

#newevent
#id 4421
#rarity -2
#req_magic 4
#req_luck 3
#req_unique 1
#req_pathair 1
#msg "A sentient gale granted mastery of Air."
#airboost 1
#2d6vis 1
#end

#newevent
#id 4422
#rarity -2
#req_magic 4
#req_luck 3
#req_unique 1
#req_pathearth 1
#msg "Planetary resonance fortified your mage's Earth magic."
#earthboost 1
#2d6vis 3
#end

#newevent
#id 4425
#rarity -2
#req_magic 5
#req_luck 3
#req_lab 1
#msg "Ambient magic naturally enhances the skills of local mages."
#pathboost 1
#end

#newevent
#id 4426
#rarity -2
#req_magic 5
#req_luck 3
#req_growth 3
#req_pathnature 1
#msg "In this magical land, nature magic comes easily to your mages."
#natureboost 1
#1d6vis 6
#end

#newevent
#id 4427
#rarity -2
#req_magic 5
#req_luck 3
#req_death 3
#req_pathdeath 1
#msg "Concentrated death magic granted your mages a chilling clarity."
#deathboost 1
#1d6vis 5
#end

#newevent
#id 4429
#rarity -2
#req_magic 5
#req_luck 3
#req_lab 1
#msg "Total magical saturation granted your mage ultimate power."
#pathboost 9
#2d6vis 53
#end

#newevent
#id 4430
#rarity -1
#req_chaos 4
#req_luck 3
#req_land 1
#msg "A riot spilled over, leaving behind a cache of gold for you."
#gold 600
#unrest 10
#end

#newevent
#id 4431
#rarity -2
#req_chaos 5
#req_luck 3
#req_land 1
#msg "Lack of order allowed thieves to plunder a vault for you."
#magicitem 4
#gold 1000
#end

#newevent
#id 4432
#rarity 1
#req_chaos 4
#req_unluck 3
#req_land 1
#msg "Chaos allowed a criminal syndicate to take permanent root."
#landgold -15
#unrest 40
#end

#newevent
#id 4434
#rarity -1
#req_order 4
#req_luck 3
#req_land 1
#msg "Ordered administration stabilized the currency, boosting trade."
#landgold 20
#taxboost 50
#end

#newevent
#id 4435
#rarity -2
#req_order 5
#req_luck 3
#req_land 1
#msg "An artifact of absolute law has been discovered by inquisitors."
#magicitem 4
#incdom 2
#end

#newevent
#id 4436
#rarity 1
#req_order 4
#req_unluck 3
#req_land 1
#msg "Bureaucracy is so rigid that food distribution has failed."
#kill 10
#landprod -10
#end

#newevent
#id 4437
#rarity 2
#req_order 5
#req_unluck 3
#req_land 1
#msg "Extreme laws and misfortune caused massive tax riots."
#unrest 150
#gold -500
#end

#newevent
#id 4440
#rarity -2
#req_prod 4
#req_luck 3
#req_land 1
#msg "Hard work and luck led to a steam and gear breakthrough!"
#landprod 30
#gold 1000
#magicitem 3
#end

#newevent
#id 4441
#rarity 2
#req_prod 4
#req_unluck 3
#req_land 1
#msg "High quotas and luck led to a massive factory explosion."
#kill 5
#landprod -20
#gold -500
#unrest 40
#end

#newevent
#id 4442
#rarity -2
#req_prod 3
#req_magic 3
#req_lab 1
#req_land 1
#msg "Mages integrated rituals into the province's workshops."
#magicitem 2
#magicitem 2
#1d6vis 3
#end

#newevent
#id 4443
#rarity 2
#req_prod 3
#req_drain 3
#req_land 1
#msg "Total magic drain has made work physically exhausting."
#kill 2
#unrest 30
#landprod -10
#disease 5
#end

#newevent
#id 4444
#rarity -1
#req_death 3
#req_order 3
#req_land 1
#msg "In this land of death, even the spirits must pay their taxes."
#gold 400
#incdom 2
#unrest -10
#end

#newevent
#id 4445
#rarity -1
#req_death 4
#req_order 3
#req_land 1
#msg "Burials are organized into magically resonant grids."
#2d6vis 5
#incdom 3
#end

#newevent
#id 4446
#rarity 1
#req_growth 4
#req_chaos 3
#req_land 1
#msg "Explosive growth in a lawless province led to filthy slums."
#unrest 50
#disease 10
#kill 5
#end

#newevent
#id 4449
#rarity -2
#req_prod 5
#req_magic 3
#req_lab 1
#req_land 1
#msg "Industry and magic built a forge that draws from the aether."
#magicitem 4
#4d6vis 53
#landprod 50
#end

#newevent
#id 4450
#rarity 1
#req_unluck 4
#req_chaos 3
#req_land 1
#msg "A powerful bandit lord has established a shadow government."
#unrest 50
#landgold -10
#end

#newevent
#id 4451
#rarity 1
#req_unluck 4
#req_death 3
#req_land 1
#msg "A virulent, unlucky plague has struck the province."
#kill 20
#disease 15
#unrest 30
#end

#newevent
#id 4452
#rarity 1
#req_unluck 4
#req_order 3
#req_land 1
#msg "Administrators were caught in a massive embezzlement scheme."
#gold -800
#unrest 20
#taxboost -100
#end

#newevent
#id 4453
#rarity 1
#req_unluck 4
#req_land 1
#req_minpop 200
#msg "Unlucky landslides permanently damaged local infrastructure."
#landgold -20
#taxboost -50
#landprod -10
#end

#newevent
#id 4455
#rarity 1
#req_unluck 4
#req_chaos 3
#req_land 1
#msg "A charismatic rebel emerged, claiming you are cursed."
#com 55
#16d6units 1312
#unrest 80
#end

#newevent
#id 4460
#rarity 2
#req_unluck 5
#req_coast 1
#req_capital 0
#req_turn 15
#msg "A catastrophic earthquake caused the coast to sink."
#kill 90
#fort 0
#temple 0
#lab 0
#end

#newevent
#id 4461
#rarity 2
#req_unluck 5
#req_chaos 3
#req_land 1
#msg "Extreme misfortune opened a portal releasing a Demon Lord."
#com 821
#4d6units 304
#kill 20
#unrest 150
#end

#newevent
#id 4462
#rarity 2
#req_unluck 5
#req_order 3
#req_land 1
#req_turn 20
#msg "Total societal collapse; the treasury has been looted."
#gold -5000
#landgold -50
#landprod -50
#unrest 200
#end

#newevent
#id 4470
#rarity 1
#req_unluck 4
#req_land 1
#msg "Unprecedented rains caused a catastrophic flood."
#kill 15
#unrest 40
#landprod -10
#end

#newevent
#id 4474
#rarity 2
#req_unluck 5
#req_land 1
#req_kill 30
#req_fort 0
#req_temple 0
#req_lab 0
#req_unrest 80
#msg "A massive earthquake leveled the local infrastructure."
#end

#newevent
#id 4476
#rarity 2
#req_unluck 5
#req_land 1
#req_com 2213
#req_kill 50
#req_unrest 200
#req_gemloss 53
#msg "A permanent rift opened; a Doom Horror arrived for every soul."
#end

#newevent
#id 4478
#rarity 2
#req_unluck 5
#req_temple 1
#msg "Extreme misfortune purged your dominion from the land."
#temple 0
#incdom -15
#unrest 300
#end

#newevent
#id 4483
#rarity -2
#req_luck 5
#req_land 1
#msg "Gold found in every well and gems in every garden."
#gold 3000
#2d6vis 53
#end

#newevent
#id 4489
#rarity -2
#req_magic 5
#req_land 1
#req_unique 1
#msg "Extreme magic saturation allowed a celestial to join you."
#nation -2
#com 651
#addequip 4
#end

#newevent
#id 4490
#rarity -1
#req_luck 2
#req_land 1
#req_minpop 50
#msg "An oracle offers prosperity in exchange for wealth."
#decscale 4
#gold -200
#unrest 10
#end

#newevent
#id 4495
#rarity -2
#req_luck 3
#req_land 1
#req_temple 1
#msg "A rival idol was shattered, increasing your province's luck."
#decscale2 4
#incdom -4
#unrest 20
#end

#newevent
#id 4497
#rarity -1
#req_luck 3
#req_lab 1
#req_magic 3
#msg "A lucky alchemist needs gems to boost provincial fortune."
#decscale2 4
#gemloss 53
#end

#newevent
#id 4499
#rarity -2
#req_luck 3
#req_land 1
#req_magic 3
#msg "A hermit blessed your reign in exchange for artifacts."
#decscale2 4
#magicitem -1
#magicitem -1
#end

#newevent
#id 4506
#rarity 2
#req_unluck 3
#req_death 3
#req_unique 1
#msg "An ancient lich offered services for a feast of souls."
#incscale2 4
#nation -2
#com 310
#kill 10
#end

#newevent
#id 4509
#rarity 2
#req_unluck 3
#req_magic 3
#req_lab 1
#msg "A dangerous ritual permanently shattered the province's fate."
#incscale3 4
#gold 1500
#magicitem 3
#end

#newevent
#id 4513
#rarity 1
#req_unluck 5
#req_magic 3
#req_unique 1
#msg "A Lich offered services for the province's total life force."
#nation -2
#com 310
#kill 99
#incdom -5
#end

#newevent
#id 4515
#rarity -2
#req_unluck 3
#req_magic 3
#req_unique 1
#req_land 1
#msg "Misfortune is so heavy that the Likho has come to share it."
#nation -2
#com 1952
#incscale 4
#end

#newevent
#id 4521
#rarity 2
#req_magic 5
#req_unluck 3
#req_land 1
#msg "Arcane saturation summoned the Gore Tide to consume all."
#com 2213
#kill 40
#unrest 200
#lab 0
#end

#newevent
#id 4525
#rarity 2
#req_death 3
#req_unluck 5
#req_land 1
#msg "The Corpse Eater manifested to consume the population."
#com 997
#kill 75
#unrest 120
#temple 0
#end

#newevent
#id 4530
#rarity 2
#req_heat 5
#req_unluck 3
#req_fort 1
#req_turn 15
#msg "Intense Heat caused the fortress to collapse."
#fort 0
#kill 5
#unrest 20
#end

#newevent
#id 4532
#rarity 2
#req_death 5
#req_unluck 3
#req_temple 1
#msg "Necrotic energy dissolved the temple into black sludge."
#temple 0
#incdom -5
#kill 5
#end

#newevent
#id 4534
#rarity 1
#req_order 4
#req_unluck 3
#req_temple 1
#msg "Extreme order and bad luck led to a violent schism."
#temple 0
#unrest 100
#incdom -4
#end

#newevent
#id 4544
#rarity 2
#req_magic 4
#req_unluck 3
#req_lab 1
#req_researcher 1
#msg "Unlucky feedback drove researchers mad and destroyed the lab."
#researchaff 4194304
#lab 0
#gemloss 53
#end

#newevent
#id 4547
#rarity 1
#req_chaos 3
#req_unluck 3
#req_fort 1
#req_turn 15
#msg "A tornado of chaotic energy destroyed the fortress."
#fort 0
#unrest 100
#kill 5
#end

#newevent
#id 4550
#rarity -2
#req_heat 5
#req_luck 3
#req_pathfire 4
#req_land 1
#msg "The relentless heat has reached a fever pitch, melting the very dunes. A master of the eternal flame was seen drawing the blinding glare into a localized furnace, tempering steel with the strength of a dying star."
#gold 500
#magicitem 4
#3d6vis 0
#end

#newevent
#id 4551
#rarity -2
#req_swamp 1
#req_growth 5
#req_luck 2
#req_pathnature 4
#msg "Growth has reached a fever pitch in the wetlands. The very moss seems to think and reach. Your Nature Master has coaxed the vines into forming a protective canopy and gifting rare resins."
#gold 300
#1d6vis 6
#defence 15
#end

#newevent
#id 4552
#rarity -2
#req_cave 1
#req_magic 5
#req_luck 2
#req_pathastral 4
#msg "The deep earth hums with saturated magic. Crystals have burst from the cavern walls, vibrating in harmony with the spheres. Your Astral Master has learned to tune these stones to the heavens."
#5d6vis 4
#researchaff 2
#end

#newevent
#id 4553
#rarity -2
#req_land 0
#req_death 5
#req_luck 3
#req_pathdeath 4
#msg "The cold currents carry the weight of a thousand shipwrecks. In this dead sea, your Necromancer has managed to bind the coral-encrusted shades of ancient mariners to your standard."
#nation -2
#com 181
#addequip 2
#end

#newevent
#id 4554
#rarity -2
#req_cave 1
#req_sloth 5
#req_luck 3
#req_pathearth 4
#msg "While the people have fallen into a state of total lethargy, your Earth Master has used the absolute stillness of the caves to grow a fortress from the living rock without a single hammer-blow."
#fort 2
#unrest -20
#end

#newevent
#id 4555
#rarity 2
#req_waste 1
#req_chaos 5
#req_heat 3
#req_unluck 3
#msg "Anarchy has shattered the social order of the waste. In the absence of law, a magical heat-vortex has turned the sands into a swirling storm of razor-sharp glass."
#kill 30
#unrest 150
#disease 10
#end

#newevent
#id 4556
#rarity -2
#req_swamp 1
#req_sloth 5
#req_magic 3
#req_pathwater 4
#msg "The swamp has become so still that time itself seems to thicken. Your Hydromancer has drawn this temporal weight into a liquid state, distilling it into pure power."
#3d6vis 2
#magicitem 3
#end

#newevent
#id 4557
#rarity -2
#req_land 0
#req_magic 5
#req_chaos 2
#req_pathnature 4
#msg "Wild magic has warped the local sea-life into beautiful, terrifying new forms. Your Nature Master has stabilized these mutations, pressing them into your service."
#nation -2
#com 394
#6d6units 394
#end

#newevent
#id 4558
#rarity -2
#req_waste 1
#req_death 5
#req_magic 3
#req_pathdeath 5
#msg "The scouring winds of the waste have uncovered the bone-white palace of a long-dead desert sovereign. Your Necromancer has reawakened the silent court."
#gold 1000
#com 998
#A600 533
#end

#newevent
#id 4559
#rarity -1
#req_cave 1
#req_order 5
#req_luck 2
#req_pathearth 4
#msg "Order in the deep caves has reached a state of mathematical perfection. Your Earth Master has used this stability to expand the mines with surgical precision."
#landgold 50
#landprod 50
#end

#newevent
#id 4560
#rarity -2
#req_waste 1
#req_unmagic 5
#req_luck 3
#req_pathastral 4
#msg "In a land where wonder has died and the air is heavy and sparkless, your Astral Master has found a way to draw gems from the absolute vacuum of the aether."
#4d6vis 4
#gold 200
#end

#newevent
#id 4561
#rarity -1
#req_waste 1
#req_growth 5
#req_luck 3
#req_land 1
#msg "The relentless drive of nature has forced life into the barren wastes. Nature gems can be found blooming from the skulls of those the desert claimed."
#3d6vis 6
#gold 100
#end

#newevent
#id 4562
#rarity -2
#req_land 0
#req_cold 5
#req_luck 3
#req_pathwater 4
#msg "The absolute zero of the deep currents has crystallized the water into shards of permanent ice. Your Water Master has used these as anchors for powerful enchantments."
#4d6vis 2
#magicitem 4
#end

#newevent
#id 4563
#rarity -1
#req_swamp 1
#req_order 5
#req_luck 3
#msg "The swamp has been tamed by absolute law. Channels are cut in perfect lines, and the very rot is processed for tax revenue."
#gold 800
#taxboost 100
#end

#newevent
#id 4600
#rarity 1
#req_order 2
#req_unluck 2
#req_land 1
#msg "The strict laws of this land have become a cage. Corrupt officials use every regulation to squeeze the populace, and the weight of their misery has brought a dark cloud of misfortune over the capital."
#decscale2 0
#incscale2 4
#unrest 40
#gold -200
#end

#newevent
#id 4601
#rarity 1
#req_order 3
#req_unluck 3
#req_land 1
#msg "The administrative complex has become so rigid that nothing moves without a bribe. The stifling order is attracting ill-favored spirits who feast on the frustration of the clerks."
#decscale2 0
#incscale2 4
#taxboost -100
#landgold -15
#end

#newevent
#id 4602
#rarity 2
#req_order 2
#req_unluck 3
#req_cave 1
#msg "In the deep caves, the law is enforced with lethal silence. The absolute rigidity of the state has caused a spiritual stagnation, allowing shadow-creatures to replace the local guards."
#decscale3 0
#incscale2 4
#defence -15
#unrest 50
#end

#newevent
#id 4603
#rarity 1
#req_chaos 2
#req_unluck 2
#req_land 1
#msg "The constant turmoil has reached a breaking point. The local government has collapsed entirely, leaving the populace to the mercy of a cruel and random fate."
#incscale2 0
#incscale2 4
#unrest 80
#gold -300
#end

#newevent
#id 4604
#rarity 1
#req_chaos 3
#req_unluck 3
#req_land 1
#msg "In the lawless streets, a series of unlucky accidents has ignited the mob's fury. They no longer protest for change; they simply burn everything in their path."
#incscale2 0
#incscale2 4
#kill 10
#unrest 100
#lab 0
#end

#newevent
#id 4605
#rarity 2
#req_chaos 2
#req_unluck 3
#req_swamp 1
#msg "The swamp is a haven for the lawless. Their violent chaos has disturbed the ancient rot, bringing a streak of terrible luck to any who try to impose order here."
#incscale3 0
#incscale2 4
#disease 5
#unrest 60
#end

#newevent
#id 4606
#rarity 1
#req_prod 2
#req_unluck 2
#req_mountain 1
#msg "High quotas and a string of fatal cave-ins have pushed the workers to the brink. The earth itself seems to resent the frantic pace of production, rewarding effort with nothing but tragedy."
#decscale2 1
#incscale2 4
#kill 15
#gold -400
#end

#newevent
#id 4607
#rarity 1
#req_prod 3
#req_unluck 3
#req_land 1
#msg "The frantic pace of industry has led to mechanical failures across the province. The machinery of production has turned into a source of constant, unlucky accidents."
#decscale2 1
#incscale2 4
#landprod -20
#unrest 40
#end

#newevent
#id 4608
#rarity 2
#req_prod 2
#req_unluck 3
#req_land 0
#msg "The rushing currents of the sea are being exploited for power, but the heavy equipment keeps snapping in the dark water. The absolute drive for production is poisoning the reefs."
#decscale3 1
#incscale2 4
#kill 5
#incscale 3
#end

#newevent
#id 4609
#rarity 1
#req_sloth 2
#req_unluck 2
#req_land 1
#msg "A wave of profound lethargy has settled over the valley. No one works, no one maintains the wards, and a heavy shroud of bad luck has followed the thickening apathy."
#incscale2 1
#incscale2 4
#landprod -15
#landgold -15
#end

#newevent
#id 4610
#rarity 1
#req_sloth 3
#req_unluck 3
#req_land 1
#req_turn 15
#msg "Neglect has reached the point of structural failure. The walls are falling, the wells are filling with silt, and the gods have turned their faces away from this lazy land."
#incscale2 1
#incscale2 4
#fort 0
#unrest 30
#end

#newevent
#id 4611
#rarity 2
#req_sloth 2
#req_unluck 3
#req_cave 1
#msg "In the deep caves, the silence has become absolute. The people simply sit in the dark, waiting for an end. Their collective despair has drawn a shadow of misfortune over the tunnels."
#incscale3 1
#incscale2 4
#kill 5
#incdom -2
#end

#newevent
#id 4612
#rarity 1
#req_heat 2
#req_unluck 2
#req_waste 1
#msg "The sun has become a hateful eye, scorching the crops and boiling the luck of the inhabitants. The relentless heat is drawing fire-spirits from the waste."
#decscale2 2
#incscale2 4
#kill 10
#1d6vis 0
#end

#newevent
#id 4613
#rarity 1
#req_heat 3
#req_unluck 3
#req_land 1
#msg "A series of unlucky volcanic fissures have opened in the province. The heat is unbearable, and the air is filled with the scent of sulfur and impending doom."
#decscale2 2
#incscale2 4
#unrest 50
#kill 5
#incscale 3
#end

#newevent
#id 4614
#rarity 2
#req_heat 2
#req_unluck 3
#req_land 0
#msg "The magical currents of the deep ocean have been superheated by an unlucky shift in the earth's crust. The water is scalding, and the sea-life is dying in the boil."
#decscale3 2
#incscale2 4
#kill 20
#taxboost -50
#end

#newevent
#id 4615
#rarity 1
#req_cold 2
#req_unluck 2
#req_land 1
#msg "The cold has deepened into a bone-chilling deep freeze. Every attempt to build a fire ends in a freak accident, and the populace is freezing in their beds."
#incscale2 2
#incscale2 4
#kill 15
#unrest 20
#end

#newevent
#id 4616
#rarity 1
#req_cold 3
#req_unluck 3
#req_land 1
#msg "A cursed storm of ice has settled over the province. The very concept of luck has frozen solid, and the people are beginning to worship the frost simply to survive."
#incscale2 2
#incscale2 4
#landprod -30
#incdom -2
#end

#newevent
#id 4617
#rarity 2
#req_cold 2
#req_unluck 3
#req_land 0
#msg "The deep ocean has turned to a slush of ice and death. An unlucky convergence of cold has trapped several trade vessels in permanent floes."
#incscale3 2
#incscale2 4
#landgold -20
#gold -200
#end

#newevent
#id 4618
#rarity 1
#req_growth 2
#req_unluck 2
#req_land 1
#msg "The land is growing too fast. The crops are enormous but filled with a blight that turns to poison in the belly. Nature has become a predatory force."
#decscale2 3
#incscale2 4
#disease 10
#kill 5
#end

#newevent
#id 4619
#rarity 1
#req_growth 3
#req_unluck 3
#req_land 1
#msg "The population has exploded, but a streak of misfortune has led to fires and collapses in the new settlements. The province is a powder keg of filth and disease."
#decscale2 3
#incscale2 4
#unrest 60
#disease 15
#end

#newevent
#id 4620
#rarity 2
#req_growth 2
#req_unluck 3
#req_swamp 1
#msg "In the humid swamp, the growth has become a choking vine. Every path cleared is reclaimed overnight by an unlucky surge of thorny vegetation that bleeds black sap."
#decscale3 3
#incscale2 4
#landprod -15
#unrest 40
#end

#newevent
#id 4621
#rarity 1
#req_death 2
#req_unluck 2
#req_waste 1
#msg "A dry, unlucky wind is blowing from the waste, carrying the scent of old graves. Life is withering, and the few survivors find their luck has evaporated with their health."
#incscale2 3
#incscale2 4
#kill 20
#landprod -10
#end

#newevent
#id 4622
#rarity 1
#req_death 3
#req_unluck 3
#req_land 1
#msg "A series of unlucky deaths among the local mages has leaked necrotic energy into the wells. The transition from life to death has become a slippery, frequent slope."
#incscale2 3
#incscale2 4
#kill 30
#disease 5
#end

#newevent
#id 4623
#rarity 2
#req_death 2
#req_unluck 3
#req_swamp 1
#msg "The rot in the swamp has gained a life of its own. An unlucky alignment of the spheres has caused the dead to rise and simply stand in the water, staring at the living."
#incscale3 3
#incscale2 4
#unrest 50
#incdom -2
#end

#newevent
#id 4624
#rarity 1
#req_magic 2
#req_unluck 2
#req_land 1
#msg "The magic in the air is shimmering with an unlucky intensity. Simple spells are exploding in the casters' faces, and the very air is starting to bleed aether."
#decscale2 5
#incscale2 4
#researchaff 1073741824
#unrest 20
#end

#newevent
#id 4625
#rarity 1
#req_magic 3
#req_unluck 3
#req_land 1
#msg "A sequence of magical mishaps has thinned the veil. Strange, unlucky geometry is appearing in the architecture, and the people are losing their minds to the distortion."
#decscale2 5
#incscale2 4
#kill 5
#gainaff 4194304
#unrest 50
#end

#newevent
#id 4626
#rarity 2
#req_magic 2
#req_unluck 3
#req_land 0
#msg "The ocean floor is glowing with a wild, unlucky magic. The fish are being reborn as multi-eyed horrors, and the mermen priests are babbling in forgotten tongues."
#decscale3 5
#incscale2 4
#com 308
#6d6units 88
#end

#newevent
#id 4627
#rarity 1
#req_unmagic 2
#req_unluck 2
#req_land 1
#msg "A fog of spiritual stagnation has rolled in, erasing memories and dulling the senses. Every attempt to record lore ends in fire or ink-blots, and a heavy gloom follows."
#incscale2 5
#incscale2 4
#researchaff 4194304
#landgold -5
#end

#newevent
#id 4628
#rarity 1
#req_unmagic 3
#req_unluck 3
#req_land 1
#msg "The spiritual void has become so strong it is pulling at the souls of the living. An unlucky trend of suicides has struck the local scholars."
#incscale2 5
#incscale2 4
#kill 10
#researchaff 0
#end

#newevent
#id 4629
#rarity 2
#req_unmagic 2
#req_unluck 3
#req_cave 1
#msg "In the deep tunnels, the last sparks of wonder have died. An unlucky collapse has buried the library, and the people have forgotten how to read their own names."
#incscale3 5
#incscale2 4
#gold -300
#researchaff 0
#end

#newevent
#id 4630
#rarity 1
#req_order 2
#req_unluck 3
#req_land 1
#msg "Misfortune has led to a treasury shortfall, and the response has been a draconian increase in enforcement. The law is now a parasite."
#decscale2 0
#incscale2 4
#taxboost -50
#unrest 30
#end

#newevent
#id 4631
#rarity 1
#req_chaos 2
#req_unluck 3
#req_land 1
#msg "A series of unlucky shortages has turned a peaceful protest into a murderous riot. The anarchy is breeding a deeper, darker streak of bad luck."
#incscale2 0
#incscale2 4
#kill 5
#gold -400
#unrest 60
#end

#newevent
#id 4632
#rarity 1
#req_prod 2
#req_unluck 3
#req_land 1
#msg "The machines are failing, the workers are dying, and the overseers are desperate. The frantic push for production is ending in a spectacular, unlucky catastrophe."
#decscale2 1
#incscale2 4
#kill 20
#landprod -20
#gold -500
#end

#newevent
#id 4633
#rarity 1
#req_sloth 2
#req_unluck 3
#req_land 1
#msg "The wells are dry, the people are still, and the bad luck is constant. The lethargy of the province has become a self-fulfilling prophecy of doom."
#incscale2 1
#incscale2 4
#landgold -10
#landprod -10
#unrest 10
#end

#newevent
#id 4634
#rarity 1
#req_heat 2
#req_unluck 3
#req_land 1
#msg "The heat is so intense it is driving the animals mad. A streak of unlucky bites has started a localized plague among the dehydrated survivors."
#decscale2 2
#incscale2 4
#disease 10
#kill 5
#end

#newevent
#id 4635
#rarity 1
#req_cold 2
#req_unluck 3
#req_land 1
#msg "The cold has reached a point where the very stones are cracking. An unlucky series of building collapses has left the populace homeless in the blizzard."
#incscale2 2
#incscale2 4
#kill 20
#gold -200
#unrest 20
#end

#newevent
#id 4636
#rarity 1
#req_growth 2
#req_unluck 3
#req_land 1
#msg "Life is too abundant. The weeds are overrunning the streets, and an unlucky failure in the sewers has turned the city into a fertile breeding ground for pestilence."
#decscale2 3
#incscale2 4
#disease 20
#unrest 30
#end

#newevent
#id 4637
#rarity 1
#req_death 2
#req_unluck 3
#req_land 1
#msg "The graveyard is full, the crops are mulch, and the bad luck is a heavy shroud. The absolute weight of death is pulling the living into the soil."
#incscale2 3
#incscale2 4
#kill 40
#incscale2 3
#end

#newevent
#id 4638
#rarity 1
#req_magic 2
#req_unluck 3
#req_lab 1
#msg "Reality is literally burning. Every unlucky word spoken by a mage causes a localized explosion of wild magic, shredding the lab and the minds within."
#decscale2 5
#incscale2 4
#lab 0
#researchaff 4194304
#end

#newevent
#id 4639
#rarity 1
#req_unmagic 2
#req_unluck 3
#req_land 1
#msg "The silence of the arcane has become a physical weight. Every unlucky thought is forgotten instantly, leaving the populace as drooling husks in a sparkless world."
#incscale2 5
#incscale2 4
#kill 10
#researchaff 0
#researchaff 0
#end

#newevent
#id 4640
#rarity -1
#req_order 1
#req_luck 1
#req_land 1
#msg "A local official has earned a reputation for absolute integrity. Under his watch, the law is respected and several bandits have voluntarily surrendered their loot."
#decscale 0
#decscale 4
#gold 150
#unrest -10
#end

#newevent
#id 4641
#rarity -1
#req_order 2
#req_luck 2
#req_land 1
#msg "A long-standing feud between noble families was settled justly and without bloodshed. The populace is impressed by the stability of the realm."
#decscale 0
#decscale 4
#taxboost 50
#end

#newevent
#id 4642
#rarity -1
#req_prod 1
#req_luck 1
#req_land 1
#msg "A young blacksmith has shown extraordinary promise, discovering a more efficient way to temper iron. Provincial output has seen a modest but steady rise."
#decscale 1
#decscale 4
#landprod 5
#gold 50
#end

#newevent
#id 4643
#rarity -1
#req_prod 2
#req_luck 2
#req_land 1
#msg "Through a stroke of good fortune, the various workshops of the province have begun coordinating their efforts perfectly, resulting in a surprising surplus."
#decscale 1
#decscale 4
#landprod 10
#gold 100
#end

#newevent
#id 4644
#rarity -1
#req_growth 1
#req_luck 1
#req_land 1
#msg "The stars have aligned to provide perfect weather and healthy soil. The infants born this year are uncommonly strong and the elders are unusually hale."
#decscale 3
#decscale 4
#taxboost 100
#unrest -5
#end

#newevent
#id 4645
#rarity -1
#req_growth 2
#req_luck 2
#req_land 1
#msg "A natural spring with minor curative properties was discovered by a lucky shepherd. The health and spirit of the local community have greatly improved."
#decscale 3
#decscale 4
#disease -5
#incpop 20
#end

#newevent
#id 4646
#rarity -1
#req_magic 1
#req_luck 1
#req_lab 1
#msg "An accidental excavation at the local library revealed a small mana-well. The air is now thick with the scent of ozone and possibility."
#decscale 5
#decscale 4
#1d3vis 53
#end

#newevent
#id 4647
#rarity -1
#req_magic 2
#req_luck 2
#req_lab 1
#msg "A researcher happened to glance at an old scroll through a specific prism, revealing a hidden formula. This minor breakthrough has energized the local academy."
#decscale 5
#decscale 4
#researchaff 1
#end

#newevent
#id 4648
#rarity -1
#req_heat 1
#req_luck 1
#req_land 1
#msg "The sun lingers over the fields with a gentle, nourishing warmth. Farmers have found that the heat has brought out a rich sweetness in the summer fruit."
#decscale 2
#decscale 4
#landgold 10
#end

#newevent
#id 4649
#rarity -1
#req_cold 1
#req_luck 1
#req_land 1
#msg "The cold has set in with a crisp, clean clarity. The frozen roads have surprisingly facilitated the transport of heavy timber and furs."
#incscale 2
#decscale 4
#landgold 10
#end

#newevent
#id 4650
#rarity -1
#req_chaos 1
#req_luck 1
#req_land 1
#msg "In a moment of sudden clarity and good fortune, the leaders of a local riot have realized the futility of their chaos and pledged themselves to public service."
#decscale 0
#decscale 4
#unrest -30
#gold 50
#end

#newevent
#id 4651
#rarity -1
#req_death 1
#req_luck 1
#req_land 1
#msg "In an overgrown graveyard, a single white rose was found blooming with unnatural vigor. This sign of hope has quelled the fear of death among the locals."
#decscale 3
#decscale 4
#unrest -20
#incdom 1
#end

#newevent
#id 4652
#rarity -1
#req_sloth 1
#req_luck 1
#req_land 1
#msg "A local artisan, previously known for his laziness, was struck by a sudden bolt of inspiration. His new designs have invigorated the local economy."
#decscale 1
#decscale 4
#landprod 5
#landgold 5
#end

#newevent
#id 4653
#rarity -1
#req_unmagic 1
#req_luck 1
#req_land 1
#msg "In a land previously devoid of magic, a child was found with the ability to call fireflies to her hand. This small miracle has returned a sense of wonder to the populace."
#decscale 5
#decscale 4
#1d6vis 4
#end

#newevent
#id 4654
#rarity -1
#req_cave 1
#req_luck 1
#req_decscale 0
#req_decscale 4
#req_landprod 10
#msg "In the deep caves, the wind whistling through the stalactites has begun to sound like harmonic music. Mining crews find the sound soothing and work with improved focus."
#end

#newevent
#id 4655
#rarity -1
#req_waste 1
#req_luck 1
#req_decscale 3
#req_decscale 4
#req_gold 200
#msg "In the absolute heart of the waste, a cluster of rare flowers has bloomed. Their petals are prized by alchemists, bringing a surge of trade to the desolate region."
#end

#newevent
#id 4656
#rarity -1
#req_land 0
#req_luck 1
#msg "A favorable shift in the ocean currents has washed a cache of valuable wreckage into the shallows. The salvage has boosted the provincial treasury."
#decscale 1
#decscale 4
#gold 300
#end

#newevent
#id 4657
#rarity -1
#req_swamp 1
#req_luck 1
#msg "The swamp has yielded an uncommonly rich layer of peat this season. The increased availability of fuel has warmed the homes and spirits of the villagers."
#decscale 1
#decscale 4
#taxboost 40
#end

#newevent
#id 4658
#rarity -1
#req_order 1
#req_luck 2
#req_land 1
#msg "A wealthy landowner, favored by recent good fortune, has decided to donate a significant portion of his wealth to improve the local fortifications."
#decscale 0
#decscale 4
#gold 100
#defence 10
#end

#newevent
#id 4659
#rarity -1
#req_prod 1
#req_luck 2
#req_land 1
#msg "A lucky encounter with a traveling tinkerer has left the local garrison with improved tools and a renewed sense of purpose."
#decscale 1
#decscale 4
#defence 5
#gold 50
#end

#newevent
#id 4660
#rarity -1
#req_order 3
#req_unluck 1
#req_land 1
#msg "Though recent times have been ill-favored, the local governor’s strict adherence to just laws has brought a sense of predictability back to the province. Fortune begins to turn."
#decscale 4
#unrest -10
#gold 50
#end

#newevent
#id 4661
#rarity -1
#req_prod 3
#req_unluck 1
#req_mountain 1
#msg "Despite a string of bad luck, the tireless work ethic of the local miners has finally paid off. A small but consistent vein of ore was found, lifting the spirits of the workers."
#decscale 4
#gold 100
#landprod 5
#end

#newevent
#id 4662
#rarity -1
#req_growth 3
#req_unluck 1
#req_land 1
#msg "The populace is uncommonly healthy and vigorous. Even though the stars have been malicious, the people’s natural resilience has allowed them to shrug off recent tragedies."
#decscale 4
#incpop 50
#unrest -5
#end

#newevent
#id 4663
#rarity -1
#req_magic 3
#req_unluck 1
#req_lab 1
#msg "The local mages have spent months performing minor rituals to smooth out the jagged edges of reality. The heavy feeling of the province is finally beginning to lift."
#decscale 4
#1d3vis 53
#researchaff 1
#end

#newevent
#id 4664
#rarity -1
#req_cave 1
#req_order 2
#req_unluck 1
#msg "In the deep caves, an organized effort to map the shifting stones has prevented a series of unlucky collapses. The tunnels feel safer and more stable than before."
#decscale 4
#defence 10
#gold 50
#end

#newevent
#id 4665
#rarity -1
#req_land 0
#req_order 2
#req_unluck 1
#msg "Favorable winds and a disciplined naval patrol have guided several lost ships back to port, overcoming a long period of maritime misfortune."
#decscale 4
#gold 150
#landgold 5
#end

#newevent
#id 4666
#rarity -1
#req_swamp 1
#req_growth 2
#req_unluck 1
#msg "A breakthrough by local herbalists in the damp wetlands has provided a cure for the recurring fevers. The cloud of misery hanging over the swamp is breaking."
#decscale 4
#disease -10
#unrest -10
#end

#newevent
#id 4667
#rarity -1
#req_waste 1
#req_sloth 2
#req_unluck 1
#msg "A hermit living in the waste has shared his knowledge of the shifting sands with your scouts. Navigating the desert is no longer a matter of mere, deadly chance."
#decscale 4
#gold 50
#unrest -5
#end

#newevent
#id 4668
#rarity -1
#req_order 4
#req_unluck 1
#req_land 1
#msg "A highly organized audit has rooted out the corrupt officials who were preying on the province's bad luck. With the parasites gone, prosperity is returning."
#decscale 4
#taxboost 50
#gold 100
#end

#newevent
#id 4669
#rarity -1
#req_prod 4
#req_unluck 1
#req_land 1
#msg "Faced with a shortage caused by ill-fortune, the industrious craftsmen of this land have found a way to repurpose old wreckage into functioning tools."
#decscale 4
#landprod 10
#gold 50
#end

#newevent
#id 4670
#rarity -1
#req_growth 4
#req_unluck 1
#req_land 1
#msg "A spike in healthy births has invigorated the province. The young are strong and optimistic, refusing to be cowed by the curse that troubled their elders."
#decscale 4
#incpop 100
#incdom 1
#end

#newevent
#id 4671
#rarity -1
#req_magic 4
#req_unluck 1
#req_land 1
#msg "The high saturation of magic in this land has allowed your mages to literally stitch a localized rift in fate. The air no longer shimmers with malice."
#decscale 4
#2d6vis 4
#researchaff 2
#end

#newevent
#id 4672
#rarity -1
#req_order 2
#req_prod 2
#req_unluck 1
#req_fort 1
#msg "Through sheer, ordered effort, the local fortress has been reinforced against the unlucky tremors that have plagued the region. The walls stand firm."
#decscale 4
#defence 20
#end

#newevent
#id 4673
#rarity -1
#req_swamp 1
#req_order 2
#req_unluck 1
#msg "A massive effort to dredge the swamp channels has removed the stagnant pools that were breeding bad luck and sickness. The water flows clear once more."
#decscale 4
#disease -5
#taxboost 20
#end

#newevent
#id 4674
#rarity -1
#req_cave 1
#req_magic 2
#req_unluck 1
#msg "A rare, magical moss has begun to bloom in the caves, guided by the high mana of the region. It provides light to travelers, ending a period of unlucky disappearances."
#decscale 4
#gold 50
#unrest -10
#end

#newevent
#id 4675
#rarity -1
#req_waste 1
#req_prod 2
#req_unluck 1
#msg "An ambitious engineering project has successfully tapped into a deep aquifer beneath the waste. The water has turned a streak of bad luck into a new beginning."
#decscale 4
#gold 200
#decscale 3
#end

#newevent
#id 4676
#rarity -1
#req_land 0
#req_prod 2
#req_unluck 1
#msg "A group of industrious mermen has successfully salvaged a treasure fleet that was lost years ago to the currents of fate. The find has stabilized the local economy."
#decscale 4
#gold 400
#landgold 10
#end

#newevent
#id 4677
#rarity -1
#req_magic 2
#req_luck -1
#req_lab 1
#msg "An alchemist working in the local lab has discovered a way to stabilize volatile reagents. This has ended a string of unlucky explosions and improved the local outlook."
#decscale 4
#1d6vis Elemental
#end

#newevent
#id 4678
#rarity -1
#req_order 5
#req_unluck 1
#req_land 1
#msg "The absolute order of the state has reached a point where even fate itself seems to follow the rules. Random tragedies have been replaced by bureaucratic certainty."
#decscale 4
#gold 200
#taxboost 100
#end

#newevent
#id 4679
#rarity -1
#req_prod 5
#req_unluck 1
#req_land 1
#msg "Your master smiths have constructed a complex orrery that tracks the movements of the spheres. By timing their work to its movements, they have bypassed the provincial bad luck."
#decscale 4
#magicitem 2
#landprod 20
#end

#newevent
#id 4680
#rarity -2
#req_magic 5
#req_luck 3
#req_land 1
#msg "The sheer saturation of magic in this land has thinned the veil to the higher spheres. A being of pure light has descended, pledging to guide your people through the coming wars."
#nation -2
#com 651
#addequip 4
#incdom 2
#end

#newevent
#id 4681
#rarity 2
#req_death 5
#req_unluck 3
#req_land 1
#msg "The weight of death is so absolute that a King of the Old World has risen from his forgotten barrow. He does not recognize your authority and has summoned his ancient court to reclaim the province."
#com 188
#addequip 2
#6d6units 194
#A300 189
#unrest 100
#end

#newevent
#id 4682
#rarity -2
#req_order 5
#req_luck 3
#req_land 1
#msg "In this land of perfect order, a legendary arbiter of the law has arrived. He brings a retinue of iron-willed guards and a mandate to purge all dissent."
#nation -2
#com 241
#6d6units 2359
#decscale2 0
#end

#newevent
#id 4683
#rarity 2
#req_chaos 5
#req_unluck 3
#req_land 1
#msg "Total chaos has allowed a charismatic predator to unite the local thugs into a cohesive army. They have claimed the province in the name of freedom and blood."
#com 147
#addequip 1
#16d6units 139
#6d6units 140
#unrest 200
#end

#newevent
#id 4684
#rarity -2
#req_growth 5
#req_luck 3
#req_forest 1
#msg "Nature has reclaimed the province so thoroughly that the forest itself has birthed a guardian. This towering entity of moss and ancient wood answers only to your call."
#nation -2
#com 931
#10d6units 361
#1d6units 362
#end

#newevent
#id 4685
#rarity -1
#req_prod 5
#req_luck 3
#req_land 1
#msg "The absolute drive for production has attracted a reclusive master of gears. He has offered to oversee your workshops, bringing his tireless mechanical servants with him."
#nation -2
#com 1073
#4d6units 532
#landprod 20
#end

#newevent
#id 4686
#rarity 2
#req_sloth 5
#req_unluck 3
#req_land 1
#msg "The absolute lethargy of the populace has created a psychic vacuum. A horror from the realm of sleep has taken physical form to feed on the waking world."
#com 2212
#kill 20
#unrest 80
#incdom -2
#end

#newevent
#id 4687
#rarity -2
#req_land 0
#req_magic 5
#req_luck 3
#msg "The pressure of the deep ocean and the high magic of the reefs have birthed a monstrosity of coral and rage. It has been bound to your service by the local mermen."
#nation -2
#com 438
#addequip 1
#6d6units 1681
#end

#newevent
#id 4688
#rarity -2
#req_waste 1
#req_heat 5
#req_luck 3
#msg "In the blistering heat of the waste, a prophet of the eternal flame has emerged from the shimmering dunes, leading a host of fire-touched warriors."
#nation -2
#com 389
#10d6units 527
#decscale2 2
#end

#newevent
#id 4689
#rarity -2
#req_mountain 1
#req_cold 5
#req_luck 3
#msg "The absolute zero of the mountain peaks has drawn a master of ice from the far north. He seeks a realm cold enough to practice his ancient craft and has sworn fealty to you."
#nation -2
#com 844
#addequip 9
#2d6units 1202
#end

#newevent
#id 4690
#rarity -2
#req_unmagic 5
#req_luck 3
#req_land 1
#msg "In a land where magic has died completely, a scholar has found a way to "see" using the emptiness itself. He offers his chilling insights into the nature of the void."
#nation -2
#com 106
#researchaff 2
#gainaff 4194304
#end

#newevent
#id 4691
#rarity 2
#req_swamp 1
#req_death 5
#req_unluck 3
#msg "The stagnant rot of the swamp has grown so thick that it has animated the remains of a prehistoric beast. The creature now prowls the wetlands, driven by an unlucky hunger."
#com 1831
#2d6units 1841
#kill 15
#disease 10
#end

#newevent
#id 4692
#rarity -2
#req_order 5
#req_magic 3
#req_land 1
#msg "The population’s fervor for order has reached a fanatical peak. A high-ranking inquisitor has arrived to ensure the province remains a bastion of pure faith."
#nation -2
#com 222
#addequip 1
#2com 149
#incdom 5
#end

#newevent
#id 4693
#rarity 2
#req_magic 5
#req_chaos 3
#req_unluck 3
#req_land 1
#msg "Wild, unlucky magic has caused the local livestock to fuse into screaming, multi-headed abominations that are now attacking the garrison."
#com 466
#4d6units 466
#kill 10
#unrest 60
#end

#newevent
#id 4694
#rarity -1
#req_cave 1
#req_order 5
#req_luck 2
#msg "The deep resonance of the caves has attracted a group of subterranean elders. They speak the language of the rocks and have offered to expand your tunnels."
#nation -2
#com 1460
#2d6units 1465
#landprod 30
#end

#newevent
#id 4695
#rarity -1
#req_waste 1
#req_heat 5
#req_magic 3
#req_unluck 3
#msg "The scorching sun of the waste has bleached the bones of a long-dead hero. Through an unlucky surge of magic, he has risen to lead his phantom army once more."
#com 533
#6d6units 615
#A600 617
#unrest 40
#end

#newevent
#id 4696
#rarity 2
#req_prod 5
#req_unluck 5
#req_land 1
#req_turn 15
#msg "The earth in this highly productive but unlucky province has literally opened up. A massive, burrowing horror has emerged to feast on the workers."
#com 2526
#kill 50
#landprod -50
#fort 0
#end

#newevent
#id 4697
#rarity -1
#req_unmagic 5
#req_order 5
#req_land 1
#msg "In the absolute silence of the unmagic zone, a group of aesthetic monks have found enlightenment. They offer their services as disciplined, magic-resistant warriors."
#nation -2
#com 2324
#12d6units 2324
#gainaff 0
#end

#newevent
#id 4698
#rarity -2
#req_land 0
#req_growth 5
#req_magic 3
#req_lab 1
#msg "The ocean growth has become sentient and protective of your mages. A being of living coral has manifested to defend the underwater laboratories."
#nation -2
#com 394
#A300 394
#defence 30
#end

#newevent
#id 4699
#rarity 2
#req_unluck 5
#req_land 1
#req_turn 20
#msg "Misfortune has reached its zenith. A Doom Horror has slipped through a crack in reality, drawn by the absolute despair of the province."
#com 2213
#kill 60
#gold -5000
#temple 0
#lab 0
#end

#newevent
#id 4700
#rarity -2
#req_waste 1
#req_heat 3
#req_luck 2
#msg "The dunes have begun to glow with a steady, internal light. A nomad, his skin like cracked obsidian and eyes like molten gold, has emerged from the shimmering haze. He claims the sun has spoken to him and offers to lead your armies."
#decscale2 2
#decscale 4
#nation -2
#com 389
#1d6units 527
#gold 200
#end

#newevent
#id 4701
#rarity 2
#req_swamp 1
#req_heat 3
#req_unluck 2
#msg "The ground in this swamp has become too hot to touch. A series of unlucky fissures has opened, releasing a vengeful spirit of flame that now treats the steam-choked marsh as its private hunting ground."
#decscale2 2
#incscale2 4
#com 3716
#2d6units 3716
#kill 15
#unrest 60
#end

#newevent
#id 4702
#rarity -2
#req_cave 1
#req_cold 3
#req_luck 2
#msg "In the absolute stillness of these frozen tunnels, a master smith has found the perfect temperature to forge rime-steel. He has emerged from the deep ice to offer his sharpest blades to your cause."
#incscale2 2
#decscale 4
#nation -2
#com 325
#magicitem 2
#gold 150
#end

#newevent
#id 4703
#rarity 2
#req_land 0
#req_cold 3
#req_unluck 2
#msg "The ocean surface has frozen into a jagged, unlucky labyrinth. From the deepest floes, a fallen prince of the ice-wastes has risen, leading a host of frost-dead to reclaim the warm waters."
#incscale2 2
#incscale2 4
#com 844
#10d6units 1202
#kill 20
#unrest 80
#end

#newevent
#id 4704
#rarity -2
#req_waste 1
#req_heat 3
#req_luck 2
#msg "The heat in the waste has reached a point where reality itself shimmers. A prophet of the eternal pyre has arrived, claiming that your reign is a precursor to a world of pure, cleansing flame."
#decscale2 2
#decscale 4
#nation -2
#com 1536
#incdom 2
#decscale 3
#end

#newevent
#id 4705
#rarity 2
#req_cave 1
#req_heat 3
#req_unluck 2
#msg "The caves have become a suffocating kiln. An unlucky shift in the magma chambers has flooded the tunnels with heat-demons who view the local miners as little more than fuel."
#decscale2 2
#incscale2 4
#com 526
#1d6units 304
#kill 10
#unrest 100
#end

#newevent
#id 4706
#rarity -2
#req_swamp 1
#req_cold 3
#req_luck 2
#msg "The swamp has frozen into a solid block of dark ice. A hermit skilled in the arts of preservation has emerged, bringing with him a retinue of spirits he has saved from the rot."
#incscale2 2
#decscale 4
#nation -2
#com 309
#2d6units 579
#gold 100
#end

#newevent
#id 4707
#rarity 2
#req_waste 1
#req_cold 3
#req_unluck 2
#msg "The cold in the waste is no longer natural. A shimmering, unlucky blizzard has brought with it a predatory entity from the high peaks that hunts by the sound of a beating heart."
#incscale2 2
#incscale2 4
#com 2231
#6d6units 1224
#kill 15
#unrest 40
#end

#newevent
#id 4708
#rarity -2
#req_land 0
#req_heat 3
#req_luck 2
#msg "The deep ocean floor has cracked, but instead of destruction, a benevolent spirit of the earth's core has emerged to guard the thermal vents. It offers its warmth to your mermen."
#decscale2 2
#decscale 4
#nation -2
#com 640
#defence 20
#1d6vis 0
#end

#newevent
#id 4710
#rarity 1
#req_order 3
#req_unluck 2
#req_land 1
#msg "The governor's insistence on perfect order has led to a series of unlucky clerical errors. To compensate, the laws have been made even more rigid, turning the province into a police state."
#decscale 0
#incscale2 4
#unrest 20
#taxboost -50
#end

#newevent
#id 4711
#rarity 2
#req_order 4
#req_unluck 2
#req_waste 1
#msg "In a desperate attempt to impose order on the shifting dunes, the local garrison has executed several 'chaotic' nomads. The blood has seemingly cursed the land, drawing a heavy shroud of misfortune."
#decscale 0
#incscale3 4
#kill 10
#landprod -10
#end

#newevent
#id 4712
#rarity 1
#req_chaos 3
#req_unluck 2
#req_land 1
#msg "The constant turmoil of the province has led to a series of unlucky skirmishes between rival gangs. Order is a memory, and the chaos is beginning to feed on itself."
#incscale 0
#incscale2 4
#unrest 40
#gold -200
#end

#newevent
#id 4713
#rarity 2
#req_chaos 4
#req_unluck 2
#req_swamp 1
#msg "The lawless nature of the swamp has allowed a virulent, unlucky plague to spread unchecked. The dying no longer care for the gods or the state, only for a violent end."
#incscale 0
#incscale3 4
#disease 10
#kill 5
#end

#newevent
#id 4714
#rarity 2
#req_chaos 3
#req_unluck 2
#req_land 0
#msg "Chaos has gripped the kelp harvesters. An unlucky shift in the currents led to a failed harvest, and now the mermen have turned to a violent, random worship of the void."
#incscale 0
#incscale2 4
#unrest 60
#incdom -2
#end

#newevent
#id 4715
#rarity 1
#req_prod 3
#req_unluck 2
#req_land 1
#msg "The frantic push for production has led to a series of unlucky industrial accidents. The response has been to increase the pace, further fracturing the workers' spirits."
#decscale 1
#incscale2 4
#kill 10
#landprod -15
#end

#newevent
#id 4716
#rarity 2
#req_prod 4
#req_unluck 2
#req_waste 1
#msg "In the waste, the constant scouring for resources has stripped the protective crust of the earth. An unlucky wind has turned the province into a choking dust-bowl of industry and misery."
#decscale 1
#incscale3 4
#disease 5
#landgold -10
#end

#newevent
#id 4717
#rarity 2
#req_prod 3
#req_unluck 2
#req_cave 1
#msg "In the deep caves, high quotas have led to sloppy shoring. An unlucky tremor has collapsed the secondary tunnels, and the survivors are forced to work double shifts in the dark."
#decscale 1
#incscale2 4
#kill 20
#gold -300
#end

#newevent
#id 4718
#rarity 1
#req_sloth 3
#req_unluck 2
#req_land 1
#msg "Lethargy has become a physical weight in this valley. An unlucky sequence of minor tragedies has convinced the populace that effort is futile, leading to total economic paralysis."
#incscale 1
#incscale2 4
#landprod -20
#landgold -10
#end

#newevent
#id 4719
#rarity 2
#req_sloth 4
#req_unluck 2
#req_swamp 1
#msg "The swamp has become so still that even the flies have stopped buzzing. An unlucky malaise has settled over the villagers, who now simply watch the water rise in silence."
#incscale 1
#incscale3 4
#unrest 10
#incdom -3
#end

#newevent
#id 4720
#rarity 1
#req_heat 3
#req_unluck 2
#req_land 1
#msg "The heat is unbearable, and an unlucky shortage of water has ignited the populace's anger. The sun-warped survivors are now burning the very granaries they need."
#decscale 2
#incscale2 4
#unrest 50
#kill 5
#end

#newevent
#id 4721
#rarity 2
#req_heat 4
#req_unluck 2
#req_cave 1
#msg "The heat in the caves has reached a point where the rock is weeping. An unlucky shift in the magma chambers has flooded the lower shafts, and the tunnels are filling with toxic air."
#decscale 2
#incscale3 4
#kill 15
#disease 5
#end

#newevent
#id 4722
#rarity 2
#req_heat 3
#req_unluck 2
#req_land 0
#msg "An unlucky convergence of thermal vents has turned this sea into a boiling pot. The kelp is turning to mush, and the mermen are fleeing the unbearable warmth."
#decscale 2
#incscale2 4
#taxboost -100
#kill 5
#end

#newevent
#id 4723
#rarity 1
#req_cold 3
#req_unluck 2
#req_land 1
#msg "The cold has become a hungry predator. Every unlucky attempt to keep the fires burning leads to a localized conflagration, leaving the survivors to freeze in the ash."
#incscale 2
#incscale2 4
#kill 15
#unrest 20
#end

#newevent
#id 4724
#rarity 2
#req_cold 4
#req_unluck 2
#req_waste 1
#msg "In the waste, an unlucky blizzard has lasted for weeks. The dunes are covered in a permanent sheet of ice, and the bones of the travelers are being preserved for a darker age."
#incscale 2
#incscale3 4
#landprod -30
#landgold -15
#end

#newevent
#id 4725
#rarity 2
#req_cold 3
#req_unluck 2
#req_cave 1
#msg "The cold in the caves is so intense that the very air is turning to frost. An unlucky collapse has sealed the main entrance, and the miners are huddling together in a cold, silent death."
#incscale 2
#incscale2 4
#kill 10
#gold -200
#end

#newevent
#id 4726
#rarity 1
#req_growth 3
#req_unluck 2
#req_land 1
#msg "Life is growing with an unlucky, aggressive speed. The crops are huge, but they are hollow shells filled with parasitic wasps that now prey on the farmers."
#decscale 3
#incscale2 4
#disease 15
#kill 5
#end

#newevent
#id 4727
#rarity 2
#req_growth 4
#req_unluck 2
#req_swamp 1
#msg "In the swamp, the vines have grown into a solid wall. An unlucky surge of quick-growth has claimed the paths, and the villagers are being strangled in their sleep by sentient creepers."
#decscale 3
#incscale3 4
#landprod -20
#unrest 30
#end

#newevent
#id 4728
#rarity 2
#req_growth 3
#req_unluck 2
#req_land 0
#msg "The reefs are being overrun by a toxic, unlucky growth of red algae. The sea-life is dying in the oxygen-starved water, and the mermen priests are weeping at the loss."
#decscale 3
#incscale2 4
#kill 10
#incdom -2
#end

#newevent
#id 4729
#rarity 1
#req_death 3
#req_unluck 2
#req_land 1
#msg "A dry wind of death is blowing through the valley. Every unlucky birth is a tragedy, and the elders are withering into dust before they can pass on their names."
#incscale 3
#incscale2 4
#kill 20
#incpop -20
#end

#newevent
#id 4730
#rarity 2
#req_death 4
#req_unluck 2
#req_waste 1
#msg "In the waste, the dead are becoming as common as the sand. An unlucky alignment of the stars has caused the bleached remains of the fallen to rise and wander aimlessly."
#incscale 3
#incscale3 4
#unrest 40
#com 188
#end

#newevent
#id 4731
#rarity 2
#req_death 3
#req_unluck 2
#req_swamp 1
#msg "The mud of the swamp has become a slurry of bone and decay. An unlucky tremor has released a pocket of necrotic gas, and the living are being pulled down into the stagnant dark."
#incscale 3
#incscale2 4
#kill 15
#disease 10
#end

#newevent
#id 4732
#rarity 1
#req_magic 3
#req_unluck 2
#req_land 1
#msg "The magic in the air is shimmering with an unlucky, jagged edge. Researchers are developing bleeding eyes as they try to read their scrolls in the flickering aether."
#decscale 5
#incscale2 4
#researchaff 524288
#unrest 20
#end

#newevent
#id 4733
#rarity 2
#req_magic 4
#req_unluck 2
#req_swamp 1
#msg "A bank of wild magic has rolled into the swamp. An unlucky discharge of power has turned the local lizards into multi-eyed horrors that now hunt the confused populace."
#decscale 5
#incscale3 4
#com 466
#4d6units 466
#kill 10
#end

#newevent
#id 4734
#rarity 2
#req_magic 3
#req_unluck 2
#req_cave 1
#msg "In the deep caves, the high magic of the crystals has begun to echo with an unlucky, dissonant sound. The miners are being driven mad by the 'music' of the earth."
#decscale 5
#incscale2 4
#gainaff 4194304
#unrest 40
#end

#newevent
#id 4735
#rarity 1
#req_unmagic 3
#req_unluck 2
#req_land 1
#msg "A fog of unmagic has settled over the province. Every attempt to call upon the gods ends in an unlucky silence, and the people are losing their faith in a world that feels so hollow."
#incscale 5
#incscale2 4
#incdom -3
#researchaff 4194304
#end

#newevent
#id 4736
#rarity 2
#req_unmagic 4
#req_unluck 2
#req_waste 1
#msg "The desert has become a void of wonder. An unlucky sandstorm has buried the last of the ancient shrines, and the survivors find their memories of magic fading like a mirage."
#incscale 5
#incscale3 4
#landgold -10
#researchaff 0
#end

#newevent
#id 4737
#rarity 2
#req_unmagic 3
#req_unluck 2
#req_land 0
#msg "The ocean currents have grown silent and sparkless. An unlucky shift in the reefs has killed the bioluminescence, leaving the mermen in a state of absolute, spiritual dark."
#incscale 5
#incscale2 4
#unrest 30
#incdom -4
#end

#newevent
#id 4738
#rarity 1
#req_order 3
#req_unluck 2
#req_land 1
#msg "A streak of bad luck in the local economy has been met with a draconian tax decree. The law is now enforced by the whip, and the people are beginning to whisper of rebellion."
#decscale 0
#incscale2 4
#taxboost -80
#unrest 40
#end

#newevent
#id 4739
#rarity 1
#req_chaos 3
#req_unluck 2
#req_land 1
#msg "A series of unlucky accidents has decimated the local militia. In the ensuing chaos, the few remaining soldiers have turned to banditry, leaving the law to rot."
#incscale 0
#incscale2 4
#defence -15
#gold -300
#end

#newevent
#id 4740
#rarity 1
#req_prod 3
#req_unluck 2
#req_land 1
#msg "The drive for production has pushed the workers into an unlucky, fatal exhaustion. The machinery is slick with blood, and the overseers demand more to meet the gods' demands."
#decscale 1
#incscale2 4
#kill 30
#unrest 30
#end

#newevent
#id 4741
#rarity 1
#req_sloth 3
#req_unluck 2
#req_land 1
#msg "The apathy of the province has reached a terminal velocity. An unlucky trend of mass-suicides has struck the local villages, as the people simply lose the will to breathe."
#incscale 1
#incscale2 4
#kill 20
#landprod -30
#end

#newevent
#id 4742
#rarity 1
#req_heat 3
#req_unluck 2
#req_land 1
#msg "A dry, unlucky heatwave is blowing from the waste. Every attempt to irrigate the land ends in a burst pipe or a dried well, and the crops are turning to ash."
#decscale 2
#incscale2 4
#landprod -40
#kill 5
#end

#newevent
#id 4743
#rarity 1
#req_cold 3
#req_unluck 2
#req_fort 1
#req_turn 15
#msg "The cold has reached the heart of the stone. An unlucky series of tremors has caused the local fortress to crack from top to bottom, leaving the garrison exposed."
#incscale 2
#incscale2 4
#fort 0
#defence -10
#end

#newevent
#id 4744
#rarity 1
#req_growth 3
#req_unluck 2
#req_land 1
#msg "Nature is expanding with an unlucky, sickening speed. Fungal spores have filled the air, turning every minor wound into a garden of necrotic mushrooms."
#decscale 3
#incscale2 4
#disease 20
#kill 10
#end

#newevent
#id 4745
#rarity 1
#req_death 3
#req_unluck 2
#req_land 1
#msg "The weight of death is pulling the living into the grave. An unlucky failure of the city sewers has flooded the streets with a slurry of cemetery soil and disease."
#incscale 3
#incscale2 4
#kill 50
#disease 10
#end

#newevent
#id 4746
#rarity 1
#req_magic 3
#req_unluck 2
#req_lab 1
#msg "The saturation of magic has become toxic. Every unlucky word spoken by a mage causes a localized ripple of wild power, shredding the lab and the sanity of those within."
#decscale 5
#incscale2 4
#lab 0
#researchaff 4194304
#end

#newevent
#id 4747
#rarity 1
#req_unmagic 3
#req_unluck 2
#req_land 1
#msg "The absence of magic is now a physical pain. Every unlucky thought is immediately forgotten, and the populace is beginning to regress into a state of primitive, mindless fear."
#incscale 5
#incscale2 4
#researchaff 0
#researchaff 0
#end

#newevent
#id 4748
#rarity 2
#req_cold 3
#req_unluck 2
#req_coast 1
#msg "An unlucky, cold mist has rolled in from the sea. In the confusion, a group of shadowy figures has ransacked the armory and disappeared back into the waves."
#incscale 2
#incscale2 4
#gold -400
#defence -10
#end

#newevent
#id 4750
#rarity -1
#req_order 3
#req_luck 2
#req_land 1
#msg "The stability of the province has attracted an international guild of honest traders. Their fair dealings have bolstered the treasury and further solidified the local laws."
#decscale 0
#decscale 4
#gold 300
#unrest -20
#end

#newevent
#id 4751
#rarity -2
#req_order 4
#req_luck 2
#req_land 1
#msg "In this bastion of law, the local courts have reached a state of perfect impartiality. Corruption has been entirely purged, and the wealthy have made massive donations to the state."
#decscale 0
#decscale 4
#gold 450
#taxboost 50
#end

#newevent
#id 4752
#rarity -2
#req_order 5
#req_luck 2
#req_land 1
#msg "The absolute order of this province has become legendary. A high justicar has arrived to pledge his sword, bringing the wealth of his office and a retinue of loyalists."
#decscale 4
#gold 600
#nation -2
#com 241
#12d6units 2359
#end

#newevent
#id 4753
#rarity -1
#req_order 3
#req_luck 2
#req_cave 1
#msg "In the deep caves, a system of mirrors and couriers has made the enforcement of law instant and just. This stability has led to a surge in precious metal extraction."
#decscale 0
#decscale 4
#gold 400
#landgold 10
#end

#newevent
#id 4754
#rarity -1
#req_order 3
#req_luck 2
#req_swamp 1
#msg "Through luck and order, the disparate tribes of the swamp have signed a lasting treaty. The previously dangerous wetlands are now a safe and profitable trade route."
#decscale 0
#decscale 4
#gold 300
#taxboost 20
#end

#newevent
#id 4755
#rarity -1
#req_prod 3
#req_luck 2
#req_land 1
#msg "A streak of good luck has led to a breakthrough in fuel efficiency. The provincial workshops are producing far more than anticipated, filling the stores with gear."
#decscale 1
#decscale 4
#gold 200
#landprod 10
#end

#newevent
#id 4756
#rarity -2
#req_prod 4
#req_luck 2
#req_land 1
#msg "The workshops of the province are working in perfect harmony. Production has outpaced all expectations, and the excess goods have been sold for a tidy profit."
#decscale 1
#decscale 4
#gold 300
#landprod 20
#end

#newevent
#id 4757
#rarity -2
#req_prod 5
#req_luck 2
#req_land 1
#msg "The pinnacle of industry has been reached. A master artificer has gifted the province a self-maintaining machine that oversees the workshops, freeing the men for war."
#decscale 4
#gold 400
#landprod 40
#magicitem 2
#end

#newevent
#id 4758
#rarity -1
#req_prod 3
#req_luck 2
#req_cave 1
#msg "In the deep caves, the miners have found a way to use the natural resonance of the rock to shatter ore veins. The yield has been uncommonly rich."
#decscale 1
#decscale 4
#gold 350
#landprod 15
#end

#newevent
#id 4759
#rarity -1
#req_prod 3
#req_luck 2
#req_land 0
#msg "Favorable currents and lucky timing have allowed your mermen to recover a massive haul of raw materials from a fleet that vanished decades ago."
#decscale 1
#decscale 4
#gold 500
#landprod 10
#end

#newevent
#id 4760
#rarity -1
#req_growth 3
#req_luck 2
#req_land 1
#msg "The air is sweet and the water is pure. The people are thriving with such vigor that every village has grown into a bustling town overnight."
#decscale 3
#decscale 4
#incpop 100
#taxboost 50
#end

#newevent
#id 4761
#rarity -2
#req_growth 4
#req_luck 2
#req_land 1
#msg "A natural spring has begun to flow with uncommonly pure water. Sickness is a memory, and the population has swelled with healthy, optimistic youths."
#decscale 3
#decscale 4
#incpop 200
#disease -10
#end

#newevent
#id 4762
#rarity -2
#req_growth 5
#req_luck 2
#req_land 1
#msg "The fertility of the land has reached a divine level. Nature gems sprout from the soil like weeds, and a spirit of the wild has emerged to guard the flourishing orchards."
#decscale 4
#3d6vis 6
#nation -2
#com 237
#incdom 2
#end

#newevent
#id 4763
#rarity -1
#req_growth 3
#req_luck 2
#req_swamp 1
#msg "The swamp has bloomed with a rare, medicinal moss. The increased trade in healing herbs has brought a wave of prosperity to the previously stagnant wetlands."
#decscale 3
#decscale 4
#gold 300
#incpop 50
#end

#newevent
#id 4764
#rarity -1
#req_growth 3
#req_luck 2
#req_waste 1
#msg "Against all odds, a massive underground aquifer has burst forth in the waste, turning the shimmering dunes into a lush garden of life."
#decscale 3
#decscale 4
#gold 400
#decscale 3
#end

#newevent
#id 4765
#rarity -1
#req_magic 3
#req_luck 2
#req_land 1
#msg "The local mages have discovered a lucky alignment of the aether. Spells feel easier to weave, and the air is thick with the scent of ozone and potential."
#decscale 5
#decscale 4
#2d6vis Elemental
#researchaff 1
#end

#newevent
#id 4766
#rarity -2
#req_magic 4
#req_luck 2
#req_lab 1
#msg "A magical breakthrough has allowed your mages to tune the local environment to the higher spheres. Research is progressing at a staggering pace."
#decscale 5
#decscale 4
#3d6vis Elemental
#researchaff 3
#end

#newevent
#id 4767
#rarity -2
#req_magic 5
#req_luck 2
#req_land 1
#msg "The saturation of magic has thinned the veil to the heavens. A being of pure light has descended to offer its wisdom to your researchers."
#decscale 4
#4d6vis 53
#nation -2
#com 651
#researchaff 5
#end

#newevent
#id 4768
#rarity -1
#req_magic 3
#req_luck 2
#req_cave 1
#msg "The crystals in the cave walls have begun to hum in time with the mages' prayers. The resonance has crystallized the ambient magic into pure astral pearls."
#decscale 5
#decscale 4
#2d6vis 4
#end

#newevent
#id 4769
#rarity -1
#req_magic 3
#req_luck 2
#req_land 0
#msg "The deep reefs are glowing with an intelligent, magical light. Mermen scholars are gaining profound insights simply by observing the pulsing of the coral."
#decscale 5
#decscale 4
#1d6vis 2
#researchaff 2
#end

#newevent
#id 4770
#rarity -1
#req_heat 3
#req_luck 2
#req_land 1
#msg "The sun lingers over the fields, but instead of a scorching heat, it brings a perfect, focused warmth that has doubled the sugar content of the harvest."
#decscale 2
#decscale 4
#gold 200
#landprod 10
#end

#newevent
#id 4771
#rarity -2
#req_heat 4
#req_luck 2
#req_waste 1
#msg "The extreme heat of the waste has been harnessed by lucky inventors to refine ore with incredible purity. The resulting steel is of legendary quality."
#decscale 2
#decscale 4
#gold 400
#magicitem 2
#end

#newevent
#id 4772
#rarity -2
#req_heat 5
#req_luck 2
#req_land 1
#msg "A Firelord has been impressed by the blinding radiance of your province. He has sent his personal guard to ensure the flame never dies."
#decscale 4
#nation -2
#com 818
#10d6units 528
#end

#newevent
#id 4773
#rarity -1
#req_heat 3
#req_luck 2
#req_land 0
#msg "The vents on the ocean floor are pulsing with a steady, lucky heat. The mermen have used this warmth to establish a series of highly productive deep-sea forges."
#decscale 2
#decscale 4
#gold 300
#landprod 15
#end

#newevent
#id 4774
#rarity -1
#req_heat 3
#req_luck 2
#req_swamp 1
#msg "In the humid swamp, the high heat and luck have allowed for the construction of primitive but effective steam-pumps, draining the muck to reveal rich soil."
#decscale 2
#decscale 4
#landprod 20
#decscale 3
#end

#newevent
#id 4775
#rarity -1
#req_cold 3
#req_luck 2
#req_land 1
#msg "The steady, crisp cold has perfectly preserved the year's surplus. There is enough grain in the warehouses to feed the entire nation through ten winters."
#incscale 2
#decscale 4
#gold 200
#taxboost 100
#end

#newevent
#id 4776
#rarity -2
#req_cold 4
#req_luck 2
#req_mountain 1
#msg "The cold has reached a point where the very water in the rocks has crystallized, pushing rare gems to the surface of the mountain."
#incscale 2
#decscale 4
#2d6vis 2
#2d6vis 3
#end

#newevent
#id 4777
#rarity -2
#req_cold 5
#req_luck 2
#req_land 1
#msg "An Ice Prince from the high peaks has recognized the frozen majesty of your realm. He has pledged his eternal frost to your standard."
#decscale 4
#nation -2
#com 844
#10d6units 1202
#end

#newevent
#id 4778
#rarity -1
#req_cold 3
#req_luck 2
#req_cave 1
#msg "In the deep caves, the cold has made the stone brittle enough to be shaped with incredible precision. A series of beautiful, icy fortifications has been erected."
#incscale 2
#decscale 4
#fort 1
#defence 10
#end

#newevent
#id 4779
#rarity -1
#req_cold 3
#req_luck 2
#req_land 0
#msg "Cold, nutrient-rich waters from the north have brought a massive migration of silver-finned fish to the reefs, sparking a boom in the oceanic economy."
#incscale 2
#decscale 4
#gold 400
#landgold 15
#end

#newevent
#id 4780
#rarity -1
#req_order 3
#req_luck 2
#req_land 1
#msg "A famously honest official has audited the province. He found that the previous administration was under-reporting yields. A large sum of gold was returned to the treasury."
#decscale 0
#decscale 4
#gold 300
#end

#newevent
#id 4781
#rarity -2
#req_order 5
#req_luck 2
#req_land 1
#msg "The perfect order of the state has allowed for a complete census. Every citizen is now accounted for, and the resulting efficiency has permanently boosted tax revenues."
#decscale 4
#landgold 20
#taxboost 100
#end

#newevent
#id 4782
#rarity -1
#req_growth 3
#req_luck 2
#req_land 1
#msg "Lucky herbalists in a flourishing province have discovered a cure for the local palsy. The workforce is now haler and more productive."
#decscale 3
#decscale 4
#disease -5
#landprod 10
#end

#newevent
#id 4783
#rarity -2
#req_prod 4
#req_luck 2
#req_land 1
#msg "Organized labor and a lucky rain-cycle have allowed for a massive irrigation project. The fields now produce two harvests for every one elsewhere."
#decscale 1
#decscale 4
#landprod 30
#taxboost 50
#end

#newevent
#id 4784
#rarity -1
#req_magic 3
#req_luck 2
#req_lab 1
#msg "A lucky archive discovery in a high-magic lab has yielded a list of previous gem-deposits that were thought exhausted."
#decscale 5
#decscale 4
#2d6vis 53
#end

#newevent
#id 4785
#rarity -2
#req_heat 4
#req_luck 2
#req_waste 1
#msg "The heat and chaos of the waste have been tamed by a lucky smith into a forge that uses the sand-storms to polish magical gear."
#decscale 4
#magicitem 3
#1d6vis 0
#end

#newevent
#id 4786
#rarity -1
#req_magic 3
#req_luck 2
#req_cave 1
#msg "The harmonics of the deep earth have intensified. The miners no longer need lanterns, as the rock itself glows with a lucky, comforting light."
#decscale 5
#decscale 4
#unrest -20
#gold 100
#end

#newevent
#id 4787
#rarity -1
#req_growth 3
#req_luck 2
#req_swamp 1
#msg "The rot of the swamp has undergone a lucky transformation, becoming the most potent fertilizer known to man. Farmers are paying handsomely for the privilege of harvesting it."
#decscale 3
#decscale 4
#gold 300
#landgold 10
#end

#newevent
#id 4788
#rarity -1
#req_prod 3
#req_luck 2
#req_land 0
#msg "A lucky dive in the deep currents has revealed the hold of a ship filled with gold that was destined for an empire that no longer exists."
#decscale 4
#gold 1000
#end

#newevent
#id 4800
#rarity 2
#req_order 1
#req_unluck 5
#req_land 1
#req_turn 20
#msg "In this orderly land, a minor disagreement over dogma has spiraled into a nightmare. Under a shroud of absolute misfortune, the local courts have ordered the execution of nearly every citizen to ensure 'purity.'"
#kill 80
#gold -3000
#unrest 300
#decscale2 0
#temple 0
#end

#newevent
#id 4801
#rarity 2
#req_chaos 1
#req_unluck 5
#req_land 1
#msg "The minor social unrest in the province has acted as a beacon for the infernal. A permanent tear in reality has opened in the town square, allowing a Doom Horror to step through and claim the 'lawless' souls."
#kill 50
#unrest 200
#com 2213
#incscale2 0
#lab 0
#end

#newevent
#id 4802
#rarity 2
#req_prod 1
#req_unluck 5
#req_land 1
#req_turn 20
#msg "A single spark in a small workshop has led to a chain reaction of impossible, unlucky explosions. The entire provincial infrastructure has been leveled by a fire that seems to burn with a spiteful intelligence."
#kill 40
#gold -5000
#landprod -50
#fort 0
#lab 0
#end

#newevent
#id 4803
#rarity 2
#req_sloth 1
#req_unluck 5
#req_land 1
#msg "The slight lethargy of the populace has curdled into a terminal condition. People have simply stopped waking up, their souls seemingly evaporated by an absolute, unlucky malaise that has settled over the valley."
#kill 75
#landgold -50
#incscale3 1
#incdom -5
#end

#newevent
#id 4804
#rarity 2
#req_heat 1
#req_unluck 5
#req_waste 1
#req_turn 15
#msg "The mild summer heat has been focused by an unlucky atmospheric anomaly. The province is being scoured by a beam of pure solar energy that turns stone to glass and flesh to ash."
#kill 90
#landprod -100
#decscale2 2
#fort 0
#temple 0
#end

#newevent
#id 4805
#rarity 2
#req_cold 1
#req_unluck 5
#req_land 1
#req_turn 20
#msg "The winter chill has deepened into a vacuum of heat. In a streak of impossible misfortune, the very air has frozen solid, shattering the lungs of the inhabitants and causing buildings to disintegrate like glass."
#kill 85
#gold -4000
#incscale2 2
#lab 0
#fort 0
#end

#newevent
#id 4806
#rarity 2
#req_growth 1
#req_unluck 5
#req_forest 1
#msg "The natural growth of the land has turned predatory. Under the weight of absolute misfortune, the trees have begun to sprout teeth and the vines have developed a taste for human blood. The province is being eaten."
#kill 60
#unrest 150
#decscale2 3
#com 931
#4d6units 362
#end

#newevent
#id 4807
#rarity 2
#req_death 1
#req_unluck 5
#req_swamp 1
#msg "The local graveyard has become a literal sinkhole for reality. In a terrifying display of bad luck, the ground has opened up, and the living are being pulled down into a silent, necrotic void."
#kill 95
#temple 0
#incscale3 3
#com 181
#end

#newevent
#id 4808
#rarity 2
#req_magic 1
#req_unluck 5
#req_land 1
#msg "The small amount of magic in the air has become a poison. Every spoken word causes the physical laws of the province to fray, leading to a localized collapse of space and time."
#kill 50
#lab 0
#gainaff 4194304
#decscale2 5
#com 308
#end

#newevent
#id 4809
#rarity 2
#req_unmagic 1
#req_unluck 5
#req_land 1
#req_turn 20
#msg "In this land where magic is scarce, a vacuum of 'nothingness' has formed. It is not merely the absence of wonder, but an active, unlucky force that is erasing the memories and bodies of the populace."
#kill 70
#researchaff 0
#incscale2 5
#gold -2000
#end

#newevent
#id 4810
#rarity 2
#req_order 2
#req_unluck 5
#req_land 0
#msg "A minor shift in the underwater statutes has led to a catastrophic series of unlucky executions. The mermen have turned on one another, and the reefs are choked with the dead."
#kill 60
#taxboost -200
#unrest 200
#decscale2 0
#end

#newevent
#id 4811
#rarity 2
#req_chaos 2
#req_unluck 5
#req_land 0
#req_turn 15
#msg "The slight turmoil of the deep currents has attracted a horror from the void. In a streak of absolute misfortune, the mermen have gone mad, destroying their own palaces in a frenzy of random violence."
#kill 50
#fort 0
#com 2213
#incscale2 0
#incdom -8
#end

#newevent
#id 4812
#rarity 2
#req_prod 2
#req_unluck 5
#req_land 0
#req_turn 20
#msg "A series of unlucky tremors has caused the ocean floor to buckle. The pressure has increased to impossible levels, crushing every structure and squeezing the life from the inhabitants."
#kill 90
#gold -5000
#landprod -50
#lab 0
#end

#newevent
#id 4813
#rarity 2
#req_sloth 2
#req_unluck 5
#req_land 0
#msg "The stillness of the deep waters has become a trap. An unlucky convergence of rot has turned the sea into a lightless, airless tomb where the living simply wither away."
#kill 70
#incscale3 1
#disease 20
#temple 0
#end

#newevent
#id 4814
#rarity 2
#req_heat 2
#req_unluck 5
#req_land 0
#req_turn 20
#msg "The mild warmth of the thermal vents has erupted into an unlucky volcanic surge. The water is literally boiling, and the province has become a graveyard of cooked coral and mermen."
#kill 80
#decscale2 2
#gold -3000
#taxboost -100
#end

#newevent
#id 4815
#rarity 2
#req_cold 2
#req_unluck 5
#req_land 0
#req_turn 15
#msg "The cold currents have shifted with impossible misfortune. The entire sea province has frozen into a single, solid block of ice, entombing the population for eternity."
#kill 95
#incscale2 2
#fort 0
#temple 0
#end

#newevent
#id 4816
#rarity 2
#req_growth 2
#req_unluck 5
#req_land 0
#msg "A minor surge of growth in the kelp forests has produced a lethal, unlucky neurotoxin. The sea-life is dying in a beautiful, glowing carpet of poison."
#kill 60
#disease 30
#decscale2 3
#incdom -4
#end

#newevent
#id 4817
#rarity 2
#req_death 2
#req_unluck 5
#req_land 0
#msg "The presence of death in the deeps has reached a critical mass. An unlucky alignment has turned the ocean currents into a swirling vortex of ghosts that feed on the life-force of the living."
#kill 75
#incscale3 3
#com 181
#4d6units 676
#end

#newevent
#id 4818
#rarity 2
#req_magic 2
#req_unluck 5
#req_land 0
#msg "The mild magic of the reefs has become a mutating force. In a streak of terrible luck, the mermen have been transformed into formless abominations that dissolve in their own laboratories."
#kill 50
#lab 0
#com 966
#4d6units 966
#decscale2 5
#end

#newevent
#id 4819
#rarity 2
#req_unmagic 2
#req_unluck 5
#req_land 0
#msg "The vacuum of magic has reached a point where the bioluminescence of the deep has died. In the absolute, unlucky dark, the mermen have lost the will to survive, their civilization simply vanishing."
#kill 80
#incscale2 5
#researchaff 0
#incdom -6
#end

#newevent
#id 4820
#rarity 2
#req_order 1
#req_unluck 5
#req_cave 1
#req_turn 20
#msg "In the orderly tunnels of the deep caves, a minor shoring error has triggered a catastrophic, unlucky sequence of collapses. The mountain is literally grinding the province into dust."
#kill 90
#gold -10000
#fort 0
#landprod -50
#end

#newevent
#id 4821
#rarity 2
#req_chaos 1
#req_unluck 5
#req_cave 1
#msg "The chaos of the miners has disturbed something that should have remained hidden. Under a shroud of misfortune, an ancient, burrowing horror has emerged to turn the tunnels into a slaughterhouse."
#kill 60
#com 2526
#10d6units 2524
#incscale2 0
#lab 0
#end

#newevent
#id 4822
#rarity 2
#req_prod 1
#req_unluck 5
#req_cave 1
#req_turn 20
#msg "A small resource shaft has tapped into a vein of liquid fire. In a streak of absolute misfortune, the magma has flooded the entire cave system, leaving nothing but scorched bone."
#kill 85
#gold -5000
#decscale2 2
#fort 0
#temple 0
#end

#newevent
#id 4823
#rarity 2
#req_sloth 1
#req_unluck 5
#req_cave 1
#msg "The apathy of the miners has led to the failure of the air-shafts. In a lightless, unlucky silence, the population has slowly suffocated in their sleep."
#kill 80
#incscale3 1
#unrest 100
#incdom -5
#end

#newevent
#id 4824
#rarity 2
#req_heat 1
#req_unluck 5
#req_cave 1
#req_turn 20
#msg "The heat of the deep forge-fires has combined with a streak of bad luck to create a lethal dust. The lungs of the miners are turning to glass, and the province is a gallery of coughing statues."
#kill 70
#disease 20
#decscale2 2
#gold -2000
#end

#newevent
#id 4825
#rarity 2
#req_cold 1
#req_unluck 5
#req_cave 1
#req_turn 15
#msg "The mountain chill has reached the heart of the rock. In a sequence of impossible misfortune, the stone itself is shattering from the cold, burying the inhabitants in a rain of razor-sharp shards."
#kill 80
#incscale2 2
#fort 0
#lab 0
#end

#newevent
#id 4826
#rarity 2
#req_growth 1
#req_unluck 5
#req_cave 1
#msg "The mild dampness of the caves has allowed for an unlucky, aggressive fungal bloom. The mushrooms are growing inside the bodies of the living, turning the province into a garden of screaming mulch."
#kill 60
#disease 40
#decscale2 3
#unrest 100
#end

#newevent
#id 4827
#rarity 2
#req_death 1
#req_unluck 5
#req_cave 1
#msg "The proximity of the graves has reached a tipping point. Under the weight of absolute misfortune, the dead have risen not to fight, but to pull the living down into the very rock of the mountain."
#kill 90
#incscale3 3
#com 181
#temple 0
#end

#newevent
#id 4828
#rarity 2
#req_magic 1
#req_unluck 5
#req_cave 1
#msg "The magic of the cavern crystals has exploded. Every unlucky thought in the province has been manifested as a shard of jagged energy, shredding the laboratory and the minds of the scholars."
#kill 50
#lab 0
#researchaff 1073741824
#decscale2 5
#end

#newevent
#id 4830
#rarity -2
#req_order 1
#req_luck 4
#req_land 1
#msg "A legendary merchant prince has been so impressed by the stability of your realm that he has relocated his entire trade network here. The gold flows like water."
#gold 1500
#landgold 40
#taxboost 100
#end

#newevent
#id 4831
#rarity -2
#req_magic 1
#req_luck 5
#req_lab 1
#msg "A miraculous alignment of the spheres has opened a permanent conduit of pure magic. The air hums with a power that your mages can draw upon indefinitely."
#foundsite 3
#3d6vis 53
#researchaff 5
#end

#newevent
#id 4832
#rarity -2
#req_death 1
#req_luck 4
#req_land 1
#msg "An ancient hero, preserved through sheer fortune in a hidden barrow, has awoken. Recognizing your divine right, he has pledged his spectral blade to your cause."
#nation -2
#com 188
#addequip 4
#1d6units 195
#end

#newevent
#id 4833
#rarity -2
#req_growth 1
#req_luck 5
#req_forest 1
#msg "The fertility of this land has reached a mythic peak. A single sapling of a world-tree has sprouted, bringing health and longevity to all who dwell in its shadow."
#incpop 500
#decscale2 3
#landgold 20
#incdom 2
#end

#newevent
#id 4834
#rarity -2
#req_prod 1
#req_luck 4
#req_land 1
#msg "A stroke of incredible luck has led local craftsmen to rediscover the secrets of ancient automation. Your workshops now produce goods at an impossible rate."
#landprod 50
#gold 800
#magicitem 2
#end

#newevent
#id 4835
#rarity -2
#req_heat 1
#req_luck 5
#req_waste 1
#msg "The mild summer heat has concentrated into a single, lucky point of light. Within this focused glare, fire rubies are forming spontaneously in the sand."
#foundsite 2
#4d6vis 0
#gold 500
#end

#newevent
#id 4836
#rarity -2
#req_cold 1
#req_luck 4
#req_mountain 1
#msg "A noble of the high frost has emerged from the mountain mists. He brings a ransom in jewels and his own keen scouts to serve the master of such a lucky realm."
#gold 1200
#2d6vis 2
#nation -2
#1d6units 141
#end

#newevent
#id 4837
#rarity -2
#req_order 1
#req_luck 4
#req_cave 1
#msg "The wind in the caves has hit a perfect frequency, vibrating ore veins until they shatter. Mining has never been easier or more profitable."
#landgold 30
#landprod 30
#gold 500
#end

#newevent
#id 4838
#rarity -2
#req_magic 1
#req_luck 5
#req_land 0
#msg "The sea-life in this province has begun to glow with an intelligent, magical light. The reefs are producing pearls of a quality unseen since the First Age."
#foundsite 2
#4d6vis 4
#gold 1000
#end

#newevent
#id 4839
#rarity -2
#req_sloth 1
#req_luck 4
#req_swamp 1
#msg "The stagnant waters of the swamp have parted to reveal the moss-covered vault of a lost civilization. Inside lay artifacts of immense power."
#magicitem 4
#magicitem 3
#gold 1000
#end

#newevent
#id 4840
#rarity -2
#req_chaos 1
#req_luck 5
#req_land 1
#msg "A fearsome mercenary leader, previously bent on chaos, has been struck by a vision of your greatness. He has disbanded his raiders and joined you as a loyal champion."
#nation -2
#com 147
#addequip 3
#12d6units 139
#end

#newevent
#id 4841
#rarity -2
#req_magic 1
#req_luck 4
#req_lab 1
#msg "A researcher's clumsy mistake in the lab has accidentally resulted in the formula for transmuting lead into gold. The breakthrough is permanent."
#landgold 50
#gold 500
#researchaff 2
#end

#newevent
#id 4842
#rarity -2
#req_prod 1
#req_luck 4
#req_freshwater 1
#msg "A lucky shift in the river's flow has uncovered a massive deposit of silt-covered gold and ancient jewelry. The haul is staggering."
#gold 2000
#landgold 15
#end

#newevent
#id 4843
#rarity -2
#req_growth 1
#req_luck 4
#req_land 1
#msg "A freak weather pattern has brought a shimmering rain that cures all sickness. The population is haler and more numerous than ever before."
#disease -50
#incpop 300
#incdom 3
#end

#newevent
#id 4844
#rarity -2
#req_magic 1
#req_luck 5
#req_land 1
#msg "A meteorite of pure starmetal has landed softly in a local field. It is cool to the touch and hums with magical potential."
#2d6vis 3
#2d6vis 4
#magicitem 4
#end

#newevent
#id 4845
#rarity -2
#req_order 1
#req_luck 4
#req_land 1
#msg "Distraught by the chaos of neighboring lands, a large group of wealthy artisans has sought sanctuary in your lucky province."
#incpop 200
#gold 600
#landprod 15
#end

#newevent
#id 4846
#rarity -2
#req_magic 1
#req_luck 5
#req_land 0
#msg "An underwater earthquake has revealed the entrance to a library of the Ancients. Mermen scholars are gaining centuries of wisdom in a single month."
#researchaff 10
#magicitem 3
#1d6vis 4
#end

#newevent
#id 4847
#rarity -2
#req_sloth 1
#req_luck 4
#req_waste 1
#msg "The wind in the waste has begun to whisper the locations of forgotten wells and hidden paths. Navigating the desert is now a trivial matter."
#landgold 20
#defence 15
#gold 300
#end

#newevent
#id 4848
#rarity -2
#req_magic 1
#req_luck 4
#req_cave 1
#msg "The magic in the caves has reached a state of perfect resonance. The rock itself is growing gems as if they were flowers in a garden."
#4d6vis 3
#4d6vis 4
#gold 400
#end

#newevent
#id 4849
#rarity -2
#req_order 1
#req_luck 5
#req_land 1
#msg "A holy figure has appeared in the province, performing miracles and drawing thousands into the true faith."
#incdom 8
#unrest -100
#nation -2
#com 241
#end

#newevent
#id 4850
#rarity -2
#req_prod 1
#req_luck 5
#req_mountain 1
#msg "A lucky miner has struck a vein of gold so thick it defies explanation. The mine will provide for the empire for generations."
#addsite 70
#landgold 100
#gold 1000
#end

#newevent
#id 4851
#rarity -2
#req_heat 1
#req_luck 5
#req_waste 1
#msg "An explorer has returned from the waste with a perfectly preserved dragon egg. It has hatched into a loyal, fire-breathing guardian."
#nation -2
#com 2534
#addequip 1
#1d6vis 0
#end

#newevent
#id 4852
#rarity -2
#req_growth 1
#req_luck 5
#req_land 1
#msg "A traveler has discovered a hidden glade where the water reverses the toll of years. The elders of the province have returned to their prime."
#foundsite 3
#worldage -1
#incpop 100
#end

#newevent
#id 4853
#rarity -2
#req_death 1
#req_luck 5
#req_land 1
#msg "A necromancer has safely opened the vault of a long-dead king. The ghosts within have accepted your rule and surrendered their hoard."
#gold 3000
#magicitem 4
#4d6vis 5
#end

#newevent
#id 4854
#rarity -2
#req_prod 1
#req_luck 4
#req_land 1
#msg "A master engineer has been so inspired by the province's industry that he has built a self-defending fortification as a gift."
#fort 3
#defence 20
#gold 400
#end

#newevent
#id 4855
#rarity -2
#req_magic 1
#req_luck 4
#req_land 0
#msg "A surge of magical water from the elemental planes has filled the reefs with vitality. Magical gems are literally washing up on the shore."
#5d6vis 2
#1d6vis 4
#gold 200
#end

#newevent
#id 4856
#rarity -2
#req_order 1
#req_luck 4
#req_land 1
#msg "Corruption has been so thoroughly rooted out that the local courts are now known for a level of justice that borders on the divine."
#taxboost 200
#gold 800
#unrest -50
#end

#newevent
#id 4857
#rarity -2
#req_growth 1
#req_luck 4
#req_waste 1
#msg "Against all logic, the local oasis has begun to grow, transforming the surrounding waste into a paradise of palm trees and cool water."
#landgold 25
#decscale 3
#incpop 150
#end

#newevent
#id 4858
#rarity -2
#req_magic 1
#req_luck 4
#req_farm 1
#msg "While plowing the fields, farmers have found that the soil has begun to yield small, perfect diamonds alongside the grain."
#3d6vis 3
#gold 500
#landgold 5
#end

#newevent
#id 4860
#rarity -1
#req_chaos 1
#req_luck 4
#req_land 1
#msg "In this land of minimal oversight, a group of scholars has gathered to debate without fear of censorship. Their discourse has yielded unexpected breakthroughs in the arcane arts."
#research 150
#decscale 4
#decscale 5
#end

#newevent
#id 4861
#rarity -1
#req_chaos 2
#req_luck 4
#req_land 1
#msg "A group of independent pioneers has returned from the borderlands with a heavy chest of gold. They have donated a portion to the treasury in exchange for continued autonomy."
#gold 400
#decscale 4
#landprod 5
#end

#newevent
#id 4862
#rarity -2
#req_chaos 4
#req_luck 2
#req_land 1
#msg "In the absolute chaos of the province, a group of looters accidentally broke into an ancient, forgotten vault instead of the local bakery. They have pledged the findings to you in exchange for a pardon."
#gold 600
#magicitem 3
#1d6vis Elemental
#end

#newevent
#id 4863
#rarity -2
#req_chaos 5
#req_luck 5
#req_land 1
#msg "Utter lawlessness has birthed a month-long festival of such intensity that it has drawn travelers from across the world. The sheer joy of the populace has manifested as a surge of pure magic."
#incpop 500
#4d6vis 53
#gold 1000
#unrest -100
#end

#newevent
#id 4864
#rarity -1
#req_chaos 2
#req_luck 5
#req_land 1
#msg "A legendary warrior, tired of the stifling laws of other empires, has sought refuge in your chaotic lands. He offers his blade to whichever master lets him fight as he pleases."
#nation -2
#com 2324
#addequip 3
#1d6units 139
#end

#newevent
#id 4865
#rarity -1
#req_chaos 1
#req_luck 4
#req_cave 1
#msg "The lack of centralized control in the deep caves has allowed individual mining families to pursue their own veins. One family has struck a rich deposit of silver."
#gold 300
#landgold 15
#decscale 4
#end

#newevent
#id 4866
#rarity -1
#req_chaos 2
#req_luck 4
#req_land 0
#msg "Drifting aimlessly in the chaotic currents of the deep, a cache of pearls has washed into a merman settlement. The locals have offered them as tribute to their 'distant' god."
#2d6vis 4
#gold 200
#decscale 4
#end

#newevent
#id 4867
#rarity -2
#req_chaos 4
#req_luck 4
#req_swamp 1
#msg "A powerful witch living in the lawless wetlands has been impressed by the total lack of order in your realm. She has gifted you one of her pets as a sign of respect."
#nation -2
#com 403
#4d6units 403
#magicitem 2
#end

#newevent
#id 4868
#rarity -1
#req_chaos 2
#req_luck 4
#req_waste 1
#msg "A group of desert nomads, thriving in the anarchy of the dunes, has decided to join your cause. They bring knowledge of the shimmering sands and a collection of stolen relics."
#nation -2
#com 1565
#1d6units 527
#magicitem 1
#end

#newevent
#id 4869
#rarity -2
#req_chaos 5
#req_luck 3
#req_waste 1
#msg "The total anarchy of the waste has allowed a fire-spirit to claim a throne of cinders. Finding your lack of laws appealing, the entity has pledged its burning host to your service."
#nation -2
#com 818
#addequip 1
#10d6units 528
#end

#newevent
#id 4870
#rarity 1
#req_chaos 1
#req_unluck 4
#req_land 1
#msg "The slight lack of order has allowed a charismatic rabble-rouser to gain a following. He is currently convincing the populace that your rule is a curse upon their luck."
#unrest 50
#incscale2 0
#incdom -2
#end

#newevent
#id 4871
#rarity 2
#req_chaos 2
#req_unluck 4
#req_land 1
#msg "In a streak of terrible misfortune, the local militia has mutinied against their officers. The soldiers have turned to banditry, using your own steel against the people."
#defence -20
#unrest 100
#com 482
#12d6units 482
#end

#newevent
#id 4872
#rarity 2
#req_chaos 4
#req_unluck 2
#req_land 1
#msg "Absolute lawlessness has turned the provincial capital into a cesspool. An unlucky outbreak of filth-fever is decimating the population, and there are no officials left to stop it."
#kill 30
#disease 20
#incscale2 3
#unrest 60
#end

#newevent
#id 4873
#rarity 2
#req_chaos 5
#req_unluck 5
#req_land 1
#req_turn 20
#msg "Total anarchy and absolute misfortune have culminated in the total collapse of provincial life. A Doom Horror has been drawn to the scent of such pure, unadulterated chaos."
#kill 80
#com 2213
#fort 0
#temple 0
#lab 0
#gold -5000
#end

#newevent
#id 4874
#rarity 1
#req_chaos 1
#req_unluck 4
#req_land 0
#msg "The minor turmoil of the currents has emboldened a group of renegade mermen. They have seized the local armory and are now raiding the pearl-farms."
#gold -300
#unrest 40
#2com 976
#6d6units 974
#end

#newevent
#id 4875
#rarity 2
#req_chaos 4
#req_unluck 4
#req_land 0
#msg "In the lawless depths of the sea, an unlucky series of blasphemous rituals has thinned the veil. A horror has emerged to feed on the minds of the mermen."
#kill 40
#incdom -5
#com 308
#4d6units 88
#end

#newevent
#id 4876
#rarity 1
#req_chaos 2
#req_unluck 4
#req_cave 1
#msg "The miners, emboldened by a lack of oversight, have ignored safety protocols in favor of looting private veins. An unlucky tremor has turned the tunnels into a tomb."
#kill 25
#gold -600
#landprod -20
#end

#newevent
#id 4877
#rarity 2
#req_chaos 5
#req_unluck 4
#req_cave 1
#msg "In the absolute anarchy of the deep tunnels, the darkness has gained a hungry intelligence. Shadows are rising to claim the living in a streak of impossible bad luck."
#kill 50
#unrest 150
#com 181
#12d6units 676
#end

#newevent
#id 4878
#rarity 1
#req_chaos 2
#req_unluck 4
#req_waste 1
#msg "Nomads in the waste, enraged by a series of unlucky shortages, have risen in a violent revolt. They have salted the few working wells and disappeared back into the dunes."
#kill 10
#unrest 80
#landprod -10
#incscale 3
#end

#newevent
#id 4879
#rarity 2
#req_chaos 4
#req_unluck 5
#req_waste 1
#req_turn 15
#msg "Total lawlessness in the waste has allowed a localized heat-vortex to spiral out of control. The sand has melted into a swirling storm of razor-sharp glass shards."
#kill 60
#unrest 200
#disease 10
#fort 0
#end

#newevent
#id 4880
#rarity 1
#req_chaos 1
#req_unluck 5
#req_land 1
#msg "A minor lack of order has combined with a streak of misfortune to turn a peaceful market day into a murderous riot. The people are looking for someone to blame."
#unrest 150
#kill 5
#gold -200
#end

#newevent
#id 4881
#rarity 1
#req_chaos 2
#req_unluck 5
#req_swamp 1
#msg "In the lawless environment of the swamp, a band of unlucky pilgrims was slaughtered. Their blood has defiled the local temple, weakening your divine presence."
#temple 0
#incdom -10
#unrest 50
#end

#newevent
#id 4882
#rarity 2
#req_chaos 4
#req_unluck 4
#req_lab 1
#msg "Chaos among the mages has led to a catastrophic, unlucky failure of containment. A multi-headed abomination has escaped and is currently eating the population."
#lab 0
#kill 20
#com 466
#4d6units 466
#end

#newevent
#id 4883
#rarity 2
#req_chaos 5
#req_unluck 3
#req_land 1
#msg "Total anarchy has allowed a mad sorcerer to seize control of the province. He is currently reshaping the landscape into a nightmare of unlucky distortions."
#revolt 1
#com 312
#addequip 2
#6d6units 1983
#decscale 5
#end

#newevent
#id 4884
#rarity 1
#req_chaos 2
#req_unluck 4
#req_sloth 3
#req_fort 1
#req_turn 15
#msg "The total apathy of the guards in this lawless land has allowed a group of thugs to simply walk into the fort and claim it as their own."
#fort 0
#com 482
#12d6units 482
#gold -300
#end

#newevent
#id 4885
#rarity 2
#req_chaos 3
#req_unluck 5
#req_heat 3
#req_swamp 1
#msg "An unlucky shift in the magma beneath the swamp has been ignored by the lawless inhabitants. The resulting steam explosion has leveled several villages."
#kill 50
#unrest 100
#decscale2 2
#end

#newevent
#id 4886
#rarity 2
#req_chaos 3
#req_unluck 5
#req_cold 3
#req_mountain 1
#msg "In the cold, chaotic highlands, the local tribes have turned on your tax collectors. The unlucky officials were found frozen and displayed as a warning."
#taxboost -200
#kill 5
#unrest 150
#end

#newevent
#id 4887
#rarity 1
#req_chaos 4
#req_unluck 3
#req_growth 3
#req_forest 1
#msg "A rogue animist is using the chaos of the province to spread a mutated, unlucky fungus. The people are being turned into mindless, spore-choked husks."
#kill 20
#disease 15
#com 1005
#6d6units 313
#end

#newevent
#id 4888
#rarity 2
#req_chaos 4
#req_unluck 4
#req_death 3
#req_land 1
#msg "The weight of death and chaos has allowed a skeletal king to unite the lawless dead. They are currently marching to purge the province of the living."
#com 188
#12d6units 194
#A300 189
#unrest 120
#end

#newevent
#id 4890
#rarity 2
#req_heat 5
#req_death 3
#req_waste 1
#msg "The relentless sun has combined with the heavy stench of death to create a spontaneous conflagration. The very bones in the local graveyards have ignited, releasing a cloud of necrotic soot that chokes the living."
#kill 30
#disease 10
#incscale2 3
#unrest 40
#end

#newevent
#id 4891
#rarity -2
#req_growth 5
#req_magic 3
#req_swamp 1
#msg "In this region of explosive growth and saturated magic, the very vines have begun to hum with aetheric power. Beings of living light have emerged from the deep green to defend the province."
#nation -2
#com 394
#10d6units 361
#4d6vis 6
#end

#newevent
#id 4892
#rarity 2
#req_sloth 5
#req_unmagic 3
#req_land 1
#msg "The absolute lethargy of the populace has combined with a vacuum of magic. The people have forgotten the use of tools and even the names of their children, regressing into a state of primitive silence."
#landprod -50
#landgold -30
#researchaff 0
#incdom -5
#end

#newevent
#id 4893
#rarity -2
#req_order 5
#req_prod 3
#req_cave 1
#msg "Absolute order and a frantic drive for production have turned the province into a single, massive machine. Efficiency is perfect, and a master engineer has arrived to oversee the gears."
#landprod 50
#gold 500
#nation -2
#com 1073
#4d6units 532
#end

#newevent
#id 4894
#rarity 2
#req_chaos 5
#req_magic 3
#req_land 1
#msg "Total anarchy and high magical saturation have caused reality to become a suggestion. The survivors are warping into chimeric forms, and a wild magic tornado is currently scouring the province."
#kill 20
#unrest 150
#com 466
#4d6units 466
#decscale2 5
#end

#newevent
#id 4895
#rarity 1
#req_cold 5
#req_death 3
#req_mountain 1
#msg "The absolute zero of the mountain peaks has frozen the very souls of the dead. They cannot pass on, and instead haunt the frozen tunnels as crystalline specters, envious of any warmth."
#com 181
#12d6units 676
#kill 5
#unrest 40
#end

#newevent
#id 4896
#rarity 1
#req_growth 5
#req_chaos 3
#req_forest 1
#msg "Explosive growth in a lawless province has led to the forest literally invading the city walls. The people are being driven out by aggressive vegetation that seems to respond to the local turmoil."
#kill 10
#unrest 100
#landprod -20
#com 931
#end

#newevent
#id 4897
#rarity -1
#req_order 5
#req_death 3
#req_land 1
#msg "In this land of unyielding law and heavy death, even the spirits are required to pay their dues. A specialized class of ghost-bureaucrats has stabilized the economy."
#landgold 30
#taxboost 100
#incdom 2
#end

#newevent
#id 4898
#rarity -2
#req_sloth 5
#req_magic 3
#req_cave 1
#msg "The absolute stillness of the tunnels has allowed the local mages to enter a state of permanent, productive meditation. Their spirits wander the aether, returning with deep wisdom."
#research 500
#researchaff 10
#3d6vis 4
#end

#newevent
#id 4899
#rarity 2
#req_heat 5
#req_chaos 3
#req_land 0
#req_turn 15
#msg "Extreme heat and a total lack of order have caused the local thermal vents to erupt. The lawless mermen are being boiled in their own palaces as the currents turn to steam."
#kill 40
#fort 0
#unrest 120
#taxboost -100
#end

#newevent
#id 4900
#rarity 1
#req_unmagic 5
#req_prod 3
#req_land 1
#msg "Total magic drain and high industrial quotas have made work physically soul-crushing. Without the spark of wonder, the workers are becoming mindless automatons of flesh and bone."
#kill 10
#disease 5
#landprod -15
#unrest 30
#end

#newevent
#id 4901
#rarity -1
#req_heat 5
#req_order 3
#req_waste 1
#msg "The scorching sun of the waste has melted the sand into a single, jagged mirror. A prophet has emerged from the glare, claiming the light has granted him a vision of your ascension."
#nation -2
#com 1536
#incdom 4
#1d6vis 0
#end

#newevent
#id 4902
#rarity -1
#req_growth 5
#req_order 3
#req_cave 1
#msg "In the damp, orderly caves, the fungal blooms have been meticulously cultivated. The resulting harvest is so bountiful that the province has become the empire’s primary granary."
#landprod 40
#landgold 20
#decscale 3
#end

#newevent
#id 4903
#rarity -2
#req_death 5
#req_chaos 3
#req_land 0
#msg "The absolute density of death in the chaotic currents has allowed a pirate king to rise from the depths. Finding your lack of laws to his liking, he has pledged his ghost-ships to your cause."
#nation -2
#com 1054
#12d6units 676
#gold 400
#end

#newevent
#id 4904
#rarity -2
#req_unmagic 5
#req_order 5
#req_land 1
#msg "In a land where magic is forbidden and the law is absolute, an elite order of mages-hunters has formed. They offer their disciplined, magic-resistant blades to your service."
#nation -2
#com 222
#10d6units 217
#gainaff 0
#end

#newevent
#id 4905
#rarity 2
#req_magic 5
#req_cold 3
#req_mountain 1
#msg "The mountain peaks are so saturated with magic and cold that the very snow has become sentient and hostile. A massive 'living' blizzard is currently burying the provincial capital."
#kill 40
#com 2231
#6d6units 1202
#incscale2 2
#end

#newevent
#id 4906
#rarity 1
#req_prod 5
#req_chaos 3
#req_swamp 1
#msg "The intense drive for production in the humid, lawless swamp has backfired. An unlucky, magical rust is eating the equipment and the armor of the garrison."
#defence -30
#gold -800
#landprod -20
#end

#newevent
#id 4907
#rarity 2
#req_death 5
#req_heat 3
#req_waste 1
#msg "The weight of death in the shimmering waste has drawn the sun's ire. The dead are not merely rising; they are being baked into brittle, fire-breathing husks that wander the dunes."
#com 533
#6d6units 615
#A600 617
#kill 5
#end

#newevent
#id 4908
#rarity -2
#req_magic 5
#req_prod 3
#req_cave 1
#msg "The deep earth's magic has reached a frequency that perfectly complements the local industry. Walls are not dug, they are 'sung' out of the rock, revealing massive gold deposits."
#addsite 70
#landgold 50
#2d6vis 3
#end

#newevent
#id 4909
#rarity 2
#req_order 5
#req_unmagic 3
#req_land 1
#msg "Absolute order and a vacuum of magic have created a society so rigid and grey that the inhabitants have begun to simply stop moving. The province is a gallery of living statues."
#taxboost -200
#landgold -20
#unrest -100
#kill 5
#end

#newevent
#id 4910
#rarity -2
#req_magic 5
#req_growth 3
#req_land 0
#msg "Wild magic and explosive growth have turned the reefs into a nightmare of beautiful, predatory life. A being of living coral has manifested to lead these monsters in your name."
#nation -2
#com 394
#10d6units 394
#A300 394
#end

#newevent
#id 4911
#rarity -1
#req_cold 5
#req_magic 3
#req_waste 1
#msg "The absolute zero of the waste has preserved the memories of a long-dead civilization. Your mages have found a way to read the very frost on the stones, gaining immense lore."
#research 300
#1d6vis 4
#magicitem 3
#end

#newevent
#id 4912
#rarity 2
#req_sloth 5
#req_death 3
#req_land 0
#msg "The total lethargy of the mermen has allowed the deep currents to fill with necrotic silt. The population is too tired to swim away, and is slowly being buried alive in the rot."
#kill 50
#incscale3 3
#incdom -4
#end

#newevent
#id 4913
#rarity 2
#req_prod 5
#req_chaos 5
#req_cave 1
#req_turn 20
#msg "The frantic push for production in the lawless caves has led to a catastrophic tectonic failure. The entire mining complex has dropped into a deeper, fire-filled abyss."
#kill 60
#gold -5000
#fort 0
#lab 0
#end

#newevent
#id 4914
#rarity -2
#req_prod 5
#req_magic 5
#req_lab 1
#msg "The combination of absolute industry and high magic has resulted in a lab accident that turned the local well-water into liquid gold. The effect is temporary but highly profitable."
#gold 2000
#1d6vis 53
#researchaff 2
#end

#newevent
#id 4915
#rarity -2
#req_heat 5
#req_order 5
#req_waste 1
#msg "The absolute heat and absolute order of the waste have attracted a solar celestial. He has arrived to impose a 'Burning Justice' upon your enemies."
#nation -2
#com 651
#addequip 1
#incdom 5
#end

#newevent
#id 4916
#rarity 2
#req_growth 5
#req_death 5
#req_forest 1
#msg "Life is too abundant in this land of death. The trees are growing out of the corpses of the inhabitants, and the forest is now a sentient, vengeful mass of undead wood."
#kill 50
#com 1005
#10d6units 313
#6d6units 314
#end

#newevent
#id 4917
#rarity 2
#req_unmagic 5
#req_chaos 5
#req_land 1
#req_turn 15
#msg "A vacuum of magic and total social turmoil have thinned the veil to the void. A rift has opened, and the very air is being sucked into the emptiness, taking the populace with it."
#kill 80
#com 308
#fort 0
#temple 0
#end

#newevent
#id 4918
#rarity -2
#req_cold 5
#req_prod 5
#req_mountain 1
#msg "Absolute cold and high production have allowed your smiths to forge armor from 'hard' water. A host of warriors clad in indestructible ice has been raised to serve the god of frost."
#nation -2
#2com 1201
#12d6units 1202
#addequip 2
#end

#newevent
#id 4919
#rarity -2
#req_sloth 5
#req_luck 5
#req_swamp 1
#msg "The absolute stillness of the swamp has acted as a mirror for the heavens. A reclusive oracle has spent decades watching the unmoving water and now offers his prophecies."
#research 400
#incdom 3
#magicitem 4
#end

#newevent
#id 4920
#rarity 1
#req_chaos 1
#req_order 1
#req_land 1
#msg "A minor lack of oversight has allowed the local bailiff to start accepting bribes. Honest citizens are being harassed, and the first flickers of resentment are turning into public unrest."
#incscale 0
#incscale 4
#gold -50
#unrest 10
#end

#newevent
#id 4921
#rarity 1
#req_chaos 1
#req_magic 1
#req_land 1
#msg "In this land where the law is loose and magic is present, an unlicensed hedge wizard has accidentally turned a local well into a font of bitter salt. The resulting shortage has sparked a minor riot."
#incscale 0
#incscale 4
#unrest 20
#1d3vis 4
#end

#newevent
#id 4922
#rarity 1
#req_chaos 1
#req_prod 1
#req_land 1
#msg "The independent spirit of the local workshops has led to a dispute over raw materials. Without a strong law to intervene, the smiths have taken to settling their differences with hammers."
#incscale 0
#incscale 4
#landprod -5
#gold -100
#end

#newevent
#id 4923
#rarity 1
#req_chaos 1
#req_sloth 1
#req_land 1
#msg "The slight lack of discipline has led to the provincial guards spending more time in the taverns than on the walls. In their stupor, they 'lost' a small portion of the armory to local thieves."
#incscale 0
#incscale 4
#defence -5
#gold -150
#end

#newevent
#id 4924
#rarity 1
#req_chaos 2
#req_unluck 1
#req_waste 1
#msg "In the shimmering heat of the waste, the lack of a strong garrison has encouraged a small group of nomads to begin raiding passing caravans."
#incscale 0
#incscale 4
#landgold -5
#unrest 15
#end

#newevent
#id 4925
#rarity 1
#req_chaos 2
#req_order 1
#req_cave 1
#msg "Two prominent mining families in the deep tunnels are feuding over a newly discovered vein. The lack of an official arbiter has led to a series of unlucky 'accidents' in the lower shafts."
#incscale 0
#incscale 4
#kill 5
#landprod -10
#end

#newevent
#id 4926
#rarity 1
#req_chaos 1
#req_unluck 1
#req_land 0
#msg "The chaotic currents of the coast have become a favored meeting spot for small-time buccaneers. Their rowdy presence is unsettling the local fishermen and hampering trade."
#incscale 0
#incscale 4
#landgold -10
#unrest 20
#end

#newevent
#id 4927
#rarity 1
#req_chaos 1
#req_growth 1
#req_swamp 1
#msg "In the damp, lawless wetlands, poaching has become rampant. The disruption of the ecosystem has led to a minor outbreak of swamp-fever among the desperate villagers."
#incscale 0
#incscale 4
#disease 5
#incscale 3
#end

#newevent
#id 4928
#rarity 1
#req_chaos 2
#req_magic 1
#req_land 1
#msg "A small group of rowdy travelers has defaced a local shrine. The lack of immediate punishment has emboldened others to ignore the holy sites of the realm."
#incscale 0
#incscale 4
#incdom -2
#unrest 10
#end

#newevent
#id 4929
#rarity 1
#req_chaos 2
#req_death 1
#req_land 1
#msg "The slight turmoil in the province has led to the neglect of the ancient graveyards. An unlucky alignment has allowed a few restless shades to wander into the village streets."
#incscale 0
#incscale 4
#unrest 15
#com 190
#end

#newevent
#id 4930
#rarity 1
#req_chaos 1
#req_order 1
#req_coast 1
#msg "The loose enforcement of laws has allowed a group of smugglers to establish a permanent den in a nearby sea-cave. They are skimming from the local taxes."
#incscale 0
#incscale 4
#taxboost -40
#landgold -5
#end

#newevent
#id 4931
#rarity 1
#req_chaos 1
#req_heat 1
#req_cave 1
#msg "In the deep caves, the heat from the forges is being managed poorly. A minor, unlucky gas leak has caused a localized explosion, stirring the anger of the miners."
#incscale 0
#incscale 4
#kill 2
#unrest 20
#end

#newevent
#id 4932
#rarity 1
#req_chaos 1
#req_cold 1
#req_land 1
#msg "The cold has set in, and the lack of organized fuel distribution has led to a minor uprising. The people are burning the local administrative building just to stay warm."
#incscale 0
#incscale 4
#unrest 30
#lab 0
#end

#newevent
#id 4933
#rarity 1
#req_chaos 1
#req_growth 1
#req_swamp 1
#msg "Without an organized effort to clear the paths, the aggressive growth of the swamp is beginning to swallow the outlying farmsteads. The people feel abandoned by the state."
#incscale 0
#incscale 4
#landprod -5
#unrest 10
#end

#newevent
#id 4934
#rarity 1
#req_chaos 2
#req_order 1
#req_land 1
#msg "A man claiming to be your official has been collecting 'emergency funds' from the populace. The lack of oversight meant it took months to realize he was a fraud."
#incscale 0
#incscale 4
#gold -200
#unrest 25
#end

#newevent
#id 4935
#rarity 1
#req_chaos 2
#req_magic 1
#req_lab 1
#msg "A group of students at the local lab has been using wild magic to prank the townspeople. The 'unlucky' transformations have turned the populace against the mages."
#incscale 0
#incscale 4
#unrest 40
#gainaff 4096
#end

#newevent
#id 4936
#rarity 1
#req_chaos 2
#req_unluck 1
#req_waste 1
#msg "In the lawless environment of the waste, a minor skirmish ended with a corpse in the primary well. The resulting sickness has been blamed on your 'cursed' administration."
#incscale 0
#incscale 4
#disease 10
#kill 5
#end

#newevent
#id 4937
#rarity 1
#req_chaos 1
#req_order 1
#req_land 0
#msg "A dispute between two merman clans over territory has turned violent. The lack of a clear law from the 'surface god' has led to a minor civil war among the reefs."
#incscale 0
#incscale 4
#unrest 50
#incdom -2
#end

#newevent
#id 4938
#rarity 1
#req_chaos 1
#req_sloth 1
#req_land 1
#msg "The apathy of the local monks has allowed a band of thieves to raid the provincial archives. Several minor relics and a small amount of gold were taken."
#incscale 0
#incscale 4
#gold -100
#magicitem 1
#end

#newevent
#id 4939
#rarity 1
#req_chaos 2
#req_prod 1
#req_land 1
#msg "A series of minor industrial accidents has convinced the local craftsmen that the stars are against them. They have stopped work to perform 'unlucky' superstitious rituals instead."
#incscale 0
#incscale 4
#landprod -10
#unrest 15
#end

#newevent
#id 4940
#rarity 1
#req_chaos 1
#req_order 1
#req_swamp 1
#msg "In the swamp, the lack of maintained dykes has led to a minor flood. A few unlucky homes were swept away, and the people are beginning to whisper of your incompetence."
#incscale 0
#incscale 4
#kill 3
#unrest 20
#end

#newevent
#id 4941
#rarity 1
#req_chaos 1
#req_magic 1
#req_cave 1
#msg "A rumor of a monster in the deep caves has been allowed to spread unchecked. The resulting panic has led to a minor strike among the mining crews."
#incscale 0
#incscale 4
#unrest 25
#landprod -5
#end

#newevent
#id 4942
#rarity 1
#req_chaos 1
#req_heat 1
#req_waste 1
#msg "The heat in the waste is making everyone irritable. A minor argument over a water-skin has turned into a bloody brawl that the local militia was too slow to stop."
#incscale 0
#incscale 4
#kill 5
#unrest 15
#end

#newevent
#id 4943
#rarity 1
#req_chaos 2
#req_cold 1
#req_land 1
#msg "An unlucky frost-surge has ruined the local market day. Frustrated traders have turned to looting the stalls, and the lack of law has allowed the chaos to spread."
#incscale 0
#incscale 4
#gold -150
#unrest 20
#end

#newevent
#id 4944
#rarity 1
#req_chaos 1
#req_growth 1
#req_land 1
#msg "A rogue herbalist is encouraging the peasants to ignore your laws in favor of 'the wisdom of the rot.' The people are becoming increasingly defiant."
#incscale 0
#incscale 4
#unrest 30
#incdom -2
#end

#newevent
#id 4945
#rarity 1
#req_chaos 2
#req_death 1
#req_land 1
#msg "The sightings of flickering lights in the local graveyard have been ignored by the officials. The resulting fear has led to a mass-emigration from the surrounding villages."
#incscale 0
#incscale 4
#emigration 5
#unrest 10
#end

#newevent
#id 4946
#rarity 1
#req_chaos 1
#req_prod 1
#req_land 1
#msg "An unlucky mechanical failure in a supply wagon has blocked the main trade road. The lack of a prompt response from the local bailiff has led to a violent dispute among the merchants."
#incscale 0
#incscale 4
#taxboost -30
#unrest 15
#end

#newevent
#id 4947
#rarity 1
#req_chaos 1
#req_order 1
#req_land 0
#msg "A minor flood in the merman capital has 'unluckily' destroyed the local tax records. Many citizens are using the chaos to avoid paying their dues."
#incscale 0
#incscale 4
#landgold -10
#taxboost -50
#end

#newevent
#id 4948
#rarity 1
#req_chaos 2
#req_prod 1
#req_cave 1
#msg "The miners in the deep tunnels have discovered that the local overseer has been skimming gold. Without a clear law to address the theft, the workers have seized the shafts."
#incscale 0
#incscale 4
#landprod -20
#unrest 40
#end

#newevent
#id 4950
#rarity 1
#req_order 2
#req_sloth 2
#req_land 1
#msg "The strict laws of the land have combined with a profound lethargy among the clerks. The paperwork required for even the simplest task has ground all trade to a halt."
#decscale 0
#incscale 1
#taxboost -100
#landgold -10
#end

#newevent
#id 4951
#rarity 1
#req_order 2
#req_magic 2
#req_lab 1
#msg "Magic is strictly regulated and used only to serve the state. Independent research is viewed as a crime, and the air in the laboratories is heavy with the scent of incense and stagnation."
#decscale 0
#decscale 5
#researchaff 33
#unrest 20
#end

#newevent
#id 4952
#rarity 2
#req_chaos 2
#req_death 2
#req_land 1
#msg "Total lawlessness has led to the neglect of the dead. In the absence of a functioning government, the bodies of the fallen are left to rot in the streets, drawing necrotic spirits."
#incscale 0
#incscale 3
#kill 10
#disease 5
#unrest 50
#end

#newevent
#id 4953
#rarity 1
#req_chaos 2
#req_growth 2
#req_forest 1
#msg "Explosive growth in a lawless province has turned the city into a jungle. Without crews to clear the vines, the architecture is being strangled by sentient, aggressive weeds."
#incscale 0
#decscale 3
#landprod -10
#unrest 30
#com 931
#end

#newevent
#id 4954
#rarity 1
#req_prod 2
#req_heat 2
#req_mountain 1
#msg "The frantic push for production in this blistering heat has turned the workshops into death traps. The output is high, but the cost in human lives is becoming unbearable."
#decscale 1
#decscale 2
#kill 5
#gold 200
#landprod 10
#end

#newevent
#id 4955
#rarity 1
#req_sloth 2
#req_cold 2
#req_land 1
#msg "The combination of absolute cold and total apathy has convinced the populace to simply stop moving. People are freezing in their beds, too tired to even light a fire."
#incscale 1
#incscale 2
#kill 10
#incdom -2
#end

#newevent
#id 4956
#rarity 1
#req_unmagic 2
#req_prod 2
#req_land 1
#msg "In a land where magic has died and production quotas are high, the work is physically soul-crushing. Without the spark of wonder, the workers are becoming hollow husks."
#incscale 5
#decscale 1
#kill 2
#unrest 25
#disease 5
#end

#newevent
#id 4957
#rarity 2
#req_unmagic 2
#req_death 2
#req_waste 1
#msg "The absolute absence of magic in this land of death has created a spiritual vacuum. Neither the living nor the dead can find rest in a world so hollow and grey."
#incscale 5
#incscale 3
#kill 15
#incdom -5
#researchaff 0
#end

#newevent
#id 4958
#rarity 1
#req_magic 2
#req_prod 2
#req_lab 1
#msg "High magic and high production have led to a series of lab accidents. Volatile reagents are being mass-produced with sloppy oversight, leading to localized aetheric fires."
#decscale 5
#decscale 1
#unrest 40
#gold -300
#1d6vis Elemental
#end

#newevent
#id 4959
#rarity 2
#req_chaos 2
#req_heat 2
#req_land 0
#req_turn 15
#msg "The total lack of order in these boiling currents has led to a series of steam-explosions. The mermen are fighting over the few remaining cool-water reefs."
#incscale 0
#decscale 2
#kill 10
#unrest 60
#fort 0
#end

#newevent
#id 4960
#rarity 1
#req_order 2
#req_cold 2
#req_cave 1
#msg "In the deep caves, the law is as cold as the stone. Every infraction is punished by exposure to the frost-vents, and the people have become as brittle as ice."
#decscale 0
#incscale 2
#kill 5
#unrest 20
#defence 10
#end

#newevent
#id 4961
#rarity 1
#req_sloth 2
#req_growth 2
#req_cave 1
#msg "The damp stillness of the caves and the explosive growth of the spores have turned the tunnels into a labyrinth of lethal mushrooms. The miners are being slowly absorbed."
#incscale 1
#decscale 3
#landprod -20
#disease 10
#end

#newevent
#id 4962
#rarity 2
#req_heat 2
#req_death 2
#req_swamp 1
#msg "The heat of the swamp has combined with a high density of death to create a suffocating, necrotic miasma. The living are breathing in the rot of their ancestors."
#decscale 2
#incscale 3
#kill 10
#disease 15
#unrest 30
#end

#newevent
#id 4963
#rarity 2
#req_chaos 2
#req_magic 2
#req_land 0
#msg "Wild magic and chaotic currents have turned the reefs into a nightmare of chimeric sea-life. The mermen have lost control of their own environment."
#incscale 0
#decscale 5
#com 466
#4d6units 394
#kill 5
#end

#newevent
#id 4964
#rarity 1
#req_unmagic 2
#req_sloth 2
#req_cave 1
#msg "The absence of magic and the profound lethargy of the miners have made the deep caves feel like a tomb. The people have forgotten why they even dig."
#incscale 5
#incscale 1
#landgold -10
#researchaff 0
#end

#newevent
#id 4965
#rarity 1
#req_heat 2
#req_death 2
#req_waste 1
#msg "The relentless sun and the weight of death in the waste have turned the sand into a jagged, necrotic crust. Every step is a struggle against the environment."
#decscale 2
#incscale 3
#kill 5
#landprod -10
#unrest 10
#end

#newevent
#id 4966
#rarity 1
#req_order 2
#req_prod 2
#req_land 1
#msg "Extreme order and high production have turned the province into a massive, joyless factory. Every hour is accounted for, and the human spirit is being ground into dust."
#decscale 0
#decscale 1
#unrest 15
#landprod 15
#gold 100
#end

#newevent
#id 4967
#rarity 1
#req_growth 2
#req_magic 2
#req_temple 1
#msg "The combination of high growth and high magic has caused the local temple to be consumed by sentient flowers. The priests can no longer reach the altar through the thorns."
#decscale 3
#decscale 5
#incdom -4
#unrest 10
#end

#newevent
#id 4968
#rarity 1
#req_order 2
#req_death 2
#req_swamp 1
#msg "Absolute order in the swamp has led to the dredging of every natural pool. While the water is clear, the 'soul' of the wetlands has been killed by the rigid canals."
#decscale 0
#incscale 3
#taxboost 50
#incdom -2
#incscale 3
#end

#newevent
#id 4969
#rarity 1
#req_magic 2
#req_chaos 2
#req_land 1
#msg "The magic in the air is so thick it is inducing a state of frantic, chaotic movement. The people are dancing themselves to death in a frenzy of uncontrolled power."
#decscale 5
#incscale 0
#kill 5
#unrest 80
#gainaff 4096
#end

#newevent
#id 4970
#rarity 1
#req_cold 2
#req_prod 2
#req_land 1
#msg "The cold has set in early, and the frantic push for production has led to the harvest of frozen, useless grain. The warehouses are full of ice instead of food."
#incscale 2
#decscale 1
#gold -200
#taxboost -100
#end

#newevent
#id 4971
#rarity 1
#req_heat 2
#req_magic 2
#req_waste 1
#msg "The heat of the waste and the high magical saturation have created a permanent hallucination. The people are wandering into the dunes, chasing non-existent cities."
#decscale 2
#decscale 5
#kill 10
#unrest 20
#incdom -2
#end

#newevent
#id 4972
#rarity 1
#req_sloth 2
#req_growth 2
#req_land 0
#msg "The stillness of the deep waters and the high density of life have led to a massive algal bloom. The mermen are suffocating in the very water that should sustain them."
#incscale 1
#decscale 3
#kill 15
#taxboost -50
#end

#newevent
#id 4973
#rarity 1
#req_order 2
#req_death 2
#req_land 1
#msg "The absolute order of this land of death means that even the skeletons are given a daily schedule. The grim efficiency is terrifying to the remaining living."
#decscale 0
#incscale 3
#landprod 10
#unrest 20
#incdom 2
#end

#newevent
#id 4974
#rarity 2
#req_unmagic 2
#req_growth 2
#req_forest 1
#msg "A vacuum of magic and high growth have produced a breed of 'hungry' plants that drain the life-force of everything they touch to compensate for the lack of aether."
#incscale 5
#decscale 3
#kill 10
#disease 5
#unrest 15
#end

#newevent
#id 4975
#rarity 2
#req_chaos 2
#req_heat 2
#req_cave 1
#req_turn 15
#msg "Total turmoil among the miners has led to the sabotage of the magma-containment wards. The tunnels are now filled with uncontrolled fire and screaming workers."
#incscale 0
#decscale 2
#kill 25
#fort 0
#unrest 100
#end

#newevent
#id 4976
#rarity 1
#req_cold 2
#req_prod 2
#req_mountain 1
#msg "The absolute cold and high production quotas have caused the metal to become as brittle as glass. Hammers are shattering against the anvils, and the smiths are losing fingers to the frost."
#incscale 2
#decscale 1
#landprod -20
#gold -300
#kill 2
#end

#newevent
#id 4977
#rarity 1
#req_magic 2
#req_sloth 2
#req_lab 1
#msg "The magic in this lazy valley has become heavy and unmoving. Spells take twice as long to cast, and the mages are falling into a permanent, dreamless sleep."
#decscale 5
#incscale 1
#researchaff 0
#unrest 10
#end

#newevent
#id 4978
#rarity 1
#req_unmagic 2
#req_chaos 2
#req_land 1
#msg "The lack of magic and total social turmoil have convinced the populace that the gods have abandoned them. They are salting the fields and burning the shrines in a fit of nihilistic rage."
#incscale 5
#incscale 0
#kill 10
#temple 0
#incdom -5
#end

#newevent
#id 4980
#rarity 1
#req_chaos 1
#req_prod 1
#req_land 1
#msg "In this land of loose laws and heavy industry, rival workshops have begun sabotaging one another to meet their quotas. The lack of oversight has turned healthy competition into a series of violent accidents."
#incscale 0
#decscale 1
#unrest 20
#gold -100
#landprod -5
#end

#newevent
#id 4981
#rarity 1
#req_chaos 1
#req_sloth 1
#req_land 1
#msg "The slight lack of order has encouraged the lazier citizens to congregate in the streets, blocking the movement of goods. Without a strong militia to move them along, trade has ground to a stuttering halt."
#incscale 0
#incscale 1
#unrest 15
#landgold -10
#taxboost -30
#end

#newevent
#id 4982
#rarity 1
#req_chaos 1
#req_heat 1
#req_land 1
#msg "The summer heat is making the unmanaged populace irritable. A minor dispute at a tavern has expanded into a full-scale brawl that the local guards are too disorganized to contain."
#incscale 0
#decscale 2
#kill 5
#unrest 30
#end

#newevent
#id 4983
#rarity 1
#req_chaos 1
#req_cold 1
#req_land 1
#msg "The winter chill has arrived, and the lack of a centralized wood-ration has led to neighbors fighting over fuel. Small fires are breaking out as people try to stay warm in the chaos."
#incscale 0
#incscale 2
#kill 2
#unrest 25
#lab 0
#end

#newevent
#id 4984
#rarity 1
#req_chaos 1
#req_growth 1
#req_forest 1
#msg "The explosive growth of the province has outpaced the local government's ability to plan. Shanty-towns are popping up in the encroaching woods, serving as havens for disease and rebellion."
#incscale 0
#decscale 3
#disease 10
#unrest 20
#incdom -2
#end

#newevent
#id 4985
#rarity 1
#req_chaos 1
#req_death 1
#req_land 1
#msg "The weight of death in the province has attracted those who would profit from the dead. The lack of law has allowed grave-robbing to become a public nuisance, distressing the grieving families."
#incscale 0
#incscale 3
#unrest 30
#incdom -3
#end

#newevent
#id 4986
#rarity 1
#req_chaos 2
#req_magic 2
#req_land 1
#msg "The saturation of magic and a lack of licensing has led to students practicing wild enchantments in the marketplace. Several 'unlucky' transformations have caused a minor panic."
#incscale 0
#decscale 5
#unrest 40
#gainaff 4096
#end

#newevent
#id 4987
#rarity 1
#req_chaos 1
#req_unmagic 1
#req_land 1
#msg "In this land where wonder is dying and the law is loose, the people have begun blaming 'strangers' for their lack of luck. A mob has gathered to burn a local repository of lore."
#incscale 0
#incscale 5
#gold -200
#researchaff 0
#end

#newevent
#id 4988
#rarity 1
#req_chaos 1
#req_prod 1
#req_cave 1
#msg "In the deep tunnels, independent mining crews are fighting over air-shafts. The lack of an overseer has led to a series of deliberate cave-ins that have hampered production."
#incscale 0
#decscale 1
#kill 10
#landprod -15
#end

#newevent
#id 4989
#rarity 1
#req_chaos 2
#req_sloth 2
#req_cave 1
#msg "The miners have become lazy and defiant. Without a strong law to enforce the shifts, they have begun loitering in the dark, whispering of ancient, forbidden things."
#incscale 0
#incscale 1
#unrest 25
#incdom -2
#end

#newevent
#id 4990
#rarity 1
#req_chaos 1
#req_heat 1
#req_land 0
#msg "The heat of the thermal vents is ignored by the disorganized mermen. A minor boiler-leak was left unpatched, and the resulting steam has scalded several prominent citizens, sparking an uprising."
#incscale 0
#decscale 2
#kill 5
#unrest 40
#end

#newevent
#id 4991
#rarity 1
#req_chaos 2
#req_growth 2
#req_land 0
#msg "A dispute over kelp-harvesting rights has turned violent. Without a clear decree from above, the mermen are using their harpoons on one another instead of the fish."
#incscale 0
#decscale 3
#unrest 50
#landgold -10
#end

#newevent
#id 4992
#rarity 1
#req_chaos 1
#req_prod 1
#req_swamp 1
#msg "In the lawless swamp, a group of poachers has established a trade in illicit animal parts. Their presence is drawing dangerous predators closer to the villages."
#incscale 0
#decscale 1
#gold -100
#com 403
#end

#newevent
#id 4993
#rarity 1
#req_chaos 1
#req_death 1
#req_swamp 1
#msg "A bank of necrotic fog has rolled into the swamp, and the disorganized villagers have gone into a state of blind panic. They are currently burning the dykes that keep the rot at bay."
#incscale 0
#incscale 3
#kill 10
#unrest 60
#end

#newevent
#id 4994
#rarity 1
#req_chaos 1
#req_heat 1
#req_waste 1
#msg "The nomads of the waste have taken advantage of the shimmering heat and your weak garrison to raid the provincial stores. They vanished back into the dunes before the alarm could be raised."
#incscale 0
#decscale 2
#gold -300
#landprod -5
#end

#newevent
#id 4995
#rarity 1
#req_chaos 2
#req_unmagic 2
#req_waste 1
#msg "The desert has become a place of unmagic and lawlessness. The people have forgotten the holy hymns, replacing them with a violent, nihilistic worship of the wind."
#incscale 0
#incscale 5
#incdom -5
#unrest 15
#end

#newevent
#id 4996
#rarity 1
#req_chaos 1
#req_prod 2
#req_land 1
#msg "A local blacksmith has refused to follow the army's requirements, choosing instead to sell his steel to the highest bidder. The lack of a strong law has encouraged others to follow his lead."
#incscale 0
#decscale 1
#gold -200
#defence -5
#end

#newevent
#id 4997
#rarity 1
#req_chaos 1
#req_sloth 2
#req_land 1
#msg "A wave of lethargy has hit the lawless province. Groups of people are simply sitting in the middle of the roads, refusing to work or move, and the militia is too undisciplined to intervene."
#incscale 0
#incscale 1
#landgold -15
#landprod -10
#end

#newevent
#id 4998
#rarity 1
#req_chaos 1
#req_heat 2
#req_cave 1
#msg "In the deep caves, a heat-vent was left unmonitored. The resulting surge has flooded a minor tunnel with magma, incinerating a collection of valuable tools."
#incscale 0
#decscale 2
#gold -400
#kill 2
#end

#newevent
#id 4999
#rarity 1
#req_chaos 2
#req_cold 1
#req_land 1
#msg "An unlucky cold snap has hit the province. In the absence of a strong guard, the people have broken into the state granaries to find things to burn for warmth."
#incscale 0
#incscale 2
#gold -200
#unrest 30
#end

#newevent
#id 5000
#rarity 1
#req_chaos 2
#req_growth 2
#req_forest 1
#msg "Nature is expanding into the disorganized city. The streets are choked with thorns, and the people have begun worshiping the wild vines that are currently strangling your tax collectors."
#incscale 0
#decscale 3
#kill 2
#unrest 40
#incdom -3
#end

#newevent
#id 5001
#rarity 1
#req_chaos 2
#req_death 1
#req_land 1
#msg "The density of death in the province has reached a point where the dead are visible to the living. The disorganized populace has reacted with mindless violence, burning down the local cemetery gates."
#incscale 0
#incscale 3
#unrest 50
#com 190
#end

#newevent
#id 5002
#rarity 1
#req_chaos 1
#req_magic 2
#req_lab 1
#msg "Students at the local lab have been using wild magic to harass the townspeople. Without a strict master to oversee them, their 'jokes' have turned into a series of unlucky fires."
#incscale 0
#decscale 5
#unrest 45
#lab 0
#end

#newevent
#id 5003
#rarity 1
#req_chaos 1
#req_unmagic 2
#req_land 1
#msg "In this land where magic is weak and the law is loose, a charlatan has begun preaching that the world is a dream. The people are following his lead, abandoning their chores."
#incscale 0
#incscale 5
#landprod -20
#unrest 15
#end

#newevent
#id 5004
#rarity 1
#req_chaos 2
#req_prod 1
#req_cave 1
#msg "The miners in the tunnels have seized the equipment and are refusing to return it. They claim that in this lawless land, the steel belongs to those who hold it."
#incscale 0
#decscale 1
#gold -300
#landprod -15
#unrest 40
#end

#newevent
#id 5005
#rarity 1
#req_chaos 1
#req_sloth 2
#req_fort 1
#msg "The soldiers have become so lazy that they are now letting bandits through the gates in exchange for a portion of the loot. The law is a joke in this province."
#incscale 0
#incscale 1
#defence -15
#gold -400
#end

#newevent
#id 5006
#rarity 1
#req_chaos 1
#req_heat 2
#req_swamp 1
#msg "The heat of the swamp has combined with a minor riot. In the confusion, the dykes were sabotaged, and the resulting steam from the submerged vents has blinded several villagers."
#incscale 0
#decscale 2
#kill 5
#disease 5
#unrest 50
#end

#newevent
#id 5007
#rarity 1
#req_chaos 2
#req_cold 2
#req_mountain 1
#msg "The cold has set in, and the local tribes have decided that your rule is too weak to endure the winter. They have stopped paying taxes and are currently raiding the local armory."
#incscale 0
#incscale 2
#taxboost -100
#gold -200
#unrest 60
#end

#newevent
#id 5008
#rarity 1
#req_chaos 1
#req_growth 2
#req_swamp 1
#msg "A rogue herbalist is using the chaos of the province to spread a mutated fungus. The people are being turned into defiant, spore-choked husks who refuse to answer your call."
#incscale 0
#decscale 3
#kill 5
#unrest 40
#incdom -2
#end

#newevent
#id 5035
#rarity 1
#req_chaos 3
#req_prod 1
#req_land 1
#msg "In this land of loose laws and emerging industry, rival craftsmen have begun sabotaging one another’s workshops. The lack of a strong governor has turned minor professional jealousy into a string of violent, unlucky fires."
#incscale 0
#decscale 1
#gold -200
#unrest 30
#lab 0
#end

#newevent
#id 5036
#rarity 1
#req_chaos 4
#req_prod 2
#req_mountain 1
#msg "The independent miners in the highlands, emboldened by the lack of oversight, have begun digging dangerous, unauthorized tunnels. A series of collapses has claimed several lives, yet the looting of the earth continues."
#incscale 0
#decscale 1
#kill 10
#gold -400
#landprod -10
#end

#newevent
#id 5037
#rarity 2
#req_chaos 5
#req_prod 1
#req_cave 1
#req_turn 15
#msg "The intense drive for production in the deep caves is being managed by a disorganized committee of miners. A minor boiler failure was ignored, leading to a massive steam explosion that has leveled a district."
#incscale 0
#decscale 1
#kill 20
#gold -800
#fort 0
#end

#newevent
#id 5038
#rarity 1
#req_chaos 3
#req_sloth 1
#req_land 1
#msg "The breakdown of order has encouraged the lazier citizens to congregate in the trade roads, demanding 'freedom from effort.' Without a militia to move them, commerce has ground to a stuttering halt."
#incscale 0
#incscale 1
#taxboost -50
#landgold -10
#unrest 20
#end

#newevent
#id 5039
#rarity 1
#req_chaos 4
#req_sloth 2
#req_swamp 1
#msg "In the lawless wetlands, the villagers have simply stopped maintaining the dykes. They claim that in a world without order, there is no reason to fight the rising water. The swamp is beginning to reclaim the village."
#incscale 0
#incscale 1
#landprod -15
#unrest 30
#disease 5
#end

#newevent
#id 5040
#rarity 2
#req_chaos 5
#req_sloth 1
#req_land 0
#msg "The total apathy of the mermen has combined with a complete lack of law. Palaces are being stripped of their ornaments by looters, and the population is too tired or too lawless to stop them."
#incscale 0
#incscale 1
#gold -500
#taxboost -100
#incdom -2
#end

#newevent
#id 5041
#rarity 1
#req_chaos 3
#req_heat 1
#req_waste 1
#msg "The summer heat is baking the lawless waste. The nomads have taken the shimmering air as a sign of divine favor for their anarchy, and are currently raiding your border outposts with fanatical glee."
#incscale 0
#decscale 2
#kill 5
#unrest 40
#1d6vis 0
#end

#newevent
#id 5042
#rarity 1
#req_chaos 4
#req_heat 2
#req_land 1
#msg "The heat in the valley is making the unmanaged populace aggressive. A minor dispute over a water-well has turned into a bloody uprising that has left the local administrative building in ashes."
#incscale 0
#decscale 2
#kill 10
#unrest 80
#gold -300
#end

#newevent
#id 5043
#rarity 2
#req_chaos 5
#req_heat 1
#req_cave 1
#req_turn 15
#msg "In the deep caves, the heat has become a catalyst for rebellion. The miners have sabotaged the cooling-vents, claiming the 'burning earth' will cleanse the province of your rule."
#incscale 0
#decscale 2
#kill 15
#unrest 100
#fort 0
#end

#newevent
#id 5044
#rarity 1
#req_chaos 3
#req_cold 1
#req_mountain 1
#msg "The winter chill has arrived, and the lack of an organized wood-ration has led to neighbors killing one another for fuel. The disorganized garrison is doing more looting than protecting."
#incscale 0
#incscale 2
#kill 5
#unrest 30
#gold -200
#end

#newevent
#id 5045
#rarity 1
#req_chaos 4
#req_cold 2
#req_land 1
#msg "The cold has set in, and the soldiers in this lawless land have decided that freezing on the walls is not for them. They have abandoned their posts to burn the local granary for warmth."
#incscale 0
#incscale 2
#defence -15
#unrest 60
#gold -400
#end

#newevent
#id 5046
#rarity 2
#req_chaos 5
#req_cold 1
#req_land 0
#msg "The ocean floor has grown uncomfortably cold. Emboldened by the lack of law, several merman war-bands have seized the local treasure-vaults and fled for warmer waters."
#incscale 0
#incscale 2
#gold -1000
#com 976
#6d6units 974
#end

#newevent
#id 5047
#rarity 1
#req_chaos 3
#req_growth 1
#req_forest 1
#msg "Without a strong law to enforce the clearing of the woods, the aggressive growth has begun to swallow the roads. Travelers are being ambushed by outlaws hiding in the sentient brambles."
#incscale 0
#decscale 3
#unrest 25
#landgold -10
#com 1313
#end

#newevent
#id 5048
#rarity 1
#req_chaos 4
#req_growth 2
#req_swamp 1
#msg "The humid swamp is a haven for the lawless and the fecund. A minor lack of oversight has allowed a mutated breed of lizard-men to overpopulate and swarm the local settlements."
#incscale 0
#decscale 3
#kill 10
#unrest 50
#2d6units 423
#end

#newevent
#id 5049
#rarity 2
#req_chaos 5
#req_growth 1
#req_land 1
#msg "Life is too abundant in this lawless land. A rogue herbalist has convinced the people that the 'Spirit of the Jungle' demands the blood of the civilized. A violent, plant-worshiping cult has formed."
#incscale 0
#decscale 3
#incdom -5
#unrest 150
#com 931
#end

#newevent
#id 5050
#rarity 1
#req_chaos 3
#req_death 1
#req_land 1
#msg "The weight of death in the province is being met with total administrative failure. Bodies are piling up in the streets, and the disorganized populace is fleeing the resulting stench and spirits."
#incscale 0
#incscale 3
#disease 10
#emigration 5
#unrest 40
#end

#newevent
#id 5051
#rarity 1
#req_chaos 4
#req_death 2
#req_waste 1
#msg "In the lawless waste, the dead no longer stay under the sand. Enraged by the lack of proper rites, a small host of skeletal nomads has begun raiding the living."
#incscale 0
#incscale 3
#unrest 60
#com 188
#4d6units 194
#end

#newevent
#id 5065
#rarity -1
#req_order 3
#req_land 1
#msg "The law in this province has reached a state of crystalline clarity. Inspired by the perfect justice of the courts, a group of loyal knights has pledged their lives to the state, bringing a tithe of gems."
#decscale2 0
#2d6vis 4
#nation -2
#com 23
#2d6units 22
#end

#newevent
#id 5066
#rarity 1
#req_order 3
#req_land 1
#msg "The laws here are so rigid and unyielding that a local noble has declared your 'justice' a form of tyranny. He has raised a private army of 'liberators' to return the province to a more flexible rule."
#decscale2 0
#unrest 60
#com 23
#addequip 1
#10d6units 19
#end

#newevent
#id 5067
#rarity -1
#req_chaos 3
#req_land 1
#msg "In this land of minimal oversight, trade is thriving with a wild, infectious energy. Independent traders have donated a cache of gems and their own hired guards to ensure their continued freedom."
#incscale2 0
#1d6vis Elemental
#nation -2
#2com 35
#6d6units 40
#end

#newevent
#id 5068
#rarity 1
#req_chaos 3
#req_land 1
#msg "The total lack of order has finally emboldened the local gangs. A powerful warlord has united the rabble, claiming that your distant rule is no rule at all. They are currently seizing the armory."
#incscale2 0
#unrest 100
#com 147
#16d6units 139
#6d6units 140
#end

#newevent
#id 5069
#rarity -1
#req_prod 3
#req_land 1
#msg "Provincial industry has hit a rhythm of divine efficiency. A reclusive master of gears has gifted the province a small squad of tireless mechanical servants and a supply of refined earth-essence."
#decscale2 1
#2d6vis 3
#nation -2
#2d6units 532
#landprod 15
#end

#newevent
#id 5070
#rarity 1
#req_prod 3
#req_cave 1
#msg "The earth in this province has been scoured for resources with such intensity that the deep-spirits have awoken in pain. They are rising from the shafts to reclaim the stone from your miners."
#decscale2 1
#kill 20
#com 2523
#12d6units 2524
#landprod -10
#end

#newevent
#id 5071
#rarity -1
#req_sloth 3
#req_land 1
#msg "The profound stillness of the province has allowed the populace to find a rare spiritual peace. A group of monks has emerged from their silence to offer their services, bringing gems."
#incscale2 1
#2d6vis 4
#nation -2
#com 2324
#12d6units 2324
#end

#newevent
#id 5072
#rarity 1
#req_sloth 3
#req_land 1
#msg "The collective apathy of the people has thinned the veil. In their deep, lethargic sleep, the inhabitants have accidentally opened a doorway for a horror that now stalks the physical streets."
#incscale2 1
#kill 10
#com 2212
#unrest 40
#incdom -2
#end

#newevent
#id 5073
#rarity -1
#req_heat 3
#req_waste 1
#msg "The heat in this region has become a source of vitality. Fire spirits have emerged from the shimmering dunes to dance in your honor, bringing fire rubies as a sign of their devotion."
#decscale2 2
#2d6vis 0
#nation -2
#com 99
#2d6units 527
#end

#newevent
#id 5074
#rarity 1
#req_heat 3
#req_land 1
#msg "The ground has cracked under the relentless sun. Molten monsters have emerged from a sudden fissure, treating the province as a new extension of hell."
#decscale2 2
#kill 15
#com 526
#10d6units 304
#unrest 50
#end

#newevent
#id 5075
#rarity -1
#req_cold 3
#req_mountain 1
#msg "The beautiful, crisp cold of the highlands has attracted a group of mountain scouts who thrive in the frost. They have pledged their services, presenting a gift of frozen gems."
#incscale2 2
#2d6vis 2
#nation -2
#com 141
#6d6units 141
#end

#newevent
#id 5076
#rarity 1
#req_cold 3
#req_land 1
#msg "The absolute zero of the frost has acted as a bridge for those who dwell in the eternal winter. A war-band of frost giants has crossed into the province to extinguish all warmth."
#incscale2 2
#kill 20
#com 844
#4d6units 1202
#unrest 60
#end

#newevent
#id 5077
#rarity -1
#req_growth 3
#req_forest 1
#msg "Life is so abundant here that the forest itself has begun to protect the inhabitants. A group of forest sprites and a Great Bear have emerged to stand watch over the flourishing groves."
#decscale2 3
#2d6vis 6
#nation -2
#com 694
#6d6units 592
#defence 10
#end

#newevent
#id 5078
#rarity 1
#req_growth 3
#req_land 1
#msg "The growth in the province has become aggressive and wild. Sentient vines and wooden monstrosities have begun reclaiming the town square, viewing the living as little more than fertilizer."
#decscale2 3
#kill 5
#com 931
#12d6units 361
#4d6units 362
#end

#newevent
#id 5085
#rarity -2
#req_cold 5
#req_land 1
#msg "The absolute zero of the province has been harnessed by ancient frost-smiths. They have raised a shimmering fortress of permanent ice, swearing fealty to the one who brought the eternal winter."
#fort 15
#nation -2
#com 844
#12d6units 1202
#incscale 2
#end

#newevent
#id 5086
#rarity -2
#req_growth 5
#req_land 1
#msg "Nature has reached a state of aggressive sentience. Vines and iron-wood have woven themselves into a massive, living fortification that guards the province against any who would tread upon the green."
#fort 12
#nation -2
#com 931
#10d6units 361
#1d6units 362
#end

#newevent
#id 5087
#rarity -2
#req_prod 5
#req_land 1
#msg "A master mason of legendary skill has arrived, drawn by the incredible productivity of your workshops. He offers to oversee the construction of your empire's greatest monuments."
#nation -2
#com 1606
#landprod 30
#gold 500
#end

#newevent
#id 5088
#rarity -2
#req_order 5
#req_land 1
#msg "The population’s fervor for order has reached a divine peak. A legendary arbiter has arrived to purge all dissent. His presence has ignited a spiritual fire, making your name law across the world."
#incdom 8
#unrest -100
#nation -2
#com 222
#16d6units 149
#12d6units 149
#end

#newevent
#id 5089
#rarity -2
#req_death 5
#req_land 1
#msg "In this land of absolute death, the ancient dead have recognized a master they can truly obey. A King of the Old World has risen with his silent retinue to serve your standard."
#nation -2
#com 181
#6d6units 676
#2d6units 195
#gold 400
#end

#newevent
#id 5090
#rarity 2
#req_magic 5
#req_land 1
#msg "The saturation of magic has become toxic to the flesh. A shimmering, magical fever has struck the populace, turning their dreams into nightmares and their bodies into warped glass."
#kill 30
#disease 15
#unrest 60
#decscale2 5
#end

#newevent
#id 5091
#rarity 2
#req_luck 5
#req_land 1
#req_turn 20
#msg "Fortune has been so kind for so long that the populace has fallen into a state of reckless hubris. A massive, unlucky series of gambling debts and scandals has bankrupted the provincial government."
#gold -2000
#unrest 100
#taxboost -100
#incscale2 4
#end

#newevent
#id 5092
#rarity -2
#req_unmagic 5
#req_land 1
#msg "In the absolute silence of the unmagic zone, the people have developed a chilling mental resilience. A group of void-shielded warriors has formed to defend this bastion of mundane reality."
#nation -2
#com 2324
#12d6units 2324
#gainaff 0
#defence 20
#end

#newevent
#id 5093
#rarity -2
#req_heat 5
#req_land 1
#msg "The extreme heat has been focused into a permanent, magical furnace. Your smiths can now forge artifacts with the strength of the sun itself."
#addsite 36
#2d6vis 0
#gold 300
#magicitem 3
#end

#newevent
#id 5094
#rarity -2
#req_unluck 5
#req_land 1
#msg "In a stroke of impossible irony, the absolute misfortune of the province has attracted a divine fool. He has 'accidentally' discovered a treasure vault while fleeing from a localized disaster."
#gold 1500
#magicitem 4
#decscale 4
#end

#newevent
#id 5095
#rarity -1
#req_cold 4
#req_land 1
#msg "The crisp, clean cold has perfectly preserved the local wealth. An audit has revealed that several previous governors had hidden gold in the permafrost, which has now been recovered."
#gold 800
#landgold 15
#end

#newevent
#id 5096
#rarity 1
#req_heat 4
#req_waste 1
#msg "The heat in the waste has reached a point where people are seeing non-existent armies. In their sun-warped panic, they have begun destroying their own water supplies."
#kill 5
#unrest 40
#landprod -10
#end

#newevent
#id 5097
#rarity -1
#req_prod 4
#req_land 1
#msg "A skilled engineer has arrived with a squad of mechanical constructs. He offers to reinforce your walls in exchange for access to your highly productive workshops."
#nation -2
#com 1606
#6d6units 532
#defence 15
#end

#newevent
#id 5098
#rarity 1
#req_magic 4
#req_land 1
#msg "The density of magic has turned every reflective surface into a window to the void. People are being driven mad by the sight of their own spirits being pulled into the glass."
#gainaff 4194304
#unrest 30
#kill 2
#end

#newevent
#id 5099
#rarity 1
#req_order 4
#req_land 1
#msg "The perfect order of the state has become a parasite. Every merchant is required to file their taxes in triplicate using blood-ink, grinding the provincial economy to a stuttering halt."
#taxboost -100
#landgold -15
#unrest -20
#end

#newevent
#id 5100
#rarity -1
#req_cold 5
#req_cave 1
#msg "A master of the high frost has emerged from the caves. He offers to temper your garrison’s blades in the absolute zero of the deep tunnels."
#magicitem 2
#defence 10
#2d6vis 2
#end

#newevent
#id 5101
#rarity 1
#req_growth 5
#req_cave 1
#msg "The explosive growth in the tunnels has birthed a breed of sentient, aggressive mushrooms. They are currently hunting the miners and clogging the air-shafts."
#kill 10
#disease 5
#com 1005
#4d6units 313
#end

#newevent
#id 5102
#rarity -2
#req_land 0
#req_magic 5
#msg "The pressure of the deep sea has birthed a hero of coral and iron. He has pledged his monstrous strength to the master of the lightless deeps."
#nation -2
#com 438
#addequip 1
#1d6vis 4
#end

#newevent
#id 5103
#rarity -2
#req_land 0
#req_death 5
#msg "The weight of death in the chaotic currents has allowed a pirate king to rise. Finding your realm to his liking, he has brought his ghost-ships to serve you."
#nation -2
#com 1054
#12d6units 676
#gold 400
#end

#newevent
#id 5104
#rarity -2
#req_land 0
#req_unmagic 5
#msg "In the absolute silence of the deep reefs, your mermen have found a way to shield their minds from all magic. They offer their services as elite guardians."
#nation -2
#com 1059
#10d6units 1069
#gainaff 0
#end

#newevent
#id 5105
#rarity -1
#req_prod 5
#req_mountain 1
#msg "A master mason has appeared in the highlands, claiming the high quality of your ore has inspired him to build a castle of mythic proportions."
#fort 3
#nation -2
#com 1606
#gold 200
#end

#newevent
#id 5106
#rarity -2
#req_order 5
#req_luck 3
#msg "In this bastion of law, a holy warrior has been blessed by the spheres. He has risen from the common militia to lead your armies in a crusade of order."
#nation -2
#com 241
#addequip 2
#6d6units 2359
#incdom 5
#end

#newevent
#id 5107
#rarity 2
#req_heat 5
#req_magic 3
#req_waste 1
#msg "The absolute heat of the waste has ignited the very aether. A solar flare has struck the province, incinerating the laboratory and those within."
#kill 25
#lab 0
#1d6vis 0
#unrest 40
#end

#newevent
#id 5108
#rarity 2
#req_cold 5
#req_unluck 3
#req_land 1
#msg "The cold has reached a state of magical feedback. The very air is freezing into jagged shards that fall like rain, shredding the populace."
#kill 40
#incscale2 2
#gold -500
#end

#newevent
#id 5109
#rarity 1
#req_growth 5
#req_chaos 3
#req_forest 1
#msg "Life is growing too fast in this lawless land. The trees have begun to hunt the tax-collectors, and the city walls are being cracked by sentient roots."
#kill 5
#unrest 80
#com 931
#12d6units 361
#end

#newevent
#id 5110
#rarity -1
#req_death 5
#req_order 3
#req_land 1
#msg "In this land of death and order, the skeletal workers have been given a rigid schedule. The efficiency of the dead has bolstered the local production."
#landprod 20
#landgold 10
#incdom 2
#end

#newevent
#id 5111
#rarity -2
#req_magic 5
#req_prod 5
#req_freshwater 1
#msg "High magic and high production have resulted in a lab accident that turned the provincial river into liquid gold for a single night."
#gold 2000
#1d6vis 53
#end

#newevent
#id 5112
#rarity -2
#req_unmagic 5
#req_order 5
#req_land 1
#msg "In a land where magic is purged and law is absolute, an elite order of silent monks has formed to hunt mages."
#nation -2
#com 222
#10d6units 2324
#gainaff 0
#end

#newevent
#id 5113
#rarity -1
#req_heat 5
#req_magic 3
#req_waste 1
#msg "The scorching sun has bleached the bones of a long-dead hero. Through a surge of magic, he has risen to lead his phantom army once more."
#com 533
#6d6units 615
#A600 617
#unrest 40
#end

#newevent
#id 5115
#rarity -2
#req_magic 5
#req_order 2
#req_land 1
#msg "In this bastion of magic and order, the local mages have successfully codified several major rituals into provincial law. This stability has made research significantly easier."
#researchaff 32
#taxboost 50
#decscale 0
#1d6vis 4
#end

#newevent
#id 5116
#rarity 2
#req_magic 5
#req_order 1
#req_land 1
#msg "The absolute power of magic is being used to enforce an unyielding, minor law. The spiritual weight of this 'arcane justice' is crushing the will of the inhabitants, turning them into joyless servants."
#kill 5
#unrest -50
#incdom -2
#decscale 0
#end

#newevent
#id 5117
#rarity -2
#req_magic 5
#req_chaos 2
#req_land 1
#msg "Total magical saturation has combined with a slight lack of order to create a month-long celebration of wonder. The sheer creative energy has manifested as a surge of diverse magical gems."
#2d6vis 53
#gold 400
#incpop 50
#incscale 0
#end

#newevent
#id 5118
#rarity 1
#req_magic 5
#req_chaos 1
#req_land 1
#msg "A minor social disturbance has caused a local mage to lose control of the absolute magic in the air. A localized rift has opened, and a horror has emerged to feed on the 'chaotic' aether."
#com 308
#unrest 40
#kill 5
#incscale 0
#end

#newevent
#id 5119
#rarity -2
#req_magic 5
#req_prod 2
#req_land 1
#msg "The high mana of the province has begun to inhabit the local tools. Hammers strike with magical precision, and the workshops are producing goods that seem to glow with internal light."
#landprod 20
#gold 300
#magicitem 2
#decscale 1
#end

#newevent
#id 5120
#rarity 1
#req_magic 5
#req_prod 1
#req_land 1
#msg "The intense magical energy of the province has reacted poorly with the local industry. A series of 'unlucky' explosions has leveled several workshops as the machines tried to absorb too much power."
#kill 5
#gold -500
#landprod -10
#decscale 1
#end

#newevent
#id 5121
#rarity -2
#req_magic 5
#req_sloth 2
#req_land 1
#msg "The profound stillness of the province has allowed the local mages to enter a state of shared dreaming. A reclusive Mystic has emerged from the aether to share these secrets."
#nation -2
#com 311
#incscale 1
#1d6vis 4
#end

#newevent
#id 5122
#rarity 2
#req_magic 5
#req_sloth 1
#req_land 1
#msg "The absolute magic in the air has become so heavy and thick that the people have simply stopped moving. Their souls are being slowly absorbed into the background radiance of the province."
#kill 10
#incdom -4
#landgold -15
#incscale 1
#end

#newevent
#id 5123
#rarity -2
#req_magic 5
#req_heat 2
#req_waste 1
#msg "The mild summer heat has been focused by the intense magic of the region. The very sunlight is being distilled into fire rubies by a group of industrious solar-acolytes."
#2d6vis 0
#gold 200
#decscale 2
#end

#newevent
#id 5124
#rarity 2
#req_magic 5
#req_heat 1
#req_land 1
#msg "The magical resonance of the province has amplified the heat into a lethal frequency. A flash-fire of pure aether has struck the town square, incinerating the populace."
#kill 20
#unrest 50
#decscale 2
#lab 0
#end

#newevent
#id 5125
#rarity -2
#req_magic 5
#req_cold 2
#req_mountain 1
#msg "The crisp winter cold has caused the saturated magic in the air to crystallize. Shards of pure water-magic are being harvested from the eaves of every house."
#2d6vis 2
#gold 300
#incscale 2
#end

#newevent
#id 5126
#rarity 1
#req_magic 5
#req_cold 1
#req_land 1
#msg "The magical saturation has reacted with the winter chill, creating a zone of absolute zero. The very air has frozen solid, shattering the lungs of several unfortunate inhabitants."
#kill 10
#unrest 20
#incscale 2
#end

#newevent
#id 5127
#rarity -2
#req_magic 5
#req_growth 2
#req_forest 1
#msg "Nature is thriving on the absolute magic of the province. The trees are growing fruit that glows with internal light, and the local herbalists have found a cure for every known malady."
#disease -20
#incpop 200
#3d6vis 6
#decscale 3
#end

#newevent
#id 5128
#rarity 1
#req_magic 5
#req_growth 1
#req_lab 1
#msg "The explosive growth of the land has begun to feed on the magical laboratory. Sentient, mana-hungry vines are currently strangling the researchers and draining your gems."
#kill 2
#gemloss 53
#unrest 30
#decscale 3
#end

#newevent
#id 5129
#rarity -2
#req_magic 5
#req_death 2
#req_land 1
#msg "The weight of death in the province has reached a state of magical harmony. The shades of the ancestors have risen to share their ancient wisdom with your mages."
#researchaff 32
#nation -2
#com 181
#incscale 3
#end

#newevent
#id 5130
#rarity 2
#req_magic 5
#req_death 1
#req_lab 1
#msg "A powerful spirit has been drawn to the intense magical radiance. It is currently haunting the laboratory, feeding on the intellect of your scholars."
#kill 5
#researchaff 33554432
#com 181
#incscale 3
#end

#newevent
#id 5131
#rarity -2
#req_magic 5
#req_heat 2
#req_land 0
#msg "In the deep ocean, the absolute magic has caused the thermal vents to glow with a brilliant, intelligent light. Your mermen are gaining profound insights into the nature of the abyss."
#research 300
#2d6vis 0
#decscale 2
#end

#newevent
#id 5132
#rarity 2
#req_magic 5
#req_heat 1
#req_land 0
#msg "The magical saturation has superheated the deep currents. A sudden surge of steam has cooked the local kelp forest and the mermen who tended it."
#kill 25
#taxboost -100
#decscale 2
#end

#newevent
#id 5133
#rarity -2
#req_magic 5
#req_cold 2
#req_land 0
#msg "The absolute cold of the sea-floor has caused the magic to harden into shards of permanent ice. These gems are being harvested by your mermen to power their enchantments."
#3d6vis 2
#gold 200
#incscale 2
#end

#newevent
#id 5134
#rarity 1
#req_magic 5
#req_cold 1
#req_land 0
#msg "The magical saturation has created a localized deep-freeze in the merman capital. Several prominent citizens have been frozen in blocks of 'arcane' ice."
#kill 5
#unrest 15
#incscale 2
#end

#newevent
#id 5135
#rarity -2
#req_magic 5
#req_prod 2
#req_cave 1
#msg "In the deep caves, the magic of the rocks has hit a perfect frequency. The miners find that the stones speak to them, guiding them to rich veins of precious metals."
#landgold 40
#gold 600
#decscale 1
#end

#newevent
#id 5136
#rarity 2
#req_magic 5
#req_prod 1
#req_cave 1
#msg "The intense magical resonance has caused the cave walls to vibrate with destructive force. A series of 'arcane' tremors has buried a major mining operation."
#kill 30
#gold -800
#landprod -20
#decscale 1
#end

#newevent
#id 5137
#rarity -2
#req_magic 5
#req_sloth 2
#req_cave 1
#msg "The damp stillness of the caves and the high mana have produced a breed of mushroom that secretes liquid magic. Your mages are currently harvesting the glowing sap."
#4d6vis 4
#researchaff 1
#incscale 1
#end

#newevent
#id 5138
#rarity 1
#req_magic 5
#req_sloth 1
#req_cave 1
#msg "The absolute magic in the tunnels has mutated the local fungi. The miners are breathing in magical spores that cause them to see non-existent monsters and attack one another."
#kill 10
#unrest 60
#incscale 1
#end

#newevent
#id 5139
#rarity -2
#req_magic 5
#req_growth 2
#req_swamp 1
#msg "The stagnant wetlands are shimmering with a wild, magical beauty. The very miasma has turned into a source of arcane power, attracting loyal spirits to your banner."
#1d6vis Elemental
#nation -2
#com 579
#decscale 3
#end

#newevent
#id 5140
#rarity 2
#req_magic 5
#req_growth 1
#req_swamp 1
#msg "The high growth and high magic of the swamp have created a toxic, magical fog. Those who breathe it are transformed into formless abominations that dissolve in the mud."
#kill 15
#disease 10
#decscale 3
#com 966
#end

#newevent
#id 5141
#rarity -2
#req_magic 5
#req_death 2
#req_waste 1
#msg "In the shimmering waste, the magic has preserved the souls of the long-dead. A spectral Sage has risen from the sand, offering Chilling insights to the master of this land."
#nation -2
#com 329
#gold 400
#incscale 3
#magicitem 3
#end

#newevent
#id 5142
#rarity 1
#req_magic 5
#req_death 1
#req_waste 1
#msg "The absolute magic of the waste has reacted with the density of death. A spontaneous explosion of necrotic energy has scoured a local oasis, leaving only ash and bone."
#kill 5
#incscale 3
#unrest 20
#incscale 3
#end

#newevent
#id 5143
#rarity -1
#req_magic 5
#req_order 2
#req_fort 1
#msg "The local governor has successfully used the high mana of the province to 'anchor' the fortress walls. The structure now hums with a protective, magical frequency."
#defence 20
#unrest -20
#decscale 0
#end

#newevent
#id 5146
#rarity 2
#req_unmagic 5
#req_order 1
#req_land 1
#msg "The lack of magic has birthed a fanatical fear of the unusual. A mob has burned the local library and beaten the researchers into a state of witless terror."
#lab 0
#researchaff 33554432
#unrest 40
#decscale 0
#end

#newevent
#id 5149
#rarity -2
#req_unmagic 4
#req_prod 2
#req_mountain 1
#msg "Free from the distractions of magic, the local craftsmen have focused entirely on mechanical engineering. A reclusive Master Artificer has arrived to oversee your iron-works."
#nation -2
#com 1073
#landprod 30
#decscale 1
#end

#newevent
#id 5151
#rarity 1
#req_unmagic 4
#req_sloth 2
#req_land 1
#msg "A wave of profound lethargy has hit the province. Without the flicker of magic to excite the mind, the local scholars have fallen into a deep, feeble sleep."
#landgold -15
#researchaff 33554432
#incscale 1
#end

#newevent
#id 5152
#rarity 2
#req_unmagic 5
#req_sloth 1
#req_land 1
#msg "The vacuum of magic has reached a point where the people are beginning to forget how to speak. The researchers sit in the lab in a state of absolute, mindless apathy."
#kill 20
#researchaff 33554432
#researchaff 33554432
#incscale 1
#end

#newevent
#id 5156
#rarity 1
#req_unmagic 4
#req_cold 1
#req_land 1
#msg "The combination of unmagic and extreme cold has made the researchers as fragile as ice. Every minor setback in the lab leads to a total mental collapse."
#kill 10
#researchaff 33554432
#incscale 2
#end

#newevent
#id 5157
#rarity -2
#req_unmagic 5
#req_growth 2
#req_land 1
#msg "In this land where magic does not reach, the people have grown uncommonly robust and self-reliant. A group of hale young villagers and their leader have joined the militia."
#incpop 200
#defence 15
#nation -2
#com 1565
#12d6units 1565
#decscale 3
#end

#newevent
#id 5160
#rarity 2
#req_unmagic 4
#req_death 1
#req_land 1
#msg "A series of natural deaths has been blamed on 'invisible mages.' The unmagic-saturated populace has gone into a frenzy, leaving the local researchers witless and broken."
#kill 15
#researchaff 33554432
#unrest 60
#incscale 3
#end

#newevent
#id 5161
#rarity -2
#req_unmagic 5
#req_order 2
#req_land 0
#msg "The ocean currents have grown silent and sparkless. A disciplined Merman Commander has organized the local reefs into a highly coordinated defensive network."
#land 0
#nation -2
#com 1519
#defence 20
#decscale 0
#end

#newevent
#id 5164
#rarity 1
#req_unmagic 5
#req_sloth 1
#req_land 0
#msg "The mermen in this unmagic zone have become uncommonly sluggish. Without the pulse of the reefs, the scholars have lost their edge and fallen into a stupor."
#taxboost -80
#researchaff 33554432
#incscale 1
#end

#newevent
#id 5166
#rarity 1
#req_unmagic 5
#req_sloth 1
#req_cave 1
#msg "The miners in the unmagic tunnels are being driven mad by the silence. The mages are suffering similarly, their minds breaking in the spiritual vacuum."
#kill 5
#researchaff 33554432
#landprod -20
#incscale 1
#end

#newevent
#id 5169
#rarity -2
#req_unmagic 5
#req_order 2
#req_land 1
#msg "The total lack of magic has forced the local monks to rely on pure physical discipline. A Master of the Silent Way has arrived to offer his magic-resistant service."
#nation -2
#com 2324
#10d6units 2324
#decscale 0
#gainaff 0
#end

#newevent
#id 5171
#rarity 1
#req_unmagic 4
#req_chaos 1
#req_land 1
#msg "A minor social turmoil has combined with the heavy unmagic of the region. A mob has gathered to lynch the local scholars and burn their books, leaving the survivors feeble."
#kill 5
#researchaff 33554432
#unrest 40
#incscale 0
#end

#newevent
#id 5175
#rarity -1
#req_order 4
#req_land 1
#msg "The law in this province is respected by all. The local prefecture has become a model of efficiency, returning a significant surplus to the national treasury."
#gold 500
#taxboost 100
#unrest -20
#end

#newevent
#id 5176
#rarity -2
#req_order 5
#req_land 1
#msg "The province has reached a state of fanatical devotion to your law. A legendary High Inquisitor has arrived to lead a purge of all dissent, making your word absolute."
#incdom 8
#unrest -100
#nation -2
#com 222
#16d6units 149
#12d6units 2359
#end

#newevent
#id 5177
#rarity 2
#req_order 5
#req_land 1
#msg "Absolute order has turned into absolute tyranny. The local courts are executing people for the slightest infraction, and the streets are silent with terror."
#kill 20
#taxboost -200
#unrest -100
#incdom -5
#end

#newevent
#id 5178
#rarity -1
#req_chaos 4
#req_land 1
#msg "In this land of minimal law, individual enterprise is thriving. A group of wealthy merchants has donated to the crown to ensure their continued freedom."
#gold 600
#landgold 15
#decscale 4
#end

#newevent
#id 5179
#rarity 2
#req_chaos 5
#req_land 1
#msg "Chaos has reached a tipping point. A ruthless warlord has united the local gangs into a private army and declared the province independent."
#revolt 1
#com 147
#16d6units 139
#6d6units 140
#unrest 200
#end

#newevent
#id 5180
#rarity -1
#req_prod 4
#req_land 1
#msg "A reclusive master mason has been drawn to the incredible output of your workshops. He offers to reinforce your fortifications."
#nation -2
#com 1606
#defence 15
#gold 200
#end

#newevent
#id 5181
#rarity -2
#req_prod 5
#req_land 1
#msg "The pinnacle of industry has been reached. A legendary architect has arrived to oversee the construction of a monument that will be the envy of the world."
#nation -2
#com 1606
#fort 3
#landprod 30
#gold 500
#end

#newevent
#id 5182
#rarity 2
#req_prod 5
#req_land 1
#msg "The frantic push for production has poisoned the soil. The air is a thick, grey soot that is killing the workers and the elderly."
#kill 15
#disease 10
#landprod -20
#gold -500
#end

#newevent
#id 5183
#rarity -1
#req_sloth 4
#req_land 1
#msg "The profound stillness of the province has allowed the local mages to touch the aether in their sleep. They have returned with deep wisdom."
#gainresearch 300
#1d6vis 4
#end

#newevent
#id 5184
#rarity 2
#req_sloth 5
#req_land 1
#msg "Apathy has become a terminal disease. The people have simply stopped eating or waking up, their souls evaporating into a sparkless void."
#kill 50
#incdom -5
#researchaff 33554432
#end

#newevent
#id 5185
#rarity -1
#req_heat 4
#req_waste 1
#msg "The summer heat has hit a perfect frequency, causing the sand to crystallize into fire-resonant gems."
#3d6vis 0
#gold 200
#end

#newevent
#id 5186
#rarity -2
#req_heat 5
#req_land 1
#msg "A Firelord has been impressed by the blinding radiance of your province. He has sent his personal guard to ensure the flame never dies."
#nation -2
#com 818
#10d6units 528
#incdom 3
#end

#newevent
#id 5187
#rarity -1
#req_cold 4
#req_land 1
#msg "The steady, crisp cold has perfectly preserved the local harvest. An audit has found enough grain to feed the army for years."
#gold 400
#taxboost 100
#unrest -10
#end

#newevent
#id 5188
#rarity -2
#req_cold 5
#req_land 1
#msg "The absolute zero of the frost has been harnessed. Ancient frost-smiths have raised a shimmering fortress of permanent ice in your name."
#fort 15
#nation -2
#com 844
#12d6units 1202
#2d6vis 2
#end

#newevent
#id 5189
#rarity 1
#req_growth 4
#req_land 1
#msg "Life is growing with an aggressive, sickening speed. Every minor wound is becoming a garden of parasitic, non-magical mushrooms."
#disease 15
#kill 5
#unrest 20
#end

#newevent
#id 5190
#rarity -2
#req_growth 5
#req_land 1
#msg "Nature has reached a state of aggressive sentience. Vines and iron-wood have woven themselves into a massive, living fortification."
#fort 12
#nation -2
#com 931
#10d6units 361
#1d6units 362
#end

#newevent
#id 5191
#rarity -1
#req_death 4
#req_land 1
#msg "Death is not feared here, but embraced. The spirits of the ancestors have risen to maintain the shrines and guard the living."
#nation -2
#com 181
#6d6units 676
#incdom 2
#end

#newevent
#id 5192
#rarity 2
#req_death 5
#req_land 1
#msg "The absolute weight of death has created a necrotic vacuum. A dry wind is blowing from the graveyards, erasing the memories of the living."
#kill 30
#researchaff 33554432
#incscale2 3
#end

#newevent
#id 5193
#rarity 1
#req_magic 4
#req_land 1
#msg "The saturation of magic is inducing a state of frantic movement. The people are dancing themselves to death in a frenzy of power."
#kill 5
#unrest 60
#gainaff 4194304
#end

#newevent
#id 5194
#rarity 2
#req_magic 5
#req_land 1
#msg "The magical saturation has become unstable. A rift has opened, and creatures from the void are pouring through to feed on the mana."
#kill 20
#com 308
#4d6units 88
#lab 0
#end

#newevent
#id 5195
#rarity -1
#req_unmagic 4
#req_land 1
#msg "In this land without magic, the people have developed a sturdy, physical self-reliance. The local militia is uncommonly robust."
#incpop 100
#defence 15
#gainaff 0
#end

#newevent
#id 5196
#rarity -2
#req_unmagic 5
#req_land 1
#msg "The absolute silence of the unmagic zone has granted your soldiers a chilling mental resilience. They can now shrug off spells through sheer will."
#nation -2
#com 2324
#12d6units 2324
#gainaff 0
#end

#newevent
#id 5197
#rarity -2
#req_order 5
#req_land 1
#msg "In this bastion of law, the local garrison has become a machine of perfect coordination. Every citizen is a soldier, and your word is God."
#defence 30
#taxboost 100
#incdom 4
#1d6vis 4
#end

#newevent
#id 5198
#rarity -2
#req_prod 5
#req_land 1
#msg "Absolute industry has attracted a master artificer. He has built a self-maintaining clockwork engine to oversee your workshops."
#nation -2
#com 1073
#landprod 50
#gold 400
#end

#newevent
#id 5199
#rarity 2
#req_heat 5
#req_land 1
#req_turn 15
#msg "The relentless sun has ignited the very soil. The province has become a wasteland of smoke and bone where nothing can grow."
#kill 40
#landprod -100
#incscale 3
#fort 0
#end

#newevent
#id 5200
#rarity 2
#req_cold 5
#req_land 1
#msg "The cold has reached a state of magical feedback. Shards of frozen air are falling like rain, shredding the populace."
#kill 50
#gold -1000
#taxboost -100
#lab 0
#end

#newevent
#id 5201
#rarity -2
#req_death 5
#req_swamp 1
#msg "The rot of the swamp has birthed a strange, beautiful wisdom. A spectral court has risen from the peat to offer their ancient secrets."
#research 400
#nation -2
#com 178
#4d6units 533
#end

#newevent
#id 5202
#rarity -2
#req_magic 5
#req_land 1
#msg "High magic has thinned the veil. A being of pure light has descended to offer its guidance to the master of this radiant land."
#nation -2
#com 651
#addequip 4
#incdom 3
#end

#newevent
#id 5203
#rarity -2
#req_chaos 5
#req_land 1
#msg "Total anarchy has allowed for a level of creative destruction that has supercharged the local economy. Gold is being found in every gutter."
#gold 2000
#landgold 30
#decscale 4
#end

