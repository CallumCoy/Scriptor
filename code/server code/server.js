var express = require('express');
var app = express();
var mysql = require('mysql');
var admin = require("firebase-admin");

var firebase = require('firebase');
var fireApp = firebase.initializeApp({
    apiKey: "AIzaSyBqvTFL0FUKUoLE0xQr3X-yhC4HsqLYZE0",
    authDomain: "scriptor-a57b1.firebaseapp.com",
    databaseURL: "https://scriptor-a57b1.firebaseio.com",
    projectId: "scriptor-a57b1",
    storageBucket: "scriptor-a57b1.appspot.com",
    messagingSenderId: "357246850306"
});

var bodyParser = require("body-parser");

var fireDB = firebase.database();

var churchesRef = fireDB.ref("churches");
var songsRef = fireDB.ref("songs");
var scheduleRef = fireDB.ref("schedule");
var rootRef = fireDB.ref();

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

app.get('/getchurches', function (req, res){
    var toReturn = [];
    rootRef.once("value").then(function(snapshot){
        var data = snapshot.toJSON();
        var churchList = data.churches;
        for(let element in churchList){
            var temp = {
                name: data.churches[element].churchName,
                address: data.churches[element].address
            };
            if(temp.name == undefined || temp.address == undefined){
                continue;
            } else {
                toReturn.push(temp);
            }
        }
        res.send(toReturn);
    });
});

console.log("Listening on port 8080");

app.get('/getData', function (req, res){
    // get the date of the request, and the church
    
    //----------------------------------------
    
    
    var churchNamePara = req.query.church;
    var datePara = req.query.currDate;
    var churchAddressPara = req.query.churchAddress;

    if(churchNamePara == undefined || datePara == undefined || churchAddressPara == undefined){
        res.send("N/A");
    }
    
    //debug section --------

    //churchNamePara = "Our Lady Of The Sign";
    //datePara = "4_4_2019";
    //churchAddressPara = "7311 Lyons Rd, Coconut Creek, FL 33073";

    
    
    //END Debug section-----

    churchNamePara = decodeURIComponent(churchNamePara);
    datePara = decodeURIComponent(datePara);
    churchAddressPara = decodeURIComponent(churchAddressPara);
    
    churchNamePara = churchNamePara.toLowerCase();
    datePara = datePara.toLowerCase();
    churchAddressPara = churchAddressPara.toLowerCase();
    
    //----------------------------------------
    
    //set up variable to return;
    var toReturn = [];
    
    rootRef.once("value").then(function(snapshot){
        // var data = snapshot.val();
        var data = snapshot.toJSON();
        var churchList = data.churches;
        console.log("churchNamePara = " + churchNamePara);
        console.log("churchAddressPara =" + churchAddressPara);
        var holder = null;
        for(let element in churchList){
            //if the name of the church is the one passed in AND the address is the one passed in...
            if(data.churches[element].churchName == undefined || data.churches[element].address == undefined){
                continue;
            }
            var currChurchName = data.churches[element].churchName.toLowerCase();
            var currChurchAddress = data.churches[element].address.toLowerCase();
            console.log("currChurchName = " + currChurchName);
            console.log("currChurchAddress = " + currChurchAddress);
            
            if(currChurchName == churchNamePara && currChurchAddress == churchAddressPara){
                // console.log(churchAddressPara);
                // console.log(data.churches[element].address);
                holder = element;
                break;
            } else {
                continue;
            }
        }

        //holder now contains the correct churchID
        var scheduleList = data.schedule;
        var scheduleHolder;

        //debug
        console.log(holder);


        for(let element in scheduleList){
            //if the current ID matches the church's ID
            if(element == holder){
                //in the correct church
                var allSchedules = data.schedule[element];
                for(let dateElement in allSchedules){
                    if (dateElement == datePara){
                        //get children
                        scheduleHolder = allSchedules[dateElement];
                        //abort
                        break;
                    } else {
                        
                        continue;
                    }
                }

            } else {
                continue;
            }
        } 
        //scheduleHolder contains the appropriate schedule
        for(let element in scheduleHolder){
           
            var songTitle = scheduleHolder[element];
            var songData = data.songs;
            for(let songElement in songData){
                if(songElement == songTitle){
                    //get the lyrcs
                    var temp = {
                        mainText: songData[songTitle].lyrics
                    }
                    toReturn.push(temp);      
                }
            }   
        }
        if (toReturn.length == 0){
            res.send("N/A");
        } else {
            res.send(toReturn);
        }
        
    });
    

    
});
 
app.listen(8080);

