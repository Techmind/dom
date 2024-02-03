let app_data_dir = "/home/ilya/.dominions6/";
let current_dir = "/.";

if (typeof require != "undefined")
{
	const os = require("os");
	// check the available memory
	app_data_dir = os.homedir() + "/.dominions6/";
	current_dir = __dirname;
} else {
}

// change to app_data_dir + 'log.txt';
const log_path = 'log.txt';
const mod_inspector_path = current_dir + "/dom6inspector/gamedata/";
const units_file = mod_inspector_path + 'BaseU.csv';
const mods = [
  //'/home/ilya/.dominions5/mods/StoneSoupAuction Nations 0.641.dm',
  //'/home/ilya/.dominions5/mods/DomEnhanced1_84.dm', "/home/ilya/.dominions5/mods/SparkOfDivinity_Enhanced1_2.dm", "/home/ilya/.dominions5/mods/AuxiliaryEmpires0.70wspf.dm", "/home/ilya/.dominions5/mods/bozmod_1.542_lite_dsp.dm"
  //app_data_dir + "\Dominions5\mods\WH_6_25.dm"
];
const debug_mod_location = app_data_dir + "mods/111/Debug_509_nor.dm";
const debug_mod_template = current_dir + "/Debug_509_nor.dm";
console.log("Usage: change the code to write a spells generating armies (see $battle_meta)");
console.log("OR launch dominions with debug flag and watch reports/battles and script will generate armies from log files\n\n");


let fs;
if (typeof require != "undefined")
{
	fs = require("fs");
}

const battle_meta = {
  test_army: {
    start: -1,
    prov: "custom",
    armies: {
      1: [
        //['name' => "Rusian Chieftain", 'coms' => 2, 'units' => 0],
        //['name' => "Militia", 'coms' => 0, 'units' => 30],
        //['name' => "Light Cavalry", 'coms' => 0, 'units' => 30],
        //['name' => "Rusian Hunter", 'coms' => 0, 'units' => 86],
        //['name' => "Chud Skinshifter", 'coms' => 0, 'units' => 30],
        //['name' => "Rusian Warrior", 'coms' => 0, 'units' => 20],
        //['name' => "Footman", 'coms' => 0, 'units' => 120, 'id' => 928 ],
        //['name' => 'Great Bear', 'coms' => 0, 'units' => 86, 'id' => 3003],
        { name: 'Sirin', coms: 2, units: 0 },
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
      3: [
        //['name' => "Sleeper", 'coms' => 4, 'units' => 0],
        //['name' => "Sleeper", 'coms' => 2, 'units' => 0],
        //['name' => "Assassin", 'coms' => 1, 'units' => 0],
        //['name' => "Forest Troll", 'coms' => 1, 'units' => 10],
        //['name' => "Dai Oni", 'coms' => 1, 'units' => 0],
        //['name' => "Gigante Hoplite", 'coms' => 0, 'units' => 10],
        { name: "Polemarch", coms: 4, units: 0 },
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
      //3 => [
      //  ['name' => 'Soldier Priest', 'coms' => 1, 'units' => 18],
      //  ['name' => 'Archer Priest', 'coms' => 1, 'units' => 7],
      //]
    }
  },
};


let units_lookup = {};

// LOAD UNITS if fs is present
if (typeof fs != 'undefined')
{	
	mods.forEach((mod) => {
	  const content = fs.readFileSync(mod, "utf-8");
	  const regex = /#newmonster\s*([0-9]*)\s.*?#name "([a-zA-Z\s]*)/g;
	  let matches;
	  while ((matches = regex.exec(content)) !== null) {
		const id = matches[1];
		const name = matches[2];
		units_lookup[name] = { id: id, sum_cost: 10000 };
	  }
	});
	
	let row = 0;
	const units = [];
	const csv = fs.readFileSync(units_file, "utf-8");
	const lines = csv.split("\n");
	lines.forEach((line) => {
	  const data = line.split("\t");
	  const id = data[0];
	  const name = data[1];
	  const cost = data[15];
	  const rcost = data[16];
	  if (row !== 0) {
		const sum = parseInt(cost) + parseInt(rcost);
		if (!units_lookup[name]) {
		  units_lookup[name] = { id: id, cost: cost, rcost: rcost, sum_cost: sum };
		}
		if (units_lookup[name] && units_lookup[name].sum_cost <= sum) {
		  units_lookup[name] = { id: id, cost: cost, rcost: rcost, sum_cost: sum };
		}                                                                                                                                                   
	  }
	  row++;
	});
	
	//console.log(units_lookup);
} else {
	// use cached version
	if (typeof require != 'undefined')
	{		
		units_lookup = require('./units_lookup.json');
	} else 
	{
		units_lookup = window.units_lookup;	
	}
	console.log("units from cache", units_lookup.length);
}

// load debug_log and generat army based on scout reports
if (typeof fs != 'undefined')
{	

	let lines_log = [];
	if (fs.existsSync(log_path)) {
	  console.log("USING LOG!");
	  lines_log = fs.readFileSync(log_path, "utf-8").split("\n");
	  const cnt = lines_log.length;
	  const bttl_start = "getbattlecount: seed";
	  console.log(lines_log, cnt);
	  let k = -1;
	  let in_battle_step = 0;
	  let matches = [];
	  for (let i = 0; i < cnt; i++) {
		const line = lines_log[i];
		//console.log(line, i);
		if (line.indexOf(bttl_start) >= 0) {
		  if (typeof battle_meta[k] == 'undefined') {
			battle_meta[k] = {
				'armies' : [],
				'start': '',
				'prov': '',
			}
		  }
		  in_battle_step = 1;
		  while (battle_meta[k]) {
			k++;
		  }
		  const regex = /lnr ([0-9]+),/;
		  const match = line.match(regex);
		  const prov = match[1];
		  battle_meta[k] = { start: i, prov: prov, armies: {} };
		}
		if (line.includes("getbattlecountfromvcr") && in_battle_step === 1) {
		  battle_meta[k].armies = {};
		  in_battle_step = 2;
		  continue;
		}
		if (in_battle_step === 2) {
		  const regex = /\s*([0-9]):\s*([0-9]*)\s*([0-9]*)\s*([A-Za-z\s]*)/;
		  const match = line.match(regex);
		  if (match) {
			const army = match[1];
			const coms = match[2];
			const units = match[3];
			const name = match[4].trim();
			if (!battle_meta[k].armies[army]) {
			  battle_meta[k].armies[army] = [];
			}
			battle_meta[k].armies[army].push({ name: name, coms: coms, units: units });
		  } else {
			battle_meta[k].end = i;
			const tmp = battle_meta[k];
			delete battle_meta[k];
			const prov = tmp.prov;
			battle_meta[prov] = tmp;
			in_battle_step = 0;
		  }
		}
	  }
	} else {
	  console.log("NO LOG FILE: " + log_path);
	}
}

function generate (battle_meta, units_lookup) 
{
let uniq = 0;
let name = '';		
const spells = {};
for (const prov_id in battle_meta) {
  const info = battle_meta[prov_id];
  for (const i in info.armies) {
    const units = info.armies[i];
    let prefix = "_" + prov_id;
    let spell_name;
    if (i == 0 || i == 2) {
      continue;
    }
    if (i == 1) {
      spell_name = "Summon Attacker_" + prov_id;
      prefix = "a_" + prov_id + "_";
    }
    if (i == 3) {
      spell_name = "Summon Defenders_" + prov_id;
      prefix = "d_" + prov_id + "_";
    }
    if (i == 4) {
      spell_name = "Summon PD_" + prov_id;
      prefix = "pd_" + prov_id + "_";
    }
    if (!spells[spell_name]) {
      spells[spell_name] = {};
    }
    let prev_name = "";
    units.forEach((unit) => {
      name = unit.name;
      const coms = unit.coms;
      const num = unit.units;
      const unit_id = unit.id || units_lookup[name].id;
      if (!unit_id) {
        throw new Error("Unit " + name + " not found");
      }
      let spell_internal_name = prefix + name + "_" + uniq;
      if (name.length >= 12) {
        const short_name = name.substring(0, 12);
        spell_internal_name = prefix + short_name + "_" + uniq;
      }
      if (num) {
        spells[spell_name][spell_internal_name] = `
#newspell
#name "${spell_internal_name}"
#school -1
#researchlevel 0
#effect 10001
#nreff ${num}
#damage ${unit_id}
#spec 8388608
`;
        if (prev_name) {
          spells[spell_name][spell_internal_name] += `#nextspell "${prev_name}"\n`;
        }
        spells[spell_name][spell_internal_name] += "#end\n";
        prev_name = spell_internal_name;
      } else if (coms) {
        for (let j = 0; j < coms; j++) {
          spell_internal_name = prefix + name + "_" + uniq + "_" + j;
          spells[spell_name][spell_internal_name] = `
#newspell
#name "${spell_internal_name}"
#school -1
#researchlevel 0
#effect 10021
#nreff 1
#damage ${unit_id}
#spec 8388608
`;
          if (prev_name) {
            spells[spell_name][spell_internal_name] += `#nextspell "${prev_name}"\n`;
          }
          spells[spell_name][spell_internal_name] += "#end\n";
          prev_name = spell_internal_name;
        }
      }
      uniq++;
    });
    const spell_internal_name = prefix + name + "_" + uniq;
    spells[spell_name][spell_internal_name] = `
#newspell
#name "${spell_name}"
#descr "Debug summon test army"
#path 0 4
#school 0
#researchlevel 0
#pathlevel 0 1
#fatiguecost 100
#effect 10021
#damage 1158                                                         
#spec 8388608
#nextspell "${prev_name}"
#end
`;
  }
}

let spells_text = "";
for (const name in spells) {
  for (const spell of Object.values(spells[name])) {
    spells_text += spell;
  }
}
return spells_text;
}

let spells_text = generate(battle_meta, units_lookup);


// write file to FS
if (typeof fs != 'undefined')
{		
	const content = fs.readFileSync(debug_mod_template, "utf-8");
	let new_content = "";
	let start = false;
	for (let i = 0; i < content.length; i++) {
	  if (!start) {
		new_content += content[i];
	  }
	  if (content[i].trim() === "--- START") {
		start = true;
	  }
	  if (content[i].trim() === "--- END") {
		new_content += spells_text + content[i];
		start = false;
	  }
	}
	console.log("WRITING debug mod TO " + debug_mod_location);
	fs.writeFileSync(debug_mod_location, new_content);
} 
else 
{
	window.spell_text = spells_text;
}

