PRAGMA foreign_keys = on;
BEGIN TRANSACTION;

-- Table: Person
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
    personKey    TEXT PRIMARY KEY,
    name         TEXT,
    affiliation  TEXT,
    bio          TEXT,
    url          TEXT,
    imageURL     TEXT
);

-- Table: Person
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
    personKey    TEXT PRIMARY KEY,
    name         TEXT,
    affiliation  TEXT,
    bio          TEXT,
    url          TEXT,
    imageURL     TEXT
);