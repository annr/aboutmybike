/*
    Inserts a new bike record.
*/
INSERT INTO ${schema~}.Photo(user_id, bike_id, original_file, file_path)
VALUES($1, $2, $3, $4)
RETURNING *
