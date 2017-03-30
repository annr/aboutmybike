/*
  Update amb_user record
*/

UPDATE amb_user 
   SET bio = $2,
       website = $3
 WHERE id = $1