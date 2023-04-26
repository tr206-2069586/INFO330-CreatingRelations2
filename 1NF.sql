-- Making tables drops to keep data clean
DROP TABLE IF EXISTS NF1_TEMP1;
DROP TABLE IF EXISTS NF1_TEMP2;
DROP TABLE IF EXISTS NF1;
DELETE FROM pokemon WHERE type1 = 'Mascot';

-- Adding Huskichu for extra credit
INSERT INTO pokemon(
	abilities,
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
	pokedex_number,
	sp_attack,
	sp_defense,
	speed,
	type1,
	type2,
	weight_kg,
	generation,
	is_legendary)
VALUES('[scratch,Hyperbeam,quickattack,intimidate]', 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 250, 
1000, 10, 'Mascot', 200, 2000000, 4, 500, 'Huskichu', 20.6, 999, 200, 200, 250, 'Mascot', Null, 150.0, 5, 1);

-- Adding Cougarite for extra credit
INSERT INTO pokemon(
	abilities,
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
	pokedex_number,
	sp_attack,
	sp_defense,
	speed,
	type1,
	type2,
	weight_kg,
	generation,
	is_legendary)
VALUES('[Slow Attack]', 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 10, 
20, 99, 'Mascot', 10, 500000, 1, 10, 'Cougarite', 79.4, 1000, 5, 5, 2, 'Mascot', Null, 500.0, 5, 1);

-- Building final Normal form 1 to return
CREATE TABLE NF1(
	abilities varchar(90),
	pokedex_number INT,
	name varchar(90),
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
	height_m FLOAT INT,
	hp INT,
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

-- Creating temp table and declaring varaibles to hold non duplicate columns/data
CREATE TABLE NF1_TEMP1(
	pokedex_number INT,
	name varchar(90),
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

-- Inserting non duplicate data from pokemon.csv
INSERT INTO NF1_TEMP1
SELECT	
	pokedex_number,
	name,
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

-- Removing brackets and apostrophe to better setup data for splitting
UPDATE
		pokemon
SET 
		abilities = REPLACE(REPLACE(REPLACE(REPLACE(abilities, ']', ''),'[', ''), '''', ''),' ', '');

-- Making second temp table to hold duplicate information
CREATE TABLE NF1_TEMP2(
	abilities varchar(90),
	pokedex_number INT
);		

-- Splitting abilities column into different rows and then saving in NF_TEMP2
WITH split(pokedex_number, abilities, nextabilities) AS (
	SELECT pokedex_number, '' AS abilities, abilities|| ',' AS nextabilities
	FROM pokemon
	UNION ALL 
		SELECT pokedex_number,
			substr(nextabilities, 0, instr(nextabilities, ',')) AS abilities,
			substr(nextabilities, instr(nextabilities, ',')+1) AS nextabilities
		FROM split
		WHERE nextabilities != ''
)
INSERT INTO NF1_TEMP2(abilities, pokedex_number)
SELECT abilities, pokedex_number
FROM split
WHERE abilities != ''
ORDER BY pokedex_number;

-- Joining two temp tables and then inserting all the information with dupes into the final normal form 1 table
INSERT INTO NF1(
	abilities,
	pokedex_number,
	name,
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
	percentage_male,
	sp_attack,
	sp_defense,
	speed,
	type1,
	type2,
	weight_kg,
	generation,
	is_legendary)
SELECT 
 *
  FROM NF1_TEMP2
   JOIN NF1_TEMP1
    USING (pokedex_number);