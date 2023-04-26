-- Made table drops to keep data clean
DROP TABLE IF EXISTS NF3_Table2;
DROP TABLE IF EXISTS NF3_Table1;

-- Made table and declared variables for non duplicate values which give stats about pokemon
CREATE TABLE NF3_Table1(
	pokedex_number INT PRIMARY KEY ,
	against_bug FLOAT,
	against_dark FLOAT,
	against_dragon FLOAT,
	against_electric FLOAT,
	against_fairy FLOAT,
	against_fight FLOAT,
	against_fire FLOAT,
	against_flying FLOAT,
	against_ghost FLOAT,
	against_grass FLOAT,
	against_ground FLOAT,
	against_ice FLOAT,
	against_normal FLOAT,
	against_poison FLOAT,
	against_psychic FLOAT,
	against_rock FLOAT,
	against_steel FLOAT,
	against_water FLOAT,
	attack INT,
	base_total INT,
	capture_rate INT,
	classfication varchar(90),
	defense INT,
	experience_growth INT,
	hp INT,
	name varchar(90),
	percentage_male FLOAT,
	sp_attack INT,
	sp_defense INT,
	speed INT,
	is_legendary INT
);

-- Inserted non duplicate values which give stats about pokemon from pokemon.csv
INSERT INTO NF3_Table1
SELECT	
	pokedex_number ,
	against_bug,
	against_dark,
	against_dragon,
	against_electric,
	against_fairy,
	against_fight,
	against_fire,
	against_flying,
	against_ghost,
	against_grass,
	against_ground,
	against_ice,
	against_normal,
	against_poison,
	against_psychic,
	against_rock,
	against_steel,
	against_water,
	attack,
	base_total,
	capture_rate,
	classfication,
	defense,
	experience_growth,
	hp,
	name,
	percentage_male,
	sp_attack,
	sp_defense,
	speed,
	is_legendary
FROM pokemon;

-- Created a table and variables to hold information about descriptive features which could be used to figure out what pokemon it is.
CREATE TABLE NF3_Table2(
	abilities varchar(30),
	type1 varchar(30),
	type2 varchar(30),
	generation int,
	height_m FLOAT,
	weight_kg FLOAT,
	pokedex_number INT,
	FOREIGN KEY(pokedex_number) REFERENCES NF3_Table1(pokedex_number)
);

-- inserted information about descriptive features which could be used to figure out what pokemon it is.
INSERT INTO NF3_Table2
SELECT
	abilities,
	type1,
	type2,
	generation,
	height_m,
	weight_kg,
	pokedex_number
FROM NF1;