<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="b_teampro2.storeinfo.*" %>           
<%@ page import="java.util.*" %>      
<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "검색 완료";
		String user_id = (String)session.getAttribute("user_id");
				
	%>
<%

//객체
	UserSystemDBBean system = UserSystemDBBean.getInstance();
//검색

String key = request.getParameter("key");
if(key==null){key="";}	
String cat = request.getParameter("category") ;
String filter = "reg_date"; //or  리뷰 갯수 높은 순  or 남은팀 순
String opt_e = request.getParameter("opt");
int opt = 0;
if(opt_e!=null){ opt = Integer.parseInt(opt_e);}
int category = 5;
if(cat!=null){category = Integer.parseInt(cat);} 
	
//검색 페이지 네이션 제어
   int pageSize = 3;
	String pageNum = request.getParameter("pageNum");	
    if (pageNum == null) {
        pageNum = "1";
        
    }

   int count = system.getSearchCount(key,category);
   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1) * pageSize + 1;
   int endRow = currentPage * pageSize;
  
 //검색 함수 호출 
   ArrayList<StoreinfoDataBean> searchList = system.getMainSearch(key,category,opt,startRow,pageSize);

%> 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<!-- 상단 메뉴 -->	

	<jsp:include page="../frame/top.jsp" flush="false"/>	
	
<!-- main content -->
<body onload="setBounds()">
<input type="hidden" id="user_id" value="<%=user_id %>">

		<!-- <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img  src="../../../img/main_img1.png">
          </div>
        </div>
      </div> -->
      
      <!-- <div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-bottom:0px;">
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img class="first-slide" src="../../../img/main_img1.png" alt="First slide">
            <div class="container">
              <div class="carousel-caption text-left">
                <p class="pb-5">소중한 순간과 함께하는 맛있는 한 끼, Delicious Spoon</p>    
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <img class="second-slide" src="../../../img/main_img2.jpg" alt="Second slide">
            <div class="container">
              <div class="carousel-caption text-left">
  				 <p class="pb-5">당신도 언제든지 이용 할 수 있습니다!</p>     
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <img class="third-slide" src="../../../img/main_img3.png" alt="Third slide">
            <div class="container">
              <div class="carousel-caption text-left">
				<p class="pb-5">당신의  시간을 소중하게,
								  Delicous Spoon</p>    
              </div>
            </div>
          </div>
        </div>
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div> -->
       <div class="photo_main">   
         <div id="myCarousel" class="carousel slide" data-ride="carousel">
              <div class="carousel-inner">
                <div class="carousel-item active">
                  <img  src="../../../img/main_img1.png">
                </div>
              </div>              
          </div>
          <span class="photo_main_up2">
          		<div class="w3-display-middle" style="width: 60%; text-align: center; color: white; font-size: 3.5rem;">
          			어떤 음식점을 찾으시나요? 
          		</div>
                <div class="w3-display-bottommiddle" style="width: 60%;">
                      <div class="row d-flex pt-5 pb-5 justify-content-center">         
                        <div class="col-md-8 ml-1 pr-3" style=" padding-left:27px;">
                           <input class="form-control" id="key" type="text" placeholder="찾고싶은 키워드를 입력해주세요" value="<%=key%>">
                        </div>      
                        <div class="col-auto pl-2 mr-2">
                           <button class="btn btn-small btn-depoon" id="search" type="button"><i class="fas fa-search"></i></button>
                        </div>      
                     </div>
                     
                     <div class="row d-flex pb-5 justify-content-center">         
                        <div class="btn-group-toggle" data-toggle="buttons">
                          <label class="btn btn-outline-dark <%if(category==5){out.print("active");}%> mr-3 pl-4 pr-4">
                            <input type="radio" class="category" value="5" autocomplete="off"> 전체
                          </label>
                          <label class="btn btn-outline-dark <%if(category==0){out.print("active");}%> mr-3 pl-4 pr-4">
                            <input type="radio" class="category" value="0" autocomplete="off"> 한식
                          </label>
                          <label class="btn btn-outline-dark <%if(category==1){out.print("active");}%> mr-3 pl-4 pr-4">
                            <input type="radio" class="category" value="1" autocomplete="off"> 일식
                          </label>
                          <label class="btn btn-outline-dark <%if(category==2){out.print("active");}%> mr-3 pl-4 pr-4">
                            <input type="radio" class="category" value="2" autocomplete="off"> 중식
                          </label>
                          <label class="btn btn-outline-dark <%if(category==3){out.print("active");}%> mr-3 pl-4 pr-4">
                            <input type="radio" class="category" value="3" autocomplete="off"> 양식
                          </label>
                          <label class="btn btn-outline-dark <%if(category==4){out.print("active");}%> mr-3 pl-4 pr-4">
                            <input type="radio" class="category" value="4" autocomplete="off"> 기타
                          </label>    
                        </div>
                           <div class="dropdown ml-2">
                             <button class="btn btn-depoon dropdown-toggle pl-4 pr-4" type="button" id="dropdownMenuButton" 
                             data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                               <%if(opt==0){out.print("최신순");}%>
                                 <%if(opt==1){out.print("리뷰순");}%>
                                <%if(opt==2){out.print("인기순");}%>
                             </button>
                             <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                               <a class="dropdown-item" class="opt" href="search_done.jsp?key=<%=key%>&category=<%=category%>&opt=0">최신순</a>
                               <a class="dropdown-item" class="opt" href="search_done.jsp?key=<%=key%>&category=<%=category%>&opt=1">리뷰순</a>
                               <a class="dropdown-item" class="opt" href="search_done.jsp?key=<%=key%>&category=<%=category%>&opt=2">인기순</a>
                              </div>
                         </div>
                     </div>
                  </div>   
            </span>
       </div>     
      
<div class="container">
	<!-- <div class="container">
		<img src="/bban/b_teampro2/img/search_done2.jpg"  style="height:32rem;width:100%;display:block;">
	</div> -->
	
	
	<%-- <div class="w3-display-bottommiddle" style="width: 60%;">
        <div class="row d-flex pt-5 pb-5 justify-content-center">         
          <div class="col-md-8 ml-1 pr-3" style=" padding-left:27px;">
             <input class="form-control" id="key" type="text" placeholder="찾고싶은 키워드를 입력해주세요" value="<%=key%>">
          </div>      
          <div class="col-auto pl-2 mr-2">
             <button class="btn btn-small btn-depoon" id="search" type="button"><i class="fas fa-search"></i></button>
          </div>      
       </div>
    </div>                 
	<div class="row d-flex pt-5 pb-5 justify-content-center">			
		<div class="col-md-8 ml-1 pr-3" style=" padding-left:27px;">
			<input class="form-control" id="key" type="text" placeholder="찾고싶은 키워드를 입력해주세요" value="<%=key%>">
		</div>		
		<div class="col-auto pl-2 mr-2">
			<button class="btn btn-small btn-depoon" id="search" type="button"><i class="fas fa-search"></i></button>
		</div>		
	</div>
	
	<div class="row d-flex pb-5 justify-content-center">			
		<div class="btn-group-toggle" data-toggle="buttons">
		  <label class="btn btn-outline-dark <%if(category==5){out.print("active");}%> mr-3 pl-4 pr-4">
		    <input type="radio" class="category" value="5" autocomplete="off"> 전체
		  </label>
		  <label class="btn btn-outline-dark <%if(category==0){out.print("active");}%> mr-3 pl-4 pr-4">
		    <input type="radio" class="category" value="0" autocomplete="off"> 한식
		  </label>
		  <label class="btn btn-outline-dark <%if(category==1){out.print("active");}%> mr-3 pl-4 pr-4">
		    <input type="radio" class="category" value="1" autocomplete="off"> 일식
		  </label>
		  <label class="btn btn-outline-dark <%if(category==2){out.print("active");}%> mr-3 pl-4 pr-4">
		    <input type="radio" class="category" value="2" autocomplete="off"> 중식
		  </label>
		  <label class="btn btn-outline-dark <%if(category==3){out.print("active");}%> mr-3 pl-4 pr-4">
		    <input type="radio" class="category" value="3" autocomplete="off"> 양식
		  </label>
		  <label class="btn btn-outline-dark <%if(category==4){out.print("active");}%> mr-3 pl-4 pr-4">
		    <input type="radio" class="category" value="4" autocomplete="off"> 기타
		  </label>	 
		</div>
			<div class="dropdown ml-2">
			  <button class="btn btn-depoon dropdown-toggle pl-4 pr-4" type="button" id="dropdownMenuButton" 
			  data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
			    <%if(opt==0){out.print("최신순");}%>
		   		<%if(opt==1){out.print("리뷰순");}%>
		     	<%if(opt==2){out.print("인기순");}%>
			  </button>
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
			    <a class="dropdown-item" class="opt" href="search_done.jsp?key=<%=key%>&category=<%=category%>&opt=0">최신순</a>
			    <a class="dropdown-item" class="opt" href="search_done.jsp?key=<%=key%>&category=<%=category%>&opt=1">리뷰순</a>
			    <a class="dropdown-item" class="opt" href="search_done.jsp?key=<%=key%>&category=<%=category%>&opt=2">인기순</a>
		  	 </div>
		 </div>
	</div>
	 --%>


	<!-- 검색결과 -->
	<div class="d-flex justify-content-start align-items-end pt-3 pl-4">
		<p class="lead font-weight-bold">'<%=key%>'</p>
		<p class="pl-4">에 대한 검색 결과</p>
<%	if(searchList!=null&&!key.equals("")){%>
		<p class="pl-2">(총</p>
		<p class="pl-2 font-weight-bold"><%=count%></p>	
		<p class="pl-1">개)</p>
<%}%>			
	</div>
	<div class="border-bottom mt-2 mb-2"></div>	
	<!-- 목록1 -->
	<div class="row">
<%	if(searchList!=null&&!key.equals("")){%>
		<div class="col-6">
		<% 			
			for(int i=0;i<searchList.size();i++){	
				StoreinfoDataBean search = new StoreinfoDataBean();
				search = searchList.get(i);
				
			 %>
			 <input type="hidden" class="a" name="address" value="<%=search.getAddress()%>">
			  <input type="hidden" value="<%=search.getStore_id()%>" class="store_id">
	          <input type="hidden" value="<%=system.getFavoriteCount(search.getStore_id(),user_id)%>" class="favorite">	 
			<div class="pt-1 pb-3 pl-5">
				<div class="row d-flex justify-content-start mt-3">			
					<div class="col-sm-5 d-flex justify-content-center pt-2">
						<div class="photo_main"> 	
							<img src="/bban/imageFile/<%=search.getMain_photo()%>" class="rounded pr-2" style="width: 230px; height: 165px;">				
							<span class="photo_main_up2">
		                        <span class="heart  w3-display-topright pb-1" style="padding-right:40px; padding-top: 7px;">
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
	                     </span>
	                   </div>
					</div>		
					<div class="col-sm-7 d-flex justify-content-start align-items-center pt-2">
						<div class="pl-4">
						<div class="row">
							<div class="col mt-2 text-left" style="padding-left: 14px; margin-bottom:0.5rem;">
								<p class="font-weight-bold" style="font-size:1.2rem;"><a href="detailpage.jsp?store_id=<%=search.getStore_id()%>"><%=search.getStore_name()%></a></p>	
								<input type="hidden" name="store_name" value="<%=search.getStore_name()%>">													
							</div>
							<%-- <div class="col-4 pt-3 align-items-sm-baseline" style="padding-left:14px;">
								<!-- <p style="font-size:0.9rem;margin-bottom:0rem;">카테고리</p>	 -->
								<p class="pl-2 text-right" style="font-size:0.8rem;margin-bottom:0rem;">
								<%if(search.getCategory()==0){out.print("한식");}
					        	else if(search.getCategory()==1){out.print("일식");}
					        	else if(search.getCategory()==2){out.print("중식");}
					        	else if(search.getCategory()==3){out.print("양식");}
        						else{out.print("기타");} %>
        						</p>		
							</div>	 --%>					
							</div>	
																	
							<div class="row" style="padding-left: 14px;">
								<p class="text-left" style="font-size:0.8rem; margin-bottom:0.8rem; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 15.0rem; text-align: left;"><%=search.getAddress()%></p>			
							</div>
							
							<div class="row mb-2" style="padding-left: 14px;">
								<p style="font-size:0.8rem;margin-bottom:0.9rem; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 15.0rem; text-align: left;">							
								<%	String names = search.getMenu_names();
	       					       String name [] = names.split(","); 

								  if(names!=null){
									  for(int j=0;j<name.length;j++){
										  out.print(name[j]);
										  if(j<name.length-1){
											  out.print(", ");
										  }
									  }}%>							
								</p>		
							</div>
		
							<div class="row align-items-sm-baseline" style="padding-left: 14px;">
							   <p><%=search.getAvg_mark()%></p>	
								<div class="pl-3">
								  <span class="starRe<%if(search.getAvg_mark()>=1.0){out.print(" on");}%>">1</span>
								  <span class="starRe<%if(search.getAvg_mark()>=2.0){out.print(" on");}%>">2</span>
								  <span class="starRe<%if(search.getAvg_mark()>=3.0){out.print(" on");}%>">3</span>
								  <span class="starRe<%if(search.getAvg_mark()>=4.0){out.print(" on");}%>">4</span>
								  <span class="starRe<%if(search.getAvg_mark()>=5.0){out.print(" on");}%>">5</span>
								</div>	
								<p class="pl-2" style="font-size:0.8rem;"><%=system.getReviewCount(search.getStore_id())%>건의 리뷰</p>										
							</div>
														
						</div>												
					</div>							
				</div>
			</div>		
			<div class="border-bottom pb-2 ml-3 pr-1" style="width: 98%;"></div>
			<input type="hidden" name="team" value="<%=system.getCurrent_team(search.getStore_id())%>">
			<%}//for end%>	
		</div>
		<!-- 지도 -->
		<div class="col-6 pl-4">
			<div id="map" style="width:500px;height:650px;"></div>
		</div>	
		<%}else{%>
			<div class="col-10 ml-2 d-flex mt-3 ml-4">
			<div>
			<div class="row"><p class="font-weight-bold">검색결과가 없습니다.</p></div>
			<div class="row"><p>*단어의 철자를 확인해주세요</p></div>
			<div class="row"><p>*검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요.</p></div>	
			<div class="row"><p>*검색 옵션을 변경해서 다시 검색해 보세요.</p></div>
			</div>		
			</div>
		<%}%>
	</div><!-- row end -->
	
	
	<!-- pagination -->
	<div class="d-flex justify-content-center pt-5">
	
	<%try{
	if(key!=null&&!key.equals("")){
		    if (count > 0) {
			        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage =1;
					
					if(currentPage % 10 != 0)
			           startPage = (int)(currentPage/10)*10 + 1;
					else
			           startPage = ((int)(currentPage/10)-1)*10 + 1;
						
					int pageBlock = 10;
			        int endPage = startPage + pageBlock - 1;
			        if (endPage > pageCount) endPage = pageCount;
			        %>
		<nav aria-label="Page navigation example">
		  <ul class="pagination" style="background-color:#fc5f4a;border-color:#fc5f4a;">
		<%
        if (currentPage > 5) { %>		  
		    <li class="page-item btn-depoon">
		      <a class="page-link btn-dp-p" href="search_done.jsp?pageNum=<%= currentPage - 5 %>&category=<%=category%>&key=<%=key%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		        <span class="sr-only">Previous</span>
		      </a>
		    </li>
	<%      }
       
	    for (int i = startPage ; i <= endPage ; i++) {  
	        if(currentPage==i){%>    
	 		    <li class="page-item btn-depoon"><a class="page-link btn-depoon" href="search_done.jsp?pageNum=<%=i%>&category=<%=category%>&key=<%=key%>"><%=i%></a></li>
	  	 <% }else{%>
	    		 <li class="page-item"><a class="page-link btn-dp-p" href="search_done.jsp?pageNum=<%=i%>&category=<%=category%>&key=<%=key%>"><%=i%></a></li>
	    	   <% 		       
	 		}   
	 	}//for end
			if (endPage < pageCount) {  %>
		    <li class="page-item btn-depoon">
		      <a class="page-link btn-dp-p" href="search_done.jsp?pageNum=<%= currentPage + 5 %>&category=<%=category%>&key=<%=key%>" aria-label="Next">		      
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
}; // KEY NULL IF END 
}catch(Exception e){}
	%>  
	</div><!-- pagination end -->

</div><!-- container end -->
<!-- bottom -->
<jsp:include page="../frame/bottom.jsp" flush="false"/>	

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>		


<script>

//검색 옵션 발생시
$('#search').click(function() {
  var key = $('#key').val();
  
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
        	 location.href="search_done.jsp?key="+data;   
        	 console.log(data);        	
        }
    }); // end ajax
});


$('.category').focus(function() {
	  var key = $('#key').val();
	  var index = $('.category').index(this);
	  var category = $('.category').eq(index).val();
		
	  console.log(category);
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
	        	 location.href="search_done.jsp?key="+data+"&category="+category;   
	        	 console.log(data);        	
	        }
	    }); // end ajax
	});


if(key!=""||key!="null"){
//html 에서 검색된 장소값 가져오기
var fileValue = $("input[name='address']").length;
var fileValue2 =  $("input[name='store_name']").length;
var fileValue3 =  $("input[name='team']").length;
var fileData = new Array(fileValue);
var fileData2 = new Array(fileValue2);
var fileData3 = new Array(fileValue3);

var address = new Array (fileValue);//json 형식을 위한 출력
for(var i=0; i<fileValue; i++){             	
     fileData[i] = $("input[name='address']")[i].value;
     fileData2[i] = $("input[name='store_name']").eq(i).attr("value");
     fileData3[i] = $("input[name='team']")[i].value;
   //  console.log(fileData2[i]);
     address[i] = ({groupAddress:fileData[i]});
    // console.log(address[i]);
     //console.log(fileData3[i]);
}
console.log(address);


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  


// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
var bounds = new daum.maps.LatLngBounds();   
// 지도를 생성합니다    
var map1 = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder1 = new daum.maps.services.Geocoder();

var listData = new Array(fileValue);
for(var i=0; i<fileValue; i++){                          
    listData[i] = address[i];

}

var imageSrc = '/bban/b_teampro2/img/map-localization_r.png', // 마커이미지의 주소입니다    
imageSize = new daum.maps.Size(45, 45), // 마커이미지의 크기입니다
imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);

/* var listData = [
		   {groupAddress: fileData[0]},
]; 
    */ 
   var j =0;
for (let i=0; i < listData.length ; i++) {	
// 주소로 좌표를 검색합니다
	

	geocoder1.addressSearch( fileData[i], function(result, status){		
	    // 정상적으로 검색이 완료됐으면   
	    console.log("주소"+fileData[i]);
	   if (status === daum.maps.services.Status.OK) {
	      var coords1 = new daum.maps.LatLng(result[0].y, result[0].x);	 
	    	console.log("좌표"+ result[0].y + "x:"+result[0].x);
	    	console.log("주소"+fileData[i]);
	    	console.log("대기수"+fileData3[i]);
	    	console.log("음식점명"+fileData2[i]);
	    	console.log("----------");
	        //지도 확대레벨 재설 정을 위해 변수에 연결
	        bounds.extend(new daum.maps.LatLng(result[0].y, result[0].x));
	        
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker1 = new daum.maps.Marker({
	            map: map1,
	            position: coords1,
	            image: markerImage 
	            
	        });
			//마커를 지도에 표시합니다
	         marker1.setMap(map1);
				 // 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다		
			var content = '<div class="customoverlay">' +
		    '  <a href="#" target="_blank">' +
		    '    <span class="title">'+ fileData2[i]+'</span>' +
		    '  </a>' +
		    '</div>';

			// 커스텀 오버레이를 생성합니다
			var customOverlay = new daum.maps.CustomOverlay({
			    map: map1,
			    position: marker1.getPosition(),
			    content: content,
			    yAnchor: 1 
			}); 		
		
			var content2 = '<div class="customoverlay">' +
		    '  <a href="#" target="_blank">' +
		    '    <span class="title"> 대기 팀수  '+ fileData3[i]+'</span>' +
		    '  </a>' +
		    '</div>';

			// 커스텀 오버레이를 생성합니다
			var customOverlay2 = new daum.maps.CustomOverlay({
			    map: map1,
			    position: marker1.getPosition(),
			    content: content2,
			    yAnchor: 1 
			}); 		
			customOverlay.setMap(map1);
			customOverlay2.setMap(null);
	        
	        ++j;
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map1.setCenter(coords1); 
	   
	         //마우스 이벤트 실행

	        daum.maps.event.addListener(marker1, 'mouseover', makeOverListener(map1, marker1, customOverlay));
		    daum.maps.event.addListener(marker1, 'mouseout', makeOutListener(customOverlay));		    
	        daum.maps.event.addListener(marker1, 'mouseover', makeOverListener2(map1, marker1, customOverlay2));
		    daum.maps.event.addListener(marker1, 'mouseout', makeOutListener2(customOverlay2));
	    } 
	   
	});
	
	 
}; //end for

 function makeOverListener(map1, marker1, customOverlay) {
    return function() {
    	customOverlay.setMap(null);
    };
}

 function makeOverListener2(map1, marker1, customOverlay2) {
	    return function() {
	    	customOverlay2.setMap(map1);
	    };
	}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(customOverlay) {
    return function() { 
    	customOverlay.setMap(map1);
    };
} 

function makeOutListener2(customOverlay2) {
    return function() {
    	customOverlay2.setMap(null);
    };
} 

function setBounds() {
    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
    map1.setBounds(bounds);
}

};
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

