
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch13.board.BoardDBBean" %>
<%@ page import = "ch13.member.LogonDataBean" %>   

<%
request.setCharacterEncoding("utf-8");
String title = request.getParameter("title");
String id = (String)session.getAttribute("id");
BoardDBBean logon = BoardDBBean.getInstance();
LogonDataBean member = logon.searchData(id);
String pagetitle=null;
	//타이틀 검사
	if(title.equals("diary")){
		pagetitle="diary.jsp";
	}else{pagetitle="list.jsp";
	}

%>

<!--네비게이션 -->

			  <nav class="navbar navbar-expand-lg navbar-light bg-light">
  			   
				 <a class="navbar-brand" href="#" role="button" data-toggle="modal" data-target="#exampleModal">
    			<img class="rounded-circle" src="/bban/img/practice.jpg" width="30" height="30" class="d-inline-block align-top" alt="">
      			<%if(id==null ||id==""){out.print("Login");%></a>
      		
      			<!-- Modal_login-->
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				    <form action="sessionLoginPro.jsp" method="post">	
				      <div class="modal-header">
				        <h5 class="modal-title">Login</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">							     
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
				      </div>
				      <div class="modal-footer">
				        <button class="btn btn-dark" type="submit">login</button>
				        <a role="button" class="btn btn-warning" type="button" href="join.jsp">join</a>		
				      </div>
				     </form>  
				    </div>
				  </div>
				</div>
				
		  <!--end Modal-->				  			
      			<%}else{%><%=member.getName()%></a>    
      			
     	 <!-- Modal_logout -->
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">Do you want to log out?</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				       <form action="sessionLogout.jsp">
				      <div class="modal-footer">				     
				        <button type="submit" class="btn btn-secondary">I do</button>
				        <button type="button" class="btn btn-primary" data-dismiss="modal">No. I want to see more</button>				 
				      </div>
				      </form>
				    </div>
				  </div>
				</div>
				
		  <!--end Modal-->	
	<%}%>		 
			  <div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto">
			      <li class="nav-item">
			        <a class="nav-link" href="home.jsp">Home<span class="sr-only">(current)</span></a>
			      </li>
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          	Mypage
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		       		 <a class="dropdown-item <%if(id==null||id==""){out.print(" disabled");}%>" href="diary.jsp">Diary</a>
			       		<div class="dropdown-divider"></div>     
			          	<a class="dropdown-item" href="#">More</a>			        
			        </div>
			      </li>
   			      <li class="nav-item">		     
					 <a class="nav-link" href="list.jsp">List</a>	       
			      </li>			      
			    </ul>
			    

			    <form class="form-inline my-2 my-lg-0" action="<%=pagetitle%>">				    
			      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" name="condition">
			      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>			     
			    </form>
			    
			  </div>
			</nav>
  