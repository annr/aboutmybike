/*
  Update bike record with basics
*/

-- [fields.description, fields.nickname, ${fields.type_id}, ${fields.reasons}  parseInt(fields.bike_id)])

UPDATE bike 
   SET description = $1, 
       nickname = $2, 
       type_ids = $3, 
       reason_ids = $4
 WHERE id = $4