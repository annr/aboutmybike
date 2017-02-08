select * from manufacturer where name ilike 'van%' or name ilike '%Unknown Brand%' limit 1;

CREATE TYPE market_size_type AS ENUM ('A','B', 'C');

-- \COPY country FROM countries.csv DELIMITER ',' CSV;


\COPY country FROM '/Users/arobson/Sites/aboutmybike/db/countries.csv' DELIMITER ',' CSV;

SELECT array_to_json(array_agg(t)) FROM t


COPY FROM SELECT row_to_json(r) FROM (select name from manufacturer) r;


-- from postgres command line:

-- getting brand names as simple array

-- doesn't work:
COPY (SELECT array(select brand from bike)) TO '/Users/arobson/Sites/aboutmybike/test-scripts/brand-names.js';

-- but that doesn't quote the strings!!! WTF????

-- doesn't work:
COPY (SELECT array(select concat('"', name, '"') from manufacturer)) TO '/Users/arobson/Sites/aboutmybike/test-scripts/brand-names.js';

-- doesn't work:
COPY (SELECT array(SELECT row_to_json(r) FROM (select name from manufacturer) r )) TO '/Users/arobson/Sites/aboutmybike/test-scripts/brand-names.js';


-- best so far. 
COPY (SELECT row_to_json(r) FROM (select name from manufacturer) r ) TO '/Users/arobson/Sites/aboutmybike/test-scripts/brand-names.js';

-- shit
COPY (select name from manufacturer) DELIMITER ',' CSV;
--shit
\copy (select name from manufacturer limit 10) TO '/Users/arobson/Sites/aboutmybike/test-scripts/brand-names.js' CSV

-- new path:
COPY (SELECT row_to_json(r) FROM (select name from manufacturer) r ) TO '/Users/arobson/Sites/aboutmybike/test-scripts/manufacturers/brand-names.js';