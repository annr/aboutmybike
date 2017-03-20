/*
  Update bike record with more values
*/

UPDATE bike 
   SET serial_number = $1, 
       manufacturer_id = $2, 
       model_id = $3, 
       brand_unlinked = $4, 
       model_unlinked = $5,
       updated_at = now()
 WHERE id = $6