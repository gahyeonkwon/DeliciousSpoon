<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/bban/assets/bootstrap-4.0.0/css/bootstrap.min.css">

    <title>216210054 권가현 과제</title>
    <!-- Custom styles for this template -->
  </head>

  <body class="text-center">
  	<!--네비게이션 -->
  	
			  <nav class="navbar navbar-expand-lg navbar-light bg-light">
			 
			   
				 <a class="navbar-brand" href="#">
    			<img class="rounded-circle" src="/bban/img/practice.jpg" width="30" height="30" class="d-inline-block align-top" alt="">
      			GaHyeon</a>
			 
			  <div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto">
			      <li class="nav-item active">
			        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Link</a>
			      </li>
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Dropdown
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="#">Action</a>
			          <a class="dropdown-item" href="#">Another action</a>
			          <div class="dropdown-divider"></div>
			          <a class="dropdown-item" href="#">Something else here</a>
			        </div>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link disabled" href="#">Disabled</a>
			      </li>
			    </ul>
			    <form class="form-inline my-2 my-lg-0">
			      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
			      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			    </form>
			  </div>
			</nav>
			
	<!-- contents -->
	<div class="container mt-5">		
	     <form class="form-signin" action="sessionLoginPro.jsp">
	      <img class="mb-4 rounded-circle" src="/bban/img/practice.jpg" alt="sign" width="72" height="72">
	    
	      <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
	      
		<div class="container">
		
	  	<div class="form-group row">
	    	<label  class="col-sm-2 col-form-label">Id</label>
		 	<div class="col-sm-10">
	     	 	<input type="text" class="form-control" name="id" placeholder="Id" required>
	  	  	</div>
	 	 </div>
	  	<div class="form-group row">
	    	<label class="col-sm-2 col-form-label">Password</label>
		 	<div class="col-sm-10">
	     	 	<input type="password" class="form-control" name="passwd" placeholder="Password" required>
	  	  	</div>
	 	 </div>
	
	      <div class="checkbox mb-3">
	        <label>
	          <input type="checkbox" value="remember-me"> Remember me
	        </label>
	      </div>
	      
		 	<div class="row">
		  	 	<div class="col-md-4 offset-md-2">
		      		<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
		      	</div>	
		      	<div class="col-md-4">	
		    	    <button class="btn btn-lg btn-secondary btn-block" type="button"  onclick="location.href='insertMemberForm.jsp'">Join</button>
		    	</div> 
			</div>
	     
	     </div>
	      

	    </form>
	</div>
	<div class="container mt-5"> 
	   
	    <!-- other contents -->			    
		  <div class="card-columns">
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
			      <p class="mt-5 mb-3 text-muted">&copy; 2017-2018</p>
	</div>  
        <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="/bban/assets/bootstrap-4.0.0//js/bootstrap.min.js"></script>
  </body>
</html>
