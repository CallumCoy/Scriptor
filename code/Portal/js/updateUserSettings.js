function updateUser(){
	
	var churchName = document.getElementById("Name").value;
	var address = document.getElementById("Address").value;
	var passwrd = document.getElementById("Password").value;
	var passwrdCom = document.getElementById("Passwordcom").value;
	
	userId = firebase.auth().currentUser;
	var database = firebase.database().ref("/churches/" + userId.uid);
	
	
	if (churchName != ""){
		database.update({
			"churchName": churchName
		});
		alert("Church name has been updated");
	}
	
	if (address != ""){
		database.update({
			"address": address
		});
		
		alert("address has been updated");
	}
	
	if(passwrd === ""){
		return
	}
	
	if(passwrd === passwrdCom){
		if (Password.length < 4) {
			alert('Please enter a password of atleast length 4.');
			return;
		}
	}else{
		alert('Passwords do not match.');
		return;
	}
	
	
	userId.updatePassword(passwrd).then(() => {
		alert("password was Succesfully changed");
		document.getElementById("Password").value = "";
		document.getElementById("Passwordcom").value = "";
	}, (error) => {
	  alert(error);
	});
}