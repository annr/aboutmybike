/*
    Inserts a new user record.
*/

INSERT INTO amb_user(facebook_id, first_name, last_name, gender, email) 
VALUES($1, $2, $3, $4, $5)
RETURNING *
