/*
  Inserts a user photo (table is not yet used in app)
*/
INSERT INTO user_photo(user_id, web_url)
VALUES($1, $2)
RETURNING *
