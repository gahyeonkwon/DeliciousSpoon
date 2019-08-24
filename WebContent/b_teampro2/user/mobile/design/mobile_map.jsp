<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   

<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.text.*" %>
<%
String title="지도상세페이지";
String key = request.getParameter("key");
String user_id = (String)session.getAttribute("user_id");
if(key==null){key="";}
//페이지에 위치 정보에 따른 데이터 불러오는 설정
    UserSystemDBBean system = UserSystemDBBean.getInstance(); 

	//지금 내 위치를 바탕으로 store 정보 받아올 객체 생성
	ArrayList<StoreinfoDataBean> searchList = null;
	searchList = system.getLocation_info(key,0);//전체 출력%>
	
<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/>    
   <input type="hidden" value=<%=user_id%> id="user_id">
       <div class="map_sy mb-3">
        <div class="map_sy mr-1" id="map">	        	
		</div>
	   </div>
	   <p class="c_text margin_sy mt-2">현재위치<img class="pb-2 ml-1" id="check_loc" src="../../../img/navigation_e2.png" style="width: 17px;"/></p>         
       <p class="detail_sy margin_sy mb-3 address"></p><!-- address 로 실제위치 출력 -->	   	
        <ul id="gallery">
<% try{
		 if(searchList!=null&&!key.equals("")){
			 for(int i=0;i<searchList.size();i++){
				 StoreinfoDataBean search = searchList.get(i);
					//메뉴정보 불러올 객체 생성
					String names = searchList.get(i).getMenu_names();
					String name [] = names.split(",");   
%>        
			 		<input type="hidden" value="<%=search.getStore_id()%>" class="store_id">
	   				<input type="hidden" value="<%=system.getFavoriteCount(search.getStore_id(),user_id)%>" class="favorite">	        		   	
					<input type="hidden" class="a" name="address" value="<%=search.getAddress()%>">
          <div class="border-bottom margin_sy" style="width:90%"></div>			
			<li class="mt-1">  
                 <div class="photo_main_mobile2 padding_sy"> 
                        <div class="row padding_sy">           
                         <span class="thumb_sy2" style="padding-top:8px; padding-bottom: 8px;"><img src="/bban/imageFile/<%=search.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span>
                    <div class="text padding_sy ul_new" style="width:160px;">
                     <span class="title">
                     <%    if (i==0){out.print("A");}else if(i==1){
                      out.print("B");}else{out.print("C");}%>
                         <%=search.getStore_name()%></span>
                     <span class="desc"><%for(int j=0;j<name.length;j++){out.print(name[j]+" ");}%></span>
                     <span class="desc2"><i class="far fa-heart mr-1"></i><%=system.getFavoriteCount2(search.getStore_id())%>
                     <i class="far fa-comment mr-1 ml-3"></i><%=system.getReviewCount(search.getStore_id())%>                     
                  </div>
                  </div>
                  <div class="photo_main_up_mobile2 padding_sy">
                     <span class="heart  w3-display-topright pb-1 mt-2 mr-3" style="padding-right:30px;">
                       <div style="position: absolute;">
                          <span class="linelike">
                             <img style="width: 25px; height: 25px;" src="../../../img/linelike_red.png"/>
                          </span>
                      </div>
                      <div style="position: absolute;">
                          <span class="like">
                             <img style="width: 25px; height: 25px;" src="../../../img/heart_red.png"/>
                         </span>
                      </div>
                   </span>
                  <span class="w3-display-bottomright mb-1" style="padding-right:20px; font-size:1.5rem;">
                            <i class=" wait_sy fas fa-user mr-1 ml-3"></i><%=system.getCurrent_team(search.getStore_id())%>                
                   </span>
                  <a href="mobile_detail.jsp?store_id=<%=search.getStore_id()%>">
                     <div class="img_area4 w3-display-bottomleft padding_sy"></div>
                     <div class="img_area3 w3-display-topleft padding_sy"></div>                        
                  </a> 
                  </div>                  
               </div>       

            </li>
			
	<% 		 }//for end
		 }else{//list not null end%>			
		<p class="title text-center pr-1 mt-3 mb-3" style="color:#FC5F4A;">가까운 매장이 없습니다.</p><!-- 권가현이 추가 -->
			<div class="border-bottom margin_sy" style="width:90%"></div>
 <%
		 }}catch(Exception e){}%>										
		  </ul><!-- gallery end -->
			  	 
<jsp:include page="../frame/bottom.jsp" flush="false"/>   			 
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQUERY -->
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨 
    }; 


var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//주소 - 좌표 변환 객체생성생성	 
	var geocoder = new daum.maps.services.Geocoder();

	var lat ,lon;

	var key = $('#key').val();

	if(key!=""||key!="null"){
	//html 에서 검색된 장소값 가져오기
	var fileValue = $("input[name='address']").length;

	var fileData = new Array(fileValue);
	

	var address = new Array (fileValue);//json 형식을 위한 출력
	for(var i=0; i<fileValue; i++){             	
	     fileData[i] = $("input[name='address']")[i].value;
	     address[i] = ({groupAddress:fileData[i]});
	 
	}

	var listData = new Array(fileValue);
	for(var i=0; i<fileValue; i++){                          
	    listData[i] = address[i];

	}	
	for (let i=0; i < listData.length ; i++) {	
		// 주소로 좌표를 검색합니다
			geocoder.addressSearch( fileData[i], function(result, status){		
			    // 정상적으로 검색이 완료됐으면   
			    console.log("주소"+fileData[i]);
			   if (status === daum.maps.services.Status.OK) {
			      var coords1 = new daum.maps.LatLng(result[0].y, result[0].x);	 
			    	console.log("좌표"+ result[0].y + "x:"+result[0].x);
			    	console.log("주소"+fileData[i]);
			 
			    	console.log("----------");
			    	var imageSrc ;
			     	if (i==0){
			    		imageSrc = '/bban/b_teampro2/img/map-localization-ha.png';
			    	}else if(i==1){
			    		imageSrc = '/bban/b_teampro2/img/map-localization-hb.png';
			    	}else if(i==2){
			    		imageSrc = '/bban/b_teampro2/img/map-localization-hc.png';
			    	}else{
			    		imageSrc = '/bban/b_teampro2/img/map-localization-c5.png';
			    	}
			    	 // 마커이미지의 주소입니다    
			    	var imageSize = new daum.maps.Size(30, 30), // 마커이미지의 크기입니다
			    	imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			    	 
			    	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			    	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);			    	
		        
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker1 = new daum.maps.Marker({
			            map: map,
			            position: coords1,
			            image: markerImage
			            
			        });
					//마커를 지도에 표시합니다
			         marker1.setMap(map);
		
					
			    } 
			   
			});

		}; //end for	 */
	};//end key
	
// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
 	
        lat = position.coords.latitude, // 위도
        lon = position.coords.longitude; // 경도
   
        var locPosition = new daum.maps.LatLng(lat, lon);
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition);
  
      });

} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new daum.maps.LatLng(33.450701, 126.570667);
        
    displayMarker(locPosition);
}

// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition) {
	var imageSrc = '/bban/b_teampro2/img/map-localization-s1.png', // 마커이미지의 주소입니다    
	imageSize = new daum.maps.Size(40, 35), // 마커이미지의 크기입니다
	imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	 
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
    // 마커를 생성합니다
    var marker = new daum.maps.Marker({  
        map: map, 
        position: locPosition,
        image: markerImage 
    }); 
    
    marker.setMap(map);
    map.setCenter(locPosition); 
    //주소값에서 해당 구 출력하기
    var address ;
    var key;
    var callback = function(result, status) {
        if (status === daum.maps.services.Status.OK) {
            console.log('지역 명칭 : ' + result[0].address_name);
            var address = result[0].address_name.split(" ");
            key = address[1];
            $('.address').text(result[0].address_name);
           	    $('#check_loc').click(function(){     
            	    $.ajax({
            	        type : 'POST',
            	        url : '../control/location_search.jsp',
            	        data:{
            	          key : key
            	        },
            	        cache: false,
            	        dataType:"text",
            	        success : 
            	        	function(data){      
            	        	location.href="mobile_map.jsp?key="+data;   	
            	        	      	        	    	
            	        }
            	    }); // end ajax
            	   
    	    });//end click
        }
    };
   
    geocoder.coord2RegionCode(lon,lat,callback);  	
   
}    



</script>
<!-- 즐겨찾기  -->
 <script>

	$(document).ready(function(){
		let opt = 1;
		let user_id = $('#user_id').val();
		var favorite_length = $('.favorite').length;
		for(var i=0;i<favorite_length;i++){
			var favorite = $('.favorite').eq(i).val();
			 console.log(i+": "+favorite);
				if(favorite==0){
					$(".linelike").eq(i).show();	
					$(".like").eq(i).hide();
				}else{
					$(".like").eq(i).show();
				};
		}
		
		$(".linelike").click(function(){	
		
		if(user_id=="null"||user_id==""){
			swal({
			     title: "즐겨찾기",
			     text: "로그인 후 이용 가능 합니다. 로그인으로 이동할까요?",
			     buttons: true,
			     dangerMode: true,
			   })
			   .then((willDelete) => {
			     if (willDelete) {
			         location.href='login.jsp'
			     } else {
			       return false;
			     }
			   });
		}
		var index = $(".linelike").index(this);
			console.log(index); 
			$(".like").eq(index).show();
	
			var store_id =$(".store_id").eq(index).val();	
			//ajax 사용
		    $.ajax({
		        type : 'POST',
		        url : '../control/check_favorite.jsp',
		        data:{
		         store_id : store_id,
		         user_id : user_id,
		         opt : opt
		        },
		        cache: false,
		        dataType:"text",

		    }); // end ajax

		});

		$(".like").click(function(){
			if(user_id=="null"||user_id==""){
				swal({
				     title: "즐겨찾기",
				     text: "로그인 후 이용 가능 합니다. 로그인으로 이동할까요?",
				     buttons: true,
				     dangerMode: true,
				   })
				   .then((willDelete) => {
				     if (willDelete) {
				         location.href='login.jsp'
				     } else {
				       return false;
				     }
				   });
			}			
			var index = $(".like").index(this);
			$(".like").eq(index).hide();
			var store_id =$(".store_id").eq(index).val();	
			//ajax 사용
		    $.ajax({
		        type : 'POST',
		        url : '../control/check_favorite.jsp',
		        data:{
		         store_id : store_id,
		         user_id : user_id,
		         opt : opt
		        },
		        cache: false,
		        dataType:"text",
	
		    }); // end ajax
		});

	});

</script>	