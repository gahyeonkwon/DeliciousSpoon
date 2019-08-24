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
    <link href="signin.css" rel="stylesheet">
  </head>

  <body class="text-center">
    <form class="form-signin" action="cookieLoginPro.jsp">
      <img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
    
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
	    	    <button class="btn btn-lg btn-primary btn-block" type="button"  onclick="location.href='insertMemberForm.jsp'">Join</button>
	    	</div> 
		</div>
     
     </div>
      
      <p class="mt-5 mb-3 text-muted">&copy; 2017-2018</p>
    </form>
    
        <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="/bban/assets/bootstrap-4.0.0//js/bootstrap.min.js"></script>
  </body>
</html>
