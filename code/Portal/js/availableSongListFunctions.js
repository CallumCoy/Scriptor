function addAvailableSong(oTable, name, type){
	
	var oRow = oTable.insertRow(-1);
	var songName = oRow.insertCell(0);
	var btn = oRow.insertCell(1);
	
	//writes the row into html language
	songName.innerHTML = name;
	btn.innerHTML = "<button id=\"" + name + "\" onclick=\"editSong('songsToEdit', this.id)\",title=\"" + type + " song\", style=\"text-align:center;\"> " + type + "";
}

function allAvailableSongs(note, oTable){
	firebase.database().ref('songs').once('value').then(function(snapshot){
		snapshot.forEach(function(chidldSnap){
			addAvailableSong(document.getElementById(oTable), chidldSnap.getKey() , note);
		}) 
	})
}

function editSong(oTable, songName){
	
	document.getElementById("songName").value = songName;
	
	firebase.database().ref('/songs/' + songName).once('value').then(function(snapshot){
		
		var songData = snapshot.val().lyrics;
		
	document.getElementById("lyrics").value = songData;
	})
}