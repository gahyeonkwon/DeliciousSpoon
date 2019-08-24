<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   

<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.text.*" %>

<!-- header  -->
<%
request.setCharacterEncoding("utf-8");
	String title = "매장 상세 페이지";
	String user_id = (String)session.getAttribute("user_id");
	String store_id = request.getParameter("store_id");


%>

<jsp:include page="/_template/header.inc.jsp" flush="false">
<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<!-- 상단 메뉴 -->
<jsp:include page="../frame/top.jsp" flush="false"/>	

<!-- 메인사진 위에 올린 css 가져온거 -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	

<%
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
   				
   //평균평점 출력
    double avg_score = system.getAvg_score(store_id);
   //2.1 대기상태 확인_check_Waiting 함수 
    //1 : 대기가능 상태 , 배너에 바로가기 뜸
    //-1 : 이미 대기를 한 상태 / 다른 추천 배너 뜸
    //0 : 매장자체가 대기불가능상태 / 다른 추천 배너 뜸
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
		List<UserReviewDataBean> reviewList2 = null;

		//리뷰날짜 생성
		DateFormat format1 = DateFormat.getDateInstance(DateFormat.LONG);
		//리뷰 검색
		   int pageSize = 5;
			String pageNum = request.getParameter("pageNum");	
		    if (pageNum == null) {
		        pageNum = "1";
		        
		    }
			String key = request.getParameter("key");
		
		   int count = 0;
		   int currentPage = Integer.parseInt(pageNum);
		   int startRow = (currentPage - 1) * pageSize + 1;
		   int endRow = currentPage * pageSize;
		    
			if(key==null){
				key="";
				reviewList = system.getReviews(store_id,startRow,pageSize);
				count =  system.getReviewSearchCount(key,store_id);
			}else{
				reviewList =system.getReviewSearch(key,store_id,startRow,pageSize);
				count = review_count;
			}	
		    // 개요 리뷰 
		    reviewList2 = system.getReviewSimple(store_id);
	//7. 매장추천
	
	List<StoreinfoDataBean> storeList = null; 
	storeList = system.getStores(store.getCategory(),store_id);		
%>

<!-- main content -->
<input type="hidden" value="<%=store.getAddress()%>" id="address">
<input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
<input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
<input type="hidden" value=<%=user_id%> id="user_id">		            
<div class="container">
	<div class="row pl-1 pt-2 pb-4">
		<a href="main.jsp" class="btn btn-link" style="color:black;">홈</a>
<span class="pt-2">></span>
<a href="category.jsp?category=<%=store.getCategory()%>" class="btn btn-link" style="color:black;">
<%if(store.getCategory()==0){out.print("한식");}
else if(store.getCategory()==1){out.print("일식");}
else if(store.getCategory()==2){out.print("중식");}
else if(store.getCategory()==3){out.print("양식");}
else{out.print("기타");} %></a>
<span class="pt-2">></span>
<a href="detailpage.jsp?store_id=<%=store_id%>" class="btn btn-link" style="color:black;"><%=store.getStore_name()%></a>
	</div>
</div>
<div class="container">
   	<div class="row justify-content-between mr-2 mb-2">
   		<div class="ml-3">
			<p class="h2"><%=store.getStore_name()%></p>
<input type="hidden" name="store_name" value="<%=store.getStore_name()%>">
</div>
<div class="mt-2">			
	  <div style="position: absolute;">
<span class="linelike">
 <img style="width: 20px; height: 20px;margin-bottom:5px;" src="../../../img/linelike_red.png"/>
    </span>
</div>
<div style="position: absolute;">
<span class="like">
	<img style="width: 20px; height: 20px;margin-bottom:5px;" src="../../../img/heart_red.png"/>
    	</span>
    </div>
<p class="h5" style="margin-left:25px;"> 저장하기</p>
		</div>
   	</div>
</div>       
	<div class="container">   
	       <div id="myCarousel" class="carousel slide" data-ride="carousel">
	              <ol class="carousel-indicators">
	                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	                <li data-target="#myCarousel" data-slide-to="1"></li>
	                <li data-target="#myCarousel" data-slide-to="2"></li>
	              </ol>
	              <div class="carousel-inner">
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
 <%} %>
</div><!-- crousel inner end -->
           <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
             <span class="carousel-control-prev-icon" aria-hidden="true"></span>
             <span class="sr-only">Previous</span>
           </a>
           <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
             <span class="carousel-control-next-icon" aria-hidden="true"></span>
             <span class="sr-only">Next</span>
           </a>
         </div>
<nav class="nav mb-2">
  <a class="nav-link active lead style scroll" href="#target1" style=" color: black;">개요</a>
<a class="nav-link lead scroll"  href="#target2" style=" color: black;">음식점 정보</a>
<a class="nav-link disabled lead scroll" href="#target3" style=" color: black;">위치</a>
<a class="nav-link disabled lead scroll" href="#target4" style=" color: black;">리뷰</a>
</nav>
<div class="border-bottom mb-2"></div>
<!-- 개요 --><div id="target1"> </div>
 <p class="h3 pt-2 pl-3 d-flex justify-content-start">개요</p> 
<div class="border-bottom pt-1 mb-2 ml-3 pr-1" style="width: 98%;"></div>    
 <div class="row pt-3 pl-4 d-flex justify-content-start">
<div class="col-md-4 mr-4 pr-5">
   	<div class="pl-2">        
         <div class="row"> 
            <p><%=store.getAvg_mark()%></p>
            <div class="pl-3">
<span class="starRe<%if(store.getAvg_mark()>=1.0){out.print(" on");}%>">1</span>
<span class="starRe<%if(store.getAvg_mark()>=2.0){out.print(" on");}%>">2</span>
<span class="starRe<%if(store.getAvg_mark()>=3.0){out.print(" on");}%>">3</span>
<span class="starRe<%if(store.getAvg_mark()>=4.0){out.print(" on");}%>">4</span>
<span class="starRe<%if(store.getAvg_mark()>=5.0){out.print(" on");}%>">5</span>
   </div>
</div>
<div class="pt-2">      						
<%if(reviewList2!=null){
for (int i = 0 ; i < reviewList2.size() ; i++){ 
  UserReviewDataBean review = reviewList2.get(i);
 	if(i==0){%> 	
<div class="row"> 
        	<div class="d-flex justify-content-start align-items-end pr-3">
            	<p class="lead"><%=review.getUser_id()%></p>
	</div>
	<div class="d-flex justify-content-end align-items-end">
   	<p><%=format1.format(review.getReg_date2())%></p>
   	</div>           
  </div>				          
<div class="row d-flex justify-content-start pb-1">
  	<p><%=review.getReview_title()%></p>
</div>  
  <%}else{ %>  
<div class="row"> 
         	<div class="d-flex justify-content-start align-items-end pr-3">
             	<p class="lead"><%=review.getUser_id()%></p>
	</div>
	<div class="d-flex justify-content-end align-items-end">
   	<p><%=format1.format(review.getReg_date2())%></p>
   	</div>           
  </div>				          
<div class="row d-flex justify-content-start pb-1">
  	<p><%=review.getReview_title()%></p>
</div>  
  <%}
}}%>  
       	   						 
 </div>
</div>
</div>  			       
   <div class="col-md-3 mr-4 pr-4">
         <div class="row pr-2 d-flex justify-content-start align-items-start">
         <p class="lead" style="color : red;"><i class="far fa-clock mr-2"></i>
<%if(store.getOpen_close()==1){out.print("대기가능");}
else{out.print("대기불가");}
%>		           	
  	</p>
</div>
<div class="row pt-2 d-flex justify-content-start align-items-baseline">
	<div>
 	  <p class="lead">영업시간</p>
   </div>
   <div class="ml-3">
  	 <p><%=store.getOpen_time()%></p> 
	</div>
</div>
<div class="row pt-2 d-flex justify-content-start align-items-baseline">
	<div>
   	<p class="lead">영업요일</p>
   </div>
   <div class="ml-3">
   	<p><%=store.getOpen_day()%></p>
   </div>
</div>
<div class="row pt-2 d-flex justify-content-start align-items-center">
	<div>
  	 <p class="lead">카테고리</p>	
   </div>
   <div class="ml-3">	            
   	<p><%if(store.getCategory()==0){out.print("한식");}
else if(store.getCategory()==1){out.print("일식");}
else if(store.getCategory()==2){out.print("중식");}
else if(store.getCategory()==3){out.print("양식");}
else{out.print("기타");}%>
   	</p>
   </div>	
</div>         
<div class="row pt-2 d-flex justify-content-start align-items-center">
   <p class="lead">위치</p>
</div>         
<div class="row d-flex justify-content-start align-items-baseline">
   <p><i class="fas fa-map-marked-alt mr-2 lead"></i><%=store.getAddress()%></p>		        
   </div> 
</div>
<!-- 지도 -->
<div class="col-md-3 mr-5">
	 <div id="map1" style="width:25.5rem; height:17.4rem;"></div>
  </div>
</div>    
<!-- 개요end -->
<div class="border-bottom mb-2 ml-3 pr-1" style="width: 98%;"></div>     
<div class="row pl-3">
  <div class="col d-flex justify-content-start align-items-end pt-3">
     <p class="h3">이런 음식점은 어떠세요?</p>
  </div>
  <div class="col d-flex justify-content-end align-items-end mr-1">
     <p class="h5">
     <a href="category.jsp?category=<%=store.getCategory()%>" style="color: black;padding-right:5px;">
      	더보기</a></p>
   </div>
</div>   
<div class="row pt-2 ml-1">
<% 		 if(storeList!=null){
for (int i = 0 ; i < storeList.size() ; i++){
      StoreinfoDataBean radom = storeList.get(i);
      if(i==0){%>
<div class="col-md-2 mr-5">
	 <input type="hidden" value="<%=radom.getStore_id()%>" class="store_id">
<input type="hidden" value="<%=system.getFavoriteCount(radom.getStore_id(),user_id)%>" class="favorite">	        
<div class="photo_main">
 <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=radom.getMain_photo()%>">
<span class="photo_main_up">		               
<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
     	<div style="position: absolute;">
<span>		        	
	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
  	     	<div style="position: absolute;">
<span>
 <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(radom.getStore_id()) %></p>
        </span>
    </div>   
</span>
     	
      <img style="width: 70px; height: 70px;" src="../../../img/tri.png"/>
        </span>
    </div>   
</span>		               
            <span class="heart  w3-display-topright pb-1" style="padding-right:30px;">
     	<div style="position: absolute;">
<span class="linelike">
 <img style="width: 20px; height: 20px;" src="../../../img/linelike_red.png"/>
    </span>
</div>
<div style="position: absolute;">
<span class="like">
	<img style="width: 20px; height: 20px;" src="../../../img/heart_red.png"/>
 	</span>
 </div>
</span>
        	  <a href="detailpage.jsp?store_id=<%=radom.getStore_id()%>">
		<div class="area1 w3-display-left"></div>
		<div class="area2 w3-display-bottomleft"></div>
	 </a>		               	  
 </span>			            	            
</div>           
   <div class="mt-2" style="width:14.7rem;">
   <div class="row pl-3" style="height:1.5rem;">
     <p class="title_main" style="margin-bottom:0px;"><%=radom.getStore_name()%></p>  
    </div>
    <div class="row pl-3 mt-1" style="height:1.5rem;" >
     <p> <i class="fas fa-won-sign mr-1"></i><%=radom.getAvg_price()%>원대</p>
     <p> <i class="fas fa-star ml-3 mr-1"></i><%=radom.getAvg_mark()%></p>
     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(radom.getStore_id())%></p>
       </div>
    </div>                  
</div>  		    	   
<%}else{%>
<div class="col-md-2 mr-5 ml-5">
<input type="hidden" value="<%=radom.getStore_id()%>" class="store_id">
<input type="hidden" value="<%=system.getFavoriteCount(radom.getStore_id(),user_id)%>" class="favorite">
<div class="photo_main">
 <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=radom.getMain_photo()%>">
<span class="photo_main_up">		               
<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
     	<div style="position: absolute;">
<span>		        	
	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
  	     	<div style="position: absolute;">
<span>
 <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(radom.getStore_id()) %></p>
        </span>
    </div>   
</span>
     	
      <img style="width: 70px; height: 70px;" src="../../../img/tri.png"/>
        </span>
    </div>   
</span>		               
            <span class="heart  w3-display-topright pb-1" style="padding-right:30px;">
     	<div style="position: absolute;">
<span class="linelike">
 <img style="width: 20px; height: 20px;" src="../../../img/linelike_red.png"/>
    </span>
</div>
<div style="position: absolute;">
<span class="like">
	<img style="width: 20px; height: 20px;" src="../../../img/heart_red.png"/>
 	</span>
 </div>
</span>
        	  <a href="detailpage.jsp?store_id=<%=radom.getStore_id()%>">
		<div class="area1 w3-display-left"></div>
		<div class="area2 w3-display-bottomleft"></div>
	 </a>		               	  
 </span>			            	            
</div>             
  <div class="mt-2" style="width:14.7rem;">
  <div class="row pl-3" style="height:1.5rem;">
    <p class="title_main" class="title_main" style="margin-bottom:0px;"><%=radom.getStore_name()%></p>  
   </div>
   <div class="row pl-3 mt-1" style="height:1.5rem;" >
     <p> <i class="fas fa-won-sign mr-1"></i><%=radom.getAvg_price()%>원대</p>
     <p> <i class="fas fa-star ml-3 mr-1"></i><%=radom.getAvg_mark()%></p>
     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(radom.getStore_id())%></p>
         </div>
      </div>    
</div>
<%}}}%>  		         
</div><!-- 음식점 랜덤 추천 end -->      		     
<div id="target2"><!--음식점 상세정보 -->      	 
<div class="row pt-5 pl-3"> <!-- 음식점정보-->
   <div class="col align-items-end d-flex justify-content-start">
      <p class="h3">음식점 정보</p>
   </div>
</div>    
<div class="border-bottom pt-1 mb-2 ml-3 pr-1" style="width: 98%;"></div>   
<div class="pt-2 pb-2 pl-3">   
   <div class="row d-flex justify-content-start">         
         <div class="col-sm-2 d-flex align-items-end">
            <p class="lead">카테고리</p>   
         </div>      
         <div class="col-sm-10 d-flex align-items-end">
            <p>
            <%if(store.getCategory()==0){out.print("한식");}
else if(store.getCategory()==1){out.print("일식");}
else if(store.getCategory()==2){out.print("중식");}
else if(store.getCategory()==3){out.print("양식");}
else{out.print("기타");}%>
         </p>
      </div>   
</div>         
<div class="row d-flex justify-content-start mt-2">         
      <div class="col-sm-2 d-flex align-items-end">
         <p class="lead">소개</p>   
      </div>      
      <div class="col-sm-10 d-flex align-items-end">
         <p> <%=store.getIntro()%></p>
      </div>   
</div>      
<div class="row d-flex justify-content-start mt-2">         
      <div class="col-sm-2 d-flex align-items-end">
         <p class="lead">영업시간</p>   
      </div>      
      <div class="col-sm-10 d-flex align-items-end">
         <p> <%=store.getOpen_time()%></p>
      </div>   
</div>
<div class="row d-flex justify-content-start mt-2">         
      <div class="col-sm-2 d-flex align-items-end">
         <p class="lead">영업요일</p>   
      </div>      
      <div class="col-sm-10 d-flex align-items-end">
         <p><%=store.getOpen_day()%></p>
      </div>   
</div>
<div class="row d-flex justify-content-start mt-2">         
      <div class="col-sm-2 d-flex align-items-end">
         <p class="lead">대표번호</p>   
      </div>      
      <div class="col-sm-10 d-flex align-items-end">
         <p>0<%=store.getStore_phone()%></p>
      </div>   
</div>
<div class="row d-flex justify-content-start mt-2">         
      <div class="col-sm-2 d-flex align-items-start">
         <p class="lead">대표메뉴</p>   
      </div>      
      <div class="col-sm-10 pt-2 d-flex align-items-end">
         <div>
        <%for(int i=0;i<3;i++){%>
          <div class="row" style="padding-left: 14px;">
          <p><%=name[i]%></p>
          <p class="pl-3"><%=price[i]%></p>                                       
          </div>
       <%} %>
          <div class="row mt-2" style="padding-left: 14px;">
            <%for(int i=0;i<3;i++){%>
             <img src="/bban/imageFile/<%=photo[i]%>" class="rounded pr-2" style="width: 160px; height: 150px;">
            <%} %>                 
                      </div>                                    
                   </div>               
                </div>                  
          </div>      
</div>       
  </div> <!-- 음식점 상세정보end -->   
<div id="target3"> <!-- 위치 -->    
<div class="d-flex justify-content-start pt-5 pl-3"> <!-- 위치-->
   <p class="h3">위치</p>
</div>
<div class="border-bottom pt-1 mb-2 ml-3 pr-1" style="width: 98%;"></div>   
<div class="pt-2 pb-2 pl-3">   
   <div class="row d-flex justify-content-start">         
      <div class="col ml-1 d-flex align-items-start">
         <p class="lead"><i class="fas fa-map-marked-alt mr-2 lead"></i>
         <%=store.getAddress()%>
   <%=store.getAddress_detail()%>
      </p>   
   </div>      
</div>            
<div class="row d-flex justify-content-start mt-3 ml-1">      
   <div id="map2" style="width: 98%; height: 480px;"></div>                        
      </div>      
   </div>          
</div><!--위치end -->  
<div id="target4"> <!-- 리뷰-->
<div class="row pt-5 pl-3">
   <div class="col align-items-end d-flex justify-content-start">
      <p class="h3">리뷰 (<%=review_count%>)</p> <!-- count 함수로 총 테이블 갯수 ( 리뷰갯수 출력) -->
   </div>
   <div class="col align-items-end d-flex justify-content-end mr-2 pb-1">
   
   </div>
</div>
<div class="border-bottom pt-1 mb-2 ml-3 pr-1" style="width: 98%;"></div>            
 <div class="row d-flex pt-2 justify-content-start">         
    <div class="col ml-1 d-flex align-items-start" style=" padding-left:27px;">
       <p>사람들 의견보기</p>   
    </div>      
 </div>                  
 <div class="row d-flex pt-3 justify-content-start">       
    <div class="col-md-8 ml-1 pr-3" style=" padding-left:27px;">
       <input class="form-control" id="key" type="text" placeholder="찾고싶은 키워드를 입력해주세요" value=<%=key%>>
    </div>      
    <div class="col-auto pl-2 mr-2">
       <button id="search" class="btn btn-small btn-depoon" type="button"><i class="fas fa-search"></i></button>
       <button id="reset" class="btn btn-small btn-depoon" type="button">전체보기</button>
    </div>      
 </div>   
<%	    try{	
if(reviewList==null){%>
<div class="ml-3 pt-3">
	<p class="d-flex align-right"> 작성된 리뷰가 없습니다. </p>		        
</div>	       
      <div class="border-bottom pt-5 mb-2 ml-3 pr-1" style="width: 98%;"></div>  

<%}else{
for (int i = 0 ; i < reviewList.size() ; i++){ 
  UserReviewDataBean review = reviewList.get(i);
  ArrayList<String> r_photo= new ArrayList<String>(); 
  String review_photos = review.getReview_photos();
  if(review_photos!=null){
  String review_photo [] = review_photos.split(",");

  for(int j=0;j<review_photo.length;j++){
	  r_photo.add(review_photo[j]);
  }}		
 %>	 		 
<div class="pb-2 pl-4"><!-- 리뷰칸 -->
<div class="row d-flex justify-content-start mt-3">         
   <div class="col-sm-2 d-flex align-items-center pt-2">
      <div class="pr-1 pt-4">
             <img class="rounded-circle" src="/bban/imageFile/<%=review.getUser_photo()%>" width="100rem" height="100rem">
     <h6 class="pt-1"><%=review.getUser_id()%></h6>
         </div>                  
</div>      
<div class="col-sm-8 pt-2 pl-5 d-flex">
   <div>
      <div class="row" style="padding-left: 14px;">
            <div>
<span class="starRe<%if(review.getScore()>=1){out.print(" on");}%>">1</span>
<span class="starRe<%if(review.getScore()>=2){out.print(" on");}%>">2</span>
<span class="starRe<%if(review.getScore()>=3){out.print(" on");}%>">3</span>
<span class="starRe<%if(review.getScore()>=4){out.print(" on");}%>">4</span>
<span class="starRe<%if(review.getScore()>=5){out.print(" on");}%>">5</span>
     </div>
     <p class="pl-4"><%=format1.format(review.getReg_date2())%></p>                                    
  </div>            
  <div class="row pb-3 pt-1" style="padding-left: 14px;">
     <p class="lead"><%=review.getReview_title()%></p>                                       
  </div>
  <div class="row" style="padding-left: 14px;">
     <p class="text-left"><%=review.getReview_content()%></p>                                       
      </div>       
   </div>                                   
</div>   <%
if(review_photos!=null){%>
<span class="more d-flex justify-content-end align-items-end pb-2 pl-4">더보기 <i class="fas fa-caret-down"></i></span>
   <!-- 더보기 누른 경우 -->
<div class="imgarea"> 
<div class="pt-2 pb-2 pl-5 mb-3">
   <div class="row pt-3">
 		<% for(int j=0;j<r_photo.size();j++){ %>
 <div class="col-sm-4"> 
    <img src="/bban/imageFile/<%=r_photo.get(j)%>" class="rounded" style="width:280px; height:200px;">
 </div>
     <%}%> 
     </div>							         
  </div>
</div>        
<%}%>            
      </div>
   </div>      
<div class="border-bottom mt-3 mb-2 pt-2 pb-2 ml-3 pr-1" style="width: 98%;"></div>		      
<%}}//for문 end  %>
<!-- pagination -->
<div class="d-flex justify-content-center pt-3">
<%try{
 if (count > 0) {
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
int startPage =1;

if(currentPage % 10 != 0)
         startPage = (int)(currentPage/10)*10 + 1;
else
         startPage = ((int)(currentPage/10)-1)*10 + 1;
	
int pageBlock = 10;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) endPage = pageCount;%>
<nav aria-label="Page navigation example">
  <ul class="pagination">
<%
if (startPage > 5) { %>		  
<li class="page-item btn-depoon">
  <a class="page-link btn-dp-p" href="detailpage.jsp?pageNum=<%= startPage - 5 %>&store_id=<%=store_id%>&key=<%=key%>&#target4" aria-label="Previous">
    <span aria-hidden="true">&laquo;</span>
    <span class="sr-only">Previous</span>
  </a>
</li>
<%      }
  
for (int i = startPage ; i <= endPage ; i++) {  
    if(currentPage==i){%>    
<li class="page-item btn-depoon"><a class="page-link btn-depoon" href="detailpage.jsp?pageNum=<%= i %>&store_id=<%=store_id%>&key=<%=key%>&#target4"><%=i%></a></li>
<% }else{%>
<li class="page-item"><a class="page-link btn-dp-p" href="detailpage.jsp?pageNum=<%= i %>&store_id=<%=store_id%>&key=<%=key%>&#target4"><%=i%></a></li>
<% 		       
	}   
}//for end
if (endPage < pageCount) {  %>
<li class="page-item">
  <a class="page-link btn-dp-p2" href="detailpage.jsp?pageNum=<%= startPage + 5 %>&store_id=<%=store_id%>&key=<%=key%>&#target4" aria-label="Next">
    <span aria-hidden="true">&raquo;</span>
    <span class="sr-only">Next</span>
  </a>
</li>
<%
    }
}
%>						
  </ul>
</nav>
<%
}catch(Exception e){}
	%>  
</div><!-- pagination end -->
</div>  <!-- 리뷰end -->  	 	                      
</div><!-- container -->

<!-- contents end -->
<%

//random other store 추천
StoreinfoDataBean random = system.getStore(store.getCategory(),store_id);
//1 : 대기가능 상태 , 배너에 바로가기 뜸
//-1 : 이미 대기를 한 상태 / 다른 추천 배너 뜸
//0 : 매장자체가 대기불가능상태 / 다른 추천 배너 뜸 
//2 : 노쇼 처리가 된 상태;
if(user_id==null||user_id.equals("")){//로그인 상태가 아니라면%>	
<div id="floatMenu"> 
   <div class="card" style="width: 15.6rem;">
<div>
	<img class="card-img-top" style="width: 6rem;" src="../../../img/logo_md.png" alt="Card image cap">
</div> 
<div class="card-body">	      
  <h5 class="card-title font-weight-bold"><%=team%>팀 대기중</h5>
          <div class="row d-flex justify-content-center mb-2 mt-2">
          <p class="card-text">로그인 먼저해주세요!</p>
          </div>	           
       <a href="login.jsp" class="btn btn-block btn-depoon">로그인</a>
     </div>
   </div>         
</div>	
<%}else{//로그인상태
if(check==1){%>
<div id="floatMenu"> 
   <div class="card" style="width: 15.6rem;">
<div>
	<img class="card-img-top" style="width: 6rem;" src="../../../img/logo_md.png" alt="Card image cap">
</div> 
<div class="card-body">	      
  <h5 class="card-title font-weight-bold"><%=team%>팀 대기중</h5>
<div class="row d-flex justify-content-center mb-2">
<p class="card-text">최근 호출번호  <%=lastcall%></p>
</div>
<div class="row  d-flex justify-content-center mb-2">
<p class="card-text">받게 될 번호 <%=my_num%></p>
   </div>
<a href="waiting.jsp?store_id=<%=store_id%>" class="btn btn-depoon btn-block">대기하러가기</a>
     </div>
   </div>         
</div>
<%}else if(check==0){%>
<div id="floatMenu"> 
   <div class="card" style="width: 15.6rem;">
<div class="card-body">	      
  <h5 class="card-title font-weight-bold">대기 불가능 매장</h5>
     <div class="row d-flex justify-content-center mb-2">
     <p class="card-text">이런 매장은 어떠세요?</p>
     </div>        	    
     <div class="mb-2">
		<img class="card-img-top rounded" style="width: 12rem;" src="/bban/imageFile/<%=random.getMain_photo()%>" alt="Card image cap">
</div>
    <div class="row  d-flex justify-content-center mb-2 pb-1">
     <p class="card-text"><%=random.getStore_name()%></p>
   </div>    		    
<a href="waiting.jsp?store_id=<%=random.getStore_id()%>" class="btn btn-block btn-depoon">대기하러가기</a>
     </div>
   </div>         
</div>
<%}else if(check==2){//노쇼상태%>
<div id="floatMenu"> 
   <div class="card" style="width: 15.6rem;">
<div>
	<img class="card-img-top" style="width: 6rem;" src="../../../img/logo_md.png" alt="Card image cap">
</div> 
<div class="card-body">	      
  <h5 class="card-title font-weight-bold"><%=team%>팀 대기중</h5>
<div class="row d-flex justify-content-center mb-2">
<p class="card-text">최근 호출번호 <%=lastcall%></p>
         </div>
         <div class="row  d-flex justify-content-center mb-1">
      		   노쇼 처리 되어  대기가 불가합니다.
         </div>
    </div>
  </div>  
</div>    
<%}else if(check==3){//대기 갯수 3개 제한 초과%>
<div id="floatMenu"> 
   <div class="card" style="width: 15.6rem;">
<div>
	<img class="card-img-top" style="width: 6rem;" src="../../../img/logo_md.png" alt="Card image cap">
</div> 
<div class="card-body">	      
  <h5 class="card-title font-weight-bold"><%=team%>팀 대기중</h5>
<div class="row d-flex justify-content-center mb-2">
<p class="card-text">최근 호출번호 <%=lastcall%></p>
         </div>
         <div class="row  d-flex justify-content-center mb-1">
         <p class="card-text">가능한 대기 초과</p>
         </div>
    </div>
  </div>  
</div>  
<%}else{//이미대기상태%>
<div id="floatMenu"> 
   <div class="card" style="width: 15.6rem;">
<div>
	<img class="card-img-top" style="width: 6rem;" src="../../../img/logo_md.png" alt="Card image cap">
</div> 
<div class="card-body">	      
  <h5 class="card-title font-weight-bold"><%=team%>팀 대기중</h5>
<div class="row d-flex justify-content-center mb-2">
<p class="card-text">최근 호출번호 <%=lastcall%></p>
</div>
<div class="row  d-flex justify-content-center mb-1">
<p class="card-text">내번호 <%=wait_number%></p>
          </div>
     </div>
   </div>         
</div> 	
<% }}%>	 
<!-- bottom -->
<%
}catch(Exception e){}
%>  
<jsp:include page="../frame/bottom.jsp" flush="false"/>   

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<%}//store_id 없으면 error.jsp 로 이동%>
<!-- jquery -->
<!--원페이지 스크롤 -->
<script>
$(document).ready(function(){
        $(".scroll").click(function(event){            
                event.preventDefault();
                $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
        });
});
</script>

<!-- 대기 따라오기 구현 -->

<script>
$(document).ready(function() {

    var waitlist = $("#floatMenu");
    
   var waitX = waitlist.offset().left;
   var waitY = waitlist.offset().top;
         console.log(waitX);
         console.log(waitY); 
      $('#floatMenu').css('position', 'absolute');
   $('#floatMenu').css('left', '1560px');
   $('#floatMenu').css('top', '150px');   
});  
</script>

<script>
 $(document).ready(function() {
       var waitlist = $("#floatMenu");
       
      var waitX = waitlist.offset().left;
      var waitY = waitlist.offset().top;
   // 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
   var floatPosition = parseInt($("#floatMenu").css('top'));
   // 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );
 
   $(window).scroll(function() {
      // 현재 스크롤 위치를 가져온다.
      var scrollTop = $(window).scrollTop();
      if(scrollTop>waitY){
         var newPosition = scrollTop +150+ "px";

         $("#floatMenu").stop().animate({
            "top" : newPosition
         }, 500);

      }


   }).scroll();

});

</script> 

<!-- 리뷰에서 이미지 더보기 구현 -->
<script>

$(document).ready(function(){
    $("span.more").click(function(){
    	      	
        var submenu = $(this).next("div");

        // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
        }
    });
});
</script>

<script> // 지도 연결 1
	var mapContainer = document.getElementById('map1'), // 지도를 표시할 div 
	mapOption = {
	    center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  
	
	//지도를 생성합니다    
	var map1 = new daum.maps.Map(mapContainer, mapOption); 

    var imageSrc = '/bban/b_teampro2/img/map-localization_r.png', // 마커이미지의 주소입니다    
    imageSize = new daum.maps.Size(45, 45), // 마커이미지의 크기입니다
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
	    
		var store_name =$('[name=store_name]').val();
	    // 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow1 = new daum.maps.InfoWindow({
	       content: '<div style="width:150px;text-align:center;padding:6px 0;">'+store_name+'</div>'
	    });
	    
	    infowindow1.open(map1, marker1);
	   
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map1.setCenter(coords1);
	} 
});    
</script>

<script> // 지도 연결 2

	var mapContainer = document.getElementById('map2'), // 지도를 표시할 div 
	mapOption = {
	    center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  
	
	//지도를 생성합니다    
	var map2 = new daum.maps.Map(mapContainer, mapOption); 
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder2 = new daum.maps.services.Geocoder();

	var imageSrc = '/bban/b_teampro2/img/map-localization_r.png', // 마커이미지의 주소입니다    
	    imageSize = new daum.maps.Size(45, 45), // 마커이미지의 크기입니다
	    imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);	
	//주소로 좌표를 검색합니다
	var address = $("#address").val();
	geocoder2.addressSearch(address, function(result, status) {
	
	// 정상적으로 검색이 완료됐으면 
	 if (status === daum.maps.services.Status.OK) {
	
	    var coords2 = new daum.maps.LatLng(result[0].y, result[0].x);
	
	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker2 = new daum.maps.Marker({
	        map: map2,
	        position: coords2,
	        image: markerImage 
	    });
	    var store_name =$('[name=store_name]').val();
	    // 인포윈도우로 장소에 대한 설명을 표시합니다
 	    var infowindow2 = new daum.maps.InfoWindow({
	        content: '<div style="width:150px;text-align:center;padding:6px 0;">'+store_name+'</div>'
	    }); 
	    infowindow2.open(map2, marker2);
	
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map2.setCenter(coords2);
	} 
});    
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
		/* if(confirm('즐겨찾기 로그인 후 이용가능합니다. 로그인 페이지로 이동할까요?')!=0){
			location.href=('login.jsp');
		}else{ return false;} */
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
			/* if(confirm('즐겨찾기 로그인 후 이용가능합니다. 로그인 페이지로 이동할까요?')!=0){
				location.href=('login.jsp');
			}else{ return false;} */
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
<!-- 리뷰 검색 -->
<script>
$('#search').click(function() {
	  var key = $('#key').val();
	  var store_id = $('.store_id').val();
	    $.ajax({
	        type : 'POST',
	        url : '../control/search_pro.jsp',
	        data:{
	          key : key
	        },
	        cache: false,
	        dataType:"text",
	        success : 
	        	function(data){      
	        	 location.href="detailpage.jsp?store_id="+store_id+"&key="+data+"&#target4";          	
	        }
	    }); // end ajax
	});
$('#reset').click(function() {
	  var key = $('#key').val();
	  var store_id = $('.store_id').val();
	  location.href="detailpage.jsp?store_id="+store_id+"&#target4";       
	});	
</script>

