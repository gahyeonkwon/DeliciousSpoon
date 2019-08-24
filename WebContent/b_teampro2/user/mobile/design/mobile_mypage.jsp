<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean" %>
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>
<% request.setCharacterEncoding("utf-8");%>
<%String title="마이페이지";%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
<jsp:include page="../frame/top.jsp" flush="false"/>

<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserinfoDBBean logon = UserinfoDBBean.getInstance();  
	
	UserinfoDataBean user = null;
	user=logon.selectMember(user_id);

	if(user_id!=null||!user_id.equals("")){
%>
   
      <div class="container d-flex justify-content-center">
       <div class="row">
       	<div class=" mt-5">
	        <ul id="mypage"> 	    
				<div class="media">
				  <a class ="pull-left mr-1">
				  	<%if(user.getUser_photo().equals("profile.jpg")){ %>
						<img class="rounded-circle mb-3" src="../../../img/profile.jpg" name="user_photo" id="photo" style="width:100px; height:100px;">		 
			  		<%}else{ %> 
						<img class="rounded-circle mb-3" src="/bban/imageFile/<%=user.getUser_photo()%>" id="photo" style="width:100px; height:100px;"> 	
			  		<%} %>
				  	
 				  </a>
 				  <div class="media-heading mt-3 ml-4">
					 <span class="mb-2"><%=user.getUser_id()%></span>
					 <a class="btn btn-depoon btn-block mt-3" href="mobile_updatemember_ck.jsp" style="text-decoration: none; color:white;">개인정보수정</a> 
			      </div>
				</div>
	        </ul> 
        </div>
       </div>
         <table class="table mt-5 mb-5 margin_sy text-center">		  
		  <tbody>
		    <tr>
		      <th scope="row" onClick="location.href='mobile_waitinglist.jsp'" id="btn1"><img src="../../../img/restaurant.png" class="mb-1 mr-1" style="width: 20px; height: 20px;" />현재대기</th>		      
		    </tr>
		    <tr>
		      <th scope="row" onClick=" location.href='mobile_favorite.jsp'" id="btn1"><img src="../../../img/like_icon.png" class="mb-1 mr-1" style="width: 18px; height: 18px;" />즐겨찾기</th>		      
		    </tr>
		    <tr>
		      <th scope="row" onClick=" location.href='mobile_visit.jsp'" id="btn1"><img src="../../../img/food.png" class="mb-1 mr-1" style="width: 18px; height: 18px;" />방문한 곳</th>
		    </tr>
		    <tr>
		      <th scope="row" onClick=" location.href='mobile_myreview.jsp'" id="btn1"><img src="../../../img/consulting-message.png" class="mb-1 mr-1" style="width: 18px; height: 18px;" />내가 쓴 리뷰
		  </tbody>
		</table> 
      </div>
 </body>
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
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<%}else{
 response.sendRedirect("../control/login.jsp");}%>
<script>
$(document).ready(function() {	
	$("#user_photo").hide();

	//프로필 사진 변경 
	  $("#edit").on('click',function(){  
		 $("#user_photo").click();
	});//click end

});
</script>
<script>

var upload = document.getElementById('user_photo'),
    holder = document.getElementById('photo');

	upload.onchange = function (e) {
  e.preventDefault();

  var file = upload.files[0],
      reader = new FileReader();
  	reader.onload = function (event) {
    var img = new Image();
   img.src = event.target.result;
 
    holder.appendChild(img); 
 	var source = img.src;
    $('#photo').attr('src', source);    
  };
  reader.readAsDataURL(file);

  return false;
};
</script>