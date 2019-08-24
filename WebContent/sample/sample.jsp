<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="b_teampro2.userinfo.*" %>       
<%@ page import="java.util.*" %>  
<%
	String key = request.getParameter("key");
	UserSystemDBBean system = UserSystemDBBean.getInstance();
	ArrayList<String> keyList = system.getKey(key);
	if(keyList!=null){
	for(int i=0;i<keyList.size();i++){
	out.print(keyList.get(i));
	}
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>geolocation으로 마커 표시하기</title>
    
</head>
<body>

<p style="margin-top:-12px">
    <b>Chrome 브라우저는 https 환경에서만 geolocation을 지원합니다.</b> 참고해주세요.
</p>
<button id="d"></button>
<div id="map" style="width:350px;height:350px;"></div>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55b630742f256cfb21d75e60668634a4&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨 
    }; 


var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
//주소 - 좌표 변환 객ㄴ체 생성
	//custom
	 
	var geocoder = new daum.maps.services.Geocoder();
	var lat ,lon;
// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
 
    	
        lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
            

        
        var locPosition = new daum.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
        


            
      });

} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new daum.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}


// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    var marker = new daum.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new daum.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);     
    
    //주소값에서 해당 구 출력하기
    var address ;
    var key;
    var callback = function(result, status) {
        if (status === daum.maps.services.Status.OK) {
            console.log('지역 명칭 : ' + result[0].address_name);
            var address = result[0].address_name.split(" ");
            key = address[1];
            console.log(key);
            
   
            	  //  $('#key').val(key);
            	     $('#d').click(function(){     
            	    $.ajax({
            	        type : 'POST',
            	        url : 'sample3.jsp',
            	        data:{
            	          key : key
            	        },
            	        cache: false,
            	        dataType:"text",
            	        success : 
            	        	function(data){      
            	        	 location.href="sample.jsp?key="+data;   	        	
            	        	console.log(data);
            	        	
            	        }
            	    }); // end ajax
            	   
    	    });//end click
        }
    };
    
    geocoder.coord2RegionCode(lon,lat,callback);  

	
   
}    
</script>


</body>
</html>