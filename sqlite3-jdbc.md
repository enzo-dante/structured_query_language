# Constants

use Constants for static variables for scalability

hard coding static variables is a bad practice because it makes updating very error-prone

```
    public static final String DB_NAME = "testjava.db";
    public static final String CONNECTION_STRING = "jdbc:sqlite:/Users/enzo_dante/git/java/projects/TestDB/"+DB_NAME;

    public static final String TABLE_CONTACTS = "contacts";

    public static final String  COLUMN_NAME = "name";
    public static final String  COLUMN_PHONE= "phone";
    public static final String  COLUMN_EMAIL = "email";

    public static void main(String[] args) {

        // JDBC 4.0+ connectivity method
        try {
            // create new SQLite db and establish connection to new SQLite db in project dir
            Connection connection = DriverManager.getConnection(CONNECTION_STRING);

        } catch(SQLException e) {
            System.out.println("Something went wrong: " + e.getMessage());
        }
    }
```

# error troubleshooting

after adding new code, always run to make sure it doesn't break and reduce having to look for long periods of time

if you get an error, execute in the catch block:
- the bottom section of the error should highlight the line(s) in the code where there is an error

```
catch(SQLException e) {
    System.out.println("Something went wrong: " + e.getMessage());
    e.printStackTrace();
}
```

# SELECT

> SELECT superior option
>
> statement.executeQuery();

superior because it uses less code and uses CONSTANTS

```
    // with new statement, SELECT target data
    Statement statement = connection.createStatement();
    statement.executeQuery("SELECT * FROM contacts;");

    ResultSet results = statement.executeQuery("SELECT * FROM " + TABLE_CONTACTS);

    while(results.next()) {
        System.out.println(
                results.getString(COLUMN_NAME) + " " + results.getString(COLUMN_PHONE) + " " + results.getString(COLUMN_EMAIL)
        );
    }

    // make sure to always close ResultSet connection after a SELECT SQL statement
    results.close();

```
> SELECT: inferior option
>
> statement.execute();

```
    // with new statement, SELECT target data
    Statement statement = connection.createStatement();
    statement.execute("SELECT * FROM contacts;");
    ResultSet results = statement.getResultSet();
    while(results.next()){
        System.out.println(
                results.getString("name") + " " +
                results.getInt("phone") + " " +
                results.getString("email")
        );
    }

    // make sure to always close ResultSet connection after a SELECT SQL statement
    results.close();
```

> DROP IF EXISTS

```
    statement.execute("DROP TABLE IF EXISTS" + TABLE_CONTACTS);

    // close statement instances first and then db connection to prevent performance degradation
    statement.close();
    connection.close();
```

> CREATE IF NOT EXISTS

```
    // to execute SQL with JDBC, create Statement objects with the DriverManager connection
    Statement statement = connection.createStatement();
    statement.execute("CREATE TABLE IF NOT EXISTS " + TABLE_CONTACTS +
            "(" + COLUMN_NAME + " TEXT, " + COLUMN_PHONE + " INTEGER, " + COLUMN_EMAIL + " TEXT " + ");"
            );

    // close statement instances first and then db connection to prevent performance degradation
    statement.close();
    connection.close();
```

> INSERT

since Java uses double quotes for Strings, the String values need to be in single quotes

it is also possible to break up a SQL command in JDBC with concatenating string connected by +

```
    statement.execute("INSERT INTO " + TABLE_CONTACTS + "(" + COLUMN_NAME + ", " + COLUMN_PHONE + ", " + COLUMN_EMAIL + ") VALUES('test', 1112223333, 'test@gmail.com')");

    // close statement instances first and then db connection to prevent performance degradation
    statement.close();
    connection.close();
```

> UPDATE

```
    // reuse statement and update target row
    statement.execute("UPDATE contacts SET phone=9998887777 WHERE name='Enzo';");

    // close statement instances first and then db connection to prevent performance degradation
    statement.close();
    connection.close();
```

> DELETE

```
    statement.execute("DELETE FROM contacts WHERE name='Ryan';");

    // close statement instances first and then db connection to prevent performance degradation
    statement.close();
    connection.close();
```

# review SQL commands with DB Browser with SQLite

1. open DB Browser with SQLite
2. select Open Database panel and select & open target db
2. select Browse Data view

# modularizing code

when possible for readability and scalability, avoid large blocks of code separate logic with insulated methods

```
    // note that the VALUES section is using single quotes so that the SQL double quotes command doesn't throw an error
    private static void insertContact(Statement statement, String name, Integer phone, String email) throws SQLException {
        statement.execute("INSERT INTO " + TABLE_CONTACTS + "(" + COLUMN_NAME + ", " + COLUMN_PHONE + ", " + COLUMN_EMAIL + ") VALUES('" + name + "', " + phone + ", '" + email + "');");
    }
```

# source code for JDBC practice

__this is not the best implementation, but it does show how SQL and JDBC communication with best practice CONSTANTS__

```
package com.crownhoundz;

import java.sql.*;

public class Main {

    public static final String DB_NAME = "testjava.db";
    public static final String CONNECTION_STRING = "jdbc:sqlite:/Users/enzo_dante/git/java/projects/TestDB/"+DB_NAME;

    public static final String TABLE_CONTACTS = "contacts";

    public static final String  COLUMN_NAME = "name";
    public static final String  COLUMN_PHONE= "phone";
    public static final String  COLUMN_EMAIL = "email";

    public static void main(String[] args) {

        // JDBC 4.0+ connectivity method
        try {
            // create new SQLite db and establish connection to new SQLite db in project dir
            Connection connection = DriverManager.getConnection(CONNECTION_STRING);

            // to execute SQL with JDBC, create Statement objects with the DriverManager connection
            Statement statement = connection.createStatement();

            // remove table for clean db if it exists
            statement.execute("DROP TABLE IF EXISTS " + TABLE_CONTACTS);

            // SQL CRUD
            statement.execute("CREATE TABLE IF NOT EXISTS " + TABLE_CONTACTS +
                   "(" + COLUMN_NAME + " TEXT, " + COLUMN_PHONE + " INTEGER, " + COLUMN_EMAIL + " TEXT " + ");"
                    );


//            statement.execute("INSERT INTO " + TABLE_CONTACTS + "(" + COLUMN_NAME + ", " + COLUMN_PHONE + ", " + COLUMN_EMAIL + ") VALUES('test', 1112223333, 'test@gmail.com')");
            insertContact(statement, "test", 2224444, "test@gmail.com");
            insertContact(statement, "admin", 2224444, "admin@gmail.com");

            statement.execute("UPDATE " + TABLE_CONTACTS + " SET " + COLUMN_NAME + " = 'test 2'" + " WHERE name='test'");

            statement.execute("DELETE FROM " + TABLE_CONTACTS + " WHERE name='test 2'");

            // SELECT query
            ResultSet results = statement.executeQuery("SELECT * FROM " + TABLE_CONTACTS);

            while(results.next()) {
                System.out.println(
                        results.getString(COLUMN_NAME) + " " + results.getString(COLUMN_PHONE) + " " + results.getString(COLUMN_EMAIL)
                );
            }

            // close statement instances first and then db connection to prevent performance degradation
            statement.close();
            connection.close();

        } catch(SQLException e) {
            System.out.println("Something went wrong: " + e.getMessage());
            // the bottom section of the error should highlight the line(s) in the code where there is an error
            e.printStackTrace();
        }
    }

    // private = method cannot be accessed outside of scope of this class
    // static = static methods are associated with the class itself, not with any particular object created from the class. As a result, you don’t have to create an object from a class before you can use static methods defined by the class.
    // void = method does not return a value
    // throw SQLException = since catch block will be handled in section that is calling this method
    // note that the VALUES section is using single quotes so that the SQL double quotes command doesn't throw an error
    private static void insertContact(Statement statement, String name, Integer phone, String email) throws SQLException {
        statement.execute("INSERT INTO " + TABLE_CONTACTS + "(" + COLUMN_NAME + ", " + COLUMN_PHONE + ", " + COLUMN_EMAIL + ") VALUES('" + name + "', " + phone + ", '" + email + "');");
    }
}
```

# getting metadata from ResultSet specifically in SQLite

https://docs.oracle.com/javase/8/docs/api/java/sql/ResultSetMetaData.html

```
           statement = connection.createStatement();
           results = statement.executeQuery(SONGS_SCHEMA);

           // get and save metadate of songs query result
           ResultSetMetaData metadata = results.getMetaData();
           // get number of columns in songs table metadata
           int numColumns = metadata.getColumnCount();

           // iterate over numColumns, print column metadata
           // ResultSet columns start at 1 and not 0
           for(int i = 1; i <= numColumns; i++) {
               System.out.format("Column %d in the songs table is names %s\n", i, metadata.getColumnName(i));
           }
```

# SQL injection attack

if user input isn't scrubbed the db is vulnerable to the user enter SQL commands into their input and getting private db data

the below blindly concatenates to SQL command and since 1=1 would be true for every record all records would be returned

ex:

Enter a song title:
Heartless' OR 1=1 OR '

# SQL PreparedStatement

A PreparedStatement can protect against SQL injection attacks because they are only pre-compiled once and the userInput is being treated as literal values and not as SQL

A StringBuilder concatenates string to SQL command, while a PreparedStatement would substitute literal value as title

ex:

__vulnerable StringBuilder__
SELECT name FROM artist_list WHERE title = 'Heartless' OR 1=1 OR ';

__protected PreparedStatement__
SELECT name FROM artist_list WHERE title = 'Heartless OR 1=1 OR ';

# PreparedStatement process

1. declare a constant for th following SQL statement that contains the placeholders

2. create a PreparedStatement instance using Connection.prepareStatement(SQL_STATEMENT_STRING)

3. when we're ready to perform the query (or the insert, update, or delete) we call the appropriate setter methods to set the placeholders to the values we want to use in the statement

4. we run the statement using PreparedStatement.execute() or PreparedStatement.executeQuery()

5. we process the results the same way we do when using a regular old Statement

```
    ResultSet results = statement.executeQuery("SELECT * FROM " + TABLE_CONTACTS);

    while(results.next()) {
        System.out.println(
                results.getString(COLUMN_NAME) + " " + results.getString(COLUMN_PHONE) + " " + results.getString(COLUMN_EMAIL)
        );
    }
```