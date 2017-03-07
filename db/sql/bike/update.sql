/*
  Update bike record with basics
*/

UPDATE bike 
   SET description = $1, 
       nickname = $2, 
       type_ids = $3, 
       reason_ids = $4
 WHERE id = $5