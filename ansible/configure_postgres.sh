#!/bin/bash

#PSQL variables
psqlUser='postgres'
psqlPassword='PassMe12#$'
psqlIGUSER='image_gallery'
psqlIGpass='simple'
db=image_gallery

RUN_AS_POSGRES="psql -X -U $psqlUser password=$psqlPassword --set ON_ERROR_STOP=on"
RUN_AS_IG="psql -X -U $psqlIGUSER password=$psqlIGpass --set ON_ERROR_STOP=on"

$RUN_AS_POSGRES << PSQL
CREATE USER image_gallery login password 'simple';
GRANT image_gallery to postgres;
CREATE DATABASE image_gallery owner image_gallery;
PSQL

$RUN_AS_IG << PSQL
CREATE TABLE USERS (username varchar(100) NOT NULL PRIMARY KEY, password varchar(100), full_name varchar(200));

PSQL

if [ $? -eq 0 ]; then
    echo "Success! DBs, Users, and PWs created."
else
    echo "Stopped due to an error. Try again."
fi