-- Made table drops to keep data clean need to drop table 2 first because 
DROP TABLE IF EXISTS NF2_Table2;
DROP TABLE IF EXISTS NF2_Table1;

-- Created table, declared variables and set pokedex_number as Primary key 
CREATE TABLE NF2_Table1(
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
	height_m FLOAT,
	hp INT,
	name varchar(90),
	percentage_male FLOAT,
	sp_attack INT,
	sp_defense INT,
	speed INT,
	type1 varchar(90),
	type2 varchar(90),
	weight_kg FLOAT,
	generation INT,
	is_legendary INT
);

-- Inserted information into non duplicate table from pokemon.csv
INSERT INTO NF2_Table1
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
	height_m,
	hp,
	name,
	percentage_male,
	sp_attack,
	sp_defense,
	speed,
	type1,
	type2,
	weight_kg,
	generation,
	is_legendary
FROM pokemon;

-- Make table and variables for duplicate values and make reference to pokedex_number from NF2_table1
CREATE TABLE NF2_Table2(
	pokedex_number INT,
	abilities varchar(30),
	FOREIGN KEY(pokedex_number) REFERENCES NF2_Table1(pokedex_number)
);

-- Insert duplicate values into NF_Table2 from NF1
INSERT INTO NF2_Table2
SELECT 
pokedex_number,abilities
FROM NF1;