<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<%request.setCharacterEncoding("utf-8");%>
<%
  String title="tablet_main";
  String store_id = "mrpizza76";
  session.invalidate();
  UserSystemDBBean system = UserSystemDBBean.getInstance();
%>

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
<input type="hidden" id="store_id" value="<%=store_id %>">
 <div class="back"  style="background-repeat: no-repeat;background-size: cover;">
 <img style="width: 270px; height: 270px;" class="" src="../../img/white.png">	
<div class="conatiner justify-content-center">   
  <div class="row center" style="height:300px;">
   	<p class="align-center text-center " style=" margin-left: 350px;font-size: 4.0rem; color:white; width: 600px;"><%=system.getStore_name(store_id) %></p>
     <p class="align-center text-center " style=" margin-left: 450px;font-size: 2.0rem; color:white; width: 400px;">현재 <%=system.getCurrent_team(store_id) %>팀 대기중!</p> 
      <div class="pt-5 mt-5" style="padding-left: 500px; padding-right: 500px; width:1523px;">    
      		        
             <div class=" text-center mb-3">
             <input type="button" id="tablet-join" class="btn btn-block join" style="height:70px; font-size:2.0rem" value="회원가입">    
             </div>
             <div class=" text-center mb-3">
             <input type="button" id="tablet-join" class="btn btn-block login" style="height:70px; font-size:2.0rem" value="로그인">    
             </div>
             </div>
       </div>
   </div>      
</div>

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQUERY -->
<script>

    var store_id = $('#store_id').val();
   $('.join').click(function(){
	   location.href = 'tablet_join.jsp?store_id='+store_id;
   });
   $('.login').click(function(){
	   location.href = 'tablet_login.jsp?store_id='+store_id;
   });
</script>