function logOut(){
	firebase.auth().signOut().then(function() {
		window.location = "index.html"; //if it logs off successfuly it will got to the index/signin
	}).catch(function(error) {
	  // An error happened.
	});
}

firebase.auth().onAuthStateChanged(function(user) {
  if (!user) {
	window.location = "index.html"; //if no user is logged on it will go back to index/signin
  }
});