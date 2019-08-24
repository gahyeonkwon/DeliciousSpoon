<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

	<%
		request.setCharacterEncoding("utf-8");
		String title = "회원가입완료";
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

	 <jsp:useBean id="user_data" class="b_teampro2.userinfo.UserinfoDataBean">
	     <jsp:setProperty name="user_data" property="*"/>
	 </jsp:useBean>
 
<%
	UserinfoDBBean logon = UserinfoDBBean.getInstance();  
	logon.insertMember(user_data); 
 
 %>
 
 <%--위치 다시 --%>
 <br><br><br><br><br><br><br><br><br><br>
<img src="../../../img/logo_md.png">
<div class="container">
	<form method="post" class="form-horizontal" action="../design/main.jsp">
   		<p class="h3 pt-5 pb-3 mb-5">회원가입이 완료되었습니다.</p>
		<div class="form-group row justify-content-center">
	    	<div class="col-sm-4 col-sm-offset-3">
	        	<input type="submit" class="btn btn-dark btn-block" value="메인으로">
	       </div>   
		</div>
	</form>
</div>

<jsp:include page="../frame/bottom.jsp" flush="false"/>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
