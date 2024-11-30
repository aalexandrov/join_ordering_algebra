\ir ./00_params.sql

SET search_path = :schema;

-- Q01: the original query.
SELECT c.*, o.*, i.* FROM 
    customers c
    LEFT JOIN (orders o JOIN items i USING(i_id)) USING(c_id);

-- Q02: wrongly eliminates Vera from the result. 
SELECT c.*, o.*, i.* FROM 
    customers c
    LEFT JOIN orders o USING(c_id)
    JOIN items i USING(i_id);

-- Q03: wrongly preserves Uma's dragonfruit order.
SELECT c.*, o.*, i.* FROM 
    customers c
    LEFT JOIN orders o USING(c_id)
    LEFT JOIN items i USING(i_id);

-- Antijoin between `customers left join orders` and `items`.
WITH 
    leftjoin AS (SELECT * FROM customers c LEFT JOIN orders o USING(c_id))
    SELECT * FROM leftjoin x WHERE NOT EXISTS (SELECT * FROM items i WHERE i.i_id = x.i_id);

-- Semijoin between `customers left join orders` and `items`.
WITH 
    leftjoin AS (SELECT * FROM customers c LEFT JOIN orders o USING(c_id))
    SELECT * FROM leftjoin x WHERE EXISTS (SELECT * FROM items i WHERE i.i_id = x.i_id);

-- S-antijoin between `customers left join orders` and `item`.
WITH 
    leftjoin AS (SELECT * FROM customers c LEFT JOIN orders o USING(c_id)),
    antijoin AS (SELECT * FROM leftjoin x WHERE NOT EXISTS (SELECT * FROM items i WHERE i.i_id = x.i_id)),
    semijoin AS (SELECT * FROM leftjoin x WHERE EXISTS (SELECT * FROM items i WHERE i.i_id = x.i_id))
    SELECT * FROM semijoin;
    -- SELECT * FROM antijoin x WHERE NOT EXISTS (SELECT * FROM semijoin y WHERE x.c_id = y.c_id);
