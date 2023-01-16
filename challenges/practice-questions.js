/**
* ? create many-to-many tables from instagram project
*
* * schema:
* *   users: id, username mandatory, created_at *timestamp now
* *   photos: id, image_url mandatory, user_id mandatory *foreign key, created_at
* *   comments: id, comment_text, photo_id *foreign key, user_id *foreign key, created_at *timestamp now
* *   likes: user_id *foreign key, photo_id *foreign key, created_at, primary key
* *   follows: follow_id *foreign key, followee_id *foreign key, created_at *timestamp now, primary key
* *   tags: id, tag_name, created_at *timestamp now
* *   photo_tags: photo_id *foreign key, tag_id *foreign key, primary key
*/


/**
 * ! SQL with JS practice problems
 *
 * SQL formatter
 * https://www.dpriver.com/pp/sqlformat.htm
 *
 */

// const users_schema = `
// CREATE TABLE users(
//   email VARCHAR(255),
//   created_at TIMESTAMP DEFAULT NOW()
// );
// `;

/**
 * ? What is the earliest date a user joined in the bulk dataset?
 *
 * * need clean dataset using CREATE TABLE users
 */

// solution 1

// const q = `
// SELECT DATE_FORMAT(created_at, '%M %D %Y') AS earliest_date
// FROM   users
// ORDER  BY created_at
// LIMIT 1;
// `;

// solution 2

// const q = `
// SELECT DATE_FORMAT(MIN(created_at), '%M %D %Y') AS earliest_date
// FROM users;
// `;

// connection.query(q, function(err, results, fields){
//   if(err) throw err;
//   console.log(results[0]);
// });

// connection.end();

/**
 * ? What is the email of the earliest user in the bulk dataset?
 * * need clean dataset using CREATE TABLE users
 */

// solution 1

// const q = `
// SELECT email,
// FROM   users
// ORDER  BY created_at
// LIMIT  1;
// `;

// solution 2

// const q = `
// SELECT email
// FROM   users
// WHERE  created_at = (SELECT Min(created_at)
//                      FROM   users);
// `;

// connection.query(q, function(err, results, fields){
//   if(err) throw err;
//   console.log(results[0]);
// });

// connection.end();

/**
 * ? create table according to the month they joined
 * * need clean dataset using CREATE TABLE users
 */

// solution 1

// const q = `
// SELECT Date_format(created_at, '%M') AS month,
//        Count(*)                      AS count
// FROM   users
// GROUP  BY month
// ORDER  BY count DESC;
// `;

// solution 2

// const q = `
// SELECT Monthname(created_at) AS month,
//        Count(*)              AS count
// FROM   users
// GROUP  BY month
// ORDER  BY count DESC;
// `;

// connection.query(q, function(err, results, args){
//   if(err) throw err;
//   console.log(results);
// });

// connection.end();

/**
 * ? what is the number of users with yahoo emails?
 * * need clean dataset using CREATE TABLE users
 */

// const q = `
// SELECT Count(*) AS yahoo_users
// FROM   users
// WHERE  email LIKE '%@yahoo.com';
// `;

// connection.query(q, function(err, results, args) {
//   if(err) throw err;
//   console.log(results);
// });

// connection.end();
