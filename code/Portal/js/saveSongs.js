function saveSong(){
	
	var songName = document.getElementById("songName").value;
	var songLyrics = document.getElementById("lyrics").value;
	
	var data = {
		lyrics: songLyrics,
	}
	  
	firebase.database().ref().child('/songs/' + songName ).set(data);
}