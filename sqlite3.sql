"""
SQLite 3 documentation

    https://www.sqlite.org/docs.html

DATA TYPES

    NULL

        The value is a NULL value.

    INTEGER 

        The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.

    REAL

        The value is a floating point value, stored as an 8-byte IEEE floating point number.

    TEXT 

        The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE).

    BLOB

        The value is a blob of data, stored exactly as it was input.

STORAGE CLASS

    All values in SQL statements, whether they are literals embedded in SQL statement text or parameters bound to precomputed SQL statements have an implicit storage class.

SQLite3 TRANSACTIONS

    All committed changes to a database are known as a transaction

SQLite transaction commands 

    BEGIN TRANSACTION - manually start a transaction

    END TRANSACTION - ending a transaction automatically commits any changes to a db

    COMMIT - commit changes to a db, also ending it

    ROLLBACK - this rollsback any uncommitted changes and ends the transaction since the last commit

BINARY - Compares string data using memcmp(), regardless of text encoding.

NOCASE - It is almost same as binary, except the 26 upper case characters of ASCII are folded to their lower case equivalents before the comparison is performed.

RTRIM - The same as binary, except that trailing space characters, are ignored.
"""

-- ! JDBC: java database connectivity 

--      JDBC acts like the middleman between a java application and the data source

-- ! SQLite3 + JDBC

--      steps to connect SQLite 3 driver to JDBC

--          1. download sqlite-jdbc driver jar file from github and save to desired dir

--              https://github.com/xerial/sqlite-jdbc/releases

--          2. download DB Browser for SQLite from sqlite.org

--          3. create a new Intelli J java project with the command line template

--          4. open file drown down --- project structure --- Libraries --- plus symbol --- java

--          5. open sqlite-jdbc driver from saved location --- OK

--          6. define CONSTANTS for DB_NAME and CONNECTION_STRING outside of main method

--          7. define try and catch block inside main method

--          8. in try define and establish jdbc:sqlite connection

-- ! DB Browser for SQLite

--      a GUI for handling a SQLite DB which is compatible with JDBC

--      when you are using the GUI, the app will lock the DB file and wont be able to access the db from a java application
--          * SOLUTION: open file drown down and select 'close database' to release lock

-- ! TESTING 

--      always test SQL commands first, before coding them

--          1. open the target db, and then select Execute SQL view 

--          2. enter SQL command in top input box

--          3. select play button (cmd+R on a mac)

--          4. to manage multiple SQL commands: create new tab, with top left button in play button row

--          5. TEST sql command on multiple records (minimum 3) to validate consistency of output

-- ! JDBC Statement and Execute 

--      to execute SQL with JDBC, create Statement objects with the DriverManager connection

--      each SELECT having it's own statement ensures data integrity, especially if multiple SELECT are running concurrently
--          * you can reuse a statement object to execute multiple CRUD SQL commands BUT not SELECT commands

--      automatically commits all changes made to the connected db 
--          * unless explicitly disabled, will rollback to previous state if connection is closed

--              connection.SetAutoCommit(false);

-- in terminal, to access if installed, execute:

sqlite3

-- to exit sqlite3 shell

ctl+d

.quit

-- to list out all tables and respective structure (like DESC table), execute:

.schema

-- to list out all tables, execute:

.tables

-- to list out commands need to create current state of db as a transaction, execute:

.dump

-- to list out headers of columns in sql shell, execute:

.headers on

-- to clear log, execute:

ctl+ l

-- to backup current db, execute:

.backup {back_db_name}

-- to restore db to previous state, execute:

.restore {back_db_name}

-- when creating a table, you can add a IF NOT EXISTS to the SQL command to prevent errors

IF NOT EXISTS

-- SQLite 3 concat

string_1 || string_2

ex: 'this is a test'

SELECT 'this is a ' || 'test' 

-- Comment Out Code highlight target code and on Mac press: 

CMD + / 

COLLATE {arg}

-- the sql commands don't have to be capatalized, but it helps distinguish

CREATE DATABASE <plural_database_name>;

SHOW DATABASES;

-- when dropping a db, check with SELECT that data is not essential 
-- if you delete a database use you are currently using, the SELECT database(); command will return NULL

DROP DATABASE <database_name>;

-- USE = tells mysql which database to use 

USE <database_name>; 

-- SELECT database() prints out the name of current database being utilized

SELECT database();

-- CREATE TABLE IF NOT EXISTS = instantiate a table in easy to read multi-line composition

CREATE TABLE IF NOT EXISTS pastries
    (
        name VARCHAR(50), 
        quantity INT
    );

-- note that SIZE is a reserved SQL keyword so do not use it

CREATE TABLE shirts(
    shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(100),
    color VARCHAR(100),
    shirt_size VARCHAR(1),
    last_worn INT NOT NULL DEFAULT 0
);

-- SHOW TABLES = when in target db, show tables in current db

SHOW TABLES;

-- DESC = when in target db, describe/show column structure from target table

DESC <table_name>;

SHOW COLUMNS FROM <table_name>;

-- when in target db, remove target table

DROP TABLE IF EXISTS <table_name>;

"""
insert data into a table in a target db

each value has to correspond to the column data type

order of column arguments has to match value arguments
"""

INSERT INTO <table_name>
	(
		column_name,
		column_name
	)
VALUES
	(
		value,
		value
	);

-- INSERT INTO = insert multiple values into a table in a target db

INSERT INTO verbs(
        name,
        age
    )
    VALUES
        ('Peanut', 4),
        ('Butter', 10),
        ('Jelly', 7);

-- SELECT = select the data for viewing in a table when in a target db

SELECT * FROM <table_name>;

-- escape the quotes with a backslash:

"This text has \"quotes\" in it" or 'This text has \'quotes\' in it'

-- alternate single and double quotes:
"This text has 'quotes' in it" or 'This text has "quotes" in it'

"""
mysql warnings

if you encounter an error instead of a warning, the solution is to run the following command in your mysql shell

if a VARCHAR(5) column, has a string that exceeds 5 characters
"""

set sql_mode='';

SHOW WARNINGS;

"""
NULL = unknown value

null DOES NOT mean zero
"""

-- to enforce NOT NULL when creating a table

CREATE TABLE cats2
	(
		name VARCHAR(100) NOT NULL,
		age INT NOT NULL
	);

-- to set a default value, set DEFAULT and value when creating a table

CREATE TABLE cats3
	(
		name VARCHAR(100) DEFAULT 'unnamed',
		age INT DEFAULT 99
	);

-- using both DEFAULT VALUES and NOT NULL

-- This is not redundant because this prevents the user from manually inserting a NULL value

-- Below ex would insert a NULL value:

INSERT INTO cats3(name, age) VALUES('Montana', NULL);

-- Below ex would prevent a NULL value and have a default value when creating a table:

CREATE TABLE cats5
	(
		name VARCHAR(4) NOT NULL DEFAULT 'unnamed',
		age INT NOT NULL DEFAULT 99
	);

-- below ex would return an ERROR:

INSERT INTO cats5
    (
        name,
        age
    )
    VALUES
    ('Cali', NULL);

-- primary Keys are used as unique IDs for organizing data in a table

-- when DESC a table, the key column would list PRI instead of empty

-- if you attempt to add data that has a duplicate primary value, will return ERROR

CREATE TABLE cats6
	(
		cat_id INT NOT NULL PRIMARY KEY,
		name VARCHAR(100),
		age INT,
	);

INSERT INTO cats6
    (cat_id, name, age)
    VALUES
    (1, 'fred', 33);

-- AUTO_INCREMENT PRIMARY KEY removes manual input for Primary Keys

CREATE TABLE cats7
	(
		cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(100),
		age INT,
	);

-- CRUD = create, read, update, delete

-- read = SELECT and * = return all columns

SELECT * FROM cats;

-- can target single or multiple columns with a comma seperated list

-- list order matters because it determine presentation

SELECT
    cat_id,
    name
FROM cats;

SELECT
    name,
    age
FROM cats;

-- WHERE = specific filtering commands

SELECT * FROM cats WHERE age=4;

SELECT * FROM cats WHERE name='Egg';

-- below allows you to compare columns

SELECT
    cat_id,
    age 
FROM cats
WHERE cat_id = age;

-- filters WHERE query that does not equal variable

SELECT
    title
FROM books
WHERE released_year != 2017;
 
SELECT
    title,
    author_lname
FROM books
WHERE author_lname != 'Harris';

-- CAST() = convert 1 data type to another data type

SELECT CAST('2017-05-02' AS DATETIME);

-- AS = specify alias for how data is presented from query

SELECT
    name AS 'cat_name',
    breed AS 'type_of_cat'
FROM cats;

-- UPDATE = change existing data; process should be use SELECT to target desired data set before using UPDATE

SELECT * FROM cats
	WHERE color='off white';

UPDATE shirts
    SET shirt_size='XS', color='not white'
    WHERE color='off white';

"""
DELETE = remove existing data

process should be use SELECT to target desired data set before using DELETE

when data is deleted and there is an AUTO_INCREMENT PRIMARY KEY, the keys don't shift to compensate for the deleted dataset
"""

SELECT * FROM cats
    WHERE name='Egg';

DELETE FROM cats
    WHERE name='Egg';

SELECT * FROM cats;

-- delete all enteries in table, but table shell remains

DELETE FROM <table_name>

-- SELECT DISTINCT only returns unique column values 

SELECT DISTINCT <column_name> FROM <table_name>;

SELECT DISTINCT
    CONCAT_WS(
        ' ',
        author_fname,
        author_lname
    ) AS 'authors full name'
FROM books;

SELECT DISTINCT
    author_fname,
    author_lname
FROM books;

-- ORDER BY is used to sort results

-- ASC (ascending) by default

SELECT 
    <column_name>
FROM <database_name>
    ORDER BY <column_name>;

-- using a number with ORDER BY is a shortcut to refer to a specific column

SELECT
    title
        AS 'column 1',
    author_fname
        AS 'column 2',
    author_lname
        AS 'column 3'
FROM books
    ORDER BY 2;

-- you can run an initial sort, and then a subsequent sort on the initially sorted return set by adding multiple <column_names-- in a comma seperated list

SELECT
    title
        AS 'column 1',
    author_fname
        AS 'column 2',
    author_lname
        AS 'column 3'
FROM books
    ORDER BY 2, 3;

-- select all distinct last names from books and then ORDER BY descending order

SELECT DISTINCT
    author_lname
FROM books
    ORDER BY author_lname DESC;

-- the <column_name> and the ORDER BY <column_name> don't have to match

SELECT DISTINCT
    title,
    pages
FROM books
    ORDER BY released_year;

-- LIMIT specifies a number for how many results selected

SELECT
    title,
    released_year
FROM books
    ORDER BY released_year DESC
    LIMIT 5;

-- for pagination, you could use LIMIT to specify start point and how many to count

SELECT
    title,
    released_year
FROM books
    ORDER BY released_year DESC
    LIMIT 4, 5;

-- MySQL creates the view (a named query) and stores it in the database 

CREATE VIEW customerPayments
AS
SELECT
    customerName,
    checkNumber,
    paymentDate,
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);

-- Now, you can reference the view as a table in SQL statements. For example, you can query data from the customerPayments view using the SELECT statement:

SELECT * FROM customerPayments;

-- remove view but not refereced data

DROP VIEW {view_name};

"""
mySQL database triggers: SQL statements that are automatically run when a specific table is changed
"""

-- to see the SQL db triggers in a, execute in mysql:

SHOW TRIGGERS;

-- remove a SQL db trigger

DROP TRIGGER <trigger_name>;

-- trigger syntax

trigger_time: BEFORE, AFTER

trigger_event: INSERT, UPDATE, DELETE

ON

table_name: photos, users

-- boilerplate db trigger template

DELIMITER $$

CREATE TRIGGER trigger_name
    trigger_time trigger_event ON table_name FOR EACH ROW
    BEGIN
    END;
$$

DELIMITER ;

"""
controversial SQL db trigger use: logic enforcement

triggers make debugging extremly hard, be very careful about using SQL db triggers

it would be better to simply write valdiation checks on the frontend instead of relying on the db to handle these checks
"""

-- it is possible to have db validation checks using SQL db triggers

DROP TABLE IF EXISTS users;

CREATE TABLE users(
    username VARCHAR(100),
    age INT
);

INSERT INTO users(username, age)
VALUES ('bobby', 23);

SELECT *
FROM users;

"""
DELIMITER = signal that indicates end of code line for execution

multiple line statements require multiple semicolons with arbitrary define DELIMITER
"""

-- $$ = arbitrary defined DELIMITER (can be anything like for ex: //)
DELIMITER $$
    <code_block--
$$

-- if you change the DELIMITER temporarily, make to change it back to a semicolon with--

DELIMITER ;

"""
BEFORE validation trigger

NEW = new data being INSERT
OLD = pre-existing data for DELETE
FOR EACH ROW = standard validation syntax
SQLSTATE = values with message string, common for errors
45000 = generic state representing 'unhandled user-defined exception'
"""

-- check if new user is younger than 18, throw error if true to BEFORE INSERT
-- example treats code between $$ as 1 chunk of code

DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON users FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$

DELIMITER ;

INSERT INTO users(username, age) VALUES('test', 14);

-- ex 2:

DELIMITER $$

CREATE TRIGGER prevent_self_follow
    BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
        IF NEW.follower_id = NEW.followee_id
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You cannot follow yourself';
        END IF;
    END;
$$

DELIMITER ;

"""
CREATE new data based on another action

AFTER DELETE, INSERT new row INTO TABLE that does not exist yet
"""

-- option 1:

DELIMITER $$

CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows(follower_id, followee_id)
        VALUES(OLD.follower_id, OLD.followee_id);
    END;
$$

DELIMITER ;

-- option 2:

DELIMITER $$

CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows
        SET follower_id = OLD.follower_id,
            followee_id = OLD.followee_id;
    END;
$$

DELIMITER ;