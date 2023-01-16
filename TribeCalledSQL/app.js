// import dependencies
const bodyParser = require('body-parser');
const express = require('express');
const app = express();
const mysql = require('mysql');

// configure express for frontend development with ejs template
app.set('view engine', 'ejs');

// configure body parser for express post requests
// bodyParser will catch post requests and convert in JS for express
app.use(bodyParser.urlencoded({extended: true}));

// app.css file in public dir is accessbile to all html views via express
app.use(express.static(__dirname + '/public'));

// connect express and mysql
const connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	database: 'tribe_called_sql'
});

// define GET root endpoint 
app.get('/', function(req, res) {
	const q = `
	SELECT COUNT(*) AS count
	FROM users;
	`;
	
	connection.query(q, function(err, result){
		if(err) throw err;
		const count = result[0].count;
		// res.send(`Home page count: ${count}`);
		
		// express look for user created home.ejs file in user created views dir
		// pass js object with dynamic variables to ejs template 
		res.render('home', {count: count});
	});
});

// define GET joke endpoint
app.get('/joke', function(req, res) {
	const joke = 'Where in the world are the best french fries cooked? In Greece.';
	res.send(joke);
});

// define POST register endpoint
app.post('/register', function(req, res) {
	
	// bodyParser is converting req into js with below js object
	const user = {email: req.body.email};
	
	const table = 'users';
	
	// standard node SQL INSERT syntax:
	const q = `INSERT INTO ${table} SET ?`;

	connection.query(q, user, function(err, result){
		if(err) throw err;
		// res.send('Thank you for joining our waitlist!');
		
		// after successful post, redirect user back to root route (home page)
		res.redirect('/');
	});

	// normal SQL INSERT syntax:
	// INSERT INTO users(email) VALUES ('test@gmail.com');
	// const q = `INSERT INTO ${table}(email) VALUES ('${user.email}');`;
	
	// connection.query(q, function(err, result){
	// 	if(err) throw err;
	// 	// res.send('Thank you for joining our waitlist!');
		
	// 	// after successful post, redirect user back to root route (home page)
	// 	res.redirect('/');
	// });
});

// define port to request and receive responses from server
app.listen(3000, function(req, res){
	console.log('app listening on port 3000');
});

