/*
  Selects user by either login value.
*/
   SELECT *
     FROM amb_user
    WHERE ($1 is not null and email = $1)
       OR ($2 is not null and username = $2)
    LIMIT 1;