/*
  Update amb_user username
*/

UPDATE amb_user 
   SET username = $2,
       verified = true
 WHERE id = $1