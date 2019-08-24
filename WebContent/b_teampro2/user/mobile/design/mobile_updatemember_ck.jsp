<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean" %>
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>

<%String title="회원정보확인";%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
<jsp:include page="../frame/top.jsp" flush="false"/> 
  
<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserinfoDBBean logon = UserinfoDBBean.getInstance();  
	
	UserinfoDataBean user = null;
	user=logon.selectMember(user_id);
	
%>  
 		
	      <div class="mt-5 mb-5" align="center">
	       <div class="form-group justify-content-center mt-5 mb-5 ml-10">        
		<div class="w3-display-middle-top">
			<a class ="pull-left">
			  <img class="rounded-circle mt-5 mb-5" src="/bban/imageFile/<%=user.getUser_photo()%>" id="photo" style="width:120px; height:120px;">  	
			</a>
		</div>     
	   </div>	 
	  </div>   	
	  <div class="container">	  
		   <div class="input-group input-group-lg mb-3">	   	
		     	<input id=id name="id" type="text" class="form-control margin_sy" placeholder="아이디" readonly="readonly" value="<%=user.getUser_id()%>" required>
		   </div>  
		   <div class="input-group input-group-lg">	  
		    	<input id=passwd name="passwd" type="password" class="form-control margin_sy" placeholder="비밀번호">

		   </div>  
	  </div>  
		
		 <div class="form-group row pt-2 justify-content-center">
       	 	<span id="passwdcheck" style="color:red;">비밀번호가 일치하지 않습니다. 다시 입력해주세요.</span>
       	 	<span id="passwdcheck2" style="color:green;">비밀번호가 일치합니다.정보수정이 가능합니다.</span>
          </div> 

	  <div class="container mt-5"> 
	      <div  id="mragin_gr">
		  		<button id="passwd_button" type="button" class="btn-lg btn-depoon btn btn-block">비밀번호 확인</button>
		  	    <button id="passwd_button2" type="button" class="btn-lg btn-depoon btn btn-block">개인정보 수정하기</button>
		  			
		  	</div>		  	
	  </div>
		


<jsp:include page="../frame/bottom.jsp" flush="false"/>   	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<script>
$(document).ready(function() {
	$("#passwdcheck").hide();	
	$("#passwdcheck2").hide();
	$("#passwd_button2").hide();
	
	$('#passwd_button').click(function(){
	// ajax 실행
	var passwd = $('#passwd').val();
	$.ajax({
	    type : 'POST',
	    url : '../control/check_passwd.jsp',
	    data: "passwd="+passwd,    
	    cache: false,
	    dataType:"text",
	    success : function(data) {
	        //console.log(data); 
	   		     			                 
	        if(data.match(/-1/)!=null){//true면  패스워드같음
	        location.href='mobile_updatemember.jsp';
	        }
	        else if(data.match(/1/)!=null){
	 		
	 			$("#passwdcheck").show();	//비밀번호가 일치 하지 않습니다. 비밀번호를 올바르게 입력해주세요	
	 			$("#passwdcheck2").hide();
	        }
	   
	    }
	}); // end ajax	 
	})// end click
	
	$('#passwd_button2').click(function(){
		// ajax 실행
			location.href="mobile.updatemember.jsp";
		})// end click
			
	
})// end document
</script>	