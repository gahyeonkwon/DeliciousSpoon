<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.userinfo.*"%>

<% request.setCharacterEncoding("utf-8");

%>

<% 	
	String store_id = request.getParameter("store_id");
    String user_id = request.getParameter("user_id");
  
    UserSystemDBBean system = UserSystemDBBean.getInstance();
    if(store_id!=null&&user_id!=null){
   		system.deletetWaiting(store_id,user_id);
    }else{
     response.sendRedirect("error.jsp");
    }
%>