<?php
$app_data_dir = !empty($_ENV["APPDATA"]) ? $_ENV["APPDATA"] : $_SERVER["APPDATA"];
$app_data_dir = "/home/ilya/.dominions6/";

// launch Domninions with -d flag to create debug log and watch reports you want recreated
$log_path = 'log.txt';
// use mod inspector to find unit id's
// [TODO] add dependecny using git submodules ?
$mod_inspector_path = __DIR__ . DIRECTORY_SEPARATOR . "dom6inspector" . DIRECTORY_SEPARATOR  .  "gamedata" . DIRECTORY_SEPARATOR;

$units_file = $mod_inspector_path . 'BaseU.csv';
$spells_file = $mod_inspector_path . 'spells.csv';

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
				//['name' => "Sleeper", 'coms' => 4, 'units' => 0],
				//['name' => "Sleeper", 'coms' => 2, 'units' => 0],
				//['name' => "Assassin", 'coms' => 1, 'units' => 0],
				//['name' => "Forest Troll", 'coms' => 1, 'units' => 10],
				//['name' => "Dai Oni", 'coms' => 1, 'units' => 0],
				//['name' => "Gigante Hoplite", 'coms' => 0, 'units' => 10],
				//['name' => "Polemarch", 'coms' => 5, 'units' => 0],
				//['name' => "Lochos", 'coms' => 1, 'units' => 0],
				//['name' => "Kryptes", 'coms' => 5, 'units' => 0],
				//['name' => "Geronte", 'coms' => 1, 'units' => 0],
				//['name' => "Horse Tribe Cavalry", 'coms' => 1, 'units' => 50],
			//	['name' => "Gigante Hoplite", 'coms' => 0, 'units' => 100],
				//['name' => "Clockwork Soldier", 'coms' => 0, 'units' => 20],
				//['name' => "Gigante Ekdromos", 'coms' => 0, 'units' => 10],
				//['name' => "Machaka Archer", 'coms' => 0, 'units' => 80],
				//['name' => "Helote Peltast", 'coms' => 0, 'units' => 750],
				
				['name' => "Cu Sidhe", 'coms' => 0, 'units' => 80],
				
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
	'barbs' => ['start' => -1, 'prov' => "custom",
                'armies' => [
                        1 => [
                                ['name' => "Barbarian", 'coms' => 3, 'units' => 0],
                                ['name' => "Barbarian", 'coms' => 0, 'units' => 40],

                        ],
                        3 => [
                                ['name' => 'Barbarian Heavy Horseman', 'coms' => 0, 'units' => 4],
                        ]
                ]
        ],
    
    170 => 
  array (
    'start' => 9512,
    'prov' => '170',
    'armies' => 
    array (
      0 => 
      array (
        0 => 
        array (
          'name' => 'Sidhe Warrior',
          'coms' => 0,
          'units' => 13,
        ),
        1 => 
        array (
          'name' => 'Tuatha Warrior',
          'coms' => 0,
          'units' => 31,
        ),
        2 => 
        array (
          'name' => 'Sidhe Lord',
          'coms' => 2,
          'units' => 0,
        ),
      ),
      1 => 
      array (
        0 => 
        array (
          'name' => 'Sidhe Warrior',
          'coms' => 0,
          'units' => 13,
        ),
        1 => 
        array (
          'name' => 'Tuatha Warrior',
          'coms' => 0,
          'units' => 31,
        ),
        2 => 
        array (
          'name' => 'Sidhe Lord',
          'coms' => 2,
          'units' => 0,
        ),
      ),
      4 => 
      array (
        0 => 
        array (
          'name' => 'Fir Bolg Militia',
          'coms' => 0,
          'units' => 14,
        ),
        1 => 
        array (
          'name' => 'Fir Bolg Slinger',
          'coms' => 0,
          'units' => 14,
        ),
        2 => 
        array (
          'name' => 'Rusian Chieftain',
          'coms' => 1,
          'units' => 0,
        ),
      ),
      5 => 
      array (
        0 => 
        array (
          'name' => 'Fir Bolg Militia',
          'coms' => 0,
          'units' => 6,
        ),
        1 => 
        array (
          'name' => 'Fir Bolg Slinger',
          'coms' => 0,
          'units' => 2,
        ),
        2 => 
        array (
          'name' => 'Rusian Chieftain',
          'coms' => 1,
          'units' => 0,
        ),
      ),
    ),
    'end' => 9526,
  ),
  184 => 
  array (
    'start' => 9618,
    'prov' => '184',
    'armies' => 
    array (
      0 => 
      array (
        0 => 
        array (
          'name' => 'Barbarian',
          'coms' => 0,
          'units' => 1,
        ),
        1 => 
        array (
          'name' => 'Barbarian',
          'coms' => 0,
          'units' => 1,
        ),
        2 => 
        array (
          'name' => 'Lion Tribe Warrior',
          'coms' => 0,
          'units' => 5,
        ),
        3 => 
        array (
          'name' => 'Sidhe Warrior',
          'coms' => 0,
          'units' => 41,
        ),
        4 => 
        array (
          'name' => 'Tuatha Warrior',
          'coms' => 0,
          'units' => 66,
        ),
        5 => 
        array (
          'name' => 'Sidhe Lord',
          'coms' => 3,
          'units' => 0,
        ),
        6 => 
        array (
          'name' => 'Bean Sidhe',
          'coms' => 6,
          'units' => 0,
        ),
        7 => 
        array (
          'name' => 'Baobhan Sidhe',
          'coms' => 1,
          'units' => 0,
        ),
        8 => 
        array (
          'name' => 'Hoplite',
          'coms' => 0,
          'units' => 1,
        ),
      ),
      1 => 
      array (
        0 => 
        array (
          'name' => 'Barbarian',
          'coms' => 0,
          'units' => 0,
        ),
        1 => 
        array (
          'name' => 'Lion Tribe Warrior',
          'coms' => 0,
          'units' => 0,
        ),
        2 => 
        array (
          'name' => 'Sidhe Warrior',
          'coms' => 0,
          'units' => 38,
        ),
        3 => 
        array (
          'name' => 'Tuatha Warrior',
          'coms' => 0,
          'units' => 59,
        ),
        4 => 
        array (
          'name' => 'Sidhe Lord',
          'coms' => 3,
          'units' => 0,
        ),
        5 => 
        array (
          'name' => 'Bean Sidhe',
          'coms' => 6,
          'units' => 0,
        ),
        6 => 
        array (
          'name' => 'Baobhan Sidhe',
          'coms' => 1,
          'units' => 0,
        ),
        7 => 
        array (
          'name' => 'Hoplite',
          'coms' => 0,
          'units' => 1,
        ),
      ),
      2 => 
      array (
        0 => 
        array (
          'name' => 'Slinger',
          'coms' => 0,
          'units' => 1,
        ),
        1 => 
        array (
          'name' => 'Woodsman',
          'coms' => 0,
          'units' => 24,
        ),
        2 => 
        array (
          'name' => 'Lion Tribe Archer',
          'coms' => 0,
          'units' => 3,
        ),
        3 => 
        array (
          'name' => 'Rusian Hunter',
          'coms' => 0,
          'units' => 38,
        ),
        4 => 
        array (
          'name' => 'Rusian Warrior',
          'coms' => 0,
          'units' => 17,
        ),
        5 => 
        array (
          'name' => 'Rusian Warrior',
          'coms' => 0,
          'units' => 7,
        ),
        6 => 
        array (
          'name' => 'Rusian Chieftain',
          'coms' => 3,
          'units' => 0,
        ),
      ),
      3 => 
      array (
        0 => 
        array (
          'name' => 'Woodsman',
          'coms' => 0,
          'units' => 0,
        ),
        1 => 
        array (
          'name' => 'Rusian Hunter',
          'coms' => 0,
          'units' => 0,
        ),
        2 => 
        array (
          'name' => 'Rusian Warrior',
          'coms' => 0,
          'units' => 0,
        ),
        3 => 
        array (
          'name' => 'Rusian Warrior',
          'coms' => 0,
          'units' => 0,
        ),
        4 => 
        array (
          'name' => 'Rusian Chieftain',
          'coms' => 2,
          'units' => 0,
        ),
      ),
      4 => 
      array (
        0 => 
        array (
          'name' => 'Woodsman Blowpipe',
          'coms' => 0,
          'units' => 1,
        ),
        1 => 
        array (
          'name' => 'Woodsman',
          'coms' => 0,
          'units' => 1,
        ),
        2 => 
        array (
          'name' => 'Rusian Chieftain',
          'coms' => 1,
          'units' => 0,
        ),
      ),
    ),
    'end' => 9652,
  )
	
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

$spells_lookup = [];

$row = 0;
if (($handle = fopen($spells_file, "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, "\t")) !== FALSE) {
        $num = count($data);
		// 0 - id
		// 1 - name
		// 15 basecost
		// 16 rcost
		$id = $data[0];
		$name = $data[1];
		$spells_lookup[$name] = $id;		
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
echo var_export($battle_meta, true);


$uniq = 0;
$spells = [];

$item_id = 5000;
$monster_id = 5000;

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
			$autocast = !empty($unit['autocast']) ? $unit['autocast'] : null;
			
			if (empty($name))
				{
				continue;
				}
			
			$unit_id = !empty($unit['id']) ? $unit['id'] : $units_lookup[$name]['id'];

			
			if ($autocast)
			{
				$autocasts = explode(',', $autocast);
				$spell_autocast_ids = array_map(function ($name) use ($spells_lookup) { return $spells_lookup[$name];}, $autocasts);
				
	/*			
#selectitem $item_id
#constlevel 11
#name \"autocast_$autocast\"
#autospell $spell_autocast_id
#mainpath 0
#mainlevel 1
#type 8
#end

#startitem $item_id

*/
$spells['items']["autocast_$autocast"] = "

#selectmonster $monster_id
#copystats $unit_id
\n".
implode('', array_map(function($i) { return "#onebattlespell $i\n";}, $spell_autocast_ids))
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
