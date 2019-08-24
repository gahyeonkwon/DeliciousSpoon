<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch13.board.BoardDBBean" %>
<%@ page import = "ch13.board.BoardDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "ch13.member.LogonDataBean" %>


<% 	
	String title="content";
	String id = (String)session.getAttribute("id");
	BoardDBBean logon = BoardDBBean.getInstance();
	LogonDataBean member = logon.searchData(id);

	
%>

<%

if(request.getParameter("num")==null || request.getParameter("pageNum")==null) {
  response.sendRedirect("error.jsp");
}else{ // content 조건 검사
	
		   int num = Integer.parseInt(request.getParameter("num"));
		   String pageNum = request.getParameter("pageNum");
			int currentPage = Integer.parseInt(pageNum);
			String userid = logon.searchId(id,num);
		   SimpleDateFormat sdf = 
		        new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try{
      BoardDBBean dbPro = BoardDBBean.getInstance(); 
      BoardDataBean article =  dbPro.getArticle(num); // 현재 글 content만 가져오므로 list 안써도됨
        
      int count = dbPro.getArticleCount(0,null);
      
	  int ref=article.getRef();
	  int re_step=article.getRe_step();
	  int re_level=article.getRe_level();
	

	  
%>
<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	


<!-- nav include -->
   <jsp:include page="top.jsp"  flush="false">
   	     <jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
       


<!--  content -->
	<div class="mt-5">
	 	<a role="button" href="list.jsp?pageNum=<%=pageNum%>" class="btn btn-dark">Back List</a>
	</div>
	 <div class="container pt-3">
	 	<div class="row">
	 		 	<div class="col mt-5 pt-4">
	 		 		<%
	 		 		//이전 페이지 오류  잡기
	 		 		String ad_left="";
	 		 		if(logon.selectBeforeAfter(num,1)!=0){
	 		 			ad_left="content.jsp?num="+logon.selectBeforeAfter(num,1)+"&pageNum="+pageNum;%>
	 		 			 <a href="<%=ad_left%>" id="right_left"><i class="fas fa-angle-left"></i></a>
	 		 		<%}%>		 	  
	 		 	</div>
				<div class="card col-6 <%if(article.getReadcount()>=5){out.print("border-warning bg-light text-dark");
				}else if(article.getRe_level()>=1){out.print("text-white bg-dark");
				}else{out.print("bg-light");}%> mb-3">
				  <div class="card-header"><%=article.getSubject()%></div>
				  <div class="card-body">
				    <h5 class="card-title"><%=article.getContent()%></h5>
				    <span class="badge badge-pill badge-light text-secondary"><%=sdf.format(article.getReg_date())%></span>
				  </div>
				  <div class="card-footer"><%=article.getWriter()%></div>
				</div>
	 		 	<div class="col mt-5 pt-4">
	 		 		<%
	 		 		//이후 페이지 오류  잡기
	 		 		String ad_right="";
	 		 		if(logon.selectBeforeAfter(num,-1)!=0){ //총 글갯수보다  하나 작을때부터 사라짐
	 		 			ad_right="content.jsp?num="+logon.selectBeforeAfter(num,-1)+"&pageNum="+pageNum;%>
	 		 			 <a href="<%=ad_right%>" id="right_left"><i class="fas fa-angle-right"></i></a>
	 		 		<%}%>	
	 		 	</div>			
		</div>		

		<div class="form-group">
			<%if(article.getCheck_m()==1&&id==null){//멤버가쓴글이고 로그인이 되어있지않을경우%>			
			<a role="button" href="#" class="btn btn-dark" data-toggle="modal" data-target="#simplewrite">Reply</a>			
			<%}else if(article.getCheck_m()==1&&member.getName().equals(article.getWriter())&&id!=null){//본인이쓴글을 봤을 경우%>
			<a role="button" href="#" class="btn btn-dark" data-toggle="modal" data-target="#simplewrite">Reply</a>			
			<a role="button" href="#" class="btn btn-dark" data-toggle="modal" data-target="#simpleupdate">Modify</a>	
			<a role="button" href="#"class="btn btn-dark" data-toggle="modal" data-target="#simpledelete">Delete</a>									
			<%}else if(article.getCheck_m()==1&&id!=null){//멤버가쓴글이지만 본인이아닐경우%>
			<a role="button" href="#" class="btn btn-dark" data-toggle="modal" data-target="#simplewrite">Reply</a>			
			<%}else if(article.getCheck_m()==0){//전체공개%>
			<a role="button" href="#" class="btn btn-dark" data-toggle="modal" data-target="#simplewrite">Reply</a>			
			<a role="button" href="#" class="btn btn-dark" data-toggle="modal" data-target="#simpleupdate">Modify</a>	
			<a role="button" href="#"class="btn btn-dark" data-toggle="modal" data-target="#simpledelete">Delete</a>										
 			<%} %>
		</div>
	 </div>	<!-- container end -->			
	  <!-- Modal_WRITE -->
					<div class="modal fade" id="simplewrite" tabindex="-1" role="dialog" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <form method="post" name="writeform" action="writePro.jsp?title=<%=title%>"> <!-- writepro --> 				      				    											
								<input type="hidden" name="num" value="<%=num%>">
								<input type="hidden" name="ref" value="<%=ref%>">
								<input type="hidden" name="re_step" value="<%=re_step%>">
								<input type="hidden" name="re_level" value="<%=re_level%>">		
					      <div class="modal-header">
					        <h5 class="modal-title">SimpleWrite</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      
					      <div class="modal-body">
								<div class="container">
									<%if(id==null||id==""){%>
									<div class="form-group row">												
										<label class="col-sm-2 col-form-label">Nick</label>
									 	 <div class="col-sm-4">
									      <input type="text" class="form-control" name="writer" required>
									     </div>
								    </div> 
									<div class="form-group row">												
										<label class="col-sm-2 col-form-label">Password</label>
									 	 <div class="col-sm-4">
									      <input type="password" class="form-control" name="passwd" required>
									     </div>
								    </div> 
													    
									<%}else{%>
											<input type="hidden" name="writer" value="<%=id%>">
											<input type="hidden" name="passwd" value="<%=member.getPasswd()%>">
											<input type="hidden" name="check_m" value="1">
									<%}%>
									
									<div class="form-group row">
								    	<label class="col-sm-2 col-form-label">Title</label>											
								    	<div class="col-sm-6">
								      	<input type="text" class="form-control" name="subject" required>
								    	</div>
								  	</div>  	
																				
								  	<div class="form-group row">
								    	<label class="col-sm-2 col-form-label">Content</label>
								    	<div class="col-sm-10">
								    		<textarea class="form-control" rows="3" name="content" required></textarea>
								    	</div>	
								    </div>								
								</div>														   
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					        <button type="submit" class="btn btn-primary">Save</button>	        
					      </div>
					      </form>					      						
					    </div>
					  </div>
					</div>
				 
	 <!-- modal end -->
	 
	 <!-- Modal_Update -->
		<div class="modal fade" id="simpleupdate" tabindex="-1" role="dialog" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <form method="post" name="updateform" action="updatePro.jsp?title=<%=title%>"> <!--updatepro -->
		      	   <input type="hidden" name="num" value="<%=article.getNum()%>">
		      	   <input type="hidden" name="pageNum" value="<%=pageNum%>">
		      <div class="modal-header">
		        <h5 class="modal-title">ModifyDocument</h5>
		        <button type="button" class="close" data-dismiss="modal">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>

		      <div class="modal-body">
		      				
									<div class="container">
												<%if(id!=null&&id.equals(userid)){%>										
														<input type="hidden" name="writer" value="<%=id%>">
														<input type="hidden" name="passwd" value="<%=member.getPasswd()%>">
													    <input type="hidden" name="check_m" value="1">							    
												<%}else{%>
												<div class="form-group row">												
													<label class="col-sm-2 col-form-label">Nick</label>
												 	 <div class="col-sm-4">
												      <input type="text" class="form-control" name="writer" value="<%=article.getWriter()%>" required>
												     </div>
											    </div> 
												<div class="form-group row">												
													<label class="col-sm-2 col-form-label">Password</label>
												 	 <div class="col-sm-4">
												      <input type="password" class="form-control" name="passwd" required>
												     </div>
											    </div>
										 																	    
												<%}%>
												
												<div class="form-group row">
											    	<label class="col-sm-2 col-form-label">Title</label>
											    	<div class="col-sm-6">
											      	<input type="text" class="form-control" name="subject" value="<%=article.getSubject()%>" required>
											    	</div>
											  	</div>  	
																							
											  	<div class="form-group row">
											    	<label class="col-sm-2 col-form-label">Content</label>
											    	<div class="col-sm-10">
											    		<textarea class="form-control" rows="3" name="content" required> <%=article.getContent()%></textarea>
											    	</div>	
											    </div>
												
											</div>
											
											   
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" class="btn btn-primary">Save changes</button>	        
		      </div>
		      </form>
		      						
		    </div>
		  </div>
		</div>

  <!-- modal _ DELETE -->
		<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="simpledelete">
		  <div class="modal-dialog modal-sm">
		    <div class="modal-content">
		    	<form action="deletePro.jsp?pageNum=<%=pageNum%>&title=<%=title%>" method="post">		
			    	<label class="col-form-label">Enter Passwd</label>	
				    <div class="form-group col-sm-8 offset-sm-2">			    	
		  				 <input type="hidden" name="num" value="<%=num%>">
				      	 <input type="password" class="form-control" name="passwd" required>
			    	</div>
				    <div class="form-group">
			        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
			        <button type="submit" class="btn btn-primary btn-sm">Delete</button>	        	
					</div>	
			  	</form>		     
		    </div>
		  </div>
		</div>	
			
	<%
	 }catch(Exception e){}} 
	 %>
     

<!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>


