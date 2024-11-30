\ir ./00_params.sql

SET search_path = :schema;

DELETE FROM customers;
DELETE FROM items;
DELETE FROM orders;

-- Vera doesn't have an order yet.
INSERT INTO customers (c_id, c_name) VALUES
    ('s', 'Sam'),
    ('t', 'Tom'),
    ('u', 'Uma'),
    ('v', 'Vera');

-- Contains only rows for items that are currently in stock.
INSERT INTO items (i_id, i_name) VALUES
    ('a', 'Apple'),
    ('b', 'Banana'),
    ('c', 'Cherry');

-- Uma ordered an item that is currently not in stock.
INSERT INTO orders (c_id, i_id) VALUES
    ('s', 'a'), -- Sam ordered an Apple
    ('t', 'b'), -- Tom ordered a Banana
    ('u', 'c'), -- Uma ordered a Cherry
    ('u', 'd'); -- Uma ordered a Dragonfruit (which is not in stock anymore)