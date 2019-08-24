<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>   


<% request.setCharacterEncoding("utf-8");%>

<%
	String store_id = request.getParameter("store_id");
	int open_close = Integer.parseInt(request.getParameter("open_close"));

	//매장 대기 가능여부 조절하는 함수 
	StoreinfoDBBean system = StoreinfoDBBean.getInstance();	
	 system.updateOpen_close(store_id,open_close);


%>