<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>   


<% request.setCharacterEncoding("utf-8");%>


<%
	String store_id = request.getParameter("store_id");
	String user_id = request.getParameter("user_id");
	int opt = Integer.parseInt(request.getParameter("opt"));
	String people_num= request.getParameter("people_num");
    int number = Integer.parseInt(request.getParameter("number"));
	UserSystemDBBean system = UserSystemDBBean.getInstance();	
	
	//opt == 1 일경우 입장
	 //opt == 2 일경우 노쇼
	 system.updateWait_status(store_id,user_id,opt,number);

	if(people_num!=null){
	int p_n = Integer.parseInt(people_num);
		if(opt==1){ system.insertVisited(store_id,user_id,p_n);}
	}

   
%>