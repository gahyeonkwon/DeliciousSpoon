<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>

<% request.setCharacterEncoding("utf-8");%>

<%
    String user_id = request.getParameter("user_id");
	String passwd  = request.getParameter("passwd"); 
	
	String store_id = request.getParameter("store_id");
	
	UserinfoDBBean logon = UserinfoDBBean.getInstance();
    int check= logon.userCheck(user_id,passwd);

	if(check==1){
		session.setAttribute("user_id",user_id);
		
		response.sendRedirect("tablet_waiting.jsp?store_id="+store_id);
		%>
			
		
<% 	}else if(check==0){%>
	<script> 
	  swal("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}else{ %>
	<script>
	  swal("아이디가 맞지 않습니다.");
	  history.go(-1);
	</script>
<%}%>