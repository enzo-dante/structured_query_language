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

    mySQL string commands

        https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

    mySQL date and time functions

        https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
"""

-- ! WHERE equality

--      case-insensitive, specific filtering commands

SELECT * FROM cats WHERE age=4;

SELECT * FROM cats WHERE name='Egg';

-- ! WHERE column comparisons 

--      filters WHERE column variables equal each other

SELECT
    cat_id,
    age
FROM cats
WHERE cat_id=age;

-- ! WHERE inequality

--      filters WHERE query that does NOT equal column variable

SELECT title
FROM books
WHERE released_year != 2017;

SELECT
    title,
    author_lname
FROM books
WHERE author_lname != "Harris";

-- ! WILDCARDS + WHERE + LIKE

--      WILDCARDS (%) are used with WHERE + LIKE to filter anything before or after the approximator string

--          to use an actual % or _ symbol and the special character, than use an escape: \

-- * pattern matches: "da" + anything

SELECT
    author_fname,
    title
FROM books
WHERE author_fname LIKE "da%"
ORDER BY author_fname;

-- * pattern matche: anything + "da" 

SELECT
    author_fname,
    title
FROM books
WHERE author_fname LIKE "%da"
ORDER BY author_fname;

-- * pattern matches: anything + "da" + anything

SELECT
    author_fname,
    title
FROM books
WHERE author_fname LIKE "%da%"
ORDER BY author_fname;


-- ! SUBSTRING() + IN()

--      you can use SUBSTRING() with IN as well, but LIKE/WILDCARD is superior

-- * below examples produce the same output

SELECT
    title,
    CONCAT(
        author_lname, ", ", author_fname
    ) AS "Full Name"
FROM books
WHERE author_lname LIKE "C%"
    OR author_lname LIKE "S%"
ORDER BY author_lname;

SELECT
    title,
    CONCAT(
        author_lname,
        ", ",
        author_fname
    ) AS "Full Name"
FROM books
WHERE SUBSTRING(author_lname, 1, 1) IN("C", "S")
ORDER BY author_lname;

-- ! WHERE + _ 

--      using "_" to specify number of characters in WHERE LIKE query

--          to use an actual % or _ symbol and the special character, than use an escape: \

-- * the example below filters for values of 4 index value length

SELECT
    title,
    stock_quantity
FROM books
WHERE stock_quantity LIKE "____";

-- ! WHERE + LIKE + special_characters 

--      to use an actual % or _ symbol and the special character, than use an escape: \

-- * anything%anything

SELECT title
FROM books
WHERE title LIKE "%\%%";

-- * anything_anything

SELECT title
FROM books
WHERE title LIKE "%\_%";

-- ! WHERE + NOT LIKE + WILDCARDS

--      filter WHERE everything is NOT LIKE the provided WILDCARD

SELECT
    title
FROM books
WHERE title NOT LIKE "W%";

-- ! WHERE + GREATER THAN/LESS THAN

SELECT
    title,
    released_year
FROM books
WHERE released_year >= 2000;

SELECT
    title,
    released_year
FROM books
WHERE released_year <= 2000;

-- ! SELECT var1 > var2

--      return a boolean: 

--          1 (true) 

--          0 (false)

SELECT 1 > 2;

-- ! NO STRING COMPARISONS

--      avoid string comparisons since it varies by programming language

-- * SQL does not recognize upper or lowercase as different

SELECT 'A' > 'a';

-- ! WHERE + AND

--      using the AND operator with WHERE allows for chaining multiple operators

--      generally, do NOT use more than 3 logical operators in a single WHERE  

SELECT *
FROM books
WHERE author_lname="Eggers"
    AND released_year > 2010
    AND title LIKE "%novel%";

-- ! WHERE + OR

--      using the OR operator WHERE only 1 part of the expression has to be true to return true

--      generally, do NOT use more than 3 logical operators in a single WHERE  

SELECT
    title,
    author_lname,
    released_year,
    stock_quantity
FROM books
WHERE author_lname = "Eggers"
    OR reelased_year > 2010
    OR stock_quantity > 100;

-- ! CAST()

--      convert 1 data type to another data type

SELECT CAST("2017-05-02" AS DATETIME);

-- ! WHERE + BETWEEN x AND y

--      inclusively, SELECT data in a range

--      BETWEEN is a more efficient use of AND with >= or <= 

SELECT
    title,
    released_year
FROM books
WHERE released_year BETWEEN 2004 AND 2015;

-- ! BETWEEN x AND y + CAST()

SELECT
    name,
    birth_date
FROM people
WHERE
    birth_date BETWEEN CAST("1980-01-01" AS DATETIME)
    AND CAST("2000-01-01" AS DATETIME);

-- ! WHERE + NOT BETWEEN x AND y

--      inclusively, SELECT data NOT in the lower AND upper range

SELECT 
    title,
    released_year
FROM books
WHERE released_year NOT BETWEEN 2004 AND 2015;

-- ! WHERE + IN (list)

--      return set of values IN provided column

SELECT
    title,
    author_lname
FROM books
WHERE author_lname IN("Carver", "Lahiri", "Smith");

--      using IN is a superior to OR with long comma seperated values

SELECT
    title,
    author_lname
FROM books
WHERE author_lname = "Carver"
    OR author_lname = "Lahiri"
    OR author_lname = "Smith";

-- ! WHERE + NOT IN

--      return set of values NOT IN provided column

-- * example only returns odd released years after 2000

SELECT
    title,
    released_year
FROM books
WHERE released_year NOT IN (2000, 2002, 2004, 2006);

-- ! WHERE + MODULO operator

--      the modulo (%) is the remainder operator after a division

-- * is_odd, if there is a REMAINDER from a division of 2, else even

SELECT
    title,
    released_year
FROM books
WHERE released_year % 2 != 0;

-- ! WHERE + CASE_END_STATEMENTS + AS

--      if expression asserts true execute case functionality

-- * multiple WHEN = don't use commas

SELECT
    title,
    released_year,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 50
            THEN "*"
        WHEN stock_quanity BETWEEN 51 AND 100
            THEN "**"
        ELSE
            "***"
    END AS UPPER("Stock")
FROM books;

-- * using CASE_STATEMENTS with GROUP BY, COUNT, CONCAT, and ORDER BY 

SELECT
    title,
    author_lname,
    CASE
        WHEN COUNT(title) >= 2
            THEN CONCAT(
                COUNT(title), " ", "books"
            )
        ELSE
            CONCAT(COUNT(title), " ", "book")
    END AS "COUNT"
FROM books
GROUP BY author_lname, author_fname
ORDER BY "COUNT" DESC;