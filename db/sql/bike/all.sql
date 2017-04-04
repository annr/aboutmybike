/*
  Selects bikes with details for showing on the grid
  the values we need for the grid are currently: era, type, description, username (placeholder for now)
*/
   SELECT b.*,
          photo.file_path as main_photo_path, 
          type.label AS type,
          bike_info.era AS era
     FROM bike b 
LEFT JOIN bike_info ON b.id = bike_info.bike_id
LEFT JOIN amb_user ON b.user_id = amb_user.id
LEFT JOIN photo ON b.main_photo_id = photo.id
LEFT JOIN type on b.type_ids[1]=type.id
    WHERE b.description IS NOT null 
      AND b.status != -1
      AND amb_user.verified = true
    ORDER BY b.created_at DESC