<?php
$app_data_dir = !empty($_ENV["APPDATA"]) ? $_ENV["APPDATA"] : $_SERVER["APPDATA"];
$app_data_dir = "/home/ilya/.dominions6/";

// launch Domninions with -d flag to create debug log and watch reports you want recreated
$log_path = 'log.txt';
// use mod inspector to find unit id's
// [TODO] add dependecny using git submodules ?
$mod_inspector_path = __DIR__ . DIRECTORY_SEPARATOR . "dom6inspector" . DIRECTORY_SEPARATOR  .  "gamedata" . DIRECTORY_SEPARATOR;

$units_file = $mod_inspector_path . 'BaseU.csv';

// mods for new units (WH in this case)
// TODO add linux suport ?
$mods = [
	//'/home/ilya/.dominions5/mods/StoneSoupAuction Nations 0.641.dm',                                                           
	//'/home/ilya/.dominions5/mods/DomEnhanced1_84.dm', "/home/ilya/.dominions5/mods/SparkOfDivinity_Enhanced1_2.dm", "/home/ilya/.dominions5/mods/AuxiliaryEmpires0.70wspf.dm", "/home/ilya/.dominions5/mods/bozmod_1.542_lite_dsp.dm"
//	$app_data_dir . "\Dominions5\mods\WH_6_25.dm"                                                                                                
];
$debug_mod_location =  $app_data_dir . "mods/111/Debug_509_nor.dm";

$debug_mod_template = __DIR__ . "/Debug_509_nor.dm";

echo "Usage: change the code to write a spells generating armies (see \$battle_meta)
OR launch dominions with debug flag and watch reports/battles and script will generate armies from log files\n\n";

// 0 attacker (wont generate)
// 1 attacker left 
// 2 defender (wont generate)
// 3 defender lef
// 4 pd 

$battle_meta = [
	'smartphone_army' => ['start' => -1, 'prov' => "custom", 
		'armies' => [
			1 => [
				//['name' => "Rusian Chieftain", 'coms' => 2, 'units' => 0],
				//['name' => "Militia", 'coms' => 0, 'units' => 30],
				//['name' => "Light Cavalry", 'coms' => 0, 'units' => 30],
				//['name' => "Rusian Hunter", 'coms' => 0, 'units' => 86],
				//['name' => "Chud Skinshifter", 'coms' => 0, 'units' => 30],
				//['name' => "Rusian Warrior", 'coms' => 0, 'units' => 20],
				//['name' => "Footman", 'coms' => 0, 'units' => 120, 'id' => 928 ],
				//['name' => 'Great Bear', 'coms' => 0, 'units' => 86, 'id' => 3003],
				['name' => 'Sirin', 'coms' => 10, 'units' => 0],
				
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
				//['name' => "Sleeper", 'coms' => 4, 'units' => 0],
				//['name' => "Sleeper", 'coms' => 2, 'units' => 0],
				//['name' => "Assassin", 'coms' => 1, 'units' => 0],
				//['name' => "Forest Troll", 'coms' => 1, 'units' => 10],
				//['name' => "Dai Oni", 'coms' => 1, 'units' => 0],
				//['name' => "Gigante Hoplite", 'coms' => 0, 'units' => 10],
				['name' => "Polemarch", 'coms' => 4, 'units' => 0],
				//['name' => "Geronte", 'coms' => 1, 'units' => 0],
				//['name' => "Horse Tribe Cavalry", 'coms' => 1, 'units' => 50],
				//['name' => "Gigante Hoplite", 'coms' => 0, 'units' => 68],
				//['name' => "Clockwork Soldier", 'coms' => 0, 'units' => 20],
				//['name' => "Gigante Ekdromos", 'coms' => 0, 'units' => 15],
				//['name' => "Machaka Archer", 'coms' => 0, 'units' => 80],
				//['name' => "Helote Peltast", 'coms' => 0, 'units' => 209],
				
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
	'ulm_1085_army' => ['start' => -1, 'prov' => "custom", 
		'armies' => [
			1 => [
				['name' => "Barbarian", 'coms' => 3, 'units' => 0],
				['name' => "Deer Tribe Warrior", 'coms' => 0, 'units' => 10],
				['name' => "Deer Tribe Archer", 'coms' => 0, 'units' => 10],
				
			],
			3 => [
				['name' => 'Ranger of Ulm', 'coms' => 1, 'units' => 5],
				['name' => 'Black Priest', 'coms' => 1, 'units' => 0],
				['name' => 'Fortune Teller', 'coms' => 1, 'units' => 0],
				['name' => 'Black Templar', 'coms' => 0, 'units' => 2],
				['name' => 'Wolf', 'coms' => 0, 'units' => 8],
			]
		]
	],
	'940' => ['start' => -1, 'prov' => "custom",
                'armies' => [
                        1 => [
                                ['name' => "Commander", 'coms' => 3, 'units' => 0],
                                ['name' => "Light Infantry", 'coms' => 0, 'units' => 20],
                                ['name' => "Militia", 'coms' => 0, 'units' => 20],

                        ],
                        3 => [
                                ['name' => 'Ichtyid Lord', 'coms' => 1, 'units' => 0],
				['name' => 'Ichtyid', 'coms' => 0, 'units' => 20],
				['name' => 'Crossbowman', 'coms' => 0, 'units' => 20],
				['name' => 'Captain', 'coms' => 1, 'units' => 0],
				['name' => 'Footman', 'coms' => 0, 'units' => 4],
				['name' => 'Barbarian Heavy Horseman', 'coms' => 0, 'units' => 5],
                        ]
                ]
	],
	'barbs' => ['start' => -1, 'prov' => "custom",
                'armies' => [
                        1 => [
                                ['name' => "Barbarian", 'coms' => 3, 'units' => 0],
                                ['name' => "Barbarian", 'coms' => 0, 'units' => 40],

                        ],
                        3 => [
                                ['name' => 'Ichtyid Lord', 'coms' => 1, 'units' => 0],
                                ['name' => 'Ichtyid', 'coms' => 0, 'units' => 20],
                                ['name' => 'Footman', 'coms' => 0, 'units' => 2],
                                ['name' => 'Barbarian Heavy Horseman', 'coms' => 0, 'units' => 4],
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
    while (($data = fgetcsv($handle, 1000, "\t")) !== FALSE) {
        $num = count($data);
		// 0 - id
		// 1 - name
		// 15 basecost
		// 16 rcost
		$id = $data[0];
		$name = $data[1];
		$cost = $data[15];
		$rcost = $data[16];
		if ($row != 0)
		{
			$sum = intval($cost) + intval($rcost);
			
			if (empty($units_lookup[$name]))
			{
				$units_lookup[$name] = ['id' => $id, 'cost' => $cost, $rcost => $rcost, 'sum_cost' => $sum];
			}
			// assume costliest unit(worts case scenariot) is the one we would encounter (pass ERA later)
			if (!empty($units_lookup[$name]) && $units_lookup[$name]['sum_cost'] <= $sum)
			{
				$units_lookup[$name] = ['id' => $id, 'cost' => $cost, 'rcost' => $rcost, 'sum_cost' => $sum];
			}
		}
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
			if (preg_match("~\s*([0-9]):\s*([0-9]*)\s*([0-9]*)\s*([A-Za-z\s]*)~", $lines[$i], $matches)) {
				$army = $matches[1];
				$coms = $matches[2];
				$units = $matches[3];
				$name = trim($matches[4]);
				$name = preg_replace('~\s^~', '', $name);
				
				if (empty($battle_meta[$k]['armies'][$army])) {
					$battle_meta[$k]['armies'][$army] = [];
				}
				
				//var_dump("SET $k");
				$battle_meta[$k]['armies'][$army][] = ['name' => $name, 'coms' => $coms, 'units' => $units];
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

$uniq = 0;
$spells = [];

foreach ($battle_meta as $prov_id => $info)
{	
	// 0 attacker
	// 1 attacker left
	// 2 defender
	// 3 defender lef
	// 4 pd ?
	foreach ($info['armies'] as $i => $units)
	{
		$prefix = '_' . $prov_id;
		if ($i == 0 || $i == 2) 
		{
			continue;
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
			
			$unit_id = !empty($unit['id']) ? $unit['id'] : $units_lookup[$name]['id'];
			
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
