/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

ALTER TABLE animals
DROP COLUMN species;

UPDATE animals

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE;

ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INTEGER
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name TEXT
);