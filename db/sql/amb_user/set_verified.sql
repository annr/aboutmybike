/*
  Update amb_user record
*/

UPDATE amb_user 
   SET verified = true
 WHERE id = $1