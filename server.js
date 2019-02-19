var express = require('express');
var app = express();
var mysql = require('mysql');

var bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({
    extended: true
}));

app.get('/', function (req, res) {
    res.sendFile(__dirname + '/testForm.html');
});

app.post('/sendData', function (req, res){

    //what to write to database...
    var info = req.body.content;
    
    var connection = mysql.createConnection({
        host: "jowerg.td2s.com",
        user: "adrian",
        password: "password",
        database: "HOLDER"
    });
    
    connection.connect();
        
    connection.query("UPDATE holderTable SET mainText = ?", info, function (err, result, fields){
    if (err) throw err;
        console.log(result);
    });
    connection.end();
    console.log(info);
    res.send("Information Sent! You may close this window or go back to send something else."); 
});

console.log("Lisening on port 3000");

app.get('/getData', function (req, res){
    var connection = mysql.createConnection({
        host: "jowerg.td2s.com",
        user: "adrian",
        password: "password",
        database: "HOLDER"
    });
    
    connection.connect();
    var queryString = "SELECT mainText FROM HOLDER.holderTable;";
    connection.query(queryString, function (err, result, fields){
       if (err) throw err;
       res.send(result);
    });
    connection.end();
});
 
app.listen(3000);