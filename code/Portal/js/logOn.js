function logIn(){
	
  var email = document.getElementById('email').value;
  var password = document.getElementById('Password').value;
	
	firebase.auth().signInWithEmailAndPassword(email, password).then(function(user) {
	   // user signed in
	}).catch(function(error) {
		var errorCode = error.code;
		var errorMessage = error.message;

		if (errorCode === 'auth/wrong-password') {
			alert('Wrong password.');
		} else {
			alert(errorMessage);         
		}
		console.log(error);
	});
}

firebase.auth().onAuthStateChanged(function(user) {
  if (user) {
	window.location = "Homepage.html"; //if it logs on successfuly it will got to the dashboard
  }
});