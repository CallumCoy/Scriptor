//This is functio was created to make add ToSelectedTable more flexible
function getButtonInfo (pressedButton){
	var oTable = document.getElementById("selectedTableHTML");
	addToSelectedTable(oTable, pressedButton);
}

//adds a new row to the list of songs to be played
function addToSelectedTable(oTable, name){
	
	var oRow = oTable.insertRow(-1);
	var curPlace = oRow.insertCell(0);
	var songName = oRow.insertCell(1);
	var place = oRow.insertCell(2);
	var buttonRemove = oRow.insertCell(3);
	
	//prevents the first item from giving NaN
	if(oTable.rows.length > 2){
		//The newest cell is always the position of the last song + 1, this prevents duplicate priorities,a stuff like 6 coming after 9
		var oCells = oTable.rows.item(oTable.rows.length - 2).cells;
		var lastNumber = (parseInt(oCells.item(0).innerHTML) + 1);
	} else {
		lastNumber = 1;
	}
	
	//writes the row into html language
	curPlace.innerHTML = lastNumber;
	songName.innerHTML = name;
	place.innerHTML = "<td><input type=\"text\" name = \"Row1\" value =\"" +  (lastNumber) + "\"</td>";
	buttonRemove.innerHTML = "<button onclick=\"deleteRow('selectedTableHTML', this)\",title=\"remove song\", style=\"text-align:center;\"> remove";
}

//This is the main function for sorthing out the list, it is also the function that will input the database into a table
function updateList(){
	
	var songs = [[,]];
	
	var oTable = document.getElementById("selectedTableHTML");
	var rowCount = oTable.rows.length;
	var i;
	 
	//this takes all the current data in the table, and save it into a array, along with it's desired position
	for(i = 1; i < rowCount; i++){
		var oCells = oTable.rows.item(i).cells;
		
		var songName = (oCells.item(1).innerHTML);
		var priority = (oCells.item(2).children[0].value);
		
		songs.push([songName, priority]);
	}
	
	//clears the table so it is a fresh start;
	clearTable("selectedTableHTML");
	
	//sorts the list accoring to order, duplicate locations will be ordered in the manor that they came in.
	songs.sort(function (songA, songB){
		return (songA[1] - songB[1]);
	});
	
	//inputs the now ordered list into a table
	MakeTable("selectedTableHTML", songs);
}

//clears entire table
function clearTable(tableID){

    var oTable = document.getElementById(tableID);
    var rowCount = oTable.rows.length;

	// deletes the rows one by one
	for (var i = rowCount-1; i > 0; i--) {
		var row = oTable.rows[i];
				
		oTable.deleteRow(i);
        }
    }

//mass enters the values from an array into a table
function MakeTable(tableID, songs){
	var oTable = document.getElementById(tableID);
	var i;
	
	//calls the row adding function according to the number of values in the array
	for( i= 1; i < songs.length; i++){
		addToSelectedTable(oTable, songs[i][0]);
	}
}