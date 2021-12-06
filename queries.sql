/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth > '2016-12-12' AND date_of_birth < '2019-01-01';

SELECT name FROM animals WHERE neutered AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Pikachu' OR name = 'Agumon';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals; 

ROLLBACK;

SELECT * FROM animals; 


BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;


BEGIN;

DELETE FROM animals;

ROLLBACK;


BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT AN1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO AN1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) 
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts)
FROM animals
GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth > '1990-12-31' AND date_of_birth < '2000-01-01'
GROUP BY species;

SELECT full_name, name
FROM animals
INNER JOIN owners
ON owner_id = owners.id
WHERE full_name LIKE 'Melody Pond';

SELECT animals.name, species.name
FROM animals
INNER JOIN species
ON species_id = species.id
WHERE species.name LIKE 'Pokemon';

SELECT full_name, name
FROM animals
FULL JOIN owners
ON owner_id = owners.id;

SELECT COUNT(species_id)
FROM animals
INNER JOIN species
ON species_id = species.id
WHERE species.name LIKE 'Pokemon';

SELECT COUNT(species_id)
FROM animals
INNER JOIN species
ON species_id = species.id
WHERE species.name LIKE 'Digimon';


SELECT full_name, name
FROM animals
INNER JOIN owners
ON owner_id = owners.id
WHERE full_name LIKE 'Jennifer Orwell' AND species_id = 2;

SELECT full_name, name
FROM animals
INNER JOIN owners
ON owner_id = owners.id
WHERE full_name LIKE 'Dean Winchester' AND escape_attempts = 0;

SELECT full_name, COUNT(full_name) AS value_occurrence 
FROM owners
INNER JOIN animals
ON owners.id = owner_id
GROUP BY full_name
ORDER BY 
  value_occurrence DESC
LIMIT 1;

SELECT animals.name, MAX(date_of_visit) AS last_day 
FROM animals
INNER JOIN visits
ON animals.id = animals_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
GROUP BY name
ORDER BY 
  last_day DESC
LIMIT 1;


SELECT COUNT(animals_id) 
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT vets.name, (SELECT name FROM species WHERE id = specializations.species_id)
FROM vets
FULL JOIN specializations
ON specializations.vet_id = vets.id;

SELECT (SELECT name FROM animals WHERE id = visits.animals_id)
FROM animals
INNER JOIN visits
ON animals.id = visits.animals_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
AND date_of_visit > '2020-04-01' AND date_of_visit < '2020-08-30';

SELECT (SELECT name FROM animals WHERE id = animals_id), 
COUNT(animals_id) AS value_occurrence
FROM visits
GROUP BY animals_id
ORDER BY 
  value_occurrence DESC
LIMIT 1;

SELECT (SELECT name FROM animals WHERE id = visits.animals_id), date_of_visit
FROM animals
INNER JOIN visits
ON animals.id = visits.animals_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY date_of_visit
LIMIT 1;

SELECT (SELECT name FROM animals WHERE id = animals_id), (SELECT name FROM vets WHERE id = vet_id), date_of_visit
FROM visits
WHERE date_of_visit IN (SELECT max(date_of_visit) FROM visits);

SELECT animals.species_id,  specializations.species_id
FROM visits
FULL JOIN specializations
ON visits.vet_id = specializations.vet_id
FULL JOIN animals
ON visits.animals_id = animals.id
WHERE visits.vet_id != (SELECT id FROM vets WHERE name = 'Stephanie Mendez') AND 
(specializations.species_id != animals.species_id OR  specializations.species_id  IS NULL);

SELECT (SELECT name FROM species WHERE id = animals.species_id), COUNT(animals.species_id) AS value_occurrence 
FROM visits
FULL JOIN animals
ON visits.animals_id = animals.id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY animals.species_id
ORDER BY 
  value_occurrence DESC
LIMIT 1;

SELECT
  COUNT(visits.date_of_visit),
  vets.name
FROM
  visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
WHERE
  NOT animals.species_id = ANY (
    ARRAY(
      SELECT
        specializations.species_id
      FROM
        specializations
      WHERE
        specializations.vet_id = vets.id
    )
  )
GROUP BY
  vets.name;
