-- Active: 1747928367168@@127.0.0.1@5432@conservation_db
CREATE Table rangers(
    ranger_id INT Unique ,
    "name" VARCHAR(50),
    region VARCHAR(50)
)

CREATE Table species(
    species_id INT UNIQUE,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
)

CREATE Table sightings(
    sighting_id INT UNIQUE,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT,
    sighting_time TIMESTAMP,
    "location" VARCHAR(50),
    notes VARCHAR(50)
)