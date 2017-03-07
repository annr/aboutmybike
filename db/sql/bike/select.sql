/*
  Selects specific bike by id with details to show on bike detail page.
*/
   SELECT b.*, 
          type.label AS type, 
          amb_user.username AS username, 
          type.id AS type_id, 
          Coalesce(manufacturer.name, b.brand_unlinked) AS manufacturer_name, 
          Coalesce(model.name, b.model_unlinked) As model_name, 
          bike_info.era AS era, 
          bike_info.color AS color 
     FROM bike b 
LEFT JOIN bike_info ON b.id = bike_info.bike_id 
LEFT JOIN manufacturer ON b.manufacturer_id=manufacturer.id 
LEFT JOIN model ON b.model_id=model.id
LEFT JOIN type on b.type_ids[1]=type.id
LEFT JOIN amb_user ON b.user_id=amb_user.id 
    WHERE b.id = $1