
//incomplete currently working on update Days
var enumMonth = {
	1:"Jan"
	2:"Feb"
	3:"Mar"
	4:"Apr"
	5:"May"
	6:"Jun"
	7:"Jul"
	8:"Aug"
	9:"Sep"
	10:"Oct"
	11:"Nov"
	12:"Dec"
}

function currentDate(){
	var curDate = new Date();
	document.getElementById("month").value = enumMonth[curDate.getMonth];
	
	removeOptions(document.getElementById("day"));
	removeOptions(document.getElementById("year"));
	
	var i;
    var option = document.createElement('option');
	
	for(i = 0; i < 3; i++){
        option.text = option.value = i + curDate.year - 1;
        select.add(option, 0);
	}
	
	document.getElementById("year").value = curDate.getYear;
	document.getElementById("day").value = curDate.getDay;
}

function updateDays(){
	var option = document.createElement('month');
	var selectdMonth = option.value;
	
	option = document.createElement('year');
	var selectedYear = option.value
}

function daysInThisMonth(monthToHunt, curYear) {
  var now = new Date();
  return new Date(now.curYear(), monthToHunt+1, 0).getDate();
}

function removeOptions(selectbox)
{
    var i;
    for(i = selectbox.options.length - 1 ; i >= 0 ; i--)
    {
        selectbox.remove(i);
    }
}