<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<% request.setCharacterEncoding("utf-8");%>
<%String title="즐겨찾기";%>
<%
		String user_id = (String)session.getAttribute("user_id");
		List<UserFavoriteDataBean> favoriteList  =null; 
	    
	%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/>  
    
  <%
try{  
	if(user_id==null||user_id.equals("")){
		response.sendRedirect("../design/mobile_login.jsp");
	}else{ 	
	
		   UserSystemDBBean system = UserSystemDBBean.getInstance();
		    int count = system.getFavoriteCount(user_id);
		    favoriteList = system.getFavoriteMobile(user_id);
	%>  
	<input type="hidden" id="user_id" value=<%=user_id%>>
    <div class="container"><!-- 큰헤더 -->
         <div class="row padding_sy">
         	<p class="c_text margin_sy mt-2 pt-2">즐겨찾기</p>         	
		 </div>
		 <div class="container">	
			 <div class="countarea">
			 	<p class="title_my_gr w3-display-topright padding_sy" style="padding-top:58px;">총 <%=count%> 개</p>
			</div>
		 </div>		   
     </div>      
     <div class="container"><!-- 컨텐츠 시작 / 첫번째줄 -->
     <%if(favoriteList!=null){
    	 for(int i=0;i<favoriteList.size();i++){
    		 	UserFavoriteDataBean favorite = favoriteList.get(i);
    		 	
    		 if(i%2==0){
    			%> 

        <div class="c1_sy"><!-- 1-왼쪽 -->
        <input type="hidden" class="store_id" value="<%=favorite.getStore_id()%>">
            <div class="container">
                <div id="card_size1_sy">
                	<div class="photo_main_mobile">
	                    <img style="border-radius: 5px 5px 5px 5px;" id="favorite_img" src="/bban/imageFile/<%=favorite.getMain_photo()%>" alt="Card image">              
	                	<span class="photo_main_up_mobile">                    
	                       <span class="heart  w3-display-topright pb-1 pt-1" style="padding-right:22px;">
	                             <div style="position: absolute;">
			                          <span class="favorite_delete">
			                             <i class="fas fa-times" style="color:white; width: 17px; height: 17px;"></i>
			                          </span>
	                    		 </div>
	                       </span> 
	                       <a href="mobile_detail.jsp?store_id=<%=favorite.getStore_id()%>">
		                        <div class="img_area1 w3-display-topleft"></div>
		                        <div class="img_area2 w3-display-bottomleft">		                        	
		                        	<p class="title4 text-center mt-2" style="color:white;"><%=favorite.getStore_name()%></p>
		                        	<p class="detail_sy text-center mt-3" style="color:#fc5f4a;">리뷰평점 : <%=favorite.getAvg_mark()%> 점 </p>
		                        	<p class="detail_sy text-center" style="color:#fc5f4a;">선호도 : <%=system.getFavoriteCount2(favorite.getStore_id())%> 점</p>
		                        </div>
	                       </a>
	                  </span>
	                </div>
                </div>
            </div>
        </div>
          <% 	 }else{
    			 
    	%>  
        <div class="c2_sy"><!-- 2-오른쪽 -->
        <input type="hidden" class="store_id" value="<%=favorite.getStore_id()%>">
            <div class="container">
                <div id="card_size2_sy">
                	<div class="photo_main_mobile">
	                    <img style="border-radius: 5px 5px 5px 5px;" id="favorite_img" src="/bban/imageFile/<%=favorite.getMain_photo()%>" alt="Card image">              
	                	<span class="photo_main_up_mobile">                    
	                       <span class="heart  w3-display-topright pb-1 pt-1" style="padding-right:22px;">
	                             <div style="position: absolute;">
			                          <span class="favorite_delete">
			                             <i class="fas fa-times" style="color:white; width: 17px; height: 17px;"></i>
			                          </span>
	                    		 </div>
	                       </span> 
	                       <a href="mobile_detail.jsp?store_id=<%=favorite.getStore_id()%>">
		                        <div class="img_area1 w3-display-topleft"></div>
		                        <div class="img_area2 w3-display-bottomleft">		                        	
		                        	<p class="title4 text-center mt-2" style="color:white;"><%=favorite.getStore_name()%></p>
		                        	<p class="detail_sy text-center mt-3" style="color:#fc5f4a;">리뷰평점 : <%=favorite.getAvg_mark()%> 점</p>
		                        	<p class="detail_sy text-center" style="color:#fc5f4a;">선호도 : <%=system.getFavoriteCount2(favorite.getStore_id())%> 점</p>
		                        </div>
	                       </a>
	                  </span>
	                </div>
                </div>
            </div>
        </div>

       <%
				 }
  			 }
	 }else{//list null end %>
	 <p style="margin-left:17px;">즐겨찾기가 없습니다<p>
	 <%} %>
	     </div><!-- end -->
   <%}//로그인 상태 오류
	
  }catch(Exception e){}
	%>  	 
<%

   try{
	  user_id = (String)session.getAttribute("user_id");
%>    
    
    <footer class="fixed-bottom container-content-center mt-4" id="footer">	
   	   <div align="center">  
           <p class="pt-2">개인정보 보호 정책 | 이용약관 </p>
<%  	   
	if(user_id==null ||user_id.equals("")){
%>           
		<form>
           <a href="../design/mobile_login.jsp" class="pr-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">로그인</a>
           
           <a href="../design/mobile_join.jsp" class="pl-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">회원가입</a>
		</form>
<%             
}else{
%>		
		<form>           
           <a href="../control/logout.jsp" id="footer_btn" style="text-decoration:none; color: #2478FF;">로그아웃</a>
        </form>
<% 
}
%>  
           <p class="pb-2">&copy; 2017-2018 Company, Inc. &middot;</p>
      	</div> 
        <div class="fixed-bottom" style="margin-bottom: 50px; margin-right: 10px;">
        </div> 
       
   </footer>
   <br>
<% 
	  
    }catch(Exception e){
		e.printStackTrace();
	}
%> 
    <jsp:include page="/_template/footer.inc.jsp" flush="false" />
    <!-- JQEURY -->
    <script>
	$(".favorite_delete").click(function(){
		var user_id = $('#user_id').val();
		var index = $(".favorite_delete").index(this);
		var store_id =$(".store_id").eq(index).val();	
		var opt = 0;
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
	      
	        }

	    }); // end ajax
	});
    </script>
