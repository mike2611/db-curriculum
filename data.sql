/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Agumon', '2020-02-03', true, 0 ,10.23);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Gabumon', '2018-11-15', true, 2 ,8);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Pikachu', '2021-01-07', false, 1 ,15.04);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Devimon', '2017-05-12', true, 5 ,11);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Charmander', '2020-02-08', false, 0 ,-11);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Plantmon', '2022-11-15', true, 2 ,-5.7);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Squirtle', '1993-04-02', false, 3 ,-12.13);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Angemon', '2005-06-12', true, 1 ,-45);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Boarmon', '2005-06-07', true, 7 ,20.4);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg) 
VALUES ('Blossom', '1998-10-13', true, 3 ,17);

INSERT INTO owners(full_name, age,)
VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45),
('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES ('Pokemon'),('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals
SET owner_id = 1
WHERE name LIKE 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name LIKE 'Gabumon' OR name LIKE 'Pikachu';

UPDATE animals
SET owner_id = 3
WHERE name LIKE 'Devimon' OR name LIKE 'Plantmon';

UPDATE animals
SET owner_id = 4
WHERE name LIKE 'Charmander' OR name LIKE 'Squirtle'
OR name LIKE 'Blossom';

UPDATE animals
SET owner_id = 5
WHERE name LIKE 'Angemon' OR name LIKE 'Boarmon';