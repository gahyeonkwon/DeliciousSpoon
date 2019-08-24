

//jumbotron id에 대한 공용사용
window.onload=function backCheck(){	

	var bg = new Array();
bg[bg.length] = '../img/title.jpg';
bg[bg.length] = '../img/sea.jpg';
bg[bg.length] = '../img/title4.jpg';
var obj = document.getElementById('jumbotron');
var size = Math.floor(Math.random()*(bg.length));
j = (isNaN(size)) ? 0 : size;
obj.style.backgroundImage = 'url('+ bg[size] + ')';
}
//diary.jsp 파일에서 사용 (filter)
function columCheck(n) {
 if(n==1){	  
	 $('.card-columns').css('column-count','1');
 }else if(n==2){
	 $('.card-columns').css('column-count','2');
 }else
	 $('.card-columns').css('column-count','3');
}

//diary.jsp 파일에서 사용 (filter)2
$('#btnGroupDrop1').tooltip('show')