/*
  Insert bike_info record.
*/
INSERT INTO bike_info(bike_id)
VALUES($1)
RETURNING *
