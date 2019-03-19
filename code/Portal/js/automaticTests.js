//This is a files of different tests
function BeginTheTests(){
	var oTable = document.getElementById("selectedTableHTML");
	alert("test set 1 entering");
	addAndDelete(oTable);
	alert("test set 2 entering");
	canItMakeAList(oTable);
	alert("complete");
}

//chechs single deletes and single adds
function addAndDelete(oTable){
	var start = oTable.rows.length;
	
	//should increase length by 1 and set the last rows name to helloCow
	addToSelectedTable(oTable, 'helloCow');
	
	alert("entering test 1");
	if(start != parseInt(oTable.rows.length) - 1){
		error("Automatic Test 1 failed: \n failed to add a row.");
	}
	
	alert("entering test 2");
	var oCells = oTable.rows.item(oTable.rows.length - 1).cells;
	
	if(oCells.item(1).innerHTML != 'helloCow'){
		error("Automatic test 2 failed: \n failed to input correct name");
	}
	
	//Should delete the last row, also decreasing the length by 1,  back to its original length
	alert("entering test 3");
	deleteRow(oTable, oCells);
	
	if(start != parseInt(oTable.rows.length)){
		error("Autamatic test 3 failed: \n failed to delete a row");
	}
	
	alert("entering test 4");
	oCells = oTable.rows.item(oTable.rows.length - 1).cells;
	
	if(oCells.item(1).innerHTML == 'helloCow'){
		error("automatic test 4 failed: \n failed to delete the correct row");
	}
}


//checks to see if it can, delete, make, and correctly sort a inputted array
function canItMakeAList(oTable){
	//the test array
	alert("making test arrays");
	let testSongs = [
		["queen be us",5],
		["fire at him", 1],
		["god only knows", 4],
		["howdy", 1],
		["sup ma boy", 10000],
		["why even", 22],
		["how do do", 25],
	];
	
	//What the system replies with, note ther is 1 extra, an empty set, don't know how to fix
	let reply = [];
	
	let answer = [
		["fire at him", 1],
		["howdy", 2],
		["god only knows", 3],
		["queen be us",4],
		["why even", 5],
		["how do do", 6],
		["sup ma boy", 7],
	];
	
	//Should clear table of all content, leaving the base row
	alert("entering test 5");
	clearTable(oTable);
	
	if (oTable.rows.length != 1){
		error("automatic test 5 failed: \n failed to clear table");
	}
	
	//Should add the test array to a table, table should be the length of the base array + 1
	alert("entering test 8");
	MakeTable(oTable, testSongs);
	
	if (parseInt(oTable.rows.length) - 1 != answer.length){
		error("autamatic test 8 failed: \n system added" + (answer.length  - parseInt(oTable.rows.length) - 1)  + "items to the list");
	}
	
	//pulls the data from the table, the array should be the same as the asnwer array, except one longer, with the original beeen a blank spot
	alert("entering test 9");
	for(i = 0; i < oTable.rows.length; i++){
		var oCells = oTable.rows.item(i).cells;
		
		var songName = (oCells.item(1).innerHTML);
		var priority = (oCells.item(2).children[0].value);
		
		reply.push([songName, priority]);
	}
	
	if(reply.length - 1 != answer.length){
		error("autamatic test 9 failed: \n system added" + (answer.length  - reply.length - 1)  + "items to the list");
	}
	
	alert("entering test 6");
	for(i = 0; i < reply.length - 1; i++){
		if(reply[i+1] != answer){
			error("automatic test 6 failed: \n the order is incorrect spot" + i + "doesn't match");
		}
	}
	
	//clearing table for the end of the test
	alert("entering test 7");
	clearTable(oTable);
	
	if (oTable.rows.length != 1){
		error("automatic test 7 failed: \n failed to clear table");
	}
}