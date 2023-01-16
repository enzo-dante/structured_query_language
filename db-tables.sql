"""
    SQL formatter

        https://www.dpriver.com/pp/sqlformat.htm

    NUMERIC TYPES:

        INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT

        DECIMAL(total_num_digits, digits_after_decimal),
            for accounting, use DECIMAL() as default

        NUMERIC

        FLOAT

        DOUBLE

        BIT

    STRING TYPES:

        CHAR

        VARCHAR(n-length)

        BINARY

        VARBINARY

        BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB

        TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT

        ENUM

    DATE TYPES:

        DATETIME = DATE and TIME

        DATE = 'YYYY-MM-DD' format

        NOW() = give current date time

        TIME = 'HH:MM:SS'

        CURDATE() = give current date

        CURTIME() = give current time

        TIMESTAMP = only works in range 2038-1970

        YEAR

    mySQL date and time functions

        https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
"""

-- ! SQL vs mySQL

--      SQL is a query language

--      MySQL is a relational database that uses SQL to query a database
--          databases hold data tables: a collection of columns (headers) and rows (data)

-- ! SQL Rules

--      when creating a db, use a plural name

--      always use a ";" to end a command line 

-- ! db transactions integrity

--      database transactions must be ACID-compliant

--      ? Atomicity 
--          if a series of SQL statements change a db, either all of them are committed or none of them are committed

--      ? Consistency
--          before and after a transaction, the database is in a valid functional state

--      ? Isolation
--          until the changes are committed, the changes won't be visible to other connections: transactions cannot depend on each other

--      ? Durability
--          once the changes performed by a transaction are committed to the database, they are permanent. if a db crashes and rebooted the transactions are still there once it comes back up.

-- ! CREATE DATABASE 

--      create a new title database

CREATE DATABASE book_shop;

-- ! SHOW DATABASES

--      get a list of current databases

SHOW DATABASES;

-- ! USE 

--      identify which database to use

USE book_shop;

-- ! SELECT database();

--      tell currently used database

SELECT database();

-- ! CREATE TABLE IF NOT EXISTS

--      instantiate a table in easy to read multi-line composition

CREATE TABLE IF NOT EXISTS people(
    first_name VARCHAR(20),
    age INT
);

-- ! SHOW TABLES 

--      when in target db, show tables in current db

SHOW TABLES;

-- ! DESC + table 

--      when in target db, describe/show column structure from target table

DESC people;

SHOW COLUMNS FROM people;

-- ! DROP TABLE IF EXISTS

--      first, validate in target db, remove target table

SELECT database();

DROP TABLE IF EXISTS people;

-- ! DROP DATABASE

--      first, validate current database & data with SELECT, then drop db 

SELECT database();

SHOW TABLES; 

DROP DATABASE book_shop;

-- ! INSERT INTO table 

--      in a pre-existing table, each value has to correspond to the column data type

--      order of column arguments has to match value arguments

INSERT INTO people(first_name, age)
VALUES ("Enzo", 20), ("Gary", 45);

-- ? to insert a string (VARCHAR) value that contains quotations: 

-- * escape the quotes with a backslash:

--      "This text has \"quotes\" in it" or 'This text has \'quotes\' in it'

-- * alternate single and double quotes:

--      "This text has 'quotes' in it" or 'This text has "quotes" in it'

-- ! SELECT

--      select the data for viewing in a table when in a target db

SELECT * FROM people;

-- ! WARNINGS

--      when encountering an error instead of a warning

SHOW WARNINGS;

-- ! CREATE TABLE + NOT NULL

--      to enforce an inserting column value is NOT NULL when creating a table 

--      NULL = unknown value NOT zero 

CREATE TABLE cats(
    name VARCHAR(20) NOT NULL,
    age INT NOT NULL
);

-- ! CREATE TABLE + DEFAULT 

--      to set a default value, set DEFAULT and value when creating a table

CREATE TABLE cats(
    name VARCHAR(20) DEFAULT "unnamed",
    age INT DEFAULT 1
);

-- ! CREATE TABLE + DEFAULT + NOT NULL

--      using both DEFAULT + NOT NULL is NOT redundant because this prevents the user from manually inserting a NULL value

-- * ex) would insert a NULL value:

INSERT INTO cats(name, age)
VALUES("Hero", NULL);

-- * ex) PREVENT a NULL value and have a default value when creating a table

CREATE TABLE shows(
    title VARCHAR(20) NOT NULL DEFAULT "missing",
    genre VARCHAR(20) NOT NULL DEFAULT "NOT PROVIDED"
);

-- below would return an ERROR 

INSERT INTO shows(name, age)
VALUES("Breaking Bad", NULL);

-- ! CREATE TABLE + AUTO_INCREMENT + PRIMARY KEY

--      primary Keys are used as unique IDs for organizing data in a table that removes manual input for primary keys

CREATE TABLE cats(
    cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- when DESC a table, the key column would list PRI instead of empty 

DESC cats;

-- adding data that has a duplicate primary key, will return ERROR

INSERT INTO cats(cat_id, name, age)
VALUES (1, "fred", 33), (1, "steven", 27);

-- ? CRUD

--      create, read, update, delete

-- ! SELECT *

--      return all columns

SELECT * FROM cats;

-- ! SELECT + columns

--      can target 1 or more columns with a comma seperated list where list order matters

SELECT
    cat_id,
    name
FROM cats;

-- ! SELECT + DISTINCT

--      only returns unique column values 

SELECT DISTINCT
    author_fname,
    author_lname
FROM books;

-- ! ORDER BY 

--      used to sort results & ascending by default

--          using a number with ORDER BY is a shortcut to refer to a specific column

--          the column_name and the ORDER BY column_name don't have to match

SELECT
    name,
    age
FROM cats
ORDER BY age;

-- you can run an initial sort, and then a subsequent sort on the initially sorted return set 

SELECT
    cat_id,
    name
FROM cats
ORDER BY age, name;

-- ! DISTINCT + ORDER BY 

-- the example below will select all distinct last names from books and then ORDER BY descending order

SELECT
    DISTINCT title,
    pages
FROM books
ORDER BY released_year DESC;

-- ! WHERE + EQUALS

--      specific filtering commands that is case-insensitive

-- * below selects all columns from cats table where age is 4

SELECT * 
FROM cats
WHERE age=4;

-- * below selects all columns from cats table where name is Egg

SELECT *
FROM cats
WHERE name="Egg";

-- below allows you to compare columns

SELECT
    cat_id,
    age
FROM cats
WHERE cat_id=age;

-- ! WHERE + NOT EQUALS

--      filters WHERE query that does not equal variable

SELECT title
FROM books
WHERE released_year != 2017;

-- ! CAST() 

--      convert 1 data type to another data type

SELECT CAST("2017-05-02" AS DATETIME);

-- ! AS

--      specify alias for how data is presented from query

SELECT
    name AS "cat name",
    breed AS "cat breed"
FROM cats;

-- ! UPDATE

--      first SELECT then update existing table data

SELECT *
FROM shirts
WHERE color = "off white";

UPDATE shirts
    SET shirt_size = "XS", color = "not white"
    WHERE color = "off white";

-- ! DELETE + AUTO_INCREMENT PRIMARY KEY

--      first SELECT then remove existing table data

--      * without AUTO_INCREMENT PRIMARY KEY, the keys compensate for the deleted dataset

SELECT *
FROM cats
WHERE name = "Egg";

DELETE FROM cats
WHERE name = "Egg";

SELECT * FROM cats;

-- delete all enteries in table, but table shell remains

DELETE FROM cats;

-- ! LIMIT + ORDER BY

--      specifies a number for how many results selected

--      for pagination, you could use LIMIT to specify start point and how many to count

SELECT
    title,
    released_year
FROM books
ORDER BY released_year DESC
LIMIT 5;

-- ! CREATE VIEW + AS + INNER JOIN + USING

--      a view is a named query stored in the database catalog

CREATE VIEW IF NOT EXISTS
    customerPayments
AS
SELECT
    customerNumber,
    customerName,
    checkNumber,
    paymentDate,
    amount
FROM customers
INNER JOIN
    payments USING (customerNumber);

-- ! SELECT + FROM sqlite_schema 

--      get a list of all of the other tables, indexes, triggers, and views that are contained within the SQLite3 database.

SELECT name 
FROM sqlite_schema 
WHERE type = 'view';

-- ! SELECT + FROM sqlite_master 

--      for historical compatibility, get a list of all of the other tables, indexes, triggers, and views that are contained within the SQLite3 database.

SELECT name 
FROM sqlite_master 
WHERE type = 'view';

-- ! SELECT + FROM view 

--      query data from the customerPayments view using the SELECT statement

SELECT * FROM customerPayments;

-- ! DROP VIEW

--      removes view but not refereced data

DROP VIEW customerPayments;
























































