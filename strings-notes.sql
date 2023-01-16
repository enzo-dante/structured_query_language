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

-- ? mySQL string commands

--      https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

-- ! SELECT + CONCAT() + AS

--      combine column data for cleaner output about printing values in labeled table

--      * INFERIOR SOLUTION

--          SELECT + CONCAT_WS(seperator, str1, str2)

SELECT
    title AS "Book Title",
    CONCAT(
        author_fname, " ", author_lname
    ) AS "Author Full Name"
FROM books;

-- ! SELECT + SUBSTRING(str, start, end)

--      print out only a sebset of a target string from start_index to end_index

SELECT
    SUBSTRING(
        "index starts at 1 in mySQL not 0 like other programming languages"
        7,
        26
    ) AS "String Subset";

-- ! SELECT + REPLACE()

--      in case-sensitive target_string, remove & replace substring

SELECT
    REPLACE(title, "e", "3")
FROM books;

-- ! SELECT + REVERSE()

--      prints out the string backwards

--      * INFERIOR SOLUTION: 

--           SELECT + SUBSTRING(target_string, negative_number)

-- * creates a palindrome (a word that reads the same forward & backwards)

SELECT
    CONCAT(
        "woof",
        REVERSE("woof")
    ) AS "Palindrome";


-- ! SELECT + CHAR_LENGTH()

--      returns number of characters in a target_string

SELECT
    title,
    CHAR_LENGTH(title) AS "Title Character Length"
FROM books
ORDER BY 2 DESC;


-- ! SELECT UPPER()

--      capitalize target_string 

SELECT
    UPPER(
        CONCAT(author_fname, " ", author_lname)
    ) AS "Capitalized Author Name"
FROM books;

-- ! SELECT + LOWER() = convert to all lower cases

--      lowercase target_string 

SELECT LOWER("WHY SO SERIOUS?");
