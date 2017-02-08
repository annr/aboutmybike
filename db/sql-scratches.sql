select * from manufacturer where name ilike 'van%' or name ilike '%Unknown Brand%' limit 1;

CREATE TYPE market_size_type AS ENUM ('A','B', 'C');

COPY country FROM 'countries.csv' DELIMITER ',' CSV;