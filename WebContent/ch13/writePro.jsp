<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch13.board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");
   String title = request.getParameter("title");
%>

<jsp:useBean id="article" class="ch13.board.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	article.setIp(request.getRemoteAddr());	
    BoardDBBean dbPro = BoardDBBean.getInstance();
    
    if(title.equals("diary")){
        dbPro.insertArticle2(article);        
        response.sendRedirect("diary.jsp");   	
    }else{    	
        dbPro.insertArticle(article);        
        response.sendRedirect("list.jsp");
    }
    	

%>

