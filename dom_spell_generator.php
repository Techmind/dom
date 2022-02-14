<?php

// launch Domninions with -d flag to create debug log and watch reports you want recreated
$log_path = 'c:\Program Files (x86)\Steam\steamapps\common\Dominions5\log.txt';
// use mod inspector to find unit id's
$mod_inspector_path = 'c:\games\dom\mod_inspector\dom5inspector\gamedata' . "\\";

$units_file = $mod_inspector_path . 'BaseU.csv';

// mods for new units (WH in this case)
$mods = ["C:\Users\ilya\AppData\Roaming\Dominions5\mods\WH_6_25.dm"];

$debug_mod_location = "C:\Users\ilya\AppData\Roaming\Dominions5\mods\Debug_509_nor.dm";
$debug_mod_template = __DIR__ . "\Debug_509_nor.dm";

$battle_meta = [
	'gany_cap' => ['start' => -1, 'prov' => "custom", 
		'armies' => [
			1 => [
				['name' => "Keeper of Traditions", 'coms' => 1, 'units' => 0],
				['name' => "Equite of the Sacred Shroud", 'coms' => 0, 'units' => 15],
				['name' => "Ancestor Vessel", 'coms' => 0, 'units' => 15],
				['name' => "Militia", 'coms' => 0, 'units' => 80],
			],
			3 => [
				['name' => 'Jotun Jarl', 'coms' => 1, 'units' => 0],
				['name' => 'Hunter Lord', 'coms' => 1, 'units' => 0],
				['name' => 'Eparch', 'coms' => 1, 'units' => 0],
				['name' => 'Fay Boar', 'coms' => 0, 'units' => 78],
				['name' => 'Ancient Stone Hurler', 'coms' => 0, 'units' => 14],
				['name' => 'Rain Warrior', 'coms' => 0, 'units' => 17],
				['name' => 'White Centaur', 'coms' => 0, 'units' => 14],
			]
		]
	],
	'custom_north' => ['start' => -1, 'prov' => "custom", 
		'armies' => [
			1 => [
				['name' => "Dai Oni", 'coms' => 1, 'units' => 0],
				['name' => "Keeper of Traditions", 'coms' => 1, 'units' => 0],
				['name' => "Heavy Cavalry", 'coms' => 0, 'units' => 15],
				['name' => "Fomorian Giant", 'coms' => 0, 'units' => 4],
				['name' => "Sohei", 'coms' => 0, 'units' => 20],
			],
			3 => [
				['name' => 'Jotun Jarl', 'coms' => 1, 'units' => 0],
				['name' => 'Hunter Lord', 'coms' => 1, 'units' => 0],
				['name' => 'Eparch', 'coms' => 1, 'units' => 0],
				['name' => 'Fay Boar', 'coms' => 0, 'units' => 78],
				['name' => 'Ancient Stone Hurler', 'coms' => 0, 'units' => 14],
				['name' => 'Rain Warrior', 'coms' => 0, 'units' => 17],
				['name' => 'White Centaur', 'coms' => 0, 'units' => 14],
			]
		]
	],
	'custom_north2' => ['start' => -1, 'prov' => "custom", 
		'armies' => [
			1 => [
				['name' => "Keeper of Traditions", 'coms' => 1, 'units' => 0],
				['name' => "Steel Maiden", 'coms' => 0, 'units' => 40],
				['name' => "Abysian Infantry", 'coms' => 0, 'units' => 30],
			],
			3 => [
				['name' => 'Jotun Jarl', 'coms' => 1, 'units' => 0],
				['name' => 'Hunter Lord', 'coms' => 1, 'units' => 0],
				['name' => 'Eparch', 'coms' => 1, 'units' => 0],
				['name' => 'Fay Boar', 'coms' => 0, 'units' => 78],
				['name' => 'Ancient Stone Hurler', 'coms' => 0, 'units' => 14],
				['name' => 'Rain Warrior', 'coms' => 0, 'units' => 17],
				['name' => 'White Centaur', 'coms' => 0, 'units' => 14],
			]
		]
	],

	'custom_gany' => ['start' => -1, 'prov' => "custom", 
		'armies' => [
			1 => [
				['name' => "Coral Priest", 'coms' => 1, 'units' => 0],
				['name' => "Dai Oni", 'coms' => 1, 'units' => 0],
				['name' => "Eparch", 'coms' => 1, 'units' => 0],
				['name' => "Keeper of Traditions", 'coms' => 1, 'units' => 0],
				['name' => "Thaumaturg", 'coms' => 1, 'units' => 0],
				['name' => "Atavi Infantry", 'coms' => 0, 'units' => 37],
				['name' => "Coral Guard", 'coms' => 0, 'units' => 28],
				['name' => "Illithid Soldier", 'coms' => 0, 'units' => 32],
				['name' => "Earthbound", 'coms' => 0, 'units' => 29],
				['name' => "Ancient Stone Hurler", 'coms' => 0, 'units' => 24],
				['name' => "Mammoth", 'coms' => 0, 'units' => 21],
				['name' => "Ko-Oni", 'coms' => 0, 'units' => 2],
				
			],
			3 => [
				['name' => 'Guardian', 'coms' => 0, 'units' => 21],
				['name' => 'Mother Guard', 'coms' => 0, 'units' => 21],
				['name' => 'Temple Guard', 'coms' => 0, 'units' => 31],
				['name' => 'Burning One', 'coms' => 0, 'units' => 7],
				['name' => 'Markata', 'coms' => 0, 'units' => 40],
				
				['name' => 'Dai Oni', 'coms' => 1, 'units' => 0],
				['name' => 'Moon Mage', 'coms' => 1, 'units' => 0],
				['name' => 'Colossi Storm Captain', 'coms' => 1, 'units' => 0],
				['name' => 'Mage of Summer', 'coms' => 1, 'units' => 0],
			]
		]
	]		
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
			$sum = $cost + $rcost;
			
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
			
			$unit_id = $units_lookup[$name]['id'];
			
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

echo $spells_text;

// TODO imply research from CASTERS spell or pass from console

// TODO generate debug mod
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

file_put_contents($debug_mod_location, $new_content);
