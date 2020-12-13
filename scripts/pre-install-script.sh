#!/bin/bash

echo "#--- PREPARING-DATA-FOLDERS ---#"
mkdir ../data;
mkdir ../data/html;
echo "#--- INITIALIZING-GIT-REPO ---#"
cd ../data/html;
git init;
git remote add origin-baseline git@github.com:jguilleoliva/asteg-framework.git;
git pull origin-baseline master;
echo "#--- PROCESS-COMPLETED ---#"
