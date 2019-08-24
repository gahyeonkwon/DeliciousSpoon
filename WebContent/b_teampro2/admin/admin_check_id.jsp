<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String store_id = request.getParameter("store_id");
%>

<%=store_id%> 
<% 	
	StoreinfoDBBean logon = StoreinfoDBBean.getInstance();
    int check= logon.store_idCheck(store_id);

	if(check==-1){
		
			out.print("-1");
	
	}else{
		//가입가능	
		out.print("1");
	}
%>