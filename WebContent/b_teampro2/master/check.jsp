<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.System_DBBean" %>   
<%@ page import="b_teampro2.storeinfo.System_DataBean" %>  
<% request.setCharacterEncoding("utf-8");%>

<%
	String store_id = request.getParameter("store_id");
	String opt = request.getParameter("opt");
	
	 System_DBBean system = System_DBBean.getInstance();	
	 system.updateStatus(store_id,opt);
%>