/*
  Update amb_user password
*/

UPDATE amb_user 
   SET username = $2
 WHERE id = $1