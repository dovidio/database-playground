#!/bin/bash
CONTAINER_ID=$(docker inspect -f '{{.Id}}'  oracle_database_1)
docker exec -t oracle_database_1 mkdir -p data/db-book-data
docker cp db-book-data/DDL.sql $CONTAINER_ID:/data/db-book-data/DDL.sql
docker cp db-book-data/DML.sql $CONTAINER_ID:/data/db-book-data/DML.sql

echo CREATING THE SCHEMA...
docker exec oracle_database_1 sqlplus sys/oracle@//localhost:1521 as sysdba @data/db-book-data/DDL.sql > /dev/null
if [ $? -eq 0 ]; then
   echo CREATING SCHEMA WAS SUCCESSFUL!
else
   echo CREATING SCHEMA FAILED!
fi

echo IMPORTING DATA...
docker exec oracle_database_1 sqlplus sys/oracle@//localhost:1521 as sysdba @data/db-book-data/DML.sql > /dev/null
if [ $? -eq 0 ]; then
   echo IMPORTING DATA WAS SUCCESSFUL!
else
   echo IMPORTING DATA FAILED!
fi