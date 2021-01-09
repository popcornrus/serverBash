#!/bin/bash

clear

printf "Create Database\n"

printf "Enter DB name: "
read db_name

PSD=$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c12)

mysql 
