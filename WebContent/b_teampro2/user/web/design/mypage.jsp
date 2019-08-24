<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>

<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "마이페이지";
		String user_id = (String)session.getAttribute("user_id");
		
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>    

<!-- 상단 메뉴 -->
<jsp:include page="../frame/top.jsp" flush="false"/>   
<%
try{  
	if(user_id==null||user_id.equals("")){
		response.sendRedirect("../control/error.jsp");
	}else{ 
		 //시스템 객체 생성
		UserSystemDBBean system = UserSystemDBBean.getInstance(); 
		 //날짜 객체 생성
		DateFormat format1 = DateFormat.getDateInstance(DateFormat.LONG);
	       
		//1.user 객체  <-- 프로필 사진과 아이디값
		UserinfoDBBean logon = UserinfoDBBean.getInstance();  
		UserinfoDataBean user = null;
		user=logon.selectMember(user_id);
	//페이지 네이션
		 int pageSize = 4;
		 int pageSize2 = 5;
		 int pageSize3 = 3;
		 
		String pageNum = request.getParameter("pageNum");
		String pageNum2 = request.getParameter("pageNum2");
		String pageNum3 = request.getParameter("pageNum3");
	    if (pageNum == null) {
	        pageNum = "1";	        
	    }
	    if (pageNum2 == null) {
	        pageNum2 = "1";	        
	    }
	    if (pageNum3 == null) {
	        pageNum3 = "1";	        
	    }	    
		   int currentPage = Integer.parseInt(pageNum); 
		   int currentPage2 = Integer.parseInt(pageNum2); 
		   int currentPage3 = Integer.parseInt(pageNum3); 
		   
		   int startRow = (currentPage - 1) * pageSize + 1;    
		   int startRow2 = (currentPage2 - 1) * pageSize2 + 1;   
		   int startRow3 = (currentPage3 - 1) * pageSize3 + 1;   
		   int endRow = currentPage * pageSize;	
		   int endRow2 = currentPage2 * pageSize2;	
		   int endRow3 = currentPage3 * pageSize3;	
	   int count = system.getFavoriteCount(user_id); //favorite 갯수	
	   int count2 = system.getReviews3Count(user_id); // 방문한 곳 갯수	 
	   int count3 = system.getReviews2Count(user_id); //내가쓴 리뷰 	   
		//2.방문한곳
		List<UserReviewDataBean> reviewList = null;

		//3.리뷰	
			//매장에 달린 리뷰 총갯수
			int review_count = system.getReviewCount2(user_id);				
			//리뷰 출력하는 객체 생성
			List<UserReviewDataBean> reviewList2 = null;

		//4.대기 출력
		List<UserWaitDataBean> waitinfoList = null;
		waitinfoList = system.getMywaiting2(user_id);
		//5.즐겨찾기
		List<UserFavoriteDataBean> favoriteList = null;
		
%>   
   
<!-- main content -->
<input type="hidden" id="user_id" value="<%=user_id %>">
   <div class="container">
     <div class="container">
      <ul class="list-inline border-bottom">
        <li class="list-inline-item d-flex justify-content-start pt-5"><p class="h2">마이페이지</p> <!-- title value --></li>
      </ul>      
   </div>
      <div class="justify-content-center mt-5">
 	<%if(user.getUser_photo().equals("profile.jpg")){ %>
			<img class="rounded-circle" src="../../../img/profile.jpg" name="user_photo" id="photo" style="width:10rem; height:10rem;">		 
		<%}else{ %> 
			<img class="rounded-circle" src="/bban/imageFile/<%=user.getUser_photo()%>" id="photo" style="width:10rem; height:10rem;"> 	
		<%} %>            
         <p class="lead my-3 mb-5 pb-5"><%=user_id%></p>
      </div>    
        <nav class="nav mb-2">
         <a class="nav-link active lead style scroll" href="#target1" style=" color: black;">대기 중</a>
	     <a class="nav-link lead scroll"  href="#target2" style=" color: black;">즐겨찾기</a>
	     <a class="nav-link disabled lead scroll" href="#target3" style=" color: black;">방문한 곳</a>
	     <a class="nav-link disabled lead scroll" href="#target4" style=" color: black;">내가 쓴 리뷰</a>
        </nav>
     </div>     
     <div class="container" id="target1">
        <div class="d-flex justify-content-start border-top">
          <p class="h3 pt-1 mb-3 mt-3 ml-3">대기 중 </p>
       	</div>
          <div class="row ml-1">
 <%  
 //출력부분
 if(waitinfoList!=null){
 for (int i = 0 ; i < waitinfoList.size() ; i++){
	 UserWaitDataBean waitinfo = waitinfoList.get(i);
      %>
    <!-- 실시간 대기 상황 띄우는 함수   system.getCurrent_team(waitinfo.getStore_id())-->		 
    <div class="col-md-3">
    <input class="check_list" type="hidden" value="<%=waitinfo.getCheck_list()%>">
    <input class="store_id2" type="hidden" value="<%=waitinfo.getStore_id()%>">
      <div class="card mb-5" style="width:14.8rem; height:13rem;">
		 <span class="photo_main">
          <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=waitinfo.getMain_photo()%>">      
                 
			<!-- 웨이팅 -->
					<span class="photo_main_up waiting">                    
	                     <span class="heart  w3-display-topright pb-1" style="padding-right:30px;">
	                           <div style="position: absolute;">
			                        <span class="pt-2 wait_delete"><!-- 대기 취소 버튼 -->
								  		<i class="fas fa-times" style="color:white; width: 20px; height: 20px;"></i>
			                        </span>
	                   			</div>
	                     </span> 
	                     
	                     <span class="w3-display-topleft" style="padding-left: 60px; padding-top: 25px;">
	                             <div style="position: absolute;">
				                     <span class="pt-2">
				                        <p style="color:white; width: 100px;" >남은 팀</p>
				                       <p style="color:white; font-size: 3.0rem;"><%=system.getCurrent_team(waitinfo.getStore_id()) %></p>   
				                     </span>
	                     		 </div>	                     
	                	</span>
						<a href="detailpage.jsp?store_id=<%=waitinfo.getStore_id()%>">
	                      <div class="area1 w3-display-topleft"></div>
	                      <div class="area2 w3-display-bottomleft"></div>
	                 	</a>                     
      				</span>  
      				
      				<!-- no show -->       
  			      <span class="photo_main_up no_show" style="display :none;">                    
                       <span class="heart  w3-display-topright pb-1" style="padding-right:30px;"></span>
                       <div class="area3">
                        <p class="w3-display-middle c_text mt-2">NO SHOW</p>
                       </div> 
                  </span>
                </span>                          
        <div class="card-body pt-2" style="padding-left:5px; padding-right: 5px; text-align: center;">
          <p class="title_main" style="width: 14.0rem; text-align: center;"><%=waitinfo.getStore_name()%></p>
        </div>
      </div>
    </div>
      <%}}else{%>
		<p class="ml-2 pl-1 mb-4"> 대기중인 매장이 없습니다.</p>
      <%}%>
	  </div>
</div>
    <div class="container" id="target2">      
    <div class="d-flex justify-content-start border-top">
    <p class="h3 pt-1 mb-3 ml-3 mt-4">즐겨찾기 (<%=count%>)</p>
   </div> 
         <div class="row ml-1">
         <%
         favoriteList = system.getFavorite(user_id,startRow,4);
         if(favoriteList!=null){
        	 for(int i=0;i<favoriteList.size();i++){      		 
        	 	UserFavoriteDataBean favorite = favoriteList.get(i);%>
        	<input type="hidden" class="store_id" value="<%=favorite.getStore_id()%>">
            <div class="col-md-3 f_contents"> <!-- for 문-->         
              <div class="card mb-4" style="width:14.8rem; height:13rem;">
 			<span class="photo_main">
                  <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=favorite.getMain_photo()%>">                
                    <span class="photo_main_up">                    
                       <span class="heart  w3-display-topright pb-1" style="padding-right:30px;">
                             <div style="position: absolute;">
                          <span class="favorite_delete">
                             <i class="fas fa-times" style="color:white; width: 20px; height: 20px;"></i>
                          </span>
                     </div>
                       </span> 
                       <a href="detailpage.jsp?store_id=<%=favorite.getStore_id()%>">
                        <div class="area1 w3-display-topleft"></div>
                        <div class="area2 w3-display-bottomleft"></div>
                      </a>
                  </span>
               </span>                              
                <div class="card-body pt-2" style="padding-left:5px; padding-right: 5px; text-align: center;" >
                  <p  class="title_main" style="width: 14.0rem; text-align: center;"><%=favorite.getStore_name()%></p>
                </div>
              </div>
            </div>
            <%}}else{%>
				<p class="ml-2 pl-1 mb-4" id="f_alarm"> 즐겨찾기로 등록한 매장이 없습니다.</p>
             <%}%>
      	</div>
      	   			<!-- pagination -->
	         <div class="d-flex justify-content-center mb-3">
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
		        if (currentPage > 5) { %>		  
				    <li class="page-item btn-depoon">
				      <a class="page-link btn-dp-p2" href="mypage.jsp?pageNum=<%= currentPage - 5 %>&#target2" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				        <span class="sr-only">Previous</span>
				      </a>
				    </li>
			<%      }
		       
			    for (int i = startPage ; i <= endPage ; i++) {  
			        if(currentPage==i){%>    
			 		    <li class="page-item btn-dp-p2"><a class="page-link btn-dp-p2" href="mypage.jsp?pageNum=<%= i %>&#target2"><%=i%></a></li>
			  	 <% }else{%>
			    		 <li class="page-item "><a style="color:#fc5f4a" class="page-link" href="mypage.jsp?pageNum=<%= i %>&#target2"><%=i%></a></li>
			    	   <% 		       
			 		}   
			 	}//for end
					if (endPage < pageCount) {  %>
				    <li class="page-item btn-depoon">
				      <a class="page-link btn-dp-p2" href="mypage.jsp?pageNum=<%= currentPage + 5 %>&#target2" aria-label="Next">
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
      <div class="d-flex justify-content-center border-bottom pb-3 mb-1">
      </div>         
    </div>  
<!-- 방문한 곳 -->
<div class="container" id="target3">
	<div class="d-flex justify-content-start">
      <p class="h3 pt-1 mb-3 mt-4 ml-3">방문한 곳 (<%=count2%>) </p>
   	</div>
   	<div>
		<table class="table border-bottom mb-5 ml-3" style="width:71rem; height:5rem;">
	        <thead>
	          <tr>
	            <th scope="col">방문일</th>
	            <th scope="col">매장이름</th>
	            <th scope="col">리뷰확인</th>
	          </tr>
	        </thead>
	        <tbody>	 	
 <%  
  //출력부분
  		reviewList=system.getReviews3(user_id,startRow2,pageSize2);
		 if(reviewList!=null){
		 for (int i = 0 ; i < reviewList.size() ; i++){
			 UserReviewDataBean review = reviewList.get(i);    
		       %>
              <tr>
	            <th scope="row" style="padding-left:0px; padding-right:0px;"><%=format1.format(review.getReg_date())%></th>
	            <td><%=review.getStore_name()%></td>
	            <td><%if(review.getCheck_review()==0){%><a href="review.jsp?store_id=<%=review.getStore_id()%>&#target4" style="text-decoration:none; color:black;"><!-- <i class="fas fa-edit" id="review"> --></i>리뷰쓰기</a>
	            <img  src="../../../img/write.png" class="ml-1 mb-1"style="width: 20px; height: 20px;" /><%}
	            else{%><a href="detailpage.jsp?store_id=<%=review.getStore_id()%>&#target4" style="text-decoration:none; color:black;"><id="review_done"></i>리뷰확인<img  src="../../../img/reviewlist.png" class="ml-1 mb-1"style="width: 20px; height: 20px;" /></a><%}%></td>
	          </tr>
	         <% }}%>
	        </tbody>
		</table> 
	</div>        
</div>
    			<!-- pagination -->
	         <div class="d-flex justify-content-center mb-3">
			<%try{
				    if (count2 > 0) {
				   
					        int pageCount = count2 / pageSize2 + (count2 % pageSize2 == 0 ? 0 : 1);
							int startPage =1;
							
							if(currentPage2 % 10 != 0)
					           startPage = (int)(currentPage2/10)*10 + 1;
							else
					           startPage = ((int)(currentPage2/10)-1)*10 + 1;
								
							int pageBlock = 10;
					        int endPage = startPage + pageBlock - 1;
					        if (endPage > pageCount) endPage = pageCount;%>
				<nav aria-label="Page navigation example">
				  <ul class="pagination">
				<%
		        if (currentPage2 > 5) { %>		  
				    <li class="page-item btn-depoon">
				      <a class="page-link btn-dp-p2" href="mypage.jsp?pageNum2=<%= currentPage2 - 5 %>&#target3" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				        <span class="sr-only">Previous</span>
				      </a>
				    </li>
			<%      }
		       
			    for (int i = startPage ; i <= endPage ; i++) {  
			        if(currentPage2==i){%>    
			 		    <li class="page-item btn-dp-p2"><a class="page-link btn-dp-p2" href="mypage.jsp?pageNum2=<%= i %>&#target3"><%=i%></a></li>
			  	 <% }else{%>
			    		 <li class="page-item"><a style="color:#fc5f4a" class="page-link" href="mypage.jsp?pageNum2=<%= i %>&#target3"><%=i%></a></li>
			    	   <% 		       
			 		}   
			 	}//for end
					if (endPage < pageCount) {  %>
				    <li class="page-item btn-depoon">
				      <a class="page-link btn-dp-p2" href="mypage.jsp?pageNum2=<%= currentPage2 + 5 %>&#target3" aria-label="Next">
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
<!-- 내가 쓴 리뷰 -->
<div class="container" id="target4">
   <div class="d-flex justify-content-start border-top">
      <p class="h3 pt-1 mb-1 ml-3 mt-4">내가 쓴 리뷰 (<%=count3%>) </p>
    </div>
      <div class="container">
      <div class="border-bottom mt-2 mb-4 pt-2 pb-2 ml-1 pr-1" style="width: 70.5rem;"></div> 
  	<% 		
	   reviewList2 = system.getReviews2(user_id,startRow3,pageSize3);
  	if(reviewList2!=null){
						 for (int i = 0 ; i < reviewList2.size() ; i++){ 
						  UserReviewDataBean review = reviewList2.get(i);
						  ArrayList<String> r_photo= new ArrayList<String>(); 
						  String review_photos = review.getReview_photos();
						  if(review_photos!=null){
						  String review_photo [] = review_photos.split(",");
						
						  for(int j=0;j<review_photo.length;j++){
							  r_photo.add(review_photo[j]);
						  }}		
						  %> 	   
      <div class="pt-2 pb-2 pl-3">
         <div class="row d-flex justify-content-start">
            <div class="col-sm-3 d-flex align-items-start"> 
               <span class="pl-4 pt-2" style="padding-left: 16px; text-align:center;">
                  <a href="detailpage.jsp?store_id=<%=review.getStore_id()%>"><img class="rounded-circle" src="/bban/imageFile/<%=review.getMain_photo()%>" alt="Generic placeholder image" width="100rem" height="100rem"></a>
                  <h6 class="title_main pt-1" style="width: 200px; text-align: center;"><%=review.getStore_name()%></h6>
               </span>
            </div>
            <div class="col-sm-7 pt-2 d-flex">
               <div>
                       <div class="row mb-2" style="padding-left: 14px;">
	                        <div>
							  <span class="starRe<%if(review.getScore()>=1){out.print(" on");}%>">1</span>
							  <span class="starRe<%if(review.getScore()>=2){out.print(" on");}%>">2</span>
							  <span class="starRe<%if(review.getScore()>=3){out.print(" on");}%>">3</span>
							  <span class="starRe<%if(review.getScore()>=4){out.print(" on");}%>">4</span>
							  <span class="starRe<%if(review.getScore()>=5){out.print(" on");}%>">5</span>
	                        </div>
                           <p class="pl-4"><%=format1.format(review.getReg_date2())%> 방문</p> 
                        </div>
                        <div class="row pb-2" style="padding-left: 14px;">
                           <p class="lead"><%=review.getReview_title()%></p>
                      </div>
                      <div class="row" style="padding-left: 14px;">
                         <p class="text-left"><%=review.getReview_content()%></p>
                      </div>
                   </div>
                </div>
                <% if(review_photos!=null){%>
		         <span class="more d-flex justify-content-end align-items-end pb-2 pl-4 ">더보기 <i class="fas fa-caret-down"></i></span>
		         <!-- 더보기 누른 경우 -->
		      	<div class="imgarea"> 
			      <div class="pt-2 pb-2 pl-5 mb-3">
			         <div class="row pt-3">	 
                  	<%	 for(int j=0;j<r_photo.size();j++){ %>
				            <div class="col-sm-4"> 
				               <img src="/bban/imageFile/<%=r_photo.get(j)%>" class="rounded" style="width:280px; height:200px;">
				            </div>
				                <%}%>
			         </div>
			      </div>
			      <%}%> 
			    </div>	     
		      </div>
         </div>
      <div class="border-bottom mt-2 mb-4 pt-2 pb-2 ml-1 pr-1" style="width: 70.5rem;"></div> 
    
           <%}} %>
      </div>     
  </div>  
      			<!-- pagination -->
			         <div class="d-flex justify-content-center pt-3">
					<%try{
						    if (count3 > 0) {
					
							        int pageCount = count3 / pageSize3 + (count3 % pageSize3 == 0 ? 0 : 1);
									int startPage =1;
									
									if(currentPage3 % 10 != 0)
							           startPage = (int)(currentPage3/10)*10 + 1;
									else
							           startPage = ((int)(currentPage3/10)-1)*10 + 1;
										
									int pageBlock = 10;
							        int endPage = startPage + pageBlock - 1;
							        if (endPage > pageCount) endPage = pageCount;%>
						<nav aria-label="Page navigation example">
						  <ul class="pagination">
						<%
				        if (currentPage3 > 5) { %>		  
						    <li class="page-item btn-depoon">
						      <a class="page-link btn-dp-p2" href="mypage.jsp?pageNum3=<%= currentPage3- 5 %>&#target4" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						        <span class="sr-only">Previous</span>
						      </a>
						    </li>
					<%      }
				       
					    for (int i = startPage ; i <= endPage ; i++) {  
					        if(currentPage3==i){%>    
					 		    <li class="page-item btn-dp-p2"><a class="page-link btn-dp-p2" href="mypage.jsp?pageNum3=<%= i %>&#target4"><%=i%></a></li>
					  	 <% }else{%>
					    		 <li class="page-item"><a style="color:#fc5f4a" class="page-link" href="mypage.jsp?pageNum3=<%= i %>&#target4"><%=i%></a></li>
					    	   <% 		       
					 		}   
					 	}//for end
							if (endPage < pageCount) {  %>
						    <li class="page-item btn-depoon">
						      <a class="page-link btn-dp-p2" href="mypage.jsp?pageNum3=<%= currentPage3 + 5 %>&#target4" aria-label="Next">
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
<%}//로그인 상태 오류

  }catch(Exception e){}
	%>  
<jsp:include page="../frame/bottom.jsp" flush="false"/>   

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<!-- 원페이지 스크롤 -->
<script>
$(document).ready(function(){
        $(".scroll").click(function(event){            
                event.preventDefault();
                $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
        });
});
</script>
<script>
    $(document).ready(function(){
     	
    	var opt = 0;
		var user_id = $('#user_id').val();
		var check_length = $('.check_list').length;
		
		console.log(check_length);
		
		for(var i=0;i<check_length;i++){
			var check_list = $('.check_list').eq(i).val();
			if(check_list=='2'){
				$('.no_show').eq(i).show();	
				$('.waiting').eq(i).hide();
			}
		};  	
   	 // 대기 취소
		$(".wait_delete").click(function(){
			var index = $('.wait_delete').index(this);
			var store_id = $('.store_id2').eq(index).val();
			console.log(index);
			console.log(store_id);
			
			swal({
		     title: "대기취소",
		     text: "정말 취소 하시겠어요?",
		     icon: "info",
		     buttons: true,
		     dangerMode: true,
		   })
		   .then((willDelete) => {
		     if (willDelete) {
		    	//ajax 사용
				    $.ajax({
				        type : 'POST',
				        url : '../control/update_waitingcancel.jsp',
				        data:{
				         store_id : store_id,
				         user_id : user_id
				        },
				        cache: false,
				        dataType:"text",
				        success: function(){	        	
				        	swal("대기가 취소되었습니다", {
			          	         icon: "success",
			          	       })
			            	   .then((value) => {
			            		   location.reload(true);
		           	         });    
				      
				        }
			
				    }); // end ajax		
		     } else {
		       return false;
		     }
		   }); 
	
			
		});   	
    	
    	//즐겨찾기 부분
    	var opt = 0;
		var user_id = $('#user_id').val();

		$(".favorite_delete").click(function(){
			var index = $(".favorite_delete").index(this);
			var store_id =$(".store_id").eq(index).val();	
			console.log(index);
			console.log(store_id);
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
		        success: function(){	   
		        	 location.reload(true);   
		        location.href = "mypage.jsp?#target2";       
		      
		        }
	
		    }); // end ajax
		});
    	//접는부분
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
