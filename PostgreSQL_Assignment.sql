-- Active: 1747928367168@@127.0.0.1@5432@conservation_db
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);

DROP Table rangers

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

DROP Table species

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT,
    ranger_id INT,
    location VARCHAR(100),
    sighting_time TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (species_id) REFERENCES species (species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id)
);

DROP Table sightings

INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

SELECT * FROM rangers

SELECT * FROM species

SELECT * FROM sightings

-- problem 1

INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem 2

SELECT count(DISTINCT species_id) as unique_species_count
from sightings

-- problem 3

SELECT * FROM sightings WHERE location LIKE '%Pass%'

-- problem 4

SELECT name, count(*) AS total_sightings
FROM rangers
    JOIN sightings USING (ranger_id)
GROUP BY
    ranger_id
ORDER BY name;

-- problem 5

SELECT common_name
FROM species
    Left JOIN sightings USING (species_id)
WHERE
    sighting_id IS NULL;

-- problem 6

SELECT common_name, sighting_time, name
FROM sightings
    JOIN species USING (species_id)
    JOIN rangers USING (ranger_id)
ORDER BY sighting_time DESC
LIMIT 2

-- problem 7

UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    extract(
        year
        FROM discovery_date
    ) < 1800;

-- problem 8

SELECT
    sighting_id,
    CASE
        WHEN extract(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN extract(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        ELSE 'Evening'
    END as time_of_day
FROM sightings

-- problem 9

DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );