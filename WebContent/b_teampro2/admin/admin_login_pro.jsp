<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
    String store_id = request.getParameter("store_id");
	String store_passwd  = request.getParameter("store_passwd"); 
	
	StoreinfoDBBean logon = StoreinfoDBBean.getInstance();
    int check= logon.userCheck(store_id,store_passwd);

	if(check==1){
		session.setAttribute("store_id",store_id);
		response.sendRedirect("store_condition.jsp");
	}else if(check==0){%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}else{ %>
	<script>
	  alert("아이디가 맞지 않습니다..");
	  history.go(-1);
	</script>
<%}%>