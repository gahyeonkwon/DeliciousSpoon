<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   

<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.text.*" %>

<%
	String title="매장상세페이지";
	request.setCharacterEncoding("utf-8");

	String user_id = (String)session.getAttribute("user_id");
	String store_id = request.getParameter("store_id");

	if(store_id==null||store_id.equals("")){
		response.sendRedirect("../control/error.jsp");
	}else{
	//출력 데이터 함수	
		//페이지에 매장 정보 받아오기 위한 객체 생성
		UserSystemDBBean system = UserSystemDBBean.getInstance(); 

		//store 정보 받아올 객체 생성
		StoreinfoDataBean store = null;
		store = system.getStoreinfo(store_id);
		
		//메뉴정보와 사진정보 출력
		//리스트 값 생성
	    			String names = store.getMenu_names();
	    		 	String prices = store.getMenu_prices();   			
	    			String photos = store.getMenu_photos();
	    			String store_photos = store.getStore_photos();
	    			
	   				String name [] = names.split(",");   				 
	   				String price [] = prices.split(",");
	   				String photo [] = photos.split(",");
	   				String storephoto [] = store_photos.split(",");	
	   				
	  
	    //2.1 대기상태 확인_check_Waiting 함수 
	    //1 : 대기가능 상태 , 배너에 바로가기 뜸
	    //-1 : 이미 대기를 한 상태 / 다른 추천 배너 뜸
	    //0 : 매장자체가 대기불가능상태 / 다른 추천 배너 뜸
	    //2 : 노쇼
	    //3 : 대기 개수 3개 이상
	   int check =  system.check_Waiting(user_id,store_id);	
		//5.대기
			 //-1 : 함수동작 하지 않음 오류 체크 /최근 호출 번호 getLastcall
			int lastcall = system.getLastcall(store_id);
		   	//내번호 출력
			UserWaitDataBean wait = system.getMywaiting(store_id,user_id);		
		   	int wait_number = wait.getWait_number();
		   	//남은팀 출력
		   	int team = system.getCurrent_team(store_id);
		   	//내가 받게 될번호 출력
		   	int my_num = system.getCurrent_num(store_id);  			
		   	//6.리뷰
			//매장에 달린 리뷰 총갯수
			int review_count = system.getReviewCount(store_id);				
			//리뷰 출력하는 객체 생성
			List<UserReviewDataBean> reviewList = null;
			reviewList = system.getReviews(store_id,1,5);
			//리뷰날짜 생성
			DateFormat format1 = DateFormat.getDateInstance(DateFormat.LONG);
		

%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
 <jsp:include page="../frame/top.jsp" flush="false"/>
 <input type="hidden" value="<%=check%>" id="check_waiting">
 <input type="hidden" value="<%=user_id%>" id="user_id">
    <div class="container" role="main">
        <!-- 이미지슬라이드 -->
        <div class="c1">
            <div class="containter">
                <div id="myCarousel" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner" style="width:auto;height:300px">
 					<%for(int i=0;i<3;i++){ %>
		                <div class="carousel-item<%if(i==0){out.print(" active");}%>">
		                  <%if(i==0){%>
		                  <img class="first-slide" src="/bban/imageFile/<%=storephoto[i]%>" alt="First slide">
		                  <%}else if(i==1){ %>
		                  <img class="second-slide" src="/bban/imageFile/<%=storephoto[i]%>" alt="Second slide">
		                  <%}else{ %>
		                  <img class="third-slide" src="/bban/imageFile/<%=storephoto[i]%>" alt="Third slide">
		                  <%}%>		                  	                       
		                </div>
		                <%}%>
                    </div>
                    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
                    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
                </div><!-- 이미지슬라이드 끝 -->
                <ul id="gallery">
                    <!-- 컨텐츠 시작 -->
                    
                    <input type="hidden" value="<%=store.getStore_id()%>" id="store_id">
                    <input type="hidden" value="<%=store.getAddress()%>" id="address">
                    <p class="title_d"><%=store.getStore_name()%></p>
                    <div class="d-flex justify-content-center">
                        <!-- 첫번째 카테고리 -->
                        <nav class="nav mb-1">
                            <a class="nav-link active style" href="#" style="color: black;"><i class="pr-1 fas fa-phone"></i>전화</a>                            
                            <div style="margin-right: 5px; margin-bottom: 2px;">
	                            <div style="position: absolute;">
					        		<span class="linelike">
						       		 <img style="width: 20px; height: 20px; margin-top:10px;" src="../../../img/linelike_red.png"/>
					        		</span>
					    		</div>
					    		<div style="position: absolute;">
					        		<span class="like">
					        		<img style="width: 20px; height: 20px; margin-top:10px;" src="../../../img/heart_red.png"/>
					    			</span>
					  			</div>
					  		</div>	
				  			<span style="padding-top: 7px; padding-left: 18px;" >즐겨찾기</span>
                        </nav>
                    </div>
                    <div class="border-bottom margin_sy" style="width: 90%;"></div><!-- 선 -->
                    <!-- 음식점정보-->
                    <div class="d-flex justify-content-center">
                        <!-- 두번째 카테고리 -->
                        <nav class="nav mb-1">
                            <a class="nav-link active style" href="#" style=" color: black;">홈</a>
                            <a class="nav-link "  href="#" style=" color: black;">지도</a>
                            <a class="nav-link disabled " href="#" style=" color: black;">메뉴</a>
                            <a class="nav-link disabled " href="#" style=" color: black;">리뷰</a>
                        </nav>
                    </div>
                     <div class="border-bottom margin_sy" style="width:90%"></div><!-- 선 -->
	                  <div class="container">  
	                    <div class="pt-1 pb-1">
	                        <!-- 음식점 정보 -->
                        <div class="contianer  mt-4">
                            <p class="title margin_sy" style="color: #FC5F4A; padding-bottom:0px;">카테고리</p> 
                            <p class="desc2 padding_sy">
                        	<%if(store.getCategory()==0){out.print("한식");}
				            	else if(store.getCategory()==1){out.print("일식");}
				            	else if(store.getCategory()==2){out.print("중식");}
				            	else if(store.getCategory()==3){out.print("양식");}
				            	else{out.print("기타");}%>    
                            </p>
                        </div>
                        <div class="contianer  mt-4">
                            <p class="title margin_sy" style="color: #FC5F4A; padding-bottom:0px;">소개</p> 
                            <p class="desc2 padding_sy"><%=store.getIntro()%></p>
                        </div>
                        <div class="contianer mt-4">
                            <p class="title margin_sy" style="color: #FC5F4A; padding-bottom:0px;">영업시간</p> 
                            <p class="desc2 padding_sy"><%=store.getOpen_time()%></p>
                        </div>
                        <div class="contianer mt-4">
                           <p class="title margin_sy" style="color: #FC5F4A; padding-bottom:0px;">대표메뉴</p> 
			       <%for(int i=0;i<3;i++){%>
                             <div class="container">                       
	                           <div class="row padding_sy"> 	                   
		                            <p class="desc2 padding_sy"><%=name[i]%></p>
		                            <p class="desc2 padding_sy" style="padding-left: 3px; padding-right: 10px"><%=price[i]%></p>
		                       </div> 
		                     </div>   
	                <%} %>   		        
                        </div>
                	</div>
                </ul>
            </div>
        </div>
        <div class="c2">

            <ul id="gallery"><!-- 메뉴사진 -->
                <p class="title margin_sy" style="color: #FC5F4A; padding-bottom:0px;">메뉴사진</p>		                        
                  <div class="row mt-2 margin_sy">                  
                     <%for(int i=0;i<3;i++){%>
                    <img src="/bban/imageFile/<%=photo[i]%>" class="mr-2" style="width:80px; height:80px;">
                      <%}%>     
                  </div>            
                    <!-- 지도 -->
                    <p class="title margin_sy mt-5"  style="color: #FC5F4A; padding-bottom:0px;">지도</p>
                    <p class="desc2 margin_sy mb-3"><%=store.getAddress()%></p> 
                    <div class="map_sy padding_sy mb-3">
				        <div class="map_sy mr-1" id="map1"></div>
					</div>
                    <!-- 리뷰 -->
                 <p class="title margin_sy mt-4" style="color: #FC5F4A; padding-bottom:0px;">리뷰</p>
                 
                 <div class="border-bottom margin_sy" style="width:90%"></div>
                 
                 <div class="container">
           	<% 	    	
  	
        	if(reviewList!=null){   	
           	for (int i = 0 ; i < reviewList.size() ; i++){ 
					  UserReviewDataBean review = reviewList.get(i);
					  ArrayList<String> r_photo= new ArrayList<String>(); 
					  String review_photos = review.getReview_photos();
					  if(review_photos!=null){
					  String review_photo [] = review_photos.split(",");
					
					  for(int j=0;j<review_photo.length;j++){
						  r_photo.add(review_photo[j]);
					  }};		
					 %>	 
				<li  class="mt-1">
					<%-- <span class="thumb_sy"><img  class="rounded" src="/bban/imageFile/<%=review.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span> --%>								
						<div class="padding_sy">	
							<div class="row padding_sy">           
	                         <span class="thumb_sy2" style="padding-top:8px; padding-left: 10px;  text-align:center;">
                         		<img class="rounded-circle" src="/bban/imageFile/<%=review.getUser_photo()%>" style="width: 60px; height: 60px" alt="이미지1" />
	                         	<span class="desc" style="width:80px;"><%=review.getUser_id()%></span>
	                         </span>	
								<div class="text ul_new" style=" padding-left: 16px; width:230px; height: 50px;">
				                     <div class="container"> <!--  이부분 mobile detail.jsp에서 따오사ㅓ바꿈 -->
										    <div class="row" style="padding-left: 16px;">						    
											<!--     <div class="mb-1 justify-content-center"> 여기 없어야 묶임-->
												  <span class="starRe<%if(review.getScore()>=1){out.print(" on");}%>">1</span>
												  <span class="starRe<%if(review.getScore()>=2){out.print(" on");}%>">2</span>
												  <span class="starRe<%if(review.getScore()>=3){out.print(" on");}%>">3</span>
												  <span class="starRe<%if(review.getScore()>=4){out.print(" on");}%>">4</span>
												  <span class="starRe<%if(review.getScore()>=5){out.print(" on");}%>">5</span>				   										
											   <!-- </div> -->	
												<span class="detailreview_sy ml-2" style="padding-top: 2px;"><%=format1.format(review.getReg_date())%>방문</span>								
											</div>
											<span class="title" style="margin-top: 12px;">"<%=review.getReview_title()%>"</span>
										</div>                    
				                  </div>
				                  <div class="row">
					                  <span class="text ul_new" style=" padding-left: 95px; width:350px; padding-top: 0px;">									
										<span class="desc4 padding_sy"><%=review.getReview_content()%></span>
									</span>
								</div>
								<div style="padding-left: 100px;"> 
								 <%  if(review_photos!=null){
								 for(int j=0;j<r_photo.size();j++){ %>		
		                               <img src="/bban/imageFile/<%=r_photo.get(j)%>" class="mr-2" style="width: 50px; height: 50px;">
		                             
		                                     <%}}%>                                                                        
	                           </div>
				            </div>
						  </div>
					<div class="border-bottom margin_sy mt-3" style="width:90%"></div>	  

				</li>	         
              <%--  <li id="review_li"><!-- 리뷰하나 시작 -->              
                <a href="#">
                 <span class="thumb"><img class="rounded-circle" src="/bban/imageFile/<%=review.getUser_photo()%>" style="width: 80px; height: 78px" alt="이미지1" />
                  <span class="desc mt-2 pl-3"><%=review.getUser_id()%></span>
                 </span>
                 <span class="text2"> 
                      <div class="container"> 
						    <div class="row ml-3 mb-1">		
						    					    
							<!--     <div class="mb-1 justify-content-center"> 여기 없어야 묶임-->
								  <span class="starRe<%if(review.getScore()>=1){out.print(" on");}%>">1</span>
								  <span class="starRe<%if(review.getScore()>=2){out.print(" on");}%>">2</span>
								  <span class="starRe<%if(review.getScore()>=3){out.print(" on");}%>">3</span>
								  <span class="starRe<%if(review.getScore()>=4){out.print(" on");}%>">4</span>
								  <span class="starRe<%if(review.getScore()>=5){out.print(" on");}%>">5</span>				   										
							   <!-- </div> -->	
								<span class="detailreview_sy pl-2" style="padding-top: 2px;"><%=format1.format(review.getReg_date())%>방문</span>								
							</div>
						</div>	
				 </span>		
							<span class="text2">
								<span class="title padding_sy mt-1">"<%=review.getReview_title()%>"</span>
								<span class="desc4 padding_sy"><%=review.getReview_content()%></span>			     
								<div class="mt-2 mb-2 padding_sy" style="padding-left: 18px;"> 
							 <%  if(review_photos!=null){
							 for(int j=0;j<r_photo.size();j++){ %>		
	                               <img src="/bban/imageFile/<%=r_photo.get(j)%>" class="mr-2" style="width: 25%; height: 50%;">
	                                     <%}}%>                                                                        
	                           </div>
							</span>	
           				 </a>
                        </li> --%><!-- 리뷰하나 끝 -->
                    	<%}}else{//for문 end %>
                    	 <p class="margin_sy mt-3">작성된 리뷰가 없습니다</p>
           				<%} %>
                        <div class="fixed-bottom">
                            <!-- 대기하기 버튼(하단 고정) -->
                            <button type="button" id ="go_waiting" class="btn btn-depoon btn-block" style="width:100%;">대기하기</button>
                        </div>
            </ul>
        </div>
    </div>
    <jsp:include page="../frame/bottom.jsp" flush="false"/>
    <jsp:include page="/_template/footer.inc.jsp" flush="false" />

      <%}//store_id 없으면 error.jsp 로 이동%> 
    <!-- JQUERY -->
<script> // 지도 연결 1
	var mapContainer = document.getElementById('map1'), // 지도를 표시할 div 
	mapOption = {
	    center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  
	
	//지도를 생성합니다    
	var map1 = new daum.maps.Map(mapContainer, mapOption); 

    var imageSrc = '/bban/b_teampro2/img/map-localization-s1.png', // 마커이미지의 주소입니다    
    imageSize = new daum.maps.Size(40, 35), // 마커이미지의 크기입니다
    imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder1 = new daum.maps.services.Geocoder();
	
	//주소로 좌표를 검색합니다
	var address = $("#address").val();
	geocoder1.addressSearch(address, function(result, status) {
	
	// 정상적으로 검색이 완료됐으면 
	 if (status === daum.maps.services.Status.OK) {
	
	    var coords1 = new daum.maps.LatLng(result[0].y, result[0].x);
	    

	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker1 = new daum.maps.Marker({
	        map: map1,
	        position: coords1,
	        image: markerImage 
	    });

	    
	    marker1.setMap(map1);
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map1.setCenter(coords1);
	} 
});    
</script>
<!-- 대기 상태 출력 -->
<script>

//1 : 대기가능 상태 , 배너에 바로가기 뜸
//-1 : 이미 대기를 한 상태 / 내번호 뜸
//0 : 매장자체가 대기불가능상태 / 다른 추천 배너 뜸  
//2 : // 노쇼
//3 : 대기 갯수 초과

$(document).ready(function(){
	var check_waiting = $('#check_waiting').val();
	var user_id = $('#user_id').val();
	var store_id= $('#store_id').val();
	console.log(check_waiting);
	console.log(user_id);
	if(user_id=="null"){
		$('#go_waiting').html('로그인 먼저 해주세요');
		$('#go_waiting').click(function(){
			location.href="mobile_login.jsp";
		});
	}else{
		if(check_waiting==1){
			$('#go_waiting').click(function(){
				location.href='mobile_waiting.jsp?store_id='+store_id;
			});
			
		}else if(check_waiting==-1){
			$('#go_waiting').html('내 대기 상태 보기');
			$('#go_waiting').click(function(){
			  location.href='mobile_detailwaiting.jsp?store_id='+store_id;
			});
		}else{
			$('#go_waiting').html('대기 불가능');
		}
	};
	
});


</script>
<!-- 즐겨찾기 -->	
<script>
	$(document).ready(function(){
		let opt = 1;
		let user_id = $('#user_id').val();
		var favorite = $('.favorite').val();
		
		if(favorite==0){
			$(".linelike").show();	
			
			$(".like").hide();
		}else{
			$(".like").show();
		};
			
		$(".linelike").click(function(){	
		
		if(user_id=="null"||user_id==""){
			swal({
			     title: "즐겨찾기",
			     text: "로그인 후 이용 가능 합니다. 로그인으로 이동할까요?",
			     icon: "info",
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
	/* 		if(confirm('즐겨찾기 로그인 후 이용가능합니다. 로그인 페이지로 이동할까요?')!=0){
				location.href=('login.jsp');
			}else{ return;} */
		}
			
			$(".like").show();
			var store_id =$(".store_id").val();	
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
			/* 	if(confirm('즐겨찾기 로그인 후 이용가능합니다. 로그인 페이지로 이동할까요?')!=0){
					location.href=('login.jsp');
				}else{ return;} */
			}			
			$(".like").hide();
			var store_id =$(".store_id").val();	
			//ajax 사용
		    $.ajax({
		        type : 'POST',
		        url : '../control/check_favorite.jsp',
		        data:{
		         store_id : store_id,
		         user_id : user_id,
		         opt:opt
		        },
		        cache: false,
		        dataType:"text",
	
		    }); // end ajax
		});

	});
</script>	
