<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>  
<%@ page import="b_teampro2.userinfo.*" %>     
<%@ page import="java.util.*" %>
    
<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "카테고리";

		String user_id = (String)session.getAttribute("user_id");
		String cat = request.getParameter("category");
		int category = Integer.parseInt(cat);
		
		if(cat==null||cat==""){
			category = 5; //전체
		}		
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>
	 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<!-- 상단 메뉴 -->
	<jsp:include page="../frame/top.jsp" flush="false"/>	
<%   
//출력 데이터 함수
	UserSystemDBBean system = UserSystemDBBean.getInstance(); 
	//최신순
	List<StoreinfoDataBean> storeList = null;
	storeList = system.getStores(category,1,8);
	//가격순
	List<StoreinfoDataBean> storeList2 = null; 
	storeList2 = system.getStores(category,2,8);
	//조회순
	List<StoreinfoDataBean> storeList3 = null; 
	storeList3 = system.getStores(category,3,8);	

%>		
	<input type="hidden" value=<%=user_id%> id="user_id">	

<!-- main content -->
   <div id="myCarousel" class="carousel slide" data-ride="carousel">
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
      </div>
<!-- category -->      
<div class="container">
	<form action = "search_done.jsp">	
		<div class="row d-flex pb-5 justify-content-center">			
			<div class="col-md-8 ml-1 pr-3" style=" padding-left:27px;">
			    <input type="hidden" name="category" value="<%=category%>">  
				<input class="form-control" name="key" type="text" placeholder="찾고싶은 키워드를 입력해주세요">
			</div>		
			<div class="col-auto pl-2 mr-2">
				<button class="btn btn-small btn-depoon" type="submit"><i class="fas fa-search"></i></button>
			</div>		
		</div>
	</form>		
	<nav class="nav mb-2">
	  <a class="nav-link disabled lead style <%if(category==5){out.print("font-weight-bold");} %>" href="category.jsp?category=5" style=" color: black;">전체</a>
	  <a class="nav-link disabled lead <%if(category==0){out.print("font-weight-bold");} %>" href="category.jsp?category=0" style=" color: black;">한식</a>
	  <a class="nav-link disabled lead <%if(category==1){out.print("font-weight-bold");} %>"  href="category.jsp?category=1" style=" color: black;">일식</a>
	  <a class="nav-link disabled lead <%if(category==2){out.print("font-weight-bold");} %>" href="category.jsp?category=2" style=" color: black;">중식</a>
	  <a class="nav-link disabled lead <%if(category==3){out.print("font-weight-bold");} %>" href="category.jsp?category=3" style=" color: black;">양식</a>
	  <a class="nav-link disabled lead <%if(category==4){out.print("font-weight-bold");} %>" href="category.jsp?category=4" style=" color: black;">기타</a>
	</nav>	
	<div class="border-bottom mb-2"></div>	
	<div class="d-flex justify-content-start pt-3 pl-3">
		<p class="h3">최신순</p>
	</div>
	<div class="d-flex justify-content-start pt-2 pb-2 pl-3">				
	 <p class="mb-3">새로 등록된 매장이에요</p><br>
	</div>
	<div class="row pt-2 ml-1">	 
  <%  try{
	 //출력부분
		 if(storeList!=null){
			 for (int i = 0 ; i < storeList.size()-4 ; i++){
			       StoreinfoDataBean store = storeList.get(i);
			       if(i==0){%>
			      
	        <div class="col-md-2 mr-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>            
	                <div class="mt-2" style="width:14.7rem;">
	                   <div class="row pl-3" style="height:1.5rem;">
	                     <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                    </div>
	                    <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                    </div>
	                 </div>                  
	             </div>  		    	   
			       <%}else{%>
	       		 <div class="col-md-2 mr-5 ml-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>  	           
	               <div class="mt-2" style="width:14.7rem;">
	                  <div class="row pl-3" style="height:1.5rem;">
	                    <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p> 
	                   </div>
	                   <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                   </div>
	                </div>    
	       		 </div>
	         <%}}
			 
		 }%>  
     </div>     						
	<div class="row pt-4 ml-1">	 
  <% 
	 //출력부분
		 if(storeList!=null){
			 for (int i = 4 ; i < storeList.size() ; i++){
			       StoreinfoDataBean store = storeList.get(i);
			       if(i==4){%>
			      
	        <div class="col-md-2 mr-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>  	         
	                <div class="mt-2" style="width:14.7rem;">
	                   <div class="row pl-3" style="height:1.5rem;">
	                     <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                    </div>
	                    <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>   
	                    </div>
	                 </div>                  
	             </div>  		    	   
			       <%}else{%>
	       		 <div class="col-md-2 mr-5 ml-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>            
	               <div class="mt-2" style="width:14.7rem;">
	                  <div class="row pl-3" style="height:1.5rem;">
	                    <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                   </div>
	                   <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                   </div>
	                </div>    
	       		 </div>
	         <%}}
			 
		 }%>  
     </div>     						
	
	<div class="d-flex justify-content-start pt-5 pl-3">
		<p class="h3">가성비 최고!</p>
	</div>
	<div class="d-flex justify-content-start pt-2 pb-2 pl-3">				
		 <p class="mb-3">저렴한 가격에 고급 정찬 못지 않은 맛을 느껴보세요</p><br>
	</div>
	<div class="row pt-2 ml-1">
 <%  
	 //출력부분
		 if(storeList2!=null){
			 for (int i = 0 ; i < storeList2.size()-4 ; i++){
			       StoreinfoDataBean store = storeList2.get(i);
			       if(i==0){%>
			      
	        <div class="col-md-2 mr-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>            
	                <div class="mt-2" style="width:14.7rem;">
	                   <div class="row pl-3" style="height:1.5rem;">
	                     <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p> 
	                    </div>
	                    <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                    </div>
	                 </div>                  
	             </div>  		    	   
			       <%}else{%>
	       		 <div class="col-md-2 mr-5 ml-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>  	           
	               <div class="mt-2" style="width:14.7rem;">
	                  <div class="row pl-3" style="height:1.5rem;">
	                    <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                   </div>
	                   <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                   </div>
	                </div>    
	       		 </div>
	         <%}}
			 
		 }%>  
     </div>     						
	<div class="row pt-4 ml-1">	 
  <% 
	 //출력부분
		 if(storeList2!=null){
			 for (int i = 4 ; i < storeList2.size() ; i++){
			       StoreinfoDataBean store = storeList2.get(i);
			       if(i==4){%>
			      
	        <div class="col-md-2 mr-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>  	         
	                <div class="mt-2" style="width:14.7rem;">
	                   <div class="row pl-3" style="height:1.5rem;">
	                     <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                    </div>
	                    <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                    </div>
	                 </div>                  
	             </div>  		    	   
			       <%}else{%>
	       		 <div class="col-md-2 mr-5 ml-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>            
	               <div class="mt-2" style="width:14.7rem;">
	                  <div class="row pl-3" style="height:1.5rem;">
	                    <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                   </div>
	                   <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>  
	                   </div>
	                </div>    
	       		 </div>
	         <%}}
			 
		 }%>  
     </div>     						
 
  <div class="d-flex justify-content-start pt-5 pl-3">
		<p class="h3">이런 곳은 어떠세요?</p>
	</div>
	<div class="d-flex justify-content-start pt-2 pb-2 pl-3">				
		 <p class="mb-3">Delicious Spoon 이 자신있게 추천하는 곳이에요!</p><br>
	</div>
	<div class="row pt-2 ml-1">
 <%  
	 //출력부분
		 if(storeList3!=null){
			 for (int i = 0 ; i < storeList3.size()-4 ; i++){
			       StoreinfoDataBean store = storeList3.get(i);
			       if(i==0){%>
			      
	        <div class="col-md-2 mr-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>            
	                <div class="mt-2" style="width:14.7rem;">
	                   <div class="row pl-3" style="height:1.5rem;">
	                     <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                    </div>
	                    <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                    </div>
	                 </div>                  
	             </div>  		    	   
			       <%}else{%>
	       		 <div class="col-md-2 mr-5 ml-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>  	           
	               <div class="mt-2" style="width:14.7rem;">
	                  <div class="row pl-3" style="height:1.5rem;">
	                    <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>
	                     
	                   </div>
	                   <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                   </div>
	                </div>    
	       		 </div>
	         <%}}
			 
		 }%>  
     </div>     						
	<div class="row pt-4 ml-1">	 
  <% 
	 //출력부분
		 if(storeList3!=null){
			 for (int i = 4 ; i < storeList3.size() ; i++){
			       StoreinfoDataBean store = storeList3.get(i);
			       if(i==4){%>
			      
	        <div class="col-md-2 mr-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>  	         
	                <div class="mt-2" style="width:14.7rem;">
	                   <div class="row pl-3" style="height:1.5rem;">
	                     <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                    </div>
	                    <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                    </div>
	                 </div>                  
	             </div>  		    	   
			       <%}else{%>
	       		 <div class="col-md-2 mr-5 ml-5">
	       		 <input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	       		 <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">
	               <div class="photo_main">
		               <img style="width:14.7rem; height:10rem;" src="/bban/imageFile/<%=store.getMain_photo()%>">
		               <span class="photo_main_up">		               
		               <span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
	               	     	<div style="position: absolute;">
						        <span>		        	
						        	<span class="heart  w3-display-topleft pb-1" style="padding-right:30px;">
				               	     	<div style="position: absolute;">
									        <span>
										        <h3 class="pl-2 mt-1 pb-2" style="color:#fc5f4a;margin-top:0px;"><%=system.getCurrent_team(store.getStore_id()) %></p>
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
		               	  <a href="detailpage.jsp?store_id=<%=store.getStore_id()%>">
		            		<div class="area1 w3-display-left"></div>
		            		<div class="area2 w3-display-bottomleft"></div>
		            	 </a>		               	  
			            </span>			            	            
	            	</div>            
	               <div class="mt-2" style="width:14.7rem;">
	                  <div class="row pl-3" style="height:1.5rem;">
	                    <p class="title_main" style="margin-bottom:0px;"><%=store.getStore_name()%></p>  
	                   </div>
	                   <div class="row pl-3 mt-1" style="height:1.5rem;" >
	                     <p> <i class="fas fa-won-sign mr-1"></i><%=store.getAvg_price()%>원대</p>
	                     <p> <i class="fas fa-star ml-3 mr-1"></i><%=store.getAvg_mark()%></p>
	                     <p> <i class="fas fa-comment ml-3 mr-1"></i><%=system.getReviewCount(store.getStore_id())%></p>
	                   </div>
	                </div>    
	       		 </div>
	         <%}}
			 
		 }%>  
     </div>     												
</div><!-- container end -->
<!-- bottom -->
<%  }catch(Exception e){}
	%>  
<jsp:include page="../frame/bottom.jsp" flush="false"/>	

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- jquery -->		
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
		}
		var index = $(".linelike").index(this);
			//console.log(index); 인덱스 값 함수
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