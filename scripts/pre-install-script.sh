#!/bin/bash

echo "#--- PREPARING-DATA-FOLDERS ---#"
mkdir ../data;
mkdir ../data/html;
echo "#--- INITIALIZING-GIT-REPO ---#"
cd ../data/html;
git init;
git remote add origin git@bitbucket.org:astegconsultores/baseline-framework-ninesix.git;
git pull origin master;
echo "#--- PROCESS-COMPLETED ---#"
