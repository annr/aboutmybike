/*
  Update amb_user record
*/

UPDATE amb_user 
   SET verified = $2
 WHERE username = $1