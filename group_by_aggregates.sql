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

-- ! GROUP BY 

--      aggregates identical data into single rows

SELECT
    author_lname,
    COUNT(*)
FROM books
GROUP BY author_lname;

-- ! GROUP BY + COUNT()

--      COUNT() will tally column_name entries

--      COUNT(*) will count all (*) rows are GROUP BY respective author

SELECT COUNT(*)
FROM books
GROUP BY author_lname;

-- ! DISTINCT + COUNT()

--      by default COUNT does not filter for unique values, you need DISTINCT 

-- * return only rows that have BOTH a unique author_fname and author_lname

SELECT
    COUNT(
        DISTINCT author_fname, author_lname
    )
FROM books;

-- ! GROUP BY + SUM()

--      adds all the subcategory data together

SELECT
    author_fname,
    author_lname,
    SUM(pages) AS "Total Pages Written"
FROM books
GROUP BY author_fname, author_lname
ORDER BY "Total Pages Written" DESC;

-- ! GROUP BY + AVG()

--      another common use is to use GROUP BY to calculate average

-- * ex) calculate the average stock quantity for books released in the same year

SELECT
    released_year,
    AVG(stock_quantity)
FROM books
GROUP BY released_year;

-- ! GROUP BY + MIN/MAX 

--      find minimum and maximum respectively in a table

-- * ex) find the year each author published their first book

SELECT
    author_fname,
    author_lname,
    MIN(released_year)
FROM books
GROUP BY author_lname, author_fname;

-- * ex) find the longest page count for each author

SELECT
    author_fname,
    author_lname,
    MAX(pages) 
FROM book
GROUP BY author_fname, author_lname;


-- ! ORDER BY + LIMIT

--      ORDER BY yields superior performance compared to MIN/MAX 

SELECT *
FROM books
ORDER BY pages
    LIMIT 1 DESC;

-- ! SUBQUERY

--      use a subquery with an inner SELECT 

-- * execution: starts in the middle and works it's way out

SELECT
    title,
    pages
FROM books
WHERE pages = (
    SELECT
        MAX(pages)
    FROM books
);