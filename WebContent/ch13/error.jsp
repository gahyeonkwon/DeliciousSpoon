<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    
<%String title="Error" ;%>
<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	


<!-- nav include -->

   <jsp:include page="top.jsp"  flush="false">
   	     <jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
       
<div class="alert alert-secondary mt-5 pt-5 pb-5" role="alert">
   <i class="fas fa-exclamation-circle"></i>
 <div class="pt-5">
 	 Error. Please Use the other pages.<br>
 	 If you have not logged in please login.
 </div>
</div>



<!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>



