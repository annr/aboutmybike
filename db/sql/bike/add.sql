/*
    Inserts a new bike record.
*/
INSERT INTO ${schema~}.Bike(user_id, status)
VALUES($1, 1)
RETURNING *
