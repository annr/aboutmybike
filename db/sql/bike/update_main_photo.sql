/*
  Update bike record's main photo path
*/

UPDATE bike 
   SET main_photo_path = $1
 WHERE id = $2