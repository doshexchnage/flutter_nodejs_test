var mysql = require('mysql');
var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');
const { response } = require('express');

const swaggerUI = require('swagger-ui-express');
var swaggerDocument = require('./swagger.json');

var connection = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    database : 'weight_db',
    multipleStatements: true
});

const port = 3000

var app = express();

app.use('/swagger', swaggerUI.serve, swaggerUI.setup(swaggerDocument))
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());


app.get('/', function(req, res){
    res.send("Node Application Running!")
})

app.listen(port, () => {
    console.log(`Server is running on  http://localhost${port}`)
});

app.post('/registration', function(req, res){
    var username = req.body.username;
    var password = req.body.password;
    var age = req.body.age;

    if (username && password && age){

        connection.query('SELECT * FROM users WHERE username = ?', [username], function(err, results){
            if (results.length > 0){
                res.status(401)
                res.send('User already exists');
            } else {
                connection.query('INSERT INTO users (username, password, age) VALUES (?, ?, ?)', [username, password, age], function(err, results){
                    res.status(201)
                    res.send('User registered successfully!');
                    
                    res.end();
                });
            }
        })
    } else {
        res.send('Please enter all fields!');
        res.status(401)
        res.end();
    }
});



app.post('/login', function(req, res){
    var username = req.body.username;
    var password = req.body.password;

    if (username && password){
        connection.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], function(err, results){
            if (results.length > 0){
                // console.log(results)
                res.status(201)
                res.send({
                    "message": "Successful User Registration",
                    "userId": results[0].userID,
                    "username": results[0].username,
                    "age": results[0].age
                });
            } else {
                res.status(401)
                res.send("Username or password is incorrect!");
            }
            res.end();
        });
    } else {
        res.status(401)
        res.send("Please enter username and password!");
        res.end();
    }
});

app.post('/user/add_weight', function(req, res){
    var userID = req.body.userID;
    var value = req.body.value;

    if (userID && value){
        connection.query('SELECT * FROM users WHERE userID = ?', [userID], function(err, results){
            if (results.length == 0){
                res.status(401)
                res.send("User doesn't exist!");
                res.end();
            } else {
                connection.query('INSERT INTO weight (userID, value) VALUES (?, ?)', [userID, value], function(err, results){
                    res.status(201)
                    res.send('Weight added successfully!');
                    res.end();
                });
            }
        });
    } else {
        res.status(401)
        res.send("User doesn't exist! ");
        res.end();
    };
});


app.get('/user/get_weight/:userID', function(req, res){
    var userID = req.params.userID;

    if (userID){
        connection.query('SELECT * FROM users WHERE userID = ?', [userID], function(err, results){
            if (results.length == 0){
                res.status(401)
                res.send("User doesn't exist!");
                res.end();
            } else {
                connection.query('SELECT * FROM weight WHERE userID = ?', [userID], function(err, results){
                    if (results.length == 0){
                        res.status(401)
                        res.send("User doesn't have any weights recorded!");
                    } else {
                        res.status(201)
                        res.send(results);
                    }
                    res.end();
                });
            }
        });
    } else {
        res.status(401)
        res.send("Please enter user ID!");
        res.end();
    };
});


app.delete('/user/delete_weight/:id', function(req, res){
    var id = req.params.id;

    if (id){
        connection.query('SELECT * FROM weight WHERE id = ?', [id], function(err, results){
            if (results.length == 0){
                res.status(401)
                res.send("Weight doesn't exist!");
                res.end();
            } else {
                connection.query('DELETE FROM weight WHERE id = ?', [id], function(err, results){
                    res.status(201)
                    res.send('Weight deleted successfully!');
                    res.end();
                });
            }
        });
    } else {
        res.status(401)
        res.send("Please enter weight ID!");
        res.end();
    };
});

