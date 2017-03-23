#!/bin/sh

# to create the base amb db from a new instance

# requires host passed:

if [[ $# -eq 0 ]] ; then
  echo 'you need to pass the host like this: -> ./amb_base.sh amb-staging.crufdsximznc.us-west-1.rds.amazonaws.com'
  exit 0
fi

#psql  -f ./schema.sql  --host $1    --port 5432    --username arobson    --dbname amb

# countries.sql   manufacturers.sql reasons.sql   types.sql   users.sql

psql  -f ./base_app_content/countries.sql  --host $1    --port 5432    --username arobson    --dbname amb
psql  -f ./base_app_content/users.sql  --host $1    --port 5432    --username arobson    --dbname amb
psql  -f ./base_app_content/reasons.sql  --host $1    --port 5432    --username arobson    --dbname amb
psql  -f ./base_app_content/types.sql  --host $1    --port 5432    --username arobson    --dbname amb
psql  -f ./base_app_content/manufacturers.sql  --host $1    --port 5432    --username arobson    --dbname amb