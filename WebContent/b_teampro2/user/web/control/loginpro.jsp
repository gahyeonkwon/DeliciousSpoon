<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String user_id = request.getParameter("user_id");
	String passwd  = request.getParameter("passwd"); 
	
	UserinfoDBBean logon = UserinfoDBBean.getInstance();
    int check= logon.userCheck(user_id,passwd);

	if(check==1){
		session.setAttribute("user_id",user_id);
		out.print("-1");
		}else if(check==0){
			out.print("1");
			}%>