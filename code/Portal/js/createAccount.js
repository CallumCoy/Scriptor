function passwordCheck(){
	Password = document.getElementById("Password").value;
	PasswordComfirm = document.getElementById("PasswordComfirm").value;
	
	if((Password.localeCompare(PasswordComfirm)) === 0){
		if (Password.length < 4) {
			alert('Please enter a password of atleast length 4.');
			return false;
		}
		return true;
	}else{
		alert('Passwords do not match.');
		return false;
	}
}

function handleSignUp() {
 var email = document.getElementById('email').value;
  var password = document.getElementById('Password').value;
  if (email.length < 4) {
	alert('Please enter an email address.');
	return;
  }
  
  if(!passwordCheck()){
	return;
  }
	// Sign in with email and pass.
	// [START createwithemail]
	firebase.auth().createUserWithEmailAndPassword(email, password).catch(function(error) {
	// Handle Errors here.
	var errorCode = error.code;
	var errorMessage = error.message;
	// [START_EXCLUDE]
	if (errorCode == 'auth/weak-password') {
	  alert('The password is too weak.');
	  return;
	} else {
	  alert(errorMessage);
	  return;
	}
	console.log(error);
	// [END_EXCLUDE]
  });
  
  // [END createwithemail]
}

firebase.auth().onAuthStateChanged(function(user) {
  if (user) {
	  
	var userName = user.uid;

	var churchName= document.getElementById('churchName').value;
	var address = document.getElementById('Address').value;
	
	var data = {
		name: churchName,
		address: address,
	}
	
	firebase.database().ref().child('/churches/' + userName ).set(data).then( function(){	  
		window.location = "Homepage.html"; //if it logs on successfuly it will got to the dashboard
	});
  }
});