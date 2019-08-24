<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%  request.setCharacterEncoding("utf-8");
	String title=request.getParameter("title");
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">


    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/bban/assets/bootstrap-4.1.3/css/bootstrap.min.css">   
	<!-- 메인사진 위에 올린 css 가져온거 -->
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="/bban/b_teampro2/css/custom.css">

	<title><%=title%></title>        
  </head>
<% if(!title.equals("store_condition")||!title.equals("검색 완료")){%>
	  <body class="text-center">
<%}%>
 

