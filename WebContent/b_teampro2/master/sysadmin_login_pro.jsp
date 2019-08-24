<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.System_DBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String master_id = request.getParameter("master_id");
	String master_passwd  = request.getParameter("master_passwd"); 
	
	System_DBBean logon = System_DBBean.getInstance();
    int check= logon.userCheck(master_id,master_passwd);

	if(check==1){
		session.setAttribute("master_id",master_id);
		response.sendRedirect("sysadmin_store.jsp");
	}else if(check==0){%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}else{ %>
	<script>
	  alert("아이디가 맞지 않습니다.");
	  history.go(-1);
	</script>
<%}%>