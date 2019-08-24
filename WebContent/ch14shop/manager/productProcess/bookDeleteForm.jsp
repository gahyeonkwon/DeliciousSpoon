<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<%
String title="bookDeleteForm";
String managerId ="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")){
       response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
       int book_id = Integer.parseInt(request.getParameter("book_id"));
       String book_kind = request.getParameter("book_kind");
%>


	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	

 <div class="row">
    <div class="col"><jsp:include page="../top.jsp" flush="false"/></div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../left.jsp" flush="false"/></div> 
    <div class="col-8 p-2 m-2">
		<!-- 삭제하기-->			
		<form method="POST" name="delForm"  
		   action="bookDeletePro.jsp?book_id=<%= book_id%>&book_kind=<%=book_kind%>" 
		   > 
		      <button type="submit" value="삭제" >  
		</form>			
    </div>   
  </div>
    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

    
<% 
   }
}catch(Exception e){
	e.printStackTrace();
}
%>
