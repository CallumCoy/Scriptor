function saveSong(){
	
	var songName = document.getElementById("songName").value;
	var songLyrics = document.getElementById("lyrics").value;
	
	songName = songName.charAt(0).toUpperCase() + songName.slice(1);
	
	var data = {
		lyrics: songLyrics,
	}

	firebase.database().ref().child('/songs/' + songName ).set(data);
	alert("saved");
	
	addSong(songName);
}

function addSong(songToAdd){
	
	console.log("hello");
	var songs = [];
	var oTable = document.getElementById("songsToEdit");
	var rowCount = oTable.rows.length;
	var i;
	
	songs.push(songToAdd);
	
	for(i = 1; i < rowCount; i++){
		var oCells = oTable.rows.item(i).cells;
		
		if(songToAdd === oCells.item(0).innerHTML){
			return;
		}
		
		songs.push(oCells.item(0).innerHTML);
		songs.sort();
		var somr = songs.shift();
		
		
		if(songToAdd === somr){
			break;
		}
	}
		
	var oRow = oTable.insertRow(i);
	var songName = oRow.insertCell(0);
	var btn = oRow.insertCell(1);
	
	//writes the row into html language
	songName.innerHTML = songToAdd;
	btn.innerHTML = "<button id=\"" + songToAdd + "\" onclick=\"editSong('songsToEdit', this.id)\",title=\"Edit song\", style=\"text-align:center;\"> Edit";
}