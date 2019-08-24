<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "ch13.board.BoardDBBean" %>
<%@ page import = "ch13.board.BoardDataBean" %>
<%@ page import = "ch13.member.LogonDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

   


<%!
    int pageSize = 5;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
 
	String options = request.getParameter("options");
	 int optionsint=-1;
	if(options!=null){
		 optionsint = Integer.parseInt(options);
	}
	String title="list";
	String condition = request.getParameter("condition");//top.jsp에서 받아옴
	String pageNum = request.getParameter("pageNum");
	String id = (String)session.getAttribute("id"); 
	BoardDBBean logon = BoardDBBean.getInstance();
	LogonDataBean member = logon.searchData(id);	 

	String time = logon.checktime();
	
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number = 0;
    List<BoardDataBean> articleList = null;
    BoardDBBean dbPro = BoardDBBean.getInstance(); 
	//검색코드
    if(condition==""||condition==null){//검색값이 없으면
    		count = dbPro.getArticleCount(0,condition);//일반 값 가져오기
		    if (count > 0){		    
		        articleList = dbPro.getArticles(startRow, pageSize,0,condition);//검색없이 select
		      }
		    if (count==0){dbPro.countRefresh();} // 게시글 없을경우 번호 초기화;
   	 }else{ //사용자가 검색을 이용했을경우 실행되는 문장
   	 		//top에서검색했을경우
   	 		count = dbPro.getArticleCount(1,condition);	    
	    	if (count > 0){
	    		articleList = dbPro.getArticles(startRow,pageSize,1,condition);   		
		    	} 	  
	    	
	    	if(optionsint>1){
				count = dbPro.getArticleCount(optionsint,condition);	    
		    	if (count > 0){
		    		articleList = dbPro.getArticles(startRow,pageSize,optionsint,condition);   		
			    	} 		    		
	    	}
				
   	 }	
   		 		  
    
	number = count-(currentPage-1)*pageSize;
%>

<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	

<!-- nav include -->

   <jsp:include page="top.jsp"  flush="false">
   	     <jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
	
  <!--  list main content start --> 
  
	<div class="card mb-3">
	  <img class="card-img-top" src="../img/title5.jpg" alt="Card image cap">
	  <div class="card-body">
	  	 	<div class="row justify-content-center mt-3">
		  	 	<i class="fas fa-quote-left"></i>  		  	
 				<h5 class="card-title">&nbsp;&nbsp;&nbsp;OPEN BOARD&nbsp; &nbsp;</h5>
				<i class="fas fa-quote-right"></i>	    
			</div>
	    <p class="card-text">This is an open board. Share your questions and comments</p>
	    <p class="card-text"><small class="text-muted">Last updated <%=time%> mins ago</small></p>
	  </div>
		<form action="list.jsp?<%=options%>&<%=condition%>"><!-- 검색옵션 -->	
	  	<div class="mt-5 pb-5 row justify-content-center">		
				<div class="mr-sm-2">
				      <select name="options" class="form-control">
				        <option value="2"<%if(optionsint==2){out.print(" selected");}%>>Writer</option>
				        <option value="3"<%if(optionsint==3){out.print(" selected");}%>>Subject</option>
				        <option value="4"<%if(optionsint==4){out.print(" selected");}%>>Content</option>			        
				      </select>	
			    </div> 		 
			    <div class="col-md-4">
			    <input class="form-control" type="text" placeholder="search" name="condition" required> 
			    </div>      
				<div> 	
					<button type="submit" class="btn btn-outline-success">
					  <i class="fas fa-search"></i>
					</button>  
				</div>
		
			<div class="pl-2"> 				<!-- Modal_Trigger -->				  
				<button type="button" id="write" class="btn btn-outline-dark" data-toggle="modal" data-target="#simplewrite">
				<i class="fas fa-pencil-alt"></i>
				</button>
			</div>				
		</div>
		</form> <!--  검색옵션 end -->	
	</div>

	<!-- modal write -->
		<div class="modal fade" id="simplewrite" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <form method="post" name="writeform" action="writePro.jsp?title=<%=title%>"> <!-- writepro --> 		
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">SimpleWrite</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      
		      <div class="modal-body">
		        
				<% 
				
				  int num = 0, ref = 1, re_step = 0, re_level = 0;
			
				  try{
				    if(request.getParameter("num")!=null){
					   num=Integer.parseInt(request.getParameter("num"));			   
					   ref=Integer.parseInt(request.getParameter("ref"));
					   re_step=Integer.parseInt(request.getParameter("re_step"));
					   re_level=Integer.parseInt(request.getParameter("re_level"));
					   
					   
				    }
				%>											
									<input type="hidden" name="num" value="<%=num%>">
									<input type="hidden" name="ref" value="<%=ref%>">
									<input type="hidden" name="re_step" value="<%=re_step%>">
									<input type="hidden" name="re_level" value="<%=re_level%>">
									

									<div class="container">
										<%if(id==null||id==""){%>
										<div class="form-group row">												
											<label class="col-sm-2 col-form-label">Nick</label>
										 	 <div class="col-sm-4">
										      <input type="text" class="form-control" name="writer">
										     </div>
									    </div> 
										<div class="form-group row">												
											<label class="col-sm-2 col-form-label">Password</label>
										 	 <div class="col-sm-4">
										      <input type="password" class="form-control" name="passwd">
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
									      	<input type="text" class="form-control" name="subject" style="ime-mode:inactive;" required>
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
		      							  <%
											  }catch(Exception e){}
											%>  
		    </div>
		  </div>
		</div>
<!-- write modal end -->
<!-- table content -->

<%

if (count == 0) { 

%>
	
<div class="alert alert-danger mt-5 pt-5 pb-5" role="alert">
   <i class="fas fa-exclamation-circle"></i>
 <div class="pt-5">
 	 There are no saved posts on the board.
 </div>
</div>

<% 

} else {

%>
	
<div class="container mt-5">

			<table class="table table-hover">
			  <caption>글목록(전체 글:<%=count%>)	
				</caption>
			  <thead>
			    <tr>
			      <th scope="col">번호</th>
			      <th scope="col">제 목</th>
			      <th scope="col">작성자</th>
			      <th scope="col">작성일</th>
			      <th scope="col">조 회</th>
			      <th scope="col">IP</th>
			    </tr>
			  </thead>
			  <tbody>
			  
			  <%  
			  
			  if(articleList!=null){
	
			   for (int i = 0 ; i < articleList.size() ; i++) {
			       BoardDataBean article = articleList.get(i);
			%>
			
			    <tr>
			      <th scope="row"><%=number--%></th>
			
			<%
				int wid=0; 
				if(article.getRe_level()>0){
					   wid=10*(article.getRe_level()); //이미지를 이용해서 하는것보다 마진이나 패딩으로 주면좋음
					   %>
				<td> <!-- text-indent: ~꼴도 괜찮음 -->	  					
	  					<div style="padding-left:<%=wid%>px">
	  					<i class="fab fa-replyd"></i>
	  					
			<%  }else{%>
				<div>
				<td style="padding-left:<%=wid%>px">
				
			<%  }%>
		
			    <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
			           <%=article.getSubject()%></a> </div>
			           
			<% if(article.getReadcount()>=5){%>
			     <i class="fas fa-fire"></i> <%}%></td>
			    <td><%=article.getWriter()%></td>        
			    <td><%= sdf.format(article.getReg_date())%></td>
			    <td><%=article.getReadcount()%></td>
			    <td><%=article.getIp()%></td>
			  </tr>
			<%}
			  }else{
				  response.sendRedirect("error.jsp");
			  } //if end 
			%>
			
				 </tbody>
			</table>
			<%}%>
</div> 	


			<!--  pagination -->
			
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			<%
			    if (count > 0) {
			        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage =1;
					
					if(currentPage % 10 != 0)
			           startPage = (int)(currentPage/10)*10 + 1;
					else
			           startPage = ((int)(currentPage/10)-1)*10 + 1;
						

					int pageBlock = 10;
			        int endPage = startPage + pageBlock - 1;
			        if (endPage > pageCount) endPage = pageCount;

			        
			        if (startPage > 5) { %>
			            <li class="page-item">
					         <a class="page-link" href="list.jsp?pageNum=<%= startPage - 5 %>" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						        <span class="sr-only">Previous</span>
					     	 </a>
			    		</li>		     	 
			        
			<%      }
			        
			        for (int i = startPage ; i <= endPage ; i++) {  
			        	if(currentPage==i){
			        %> <li class="page-item active"><span class="page-link"><%= i %><span class="sr-only">(current)</span></span></li>
			        <% }else{%>
			        	<%if(condition!=null) {%>
			            <li class="page-item"><a class="page-link" href="list.jsp?pageNum=<%= i %>&options=<%=options%>&condition=<%=condition%>"><%= i %></a></li>
			      <%}else{ %>
			      			            <li class="page-item"><a class="page-link" href="list.jsp?pageNum=<%= i %>"><%= i %></a></li>
			      <%} %> 			       
			<%}     
			}
			        
			        if (endPage < pageCount) {  %>
			            <li class="page-item">
						      <a class="page-link" href="list.jsp?pageNum=<%= startPage + 5 %>" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						        <span class="sr-only">Next</span>
						      </a>
						</li>      
			
			    
			<%
			        }
			    }
			%>
							
			  </ul>
			</nav>
			
			

		
<!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>









