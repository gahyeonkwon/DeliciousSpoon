<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<%
String title="tablet_login";
String store_id = request.getParameter("store_id");   
%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:include page="/_template/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>

  <style>
	.o_font_gr{
	   padding-top:35px;
	   font-size:10.0rem;
	}
	
	.back{
	    background-image: url("../../img/main_img5.jpg");
	    height: 775px;
	}
 
	#tablet-btn{
	   background-color: #FC5F4A;
	   border-color: #FC5F4A;
	   color:#FFFFFF;
	   font-size:4.0rem;	
	   height:30rem;	  
     }  
     #tablet-join{
       background-color: #FC5F4A;
       border-color: #FFFFFF;
	   color:#FFFFFF;
     } 
     
     #ck_gender{
     color:#FFFFFF;
     height:34px;
     }
     
     .row{
     height:600px;
     }
     
     body{
     padding-bottom:0;
     }
	     
 </style>
<body style="padding-bottm:0;">
 <div class="back"  style="background-repeat: no-repeat;background-size: cover;">
	<img style="width: 270px; height: 270px;" class="" src="../../img/white.png">
		<p class="text-center" style="font-size:2.0rem; margin-bottm:0; color:#ffffff">로그인</p>
			<form action="loginpro.jsp" method="post">
<div class="conatiner justify-content-center">   
  <div class="row center" style="height:300px;"> 
  
  	<input name="store_id" type="hidden" value="<%=store_id%>">
      <div class="pt-4" style="padding-left: 500px; padding-right: 500px; width:1523px;"> 
             <div class="text-center mb-3" > 
                    <input type="text" name="user_id" id="user_id" class="form-control pt-2 pb-2" placeholder="아이디" required>
             </div>
             <div class=" text-center mb-3" > 
                    <input type="password" name="passwd" id="passwd" class="form-control pt-2 pb-2" placeholder="비밀번호" required>
             </div> 
             <div class=" text-center mb-3">
             <input type="submit" id="tablet-join" class="btn btn-block pt-2 pb-2" value="대기신청">    
             </div>
       </div>
      
   </div>      
</div>
 </form>
</div>
</body>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>