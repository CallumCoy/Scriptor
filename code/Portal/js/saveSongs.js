function saveSong(){
	songName = document.getElementById("songName");
	songLyrics = document.getElementById("lyrics");
	
	firebase.database().ref('songs/' + songName).set({
    Lyrics: songLyrics
	}, function(error) {
    if (error) {
		// The write failed...
		alert("the file failed to write to the database); 
    } else {
		// Data saved successfully!
		alert("the file successfuly wrote to the database);
    }
	});
}

function selectSong(songName){
	document.getElementById("songName").value = songName;
	
	var lyrics = firebase.database().ref("song/" + songName).once("value").then(function snapshot) {
			var username = (snapshot.val() && snapshot.val().username) 	|| 'Anonymous';
	})
}