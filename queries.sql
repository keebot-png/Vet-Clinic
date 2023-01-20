/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pickachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT * FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT MAX(weight_kg), MIN(weight_kg), species FROM animals GROUP BY species;
SELECT AVG(escape_attempts), species, date_of_birth FROM animals GROUP BY species, date_of_birth HAVING date_of_birth BETWEEN'1990-01-01' AND '2000-12-31';

-- Multiple table queries

SELECT animals.name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Melody Pond';
SELECT * FROM animals JOIN species ON species.id = animals.species_id WHERE species.id = 1;
SELECT * FROM animals JOIN owners ON owners.id = animals.owner_id WHERE 
SELECT COUNT(animals.species_id) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;
SELECT * FROM animals JOIN owners ON owner.id = animals.owner_id WHERE owners.species_id = 2;
SELECT * FROM animals JOIN owners ON  WHERE escape_attempts = 0 AND animals.owner_id = 5;
SELECT owners.full_name, COUNT(animals.name) AS animals_owned FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY full_name ORDER BY animals_owned DESC;