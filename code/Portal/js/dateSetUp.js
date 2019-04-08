function setDate(){
	d = new Date();

	document.getElementById("ddday").value = d.getDay();
	document.getElementById("ddmonth").value = d.getMonth();
	document.getElementById("ddyear").value = d.getFullYear();
	
	allAvailableSongs("Add", "availableTableHTML");
}