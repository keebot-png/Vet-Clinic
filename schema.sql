/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic

CREATE TABLE animals (
    id INTEGER,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

ALTER TABLE animals
ADD COLUMN species TEXT;

SELECT * FROM animals;