# npm install dependencies

if downloaded from Github, package.json is already contains necessary packages and simply ignore below steps, cd into root project dir, and execute:

npm install

1. to instantiate a package.json file in project dir in goormIDE, execute: 

npm init 

a package.json file will store and save the project dependencies packages and their respective versions for the project to function

2. next, to install express execute:

npm install express --save

the option save will save the express package to the package.json file

3. install faker and mysql packages by executing:

npm install faker, mysql --save

4. install ejs to build frontend

npm install --save ejs

5. install body-parser for express post requests

npm install --save body-parser

6. create public dir in root project dir

mkdir public

7. create an app.css file in public dir

touch app.css

8. in root dir, create an app.js file

9. verify that app.js file has app.css file connected via express

app.use(express.static_dirname + '/public');

# mysql

In terminal, access mySQL and create database explicitly with below name for mySQL connection

mysql-ctl cli

CREATE DATABASE tribe_called_sql;

USE tribe_called_sql;

# users TABLE schema.sql

check that the schema.sql is in the root project folder

in mysql, execute:

source schema.sql

# generate faker dataset

to generate random 500 users, in goormIDE terminal that is in the root folder of the startup.js file execute:

node startup.js

# Establish mysql connection with node mysql package explicitly with below credentials

const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'tribe_called_sql'
});

# app listen on port 3000

to start the app in goormIDE, cd into project dir from terminal and execute:

node app.js

to preview the app in goormIDE, select the prevew dropdown or copy the URL and manually enter the desired endpoint
