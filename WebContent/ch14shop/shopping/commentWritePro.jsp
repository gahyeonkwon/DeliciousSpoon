<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>



<% request.setCharacterEncoding("utf-8");
%>
 
<jsp:useBean id="comment" scope="page" 
     class="ch14.bookshop.master.ShopBookDataBean">
      <jsp:setProperty name="comment" property="*"/>
</jsp:useBean>


		<% 
		 String book_id=request.getParameter("book_id");
		 String book_kind = request.getParameter("book_kind");
		ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();		
				bookProcess.insertComment(comment); 
			     response.sendRedirect("bookContent.jsp?book_id="+book_id+"&book_kind="+book_kind);
		%>