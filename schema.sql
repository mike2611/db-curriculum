/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id  INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(250),
	date_of_birth  DATE,
	escape_attempts INT,
	neutered  BOOLEAN,
	weight_kg DECIMAL,
	PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(250);

CREATE TABLE owners(
	id  INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(250),
	age INT,
	PRIMARY KEY(id)
);

CREATE TABLE species(
	id  INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(250),
	PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD FOREIGN KEY(species_id) 
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD FOREIGN KEY(owner_id) 
REFERENCES owners(id);

CREATE TABLE vets(
	id  INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(250),
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY(id)
);


CREATE TABLE specializations(
 id  INT GENERATED ALWAYS AS IDENTITY,
 species_id INT REFERENCES species(id) ON  DELETE CASCADE,
 vet_id INT REFERENCES vets(id) ON DELETE CASCADE,
 PRIMARY KEY (id)
);

CREATE TABLE visits(
 id  INT GENERATED ALWAYS AS IDENTITY,
 species_id INT REFERENCES animals(id) ON  DELETE CASCADE,
 vet_id INT REFERENCES vets(id) ON DELETE CASCADE,
 date_of_visit DATE,
 PRIMARY KEY (id)
);

