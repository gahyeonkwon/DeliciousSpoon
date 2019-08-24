<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "ch13.member.LogonDataBean" %>    
<%@ page import = "ch13.board.BoardDBBean" %>
	<%
	BoardDBBean logon = BoardDBBean.getInstance();
	String id = (String)session.getAttribute("id");
	LogonDataBean member = logon.searchData(id);
	%>   
<%String title="home" ;%>

<!-- header  -->
	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	


<!-- nav include -->
    <jsp:include page="top.jsp"  flush="false">
   	     <jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
<%if(id==null || id==""){
	
%>
	<!-- content_회원아닌사람 -->

		<div class="container mt-5 mb-5">		
				<div class="jumbotron">
				  <h1 class="display-4">Diary for You</h1>
				  <p class="lead"></p>
				  <hr class="my-4">
				  <p>Press the button below if you would like to join us.</p>
		  	 		<div class="col-md-6 offset-md-3">
			      		<a role="button" type="button" href="join.jsp" class="btn btn-lg btn-warning btn-block">Join</a>
			      	</div>	
				</div>	   
	  	 	<div class="row justify-content-center">
		  	 	<i class="fas fa-quote-left"></i>  		  	
				<p class="lead pb-3">&nbsp;&nbsp;&nbsp; YOU CAN DO LIKE&nbsp; &nbsp;</p>
				<i class="fas fa-quote-right"></i>	    
			</div>
		  <div class="card-columns" id="example">
		  <div class="card">
		    <img class="card-img-top" src="/bban/img/trip.jpg" alt="Card image cap">
		    <div class="card-body">
		      <h5 class="card-title">Card title that wraps to a new line</h5>
		      <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
		    </div>
		  </div>
		  <div class="card p-3">
		    <blockquote class="blockquote mb-0 card-body">
		      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
		      <footer class="blockquote-footer">
		        <small class="text-muted">
		          Someone famous in <cite title="Source Title">Source Title</cite>
		        </small>
		      </footer>
		    </blockquote>
		  </div>
		  <div class="card">
		    <img class="card-img-top" src="/bban/img/cat3.jpg" alt="Card image cap">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
		  <div class="card bg-primary text-white text-center p-3">
		    <blockquote class="blockquote mb-0">
		      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat.</p>
		      <footer class="blockquote-footer">
		        <small>
		          Someone famous in <cite title="Source Title">Source Title</cite>
		        </small>
		      </footer>
		    </blockquote>
		  </div>
		  <div class="card text-center">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
		  <div class="card">
		    <img class="card-img" src="/bban/img/cat.jpg" alt="Card image">
		  </div>
		  <div class="card p-3 text-right">
		    <blockquote class="blockquote mb-0">
		      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
		      <footer class="blockquote-footer">
		        <small class="text-muted">
		          Someone famous in <cite title="Source Title">Source Title</cite>
		        </small>
		      </footer>
		    </blockquote>
		  </div>
		  <div class="card">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
		  <div class="card">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
		  <div class="card">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
		  <div class="card">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>		  		  		  
  		  <div class="card">
		    <img class="card-img" src="/bban/img/cat4.jpg" alt="Card image">
		  </div>
		</div>
			      <p class="mt-5 text-muted">&copy; 2017-2018</p>

	</div>

<%}else{ %>
<!-- content_회원인사람 -->
	<div class="container mt-5 mb-5">		
			<div class="jumbotron" id="jumbotron">
			  <h1 class="display-4">Hello, <%=member.getName()%> !</h1>
			  <p class="lead">How do you feel today? Keep a Diary</p>
			  <hr class="my-4">
			  <p>Just press the button below to complete my diary.</p>
				<div class="row">
			  	 	<div class="col-md-6 offset-md-3 pt-5">
			      		<a class="btn btn-lg btn-outline-dark btn-block" type="button" href="diary.jsp">Keep Diary</a>
			      	</div>
			    </div>  	
			</div>	   	    	    
			
	</div>
<% }%>  

<!-- footer -->
	<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

