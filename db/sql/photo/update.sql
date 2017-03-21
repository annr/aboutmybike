/*
  Update photo record's file_path if nec (will overwrite) and set update_at.
*/

UPDATE photo 
   SET file_path = $2, 
       metadata = $3,
       updated_at = now()
 WHERE id = $1