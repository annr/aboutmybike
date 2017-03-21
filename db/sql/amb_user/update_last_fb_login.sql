/*
  Update amb_user record
*/

UPDATE amb_user 
   SET last_login = now()
 WHERE facebook_id = $1