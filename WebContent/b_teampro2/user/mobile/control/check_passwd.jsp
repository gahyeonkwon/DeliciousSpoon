<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String user_id = (String)session.getAttribute("user_id");
	String passwd = request.getParameter("passwd");
%>

<%
	UserinfoDBBean logon = UserinfoDBBean.getInstance();
    int check = logon.selectPasswd(user_id,passwd);

    if(check==-1){
		//패스워드동일
			out.print("-1");
	
	}else{
			out.print("1");
	}
%>
   