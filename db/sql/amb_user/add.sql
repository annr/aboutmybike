/*
  Inserts a new user record.
*/

INSERT INTO amb_user(email, username, password, verified)
VALUES($1, $2, $3, true)
RETURNING *
