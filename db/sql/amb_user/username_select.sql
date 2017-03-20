/*
  Selects user by username
*/
   SELECT u.*,
          user_photo.web_url as picture,
          bike.id as bike_id,
          photo.file_path as bike_main_photo,
          to_char(u.created_at, 'Month DD, YYYY') as join_date
     FROM amb_user u 
LEFT JOIN bike on bike.user_id = u.id
LEFT JOIN photo ON bike.main_photo_id = photo.id
LEFT JOIN user_photo on user_photo.user_id = u.id
    WHERE u.username = $1 limit 1;