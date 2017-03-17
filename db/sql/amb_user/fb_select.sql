/*
  Selects user from Facebook login
*/
 
   SELECT u.*,
          user_photo.web_url as picture,
          bike.id as bike_id
     FROM amb_user u 
LEFT JOIN bike on bike.user_id = u.id
LEFT JOIN user_photo on user_photo.user_id = u.id
    WHERE u.facebook_id = $1 limit 1;