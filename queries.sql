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
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON owners.id = animals.owner_id; 
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;
SELECT * FROM animals JOIN owners ON owners.id = animals.owner_id WHERE animals.species_id = 2 AND owners.full_name = 'Jennifer Orwell';
SELECT * FROM animals JOIN owners ON owners.id = animals.owner_id WHERE animals.escape_attempts = 0 AND animals.owner_id = 5;
SELECT owners.full_name, COUNT(animals.name) AS animals_owned FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY full_name ORDER BY animals_owned DESC;

-- Join Table queries

SELECT animals.name from animals JOIN visits ON visits.animals_id = animals.id WHERE vet_id = 1 ORDER BY visits.date_of_visit DESC LIMIT 1;
SELECT COUNT(DISTINCT animals_id) FROM visits WHERE vet_id = 3;
SELECT vets.name, specializations.species_id, specializations.vet_id FROM vets LEFT JOIN specializations ON specializations.vet_id = vets.id;
SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vet_id = 3;
SELECT animals.name, COUNT(visits.animals_id) FROM animals JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY COUNT(visits.animals_id) DESC lIMIT 1;
SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON visits.animals_id = animals_id WHERE visits.vet_id = 2 ORDER BY visits.date_of_visit ASC LIMIT 1;
SELECT * FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id WHERE visits.date_of_visit = (SELECT MIN(date_of_visit) FROM visits);
SELECT COUNT(visits.animals_id) FROM visits JOIN vets ON vets.id = visits.vet_id WHERE vet_id = 2;
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT(animals.species_id) DESC LIMIT 1;