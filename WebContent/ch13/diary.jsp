<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import = "ch13.member.LogonDataBean" %>    
<%@ page import = "ch13.board.BoardDBBean" %>   
<%@ page import = "ch13.board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Random" %>
<%!
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>



<%
	request.setCharacterEncoding("utf-8");
	String condition = request.getParameter("condition");//top.jsp에서 받아옴
    String title="diary";
	String id = (String)session.getAttribute("id");
%>

<%//LIST 기능 구현 코드 

	BoardDBBean logon = BoardDBBean.getInstance();
	 
    int count = 0;
    List<BoardDataBean> articleList = null;
    BoardDBBean dbPro = BoardDBBean.getInstance(); 
    

    if(condition==""||condition==null){  
		count = dbPro.getArticleCount(id,0,condition);        
	    if (count > 0){		    
	        articleList = dbPro.getArticles(id,0,condition);
	      }
	    if (count==0){dbPro.countRefresh();} // 게시글 없을경우 번호 초기화;
	 }else{  	
		count = dbPro.getArticleCount(id,1,condition);	    
    	if (count > 0){
    		articleList = dbPro.getArticles(id,1,condition);   		
	    	}  
    	}
%>

<%

   try{

	   if(id==null || id.equals(""))
           response.sendRedirect("error.jsp");
	   else{
%>


<!-- header  -->
	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	


<!-- nav include -->
    <jsp:include page="top.jsp"  flush="false">
   	     <jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
       

<!-- Modal_WRITE -->
<% 				
			  int num = 0;	
					  try{
					    if(request.getParameter("num")!=null){
						   num=Integer.parseInt(request.getParameter("num"));			   					   
					    }
			%>											
								
				<div class="modal fade" id="writediary" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <form method="post" name="writeform" action="writePro.jsp?title=<%=title%>"> <!-- writepro --> 	
								<input type="hidden" name="num" value="<%=num%>">	
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">SimpleWrite</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      
				      <div class="modal-body">   
								<div class="container">										    
											<input type="hidden" name="writer" value="<%=id%>">									
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
  			 <% }catch(Exception e){}%>
<!-- write modal end -->
<!-- content -->
		<div class="container mt-5 mb-5">		
				<div class="jumbotron" id="jumbotron">
				  <h1 class="display-3">The number of diaries : <%=count%></h1>
				  <p class="lead">Write down the memories you would like to have.</p>
				  <hr class="my-4">
		  	 		<div class="col-md-6 offset-md-3 pt-5">
			      		<button role="button" type="button" class="btn btn-lg btn-danger btn-block" data-toggle="modal" data-target="#writediary">Write for Today</button>
			      	</div>
			     </div> 						      		  		    
		</div> <!-- container class -->

<!-- DIARY LIST -->
<div class="container">

	  <div class="btn-group col align-self-end mt-2" role="group">
		    <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"  data-toggle="tooltip" data-placement="right" title="Use this button to adjust the screen output.">
		      <i class="fas fa-filter"></i>
		    </button>
		    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
		      <button type="button" class="dropdown-item" onclick="columCheck(1)">1</button>
		      <button type="button" class="dropdown-item" onclick="columCheck(2)">2</button>					      
		      <button type="button" class="dropdown-item" onclick="columCheck(3)">3</button>
		    </div>
 	 </div>
	<%if (count == 0) { 	
		
	%>
		
	<div class="alert alert-secondary mt-5 pt-5 pb-5" role="alert">
	   <i class="fas fa-exclamation-circle"></i>
	 <div class="pt-5">
	 	  Keep a New Diary!
	 </div>
	</div>
	
	<%}%>
	<div class="card-columns mt-5 pt-2">	
		<%    
	  if(articleList!=null){
		  int number=0;
		   for (int i = 0 ; i < articleList.size() ; i++) {
		       BoardDataBean article = articleList.get(i);
			%>

		  <div class="card text-center">
		    <form action="deletePro.jsp">
		 	<input type="hidden" name="num" value="<%=article.getNum()%>">
		 	<input type="hidden" name="title" value="<%=title%>">	
		    <button type="submit" class="close mr-2">
         	 <span aria-hidden="true">&times;</span>
       		</button>
       		</form>
		    <div class="card-body">
		      <h5 class="card-title"><%=article.getSubject()%></h5>
		      <p class="card-text"><%=article.getContent()%></p>
		      <p class="card-text"><small class="text-muted"><%= sdf.format(article.getReg_date())%> </small></p>
		    </div>
		  </div>		  
		
	<%} }%>
	</div>
</div>

<!-- footer -->
	<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

			
			
<%}}catch(Exception e){
		e.printStackTrace();
	}
%>


	   					
