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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>216210054 권가현 과제</title>


    <!-- Custom styles for this template -->
    <link href="signin.css" rel="stylesheet">
  </head>

  <body class="text-center">
    <form method="post" action="insertMemberPro.jsp">
      <img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
    
      <h1 class="h3 mb-3 font-weight-normal">Check in</h1>
      

  	<div class="form-group row">
    	<label  class="col-sm-2 col-form-label">Id</label>
	 	<div class="col-sm-8">
     	 	<input type="text" class="form-control" placeholder="Id" name="id" required>
  	  	</div>
 	 </div>
  	<div class="form-group row">
    	<label class="col-sm-2 col-form-label">Password</label>
	 	<div class="col-sm-8">
     	 	<input type="password" class="form-control" placeholder="Password" name="passwd" required>
  	  	</div>
 	 </div>
  	<div class="form-group row">
    	<label class="col-sm-2 col-form-label">Name</label>
	 	<div class="col-sm-8">
     	 	<input type="text" class="form-control" placeholder="Name" name="name" required>
  	  	</div>
 	 </div>

	  	<div class="col-md-6 offset-md-3">	      
	      <button class="btn btn-lg btn-primary btn-block" type="submit">Join</button>
	    </div>	     	
      	<input type="reset" value="Reset" class="btn btn-lg btn-secondary">
      
      <p class="mt-5 mb-3 text-muted">&copy; 2017-2018</p>
    </form>
    
        <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  </body>
</html>
