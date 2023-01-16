// in goormIDE terminal from project directory, execute: 
// node app.js

// SQL formatter
// https://www.dpriver.com/pp/sqlformat.htm

const { fake } = require('faker');
const faker = require('faker'); // create fake data  
const { connect } = require('http2');
const mysql = require('mysql'); // communicates with mysql db

// establish connection to mysql db
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'tribe_called_sql'
});

/**
 * ! define SELECT test SQL query
 */

// const q = 'SELECT CURDATE() AS solution';

// // connect to mySQL db and execute provided SQL query on callback
// connection.query(q, function(error, results, fields) {
// 	if(error) throw error;
	
// 	// alias must match in SQL query and in JS expression
// 	// ex) solution
	
// 	console.log(`The solution is: ${results[0].solution}`);
// });

// // end connection from mySQL db after callback SQL query is executed
// connection.end();

/**
 * ! define INSERT test SQL query using faker date
 * * since SQL and JS handle dates differently, just define date using faker package in INSERT command
 */

// const person = {
//   email: faker.internet.email(),
//   created_at: faker.date.past()
// };

// const table = 'users';
// const insert_query = `INSERT INTO ${table} SET ?`;

// // can save SQL response to a variable
// const end_result = connection.query(insert_query, person, function(err, res){
//   if(err) throw err;
//   console.log(res);
// });

// connection.end();

// // if you log out the saved SQL variable with 'sql' option, it will return mySQL JS command
// console.log(end_result.sql);

/**
 * ! define INSERT bulk SQL query using faker package
 * * per faker documentation, bulk entries should be formatted as an array of an array
 * * each entry is itself an array
 * TODO: to reset dataset, code below requires imported packages
 */

const data = [];

// loop 500 times to create dataset
// new variables are pushed to end of data array
for(let i = 0; i < 500; i++) {
  data.push([
    faker.internet.email(),
    faker.date.past()
  ]);
};

const table = 'users (email, created_at)';
const q = `INSERT INTO ${table} VALUES ?`;

// data array is within an array; entire structure is a matrix (arrays of arrays)
connection.query(q, [data], function(err, res){
  if(err) throw err;
  console.log(res);
});

connection.end();

