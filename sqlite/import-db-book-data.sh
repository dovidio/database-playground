#!/bin/bash
CONTAINER_ID=$(docker inspect -f '{{.Id}}'  sqlite_db_1)

docker exec sqlite_db_1 bash -c 'mkdir /db-book-data'

docker cp db-book-data/DDL.sql $CONTAINER_ID:/db-book-data/DDL.sql
docker cp db-book-data/DML.sql $CONTAINER_ID:/db-book-data/DML.sql

docker exec sqlite_db_1 bash -c 'rm dbbook.db > /dev/null && touch dbbook.db' > /dev/null

echo CREATING THE SCHEMA...
docker exec sqlite_db_1 bash -c 'sqlite3 dbbook.db < /db-book-data/DDL.sql' > /dev/null
if [ $? -eq 0 ]; then
   echo CREATING SCHEMA WAS SUCCESSFUL!
else
   echo CREATING SCHEMA FAILED!
fi

echo IMPORTING DATA...
docker exec sqlite_db_1 bash -c 'sqlite3 dbbook.db < /db-book-data/DML.sql' > /dev/null
if [ $? -eq 0 ]; then
   echo IMPORTING DATA WAS SUCCESSFUL!
else
   echo IMPORTING DATA FAILED!
fi