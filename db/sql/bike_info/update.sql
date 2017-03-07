/*
  Update bike_info record.
*/
UPDATE bike_info
   SET color = $1,
       era = $2
 WHERE bike_id = $3