<?php
$app_data_dir = !empty($_ENV["APPDATA"]) ? $_ENV["APPDATA"] : $_SERVER["APPDATA"];
$app_data_dir = "/home/ilya/.dominions6/";

// launch Domninions with -d flag to create debug log and watch reports you want recreated
$log_path = 'log3.txt';
// use mod inspector to find unit id's
// [TODO] add dependecny using git submodules ?
$mod_inspector_path = __DIR__ . DIRECTORY_SEPARATOR . "dom6inspector" . DIRECTORY_SEPARATOR  .  "gamedata" . DIRECTORY_SEPARATOR;

$units_file = $mod_inspector_path . 'BaseU.csv';
$spells_file = $mod_inspector_path . 'spells.csv';
$items_file = $mod_inspector_path . 'BaseI.csv';

// mods for new units (WH in this case)
// TODO add linux suport ?
$mods = [
	//'/home/ilya/.dominions5/mods/StoneSoupAuction Nations 0.641.dm',                                                           
	//'/home/ilya/.dominions5/mods/DomEnhanced1_84.dm', "/home/ilya/.dominions5/mods/SparkOfDivinity_Enhanced1_2.dm", "/home/ilya/.dominions5/mods/AuxiliaryEmpires0.70wspf.dm", "/home/ilya/.dominions5/mods/bozmod_1.542_lite_dsp.dm"
//	$app_data_dir . "\Dominions5\mods\WH_6_25.dm"                                                                                                
];
$debug_mod_location =  $app_data_dir . "mods/111/Debug_509_nor.dm";

$debug_mod_template = __DIR__ . "/Debug_509_nor.dm";

$gcost_file = __DIR__ . "/gcost.csv";

$gcosts_h = fopen($gcost_file, 'r');

$gcost_map = array();
while (($line = fgetcsv($gcosts_h, 1000, "\t")) !== FALSE) {
  //$line is an array of the csv elements
  $gcost_map[$line[0]] = $line[1];
}


echo "Usage: change the code to write a spells generating armies (see \$battle_meta)
OR launch dominions with debug flag and watch reports/battles and script will generate armies from log files\n\n";

// 0 attacker (wont generate)
// 1 attacker left 
// 2 defender (wont generate)
// 3 defender lef
// 4 pd 


$battle_meta = [
	'my_defenders' => ['start' => -1, 'prov' => "custom", 
		'armies' => [
			1 => [
				['name' => "Son of Heaven", 'coms' => 1, 'units' => 0, 'autocast' => "Mist,Wind Guide"],
				['name' => "Daughter of the Sun", 'coms' => 1, 'units' => 0, 'autocast' => "Heat from Hell"],
				['name' => "Rusian Hunter", 'coms' => 0, 'units' => 75],
				['name' => "Chud Berserker", 'coms' => 0, 'units' => 6],
				['name' => "Rusian Hunter", 'coms' => 0, 'units' => 27],
				//['name' => "Chud Skinshifter", 'coms' => 0, 'units' => 50],
				['name' => "Chud Skinshifter", 'coms' => 0, 'units' => 10],
				['name' => 'Great Bear', 'coms' => 0, 'units' => 90, 'id' => 3003],
				['name' => 'Alkonost', 'coms' => 1, 'units' => 0, 'autocast' => "Flaming Arrows"],
				['name' => 'Slinger', 'coms' => 0, 'units' => 80],
				
				
				//['name' => "Militia", 'coms' => 0, 'units' => 30],
				//['name' => "Light Cavalry", 'coms' => 0, 'units' => 30],
				
				//['name' => "Firebird", 'coms' => 0, 'units' => 40],
				//['name' => "Rusian Warrior", 'coms' => 0, 'units' => 20],
				//['name' => "Footman", 'coms' => 0, 'units' => 120, 'id' => 928 ],
				
				
				
				//['name' => 'Sirin', 'coms' => 1, 'units' => 0],
				//['name' => 'Daughter of the Sun', 'coms' => 4, 'units' => 0],
				
				//['name' => "Ettin", 'coms' => 0, 'units' => 1],
				//['name' => "Foul Spawn", 'coms' => 0, 'units' => 30, 'id'],
				//['name' => "Heavy Infantry", 'coms' => 0, 'units' => 10],
				//['name' => "Woodsman Blowpipe", 'coms' => 0, 'units' => 30],
				//['name' => "Vine Man", 'coms' => 0, 'units' => 30],
				//['name' => "Militia", 'coms' => 0, 'units' => 20],
				//['name' => "White Centaur", 'coms' => 0, 'units' => 80],
				//['name' => "Satyr", 'coms' => 0, 'units' => 300],
				//['name' => "Archer", 'coms' => 0, 'units' => 300],
				//['name' => "Crossbowman", 'coms' => 0, 'units' => 15]
				//['name' => "Wolf Tribe Archer", 'coms' => 0, 'units' => 80],
				//['name' => "Wolf Tribe Warrior", 'coms' => 0, 'units' => 80]
				                                 
			],
			3 => [
				/*2+0 0+0 Woodhenge Druid (0 0)
  0:  0+0 4+0 Atavi Archer (0 0)
  0:  0+0 443+0 Helote Peltast (0 0)
  0:  0+0 101+0 Neodamode Peltast (0 0)
  0:  0+0 82+0 Gigante Hoplite (0 0)
  0:  1+0 0+0 Lochos (0 0)
  0:  6+0 0+0 Polemarch (0 0)
  0:  5+0 0+0 Ephor (0 0)
*/
				
				['name' => "Polemarch", 'coms' => 6, 'units' => 0, 'items' => "Helmet of Heroes"],
				['name' => "Ephor", 'coms' => 5, 'units' => 0, 'items' => 'Fire in a Jar'],
				['name' => "Woodhenge Druid", 'coms' => 5, 'units' => 0, 'items' => 'Fire in a Jar'],
								

				//['name' => "Sleeper", 'coms' => 4, 'units' => 0],
				//['name' => "Sleeper", 'coms' => 2, 'units' => 0],
				//['name' => "Assassin", 'coms' => 1, 'units' => 0],
				//['name' => "Forest Troll", 'coms' => 1, 'units' => 10],
				//['name' => "Dai Oni", 'coms' => 1, 'units' => 0],
				//['name' => "Gigante Hoplite", 'coms' => 0, 'units' => 10],
				//['name' => "Polemarch", 'coms' => 10, 'units' => 0],
				//['name' => "Lochos", 'coms' => 1, 'units' => 0],
				//['name' => "Kryptes", 'coms' => 5, 'units' => 0],
				//['name' => "Geronte", 'coms' => 1, 'units' => 0],
				//['name' => "Horse Tribe Cavalry", 'coms' => 1, 'units' => 50],
				['name' => "Gigante Hoplite", 'coms' => 0, 'units' => 82],
				//['name' => "Clockwork Soldier", 'coms' => 0, 'units' => 20],
				//['name' => "Gigante Ekdromos", 'coms' => 0, 'units' => 10],
				//['name' => "Machaka Archer", 'coms' => 0, 'units' => 80],
				['name' => "Helote Peltast", 'coms' => 0, 'units' => 443],
				['name' => "Neodamode Peltast", 'coms' => 0, 'units' => 101],
				
				//['name' => "Cu Sidhe", 'coms' => 0, 'units' => 80],
				
				//['name' => "Fir Bolg Warrior", 'coms' => 1, 'units' => 30],
				//['name' => "Fir Bolg Slinger", 'coms' => 1, 'units' => 30],
				//['name' => "Fir Bolg Militia", 'coms' => 1, 'units' => 30],
				
				//['name' => "Knight of the Chalice", 'coms' => 0, 'units' => 80],
				//['name' => "Flagellant", 'coms' => 0, 'units' => 200],
				//['name' => "Man at Arms", 'coms' => 0, 'units' => 200],
				//['name' => 'Rusian Chieftain', 'coms' => 1, 'units' => 0],
				//['name' => 'Chud Skinshifter', 'coms' => 0, 'units' => 10],
				//['name' => 'Rusian Hunter', 'coms' => 0, 'units' => 9],

				//['name' => "Rusian Warrior", 'coms' => 0, 'units' => 11],
				//['name' => 'Black Priest', 'coms' => 1, 'units' => 0],
				//['name' => 'Hochmeister', 'coms' => 4, 'units' => 0],
				//['name' => 'Black Templar', 'coms' => 0, 'units' => 20],
				//['name' => 'Ranger of Ulm', 'coms' => 3, 'units' => 7],
				//['name' => 'Fortune Teller', 'coms' => 2, 'units' => 0],
				//['name' => 'Wolf', 'coms' => 0, 'units' => 40],
				
			]
			                                                           
//			3 => [
//				['name' => 'Soldier Priest', 'coms' => 1, 'units' => 18],
//				['name' => 'Archer Priest', 'coms' => 1, 'units' => 7],
//			]         
		]
	],                 
	'fbirds' => ['start' => -1, 'prov' => "custom",
                'armies' => [
                        1 => [
                                ['name' => "Firebird", 'coms' => 0, 'units' => 40],
                                //['name' => "Barbarian", 'coms' => 0, 'units' => 40],

                        ],
                        3 => [
                                ['name' => 'Barbarian Heavy Horseman', 'coms' => 0, 'units' => 4],
                        ]
                ]
        ],
    'blitz' => ['start' => -1, 'prov' => "custom",
                'armies' => [
                        1 => [
                        		['name' => 'Flame Spirit', 'coms' => 1, 'units' => 0],
                                ['name' => "Ichtyid Lord", 'coms' => 1, 'units' => 0],
                                ['name' => "Ichtyid Shaman", 'coms' => 1, 'units' => 0],
                                ['name' => "Solar Serpent", 'coms' => 1, 'units' => 0],
                                ['name' => 'Fire Snake', 'coms' => 0, 'units' => 84],
                                ['name' => "Horned Serpent", 'coms' => 0, 'units' => 61],
                                ['name' => "Ichtyid", 'coms' => 0, 'units' => 41],
                                ['name' => "Ichtyid Warrior", 'coms' => 0, 'units' => 66],
                                ['name' => "Scorpion Beast", 'coms' => 0, 'units' => 56],
                                ['name' => "Will o' the Wisp", 'coms' => 0, 'units' => 49],

                        ],
                        3 => [
                                ['name' => 'Palankasha', 'coms' => 0, 'units' => 36],
                                ['name' => 'Atavi Archer', 'coms' => 0, 'units' => 58],
                                ['name' => 'Bandar Archer', 'coms' => 0, 'units' => 20],
                                ['name' => 'Raksharaja', 'coms' => 1, 'units' => 0, 'autospell' => 'Divine Bleessing'],
                        ]
                ]
        ],
	# todo add mpaths and gear 
];

$units_lookup = [];

foreach ($mods as $mod)
{
	$content = file_get_contents($mod);
	
	preg_match_all("~#newmonster\s*([0-9]*)\s.*?#name \"([a-zA-Z\s]*)~sm", $content, $matches);
	
	foreach ($matches[1] as $k => $v)
	{
		$name = $matches[2][$k];
		$id = $v;
		$units_lookup[$name] = ['id' => $id, 'sum_cost' => 10000];
	}
	
}
                                                                                                                      
$row = 0;
if (($handle = fopen($units_file, "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 100000, "\t")) !== FALSE) {
        $num = count($data);
        //var_dump($data);die;
		// 0 - id
		// 1 - name
		// 15 basecost
		// 16 rcost
		$id = $data[0];
		$name = $data[1];
		$cost = $data[15];
		$rcost = $data[16];
		$holycost = $data[488] ?  $data[488] : 0  ;
		if ($row != 0)
		{
			// consider beingsacred 5 gold more valuable
			$sum = intval($cost) + intval($rcost) + $holycost * 5;
			
			if (empty($units_lookup[$name]))
			{
				$units_lookup[$name] = ['id' => $id, 'name' => $name, 'gcost' => $cost, $rcost => $rcost, 'sum_cost' => $sum];
			}
			// assume costliest unit(worts case scenariot) is the one we would encounter (pass ERA later)
			if (!empty($units_lookup[$name]) && $units_lookup[$name]['sum_cost'] <= $sum)
			{
				$units_lookup[$name] = ['id' => $id, 'name' => $name, 'gcost' => $cost, 'rcost' => $rcost, 'sum_cost' => $sum];
			}
			$units_lookup[$id] = $units_lookup[$name];
		}
		
		$row++;
    }
    fclose($handle);
}

//unit auto-tests spells
$sacred_test = [
	// recruitanywhere
	727 => 26,
	845 => 140,
	1326 => 27,
	1469 => 40,
	1488 => 40,
	1495 => 40,
	1763 => 50,
	2837 => 20,
	2490 => 50,
	
	//
	3110 => 40,
	3101 => 10,
	
	// palanksha
	1747 => 55,
	
	// burning one
	1543 => 70,
	
	// yavan archer
	1328 => 30,
	1327 => 35,
	1130 => 16,

	// minotaur
	234 => 40,
	
	// elephant
	2307 => 80,
	// chud berserker
	2994 => 35,
	// chud skinshifter
	2997 => 65,
	// guardian
	66 => 20,
	// elfs
	1503 => 55,
	// burning one
	1543 => 70,
	
	// kotc
	135 => 60,
	// rephalite
	2030 => 100,
	// andromania
	3847 => 0,
	// mekone
	3150 => 0,
	// ulm zwehainder
	1034 => 0
];

$test_gold = 1500;

foreach ($sacred_test as $unit_id => $gcost)
{
	$gcost_real = ($gcost ? $gcost :  ($gcost_map[$unit_id] ? $gcost_map[$unit_id] : $units_lookup[$unit_id]['gcost']));
	
	$cnt = intval(ceil($test_gold / $gcost_real));
	$name = $units_lookup[$unit_id]['name'];
	
	$battle_meta["$name"] = ['start' => -1, 'prov' => "custom_$unit_id", 
		'armies' => [
			1 => [
				['name' => "Polemarch", 'coms' => 1, 'units' => 0, 'autocast' => "Sermon of Courage,Divine Blessing", 'items' => "Crown of Command,Horn of Valor", 'hold' => 1],
				['name' => $name, 'id' => $unit_id, 'coms' => 0, 'units' => $cnt],
	]]];
}


$spells_lookup = [];

$row = 0;
if (($handle = fopen($spells_file, "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, "\t")) !== FALSE) {
        $num = count($data);
		$id = $data[0];
		$name = $data[1];
		$spells_lookup[$name] = $id;		
		$row++;
    }
    fclose($handle);
}

$items_lookup = [];

$row = 0;
if (($handle = fopen($items_file, "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, "\t")) !== FALSE) {
        $num = count($data);
		$id = $data[0];
		$name = $data[1];
		$items_lookup[$name] = $id;		
		$row++;
    }
    fclose($handle);
}


//var_dump(array_keys($units_lookup));die;

if (file_exists($log_path)) {
	echo "USING LOG!\n";
	$lines = file($log_path);

	$cnt = count($lines);

	$bttl_start = "getbattlecount: seed";

	$k = -1;
	$in_battle_step = 0;

	$matches = [];

	for ($i = 0; $i < $cnt; $i++)
	{
		$line = $lines[$i];
		if (strpos($lines[$i], $bttl_start) !== false)
		{
			if (empty($battle_meta[$k]['armies']))
			{
				//var_dump("UNSET $k");
				//var_dump($battle_meta[$k]);
				unset($battle_meta[$k]);
			}
			$in_battle_step = 1;
			while (!(empty($battle_meta[$k])))
			{
				$k++;
			}
			if (preg_match("~lnr ([0-9]+),~", $lines[$i], $matches) === false)
			{
				var_dump(__LINE__, $matches, $lines[$i]); die();
			}
			$prov = $matches[1];
			$battle_meta[$k] = ['start' => $i, 'prov' => $prov, 'armies' => []];		
		}
		if (preg_match("~getbattlecountfromvcr~", $lines[$i]) && $in_battle_step == 1)
		{
			$battle_meta[$k]['armies'] = [];
			$in_battle_step = 2;
			//var_dump([$i, $k]);
			continue;
		}
		
		if ($in_battle_step == 2)
		{		
			//   0:  0 15 Sea Troll (0 0)
			if (preg_match("~\s*([0-9]):\s*([0-9\+]*)\s*([0-9\+]*)\s*([A-Za-z\s]*)~", $lines[$i], $matches)) {
				//var_dump($matches);
				$army = $matches[1];
				$coms = 1*explode('+', $matches[2])[0];
				$units = 1*explode('+', $matches[3])[0];
				$name = trim($matches[4]);
				$name = preg_replace('~\s^~', '', $name);
				
				
				
				if (empty($battle_meta[$k]['armies'][$army])) {
					$battle_meta[$k]['armies'][$army] = [];
				}
				
				//var_dump("SET $k");
				$battle_meta[$k]['armies'][$army][] = ['name' => $name, 'coms' => $coms, 'units' => $units];
				//var_dump($battle_meta[$k]['armies'][$army]);die;
			} else {
				$battle_meta[$k]['end'] = $i;
				$tmp = $battle_meta[$k];
				unset($battle_meta[$k]);
				$prov = $tmp['prov'];
				$battle_meta[$prov] = $tmp;
				$in_battle_step = 0;
			}		
		}
	}
} else {
	echo "NO LOG FILE: $log_path\n";
}

var_dump(array_keys($battle_meta));
//echo var_export($battle_meta, true);


$uniq = 0;
$spells = [];

$item_id = 5000;
$monster_id = 5000;

foreach ($battle_meta as $prov_id => $info)
{	
	if (strlen($prov_id) >= 12)
	{
		$prov_id = substr($prov_id, 0, 12);
	}
	
	// 0 attacker
	// 1 attacker left
	// 2 defender
	// 3 defender lef
	// 4 pd ?
	foreach ($info['armies'] as $i => $units)
	{
		$prefix = '_' . $prov_id;
		if (/*$i == 0/* ||*/ $i == 2) 
		{
			continue;
		}
		if ($i == 0) {
			$spell_name = 'Summon Attacker_pre_' . $prov_id;
			$prefix = 'a_' . $prov_id . '_';
		}
		if ($i == 1) {
			$spell_name = 'Summon Attacker_' . $prov_id;
			$prefix = 'a_' . $prov_id . '_';
		}
		
		if ($i == 3) {
			$spell_name = 'Summon Defenders_' . $prov_id;
			$prefix = 'd_' . $prov_id . '_';
		}
		if ($i == 4) {
			$spell_name = 'Summon PD_' . $prov_id;
			$prefix = 'pd_' . $prov_id . '_';
		}
		
		if (empty($spells[$spell_name]))
		{
			$spells[$spell_name] = [];
		}
		
		$prev_name = "";
		
		foreach ($units as $unit)
		{
			$name = $unit['name'];
			$coms = $unit['coms'];
			$num = $unit['units'];
			$autocast = !empty($unit['autocast']) ? $unit['autocast'] : null;
			$items = !empty($unit['items']) ? $unit['items'] : null;
			
			if (empty($name))
				{
				continue;
				}
			
			$unit_id = !empty($unit['id']) ? $unit['id'] : $units_lookup[$name]['id'];

			
			if ($autocast)
			{
				$autocasts = explode(',', $autocast);
				$spell_autocast_ids = array_map(function ($name) use ($spells_lookup) { return $spells_lookup[$name];}, $autocasts);				
			} else {
				$spell_autocast_ids = [];	
			}
			
			if ($items)
			{
				$item_ids = array_map(function ($name) use ($items_lookup) { return $items_lookup[$name];}, explode(',', $items));
				
			} else {
				$item_ids = [];
			}
			
			if ($item_ids || $spell_autocast_ids)
			{
				$spells['monster']["monster_$monster_id"] = "

#selectmonster $monster_id
#copystats $unit_id
\n".
implode('', array_map(function($i) { return "#startitem $i\n";}, $item_ids))
#copystats $unit_id
."\n".
implode('', array_map(function($i) { return "#onebattlespell $i\n";}, $spell_autocast_ids))
// support for 0 cs
.(!empty($unit['hold'])?"\n#ap 1\n":'')
."\n#end
";

$unit_id = $monster_id;

$item_id++;
$monster_id++;
			}
			
						
			if (empty($unit_id))
			{
				die("Unit $name not found");
			}
			
			$spell_internal_name = $prefix . $name . '_' . $uniq;
			
			if (strlen($name) >= 12)
			{
				$name = substr($name, 0, 12);
				$spell_internal_name = $prefix . $name . '_' . $uniq;
			}
			
			if ($num)
			{
				$spells[$spell_name][$spell_internal_name] = "
#newspell
#name \"$spell_internal_name\"
#school -1
#researchlevel 0
#effect 10001
#nreff $num
#damage $unit_id
#spec 8388608
";				

				if ($prev_name) {
					$spells[$spell_name][$spell_internal_name] .= "#nextspell \"$prev_name\"\n";
				}
				$spells[$spell_name][$spell_internal_name] .= "#end\n";
				
				$prev_name = $spell_internal_name;

			} else if ($coms) {
				for ($j = 0; $j < $coms; $j++)
				{
					$spell_internal_name = $prefix . $name . '_' . $uniq . "_" . $j;
					
					$spells[$spell_name][$spell_internal_name] = "
#newspell
#name \"$spell_internal_name\"
#school -1
#researchlevel 0
#effect 10021
#nreff 1
#damage $unit_id
#spec 8388608
";		
					if ($prev_name) {
						$spells[$spell_name][$spell_internal_name] .= "#nextspell \"$prev_name\"\n";
					}
					$spells[$spell_name][$spell_internal_name] .= "#end\n";
					
					$prev_name = $spell_internal_name;
				
				}
			}			
			
			$uniq++;
		}
		
		$spell_internal_name = $prefix . $name . '_' . $uniq;
		
		$spells[$spell_name][$spell_internal_name] = "
#newspell
#name \"$spell_name\"
#descr \"Debug summon test army\"
#path 0 4
#school 0
#researchlevel 0
#pathlevel 0 1
#fatiguecost 100
#effect 10021
#damage 1158 
#spec 8388608
#nextspell \"$prev_name\"
#end
";
	}
}

//var_dump($spells);die;

$spells_text = '';

// generate spells
foreach ($spells as $name => $rows)
{
	foreach ($rows as $text)
	{
		$spells_text .= $text;
	}
}

//echo $spells_text;

// TODO imply research from CASTERS spell or pass from console

// generate debug mod
$content = file($debug_mod_template);

$new_content = "";

$start = false;

for ($i = 0; $i < count($content); $i++)
{
	if (!$start) {
		$new_content .= $content[$i];
	}
	if (trim($content[$i]) == '--- START')
	{
		$start = true;
	}
	if (trim($content[$i]) == '--- END')
	{
		$new_content .= $spells_text . $content[$i];
	
		$start = false;
	}	
}

echo "WRITING debug mod TO $debug_mod_location\n";
file_put_contents($debug_mod_location, $new_content);
