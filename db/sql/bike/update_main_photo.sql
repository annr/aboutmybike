/*
  Update bike record's main photo path
*/

UPDATE bike 
   SET main_photo_id = $1,
       updated_at = now()
 WHERE id = $2