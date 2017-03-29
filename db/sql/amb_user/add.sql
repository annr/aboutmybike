/*
  Inserts a new user record.
*/

INSERT INTO amb_user(email, username, password)
VALUES($1, $2, $3)
RETURNING *
