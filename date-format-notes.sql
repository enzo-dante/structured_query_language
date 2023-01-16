"""
mySQL string commands

    https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

mySQL date and time functions:

    https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format

------

DATETIME = DATE and TIME

DATE = 'YYYY-MM-DD' format

NOW() = give current date time

TIME = 'HH:MM:SS'

CURDATE() = give current date

CURTIME() = give current time

TIMESTAMP = only works in range 2038-1970

YEAR
"""

-- SELECT DATE_FORMAT()

--      using DATE_FORMAT is the best way to handle printing dates

SELECT
    DATE_FORMAT(
        birth_date,
        "Was born on %W"
    )
FROM people;

SELECT
    DATE_FORMAT(
        birth_date,
        "%m%d%Y"
    )
FROM people;

-- SELECT NOW();
--      Get current date and time

-- SELECT CURDATE();
--      Get current date

-- SELECT CURTIME();
--      Get current time

INSERT INTO people(name, birth_date, birth_time, birth_date_time)
VALUES
    ("Ben", CURDATE(), CURTIME(), NOW()),
    ("Sara", CURDATE(), CURTIME(), NOW());


-- SELECT DAY();

--      get day and returns either a number or day from DATETIME or DATE

-- SELECT DAYNAME();

--      get day and returns either a number or day from DATETIME or DATE

-- SELECT DAYOFWEEK();

--      get day and returns either a number or day from DATETIME or DATE

SELECT
    name,
    DAY(birth_date),
    DAYNAME(birth_date_time),
    DAYOFWEEK(birth_date_time)
FROM people;

-- SELECT MONTH();

--      extract day and returns either a number or day from DATETIME or DATE

SELECT
    name,
    MONTH(birth_date_time)
FROM people;

-- SELECT MONTHNAME()

--      extract day and returns either a number or day from DATETIME or DATE

SELECT
    name,
    MONTHNAME(birth_date)
FROM people;

-- SELECT HOUR(), MINUTE(), SECOND()

--      extracts requested time interal from TIME data type

SELECT
    name,
    HOUR(birth_time),
    MINUTTE(birth_time),
    SECOND(birth_time)
FROM people;



-- TIMESTAMP DEFAULT NOW()

--     table data type: using TIMESTAMP is only really useful when DEFAULT NOW() is included

CREATE TABLE comments(
    content VARCHAR(100),
    create_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO comments(content)
VALUES
    ("I found this offensive"),
    ("Hello, where are you going?");

SELECT *
FROM comments
ORDER BY created_at DESC;

-- TIMESTAMP DEFAULT NOW() ON UPDATE NOW()

--      table data type: ON UPDATE NOW() will update timestamp with current timestamp
--      for each time a row is updated

CREATE TABLE more_comments(
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
);

INSERT INTO more_comments(content)
VALUES
    ("How weird"),
    ("This cannot be real");

SELECT *
FROM more_comments
ORDER BY changed_at DESC;


-- SELECT DATEDIFF()

--      will tell you difference between dates in days

SELECT
    name,
    birth_date,
    DATEDIFF(
        NOW(),
        birth_date
    ) AS "days old"
FROM people
ORDER BY "days old" DESC;


-- SELECT + INTERVAL

--      adds specified interval to provided date
--      MUST specify the interval and time type

SELECT
    birth_date,
    birth_date + INTERVAL 1 MONTH AS "adding 1 month"
FROM people;


-- SELECT - INTERVAL

--      subtracts specified interval to provided date
--      MUST specify the interval and time type

SELECT
    birth_date,
    birth_date - INTERVAL 1 MONTH AS "subtracting 1 month"
FROM people;

-- SELECT + INTERVAL "+" and "-"

--      MUST specify the interval and time type

SELECT
    birth_date,
    birth_date - INTERVAL 1 MONTH + INTERVAL 10 HOUR
FROM people;

