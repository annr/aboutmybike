/*
  Update amb_user password
*/

UPDATE amb_user 
   SET password = $2
 WHERE username = $1