<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%-- <%@ page import="b_teampro2.storeinfo.StoreinfoDBBean" %> --%>
<%@ page import="b_teampro2.storeinfo.System_DBBean" %>

<% request.setCharacterEncoding("utf-8");%>

	<%
		request.setCharacterEncoding("utf-8");
		String title = "관리자회원가입완료";
	%>
	

 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>
	
	<jsp:useBean id="store" class="b_teampro2.storeinfo.System_DataBean">
		<jsp:setProperty name="store" property="*"/>
	</jsp:useBean>
 
	<%
	// !승인 전 temporary_table 로 들어가게 되는 함수
		System_DBBean logon = System_DBBean.getInstance();
		logon.insertMember(store);
	// 승인  되어야 아래 함수가 수행 됨		
	//	StoreinfoDBBean logon = StoreinfoDBBean.getInstance();  
	//	logon.insertMember(store); 
	 
	 %>	
<%--위치 다시 --%>
 <br><br><br><br><br><br><br><br><br><br>
<img src="../img/logo_md.png">
<div class="container">
	<form method="post" class="form-horizontal" action="admin_login.jsp">
   		<p class="h3 pt-5 pb-3 mb-5">회원가입이 완료되었습니다.</p>
		<div class="form-group row justify-content-center">
	    	<div class="col-sm-4 col-sm-offset-3">
	        	<input type="submit" class="btn btn-dark btn-block" value="메인으로">
	       </div>   
		</div>
	</form>
</div>

<jsp:include page="admin_bottom.jsp" flush="false"/>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>