<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch13.board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");
   String title=request.getParameter("title");
   int num = Integer.parseInt(request.getParameter("num"));
%>
   
<%
if(title.equals("content")){	
		  String pageNum = request.getParameter("pageNum");
		  String passwd = request.getParameter("passwd");
		  BoardDBBean dbPro = BoardDBBean.getInstance();
		
		  int check = dbPro.deleteArticle(num, passwd);
		
		  if(check==1){
			  response.sendRedirect("list.jsp");		
			}else{%>
			    <script type="text/javascript">      		           
			         alert("비밀번호가 맞지 않습니다");
			         history.go(-1);	      
			   </script>
			<%} 
	}else{
		
		  BoardDBBean dbPro = BoardDBBean.getInstance();		
			dbPro.deleteArticle(num);
			response.sendRedirect("diary.jsp");
		
	}%>