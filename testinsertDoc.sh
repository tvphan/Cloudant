Shell script to test insert doc

#!/bin/bash

dbUrl = “https://tphan.cloudant.com”
dbName = “test”
dbUser = “tphan”
dbPass = “password”

## to check DB connection

curl -u $dbUser:$dbPass “https://$dbUser.cloudant.com/$dbName” -X GET

if [ $? -eq 0 ]
then
  echo “DB exist”
else
  echo "Could not connect to DB” >&2
  ## Create DB
  curl -u $dbUser:$dbPass “https://$dbUser.cloudant.com/$dbName” -X PUT
fi

## Create a document
curl -u $dbUser:$dbPass “https://$dbUser.cloudant.com/$dbName/doc_name” -X PUT -H content-type:application/json -d '{"foo":"bar"}'
if [ $? -eq 0 ]
then
   ## check Document inserted successfully
   curl -u $dbUser:$dbPass “https://$dbUser.cloudant.com/$dbName/doc_name” -X GET
else
   echo “Failed to insert Document!!!”  
   exit

fi



