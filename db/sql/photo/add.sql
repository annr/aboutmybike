/*
    Inserts a new bike record.
*/
INSERT INTO ${schema~}.Photo(user_id, bike_id, original_file, file_path, metadata)
VALUES($1, $2, $3, $4, $5)
RETURNING *
