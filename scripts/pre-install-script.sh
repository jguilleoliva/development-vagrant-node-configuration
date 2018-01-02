#!/bin/bash

echo "#--- PREPARING-DATA-FOLDERS ---#"
mkdir ../data;
mkdir ../data/html;
mkdir ../data/mysql;
echo "#--- INITIALIZING-GIT-REPO ---#"
cd ../data/html;
git init;
git remote add origin git@bitbucket.org:astegconsultores/framework-nine-web.git;
git pull origin master;
echo "#--- PROCESS-COMPLETED ---#"
