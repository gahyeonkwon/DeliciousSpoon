<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String user_id = request.getParameter("user_id");
%>

<%=user_id%> 
<% 	
	UserinfoDBBean logon = UserinfoDBBean.getInstance();
    int check= logon.idCheck(user_id);

	if(check==-1){
		
			out.print("-1");
	
	}else{
		//가입가능	
		out.print("1");
	}
%>