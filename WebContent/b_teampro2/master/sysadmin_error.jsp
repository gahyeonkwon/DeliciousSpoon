<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "¿¡·¯";
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>


<!-- nav include -->
   <jsp:include page="sysadmin_top.jsp"  flush="false">
   	     <jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
    <div class="col-10">   
	<div class="alert alert-secondary mt-5 pt-5 pb-5" role="alert">
	   <i class="fas fa-exclamation-circle"></i>
		 <div class="pt-5">
		 	 Error. Please Use the other pages.<br>
		 	 If you have not logged in please login
		</div>
		<div class="mt-3 row d-flex justfiy-content-center"> 	 
			<a class="btn btn-block" style="color:red;" href="sysadmin_login.jsp">Go to login</a> 
		</div> 	
	</div>
	</div>
	   	<jsp:include page="sysadmin_bottom.jsp"  flush="false"/>   	     
<!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>



