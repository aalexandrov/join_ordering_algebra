\ir ./00_params.sql

DROP SCHEMA IF EXISTS :schema CASCADE;
CREATE SCHEMA :schema;
SET search_path = :schema;

CREATE TABLE customers (
    c_id char NOT NULL PRIMARY KEY,
    c_name text NOT NULL
);

CREATE TABLE orders (
    c_id text NOT NULL,
    i_id char NOT NULL
);

CREATE TABLE items (
    i_id char NOT NULL PRIMARY KEY,
    i_name text NOT NULL
);
