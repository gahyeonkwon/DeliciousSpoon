<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<% request.setCharacterEncoding("utf-8");%>

<%
String title="join";
%>

<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
	
<!-- nav include -->

   <jsp:include page="top.jsp"  flush="false">
   	     <jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
   	
	
<!-- content -->
	<div class="container mt-5">
		<form action="joinpro.jsp">
		  <div class="form-group row">
		    <label class="col-sm-2 col-form-label">Id</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="id" placeholder="Id" name="id" required>
		    </div>
		    <span id="idconfmsg"></span>
		  </div>
		  <div class="form-group row">
		    <label class="col-sm-2 col-form-label">Password</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="passwd" placeholder="Password" name="passwd" required>
		    </div> 
		  </div>
		  <div class="form-group row">
		    <label class="col-sm-2 col-form-label">Nickname</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="name" placeholder="Nicknamae" name="name" required>
		    </div>
		  </div>		  	  
		  <div class="form-group row">
		    <div class="col-sm-6 offset-sm-3">
		      <button type="submit" class="btn btn-warning btn-block">Join</button>
		    </div>
		  </div>
		</form>
	</div>
	


<!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>







