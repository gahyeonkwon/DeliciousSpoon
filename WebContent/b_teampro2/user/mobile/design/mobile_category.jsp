<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   

<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.text.*" %>
<%

String title="카테고리";
String user_id = (String)session.getAttribute("user_id");
String cat = request.getParameter("category");
int category = Integer.parseInt(cat);
if(cat==null||cat==""){
	category = 5; //전체
}

UserSystemDBBean system = UserSystemDBBean.getInstance(); 


//최근 등록순
List<StoreinfoDataBean> storeList = null;
storeList = system.getStoresMobile(category,1);
//가격순
List<StoreinfoDataBean> storeList2 = null; 
storeList2 = system.getStoresMobile(category,2);

//랜덤순
List<StoreinfoDataBean> storeList4 = null; 
storeList4 = system.getStoresMobile(category,4);		

%>
<style>
a:hover {
  color: #ffffff;
  text-decoration: none;
}
</style>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/>       	   
  
  <input type="hidden" value=<%=user_id%> id="user_id">	    
        	<div class="container border-bottom pb-2 mt-1" style="font-weight: bold;">
        		<div class="s1" onClick = " location.href='mobile_category.jsp?category=0'">	
        			<p class="text-center mt-3">한식</p>
        			<%if(category==0){ %>
        			<div class="table_area1"></div>
       				<%} %>
        		</div>
        		<div class="s2" onClick = " location.href='mobile_category.jsp?category=1'">
        			<p class="text-center mt-3">일식</p>
               	   <%if(category==1){ %>
        			<div class="table_area1"></div>
       				<%} %> 			
        		</div>
        		<div class="s3" onClick = " location.href='mobile_category.jsp?category=2'">
        			<p class="text-center mt-3">중식</p>
        	       <%if(category==2){ %>
        			<div class="table_area1"></div>
       				<%} %>
        		</div>
        		<div class="s4" onClick = " location.href='mobile_category.jsp?category=3'">
        			<p class="text-center mt-3">양식</p>
        		    <%if(category==3){ %>
        			<div class="table_area1"></div>
       				<%} %>
        		</div>
        		<div class="s5" onClick = " location.href='mobile_category.jsp?category=4'">
        			<p class="text-center mt-3">기타</p>
		        	<%if(category==4){ %>
        			<div class="table_area1"></div>
       				<%} %>
        		</div>
        		
        	</div>

		    	  	
			<p class="c_text margin_sy mt-5">새로운 맛을 경험해보세요!</p>         
       		<p class="detail_sy margin_sy mb-3">새로 등록된 매장이에요</p>
       		<div class="border-bottom margin_sy" style="width:90%"></div>	   	    	      		
	        <ul id="gallery">
 <%  try{
		 //출력부분
		 if(storeList!=null){
			 for (int i = 0 ; i < storeList.size() ; i++){
			       StoreinfoDataBean store = storeList.get(i);
			       	String names = storeList.get(i).getMenu_names();
					String name [] = names.split(",");   %> 
			<input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	    	<input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	           			        
				<li class="mt-1">
                 <div class="photo_main_mobile2 padding_sy"> 
                        <div class="row padding_sy">           
                         <span class="thumb_sy2" style="padding-top:8px; padding-bottom: 8px;"><img src="/bban/imageFile/<%=store.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span>
                    <div class="text padding_sy ul_new" style="width:200px;">
                     <span class="title"><%=store.getStore_name()%></span>
                     <span class="desc"><%for(int j=0;j<name.length;j++){out.print(name[j]+" ");}%></span>
                     <span class="desc2"><i class="far fa-heart mr-1"></i><%=system.getFavoriteCount2(store.getStore_id())%>
                     <i class="far fa-comment mr-1 ml-3"></i><%=system.getReviewCount(store.getStore_id())%>                     
                  </div>
                  </div>
                  <div class="photo_main_up_mobile2 padding_sy">
                     <span class="heart  w3-display-topright pb-1 mt-2 mr-3" style="padding-right:30px;">
                    <!-- 이부분 하트좀 구제해주세여 -->
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
                            <i class=" wait_sy fas fa-user mr-1 ml-3"></i><%=system.getCurrent_team(store.getStore_id())%>                
                   </span>
                  <a href="mobile_detail.jsp?store_id=<%=store.getStore_id()%>" >
                     <div class="img_area4 w3-display-bottomleft padding_sy"></div>
                        <div class="img_area3 w3-display-topleft padding_sy"></div>                        
                     </a> 
                  </div>                  
               </div>       

            </li>

				<div class="border-bottom margin_sy" style="width:90%"></div> 
				  <%}}%>  
		
				<p class="c_text margin_sy mt-5">가성비 최고!</p>         
       			<p class="detail_sy margin_sy mb-3">저렴한 가격에 고급 정찬 못지 않은 맛을 느껴보세요.</p>
       			<div class="border-bottom margin_sy" style="width:90%"></div>
				
		<% 	 if(storeList2!=null){
			 for (int i = 0 ; i < storeList2.size() ; i++){
			       StoreinfoDataBean store = storeList2.get(i);
			       	String names = storeList2.get(i).getMenu_names();
					String name [] = names.split(",");   %>		
				<input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	    		<input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	           			
				<li class="mt-1">
                 <div class="photo_main_mobile2 padding_sy"> 
                        <div class="row padding_sy">           
                         <span class="thumb_sy2" style="padding-top:8px; padding-bottom: 8px;"><img src="/bban/imageFile/<%=store.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span>
                    <div class="text padding_sy ul_new" style="width:200px;">
                     <span class="title"><%=store.getStore_name()%></span>
                     <span class="desc"><%for(int j=0;j<name.length;j++){out.print(name[j]+" ");}%></span>
                     <span class="desc2"><i class="far fa-heart mr-1"></i><%=system.getFavoriteCount2(store.getStore_id())%>
                     <i class="far fa-comment mr-1 ml-3"></i><%=system.getReviewCount(store.getStore_id())%>                     
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
                            <i class=" wait_sy fas fa-user mr-1 ml-3"></i><%=system.getCurrent_team(store.getStore_id())%>                
                   </span>
                  <a href="mobile_detail.jsp?store_id=<%=store.getStore_id()%>" >
                     <div class="img_area4 w3-display-bottomleft padding_sy"></div>
                        <div class="img_area3 w3-display-topleft padding_sy"></div>                        
                     </a> 
                  </div>                  
               </div>       

            </li>

				<div class="border-bottom margin_sy" style="width:90%"></div> 
				  <%}}%>  

				<p class="c_text margin_sy mt-5">이런 곳은 어떠세요?</p>         
       			<p class="detail_sy margin_sy mb-3">분위기 좋은 곳에서 멋진 시간을 보내보세요</p>
       			<div class="border-bottom margin_sy" style="width:90%"></div>
		<%  if(storeList4!=null){
			 for (int i = 0 ; i < storeList4.size() ; i++){
			       StoreinfoDataBean store = storeList4.get(i);
			       	String names = storeList4.get(i).getMenu_names();
					String name [] = names.split(",");   %>    				
				<input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	    		<input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	        
	        
				<li class="mt-1">
                 <div class="photo_main_mobile2 padding_sy"> 
                        <div class="row padding_sy">           
                         <span class="thumb_sy2" style="padding-top:8px; padding-bottom: 8px;"><img src="/bban/imageFile/<%=store.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span>
                    <div class="text padding_sy ul_new" style="width:200px;">
                     <span class="title"><%=store.getStore_name()%></span>
                     <span class="desc"><%for(int j=0;j<name.length;j++){out.print(name[j]+" ");}%></span>
                     <span class="desc2"><i class="far fa-heart mr-1"></i><%=system.getFavoriteCount2(store.getStore_id())%>
                     <i class="far fa-comment mr-1 ml-3"></i><%=system.getReviewCount(store.getStore_id())%>                     
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
                            <i class=" wait_sy fas fa-user mr-1 ml-3"></i><%=system.getCurrent_team(store.getStore_id())%>                
                   </span>
                  <a href="mobile_detail.jsp?store_id=<%=store.getStore_id()%>" >
                     <div class="img_area4 w3-display-bottomleft padding_sy"></div>
                        <div class="img_area3 w3-display-topleft padding_sy"></div>                        
                     </a> 
                  </div>                  
               </div>       

            </li>

				<div class="border-bottom margin_sy" style="width:90%"></div> 
				 <%}}%> 
				

				<a href="mobile_search.jsp" style="text-decoration:none;hover-color:#ffffff">
					<p class="c_text text-center mt-5" >원하시는 정보를 찾지 못하셨나요?<i class="far fa-frown-open ml-1" style="color: #DE3131;"></i></p>
			  	</a>
			  </ul>
			 </div> 	
	<%}catch(Exception e){} %>		 
<jsp:include page="../frame/bottom.jsp" flush="false"/>   			  
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQUERY -->
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
	