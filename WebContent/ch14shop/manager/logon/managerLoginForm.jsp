<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String title = "managerLoginForm"; //title %>

<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	

		
		<div class="card bg-dark text-white">
		  <img class="card-img" src="../../../img/title4.jpg" alt="Card image">
		  <div class="card-img-overlay">
			<nav class="navbar fixed-top justify-content-end">
		 	<ul class="nav">
			  <li class="nav-item">
			    <a class="nav-link active" href="/bban/ch14shop/shopping/shopMain.jsp">홈페이지가기</a>
			  </li>
			</ul>		  	
			</nav>	
			  <div class="container">		
			    <h5 class="card-title">Manager Login</h5>
				<form class="form-inline justify-content-center" method="post" action="managerLoginPro.jsp">		
				  <div class="form-group mb-2">
				    <label for="staticEmail2" class="sr-only">Id</label>
				    <input type="text" class="form-control" name="id" placeholder="id" required>
				  </div>
				  <div class="form-group mx-sm-3 mb-2">
				    <label for="inputPassword2" class="sr-only">Password</label>
				    <input type="password" class="form-control" name="passwd" placeholder="Password" required>
				  </div>
				  <button type="submit" class="btn btn-primary mb-2">Login</button>
				</form>    
				</div>
			
		  </div>
		</div>


    
    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

    