/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT, name TEXT, date_of_birth DATE, escape_attempts INTEGER, neutered BOOLEAN, weight_kg DECIMAL,
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals DROP COLUMN id;

ALTER TABLE animals ADD id INT SERIAL PRIMARY KEY;

CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name TEXT, age INTEGER);

CREATE TABLE species (id SERIAL PRIMARY KEY, name TEXT);

ALTER TABLE animals ADD species_id INT, ADD CONSTRAINT species_constraint FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE;

ALTER TABLE animals ADD owner_id INT, ADD CONSTRAINT owner_constraint FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE;