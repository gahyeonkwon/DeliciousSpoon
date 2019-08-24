<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%

	 String title="bookContent";
	 String book_kind = request.getParameter("book_kind");
	 int book_id = Integer.parseInt(request.getParameter("book_id"));
	 String m_id=(String)session.getAttribute("id");
     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	 String id = "";
	 int buy_price=0;
	 try{
	   if(session.getAttribute("id")==null)
	     id="not";
	   else
	     id= (String)session.getAttribute("id");    
	}catch(Exception e){}

%>

<!-- header  -->
	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
  <div class="row">
    <div class="col"><jsp:include page="../module/top.jsp" flush="false" /> </div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../module/left.jsp" flush="false" /> </div> 
 
 <!-- Modal_WRITE -->							
				<div class="modal fade" id="write" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <form method="post" name="writeform" action="commentWritePro.jsp"> <!-- commentWritePro  --> 	
				      <input type="hidden" name="book_id" value="<%=book_id%>">
				      <input type="hidden" name="book_kind" value="<%=book_kind%>">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">한줄평 작성하기</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>				      
				      <div class="modal-body">   
								<div class="container">										    								
									<div class="row">
								    	<label class="col-sm-4 col-form-label">작성자</label>
								    	<div class="col-sm-4">
								      	<input type="text" class="form-control" name="writer" required readonly value="<%=m_id%>">
								    	</div>
								  	</div>  																			
								  	<div class="row pt-2">
								    	<label class="col-sm-4 col-form-label">한줄평</label>
								    	<div class="col-sm-8 pl-2">
								    		<textarea class="form-control" rows="3" name="content" required></textarea>
								    	</div>	
								    </div>		
								    
								    <div class="row justify-content-center pt-3">
				    			        <div class="starRev">
										  <span class="starR" id="1">1</span>
										  <span class="starR" id="2">2</span>
										  <span class="starR" id="3">3</span>
										  <span class="starR" id="4">4</span>
										  <span class="starR" id="5">5</span>
										  <input type="hidden" name="star" id="stari">
										 </div>
								    </div>								
								</div>									   
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">다음에 남길래요!</button>
				        <button type="submit" class="btn btn-warning btn-sm" id="gowrite">한 줄평 남기기</button>	        
				      </div>
				      </form>		
				    </div>
				  </div>
				</div>

<!-- write modal end -->   
    <!-- bookContent -->
     		      
    <div class="col-8 p-5">
			<%
			ShopBookDataBean bookList = null;
			String book_kindName="";
			List<ShopBookDataBean> commentList = null; //한줄평 들어갈코드
			  
			ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
			 
			bookList = bookProcess.getBook(book_id);
			//한줄평코드
			//public List<ShopBookDataBean> getComments(int book_id)원형 
			commentList = bookProcess.getComments(book_id);   
			//public int getCommentCount(int book_id) 원형
			int count = bookProcess.getCommentCount(book_id);
					
			if(book_kind.equals("100"))
				book_kindName="문학";
			else if(book_kind.equals("200"))
				book_kindName="외국어";  
			else if(book_kind.equals("300"))
				book_kindName="컴퓨터";
			
			%>
			
			<div class="row">
				<div class="col">
					<div class="card">
					  <div class="card-header text-left">
					   <b><%=bookList.getBook_title()%></b>
					  </div>
					</div> 
				</div>
			</div>
		<form name="inform" method="post" id="inform"> <!-- 원래는 cartinsert -->		
			<div class="row">
				<div class="col">
					<div class="row">
						<div class="col-4"><img class="card-img" src="../../imageFile/<%=bookList.getBook_image()%>" alt="Card image"></div>
						<div class="col">
								<div class="card">
									<div class="card-body">						
										      <p class="card-text"><small class="text-muted">저자 : <%=bookList.getAuthor()%></small></p>
										      <p class="card-text"><small class="text-muted">출판사 : <%=bookList.getPublishing_com()%></small></p>
										      <p class="card-text"><small class="text-muted">출판일:<%=bookList.getPublishing_date()%></small></p>
										      <p class="card-text"><small class="text-muted">정가 : <%=NumberFormat.getInstance().format(bookList.getBook_price())%>원</small></p>
										       <%buy_price = (int)(bookList.getBook_price()*((double)(100-bookList.getDiscount_rate())/100)) ;%>
										      <p class="card-text"><small class="text-muted">판매가: <%=NumberFormat.getInstance().format((int)(buy_price))%>원</small></p>  
										        <div class="row justify-content-center">
										        <small class="text-muted">수량 :</small>&nbsp;&nbsp;		
											    <input class="form-control col-sm-2" type="text" size="5" name="buy_count" value="1">&nbsp;&nbsp;						       
										        <small class="text-muted">권</small>												 
											   </div>  	
						<%
						     if(bookList.getBook_count()==0){
						%>
						         <b class="text-danger">일시품절</b>
									                           
									<%   }else{ %>	 
									       <input type="hidden" name="book_id" value="<%=book_id %>">
									       <input type="hidden" name="book_image" value="<%=bookList.getBook_image()%>">
									       <input type="hidden" name="book_title" value="<%=bookList.getBook_title() %>">
									       <input type="hidden" name="buy_price" value="<%=buy_price %>">
									       <input type="hidden" name="book_kind" value="<%=book_kind %>">
									    <div class="m-4">   
										    <div class="row justify-content-center">
										    <%if(id.equals("not")){%>
   										    <div class="p-1">     										    	
										       <button class="btn btn-sm btn-warning" type="button" name="not">장바구니</button>			       
											</div> 
											<div class="p-1">      
										       <button class="btn btn-sm btn-danger" type="button" name="not">바로구매</button>						
											</div>
										    <%}else{ %>
										    <div class="p-1">     										    	
										       <button class="btn btn-sm btn-warning" type="submit" onclick="this.form.action='cartInsert.jsp'">장바구니</button>			       
											</div> 
											<div class="p-1">      
										<% String url ="buyForm.jsp?book_id="+book_id+"&book_kind="+book_kind;  %>      
										       <button class="btn btn-sm btn-danger" type="submit" name="buy" value="buy" onclick="this.form.action='<%=url%>'">바로구매</button>						
											</div>
											</div>
										</div>      
									<%}}%>						
									
									</div>
								</div><!-- card end -->
					</div>
					</div>
				</div>
			</div>
			</form>
			<div class="row">
				<div class="col p-3 mt-5">
					<%=bookList.getBook_content()%>
				</div>
			</div>
		<!--  여기서 부터 COMMENT  -->
	<div class="row justify-content-start pl-2 mt-3 pt-3 pb-2 mb-2">			
	<p class="h3"><i class="far fa-comment"></i>&nbsp;&nbsp;한 줄평을 남겨주세요!&nbsp;&nbsp;</p>				    
	</div>  		

	<%if (count == 0) {	
	%>		
	<div class="alert alert-secondary mt-5 pt-5 pb-5" role="alert">
	   <i class="fas fa-exclamation-circle"></i>
	 <div class="pt-5">
	 	  작성 된 한줄 평이 없습니다.처음으로 한줄평을 작성해보세요!
	 </div>
	</div>	
	<%} 
	  if(commentList!=null){
		   for (int i = 0 ; i < commentList.size() ; i++) {
		       ShopBookDataBean comment = commentList.get(i);
		       String star1=comment.getStar();
		       int star=Integer.parseInt(star1);
			%>
		<input type="hidden" value="<%=comment.getStar()%>" id="star">			
		<div class="card mb-2 pb-2" style="height: 180px ">
		  <div class="card-header">
		    	<%=comment.getWriter()%>
		  </div>
		  <div class="card-body">
		    <blockquote class="blockquote">
		      <p><%=comment.getContent()%></p>
			      <div>
				  <span class="starR<%if(star>=1){out.print(" on");}%>">1</span>
				  <span class="starR<%if(star>=2){out.print(" on");}%>">2</span>
				  <span class="starR<%if(star>=3){out.print(" on");}%>">3</span>
				  <span class="starR<%if(star>=4){out.print(" on");}%>">4</span>
				  <span class="starR<%if(star>=5){out.print(" on");}%>">5</span>
				 </div>
		      	<footer class="blockquote-footer"><%= sdf.format(comment.getReg_date())%></cite></footer>
		    </blockquote>
		  </div>
		</div><!-- card end -->
		<%}}%>
		<div class="col-md-6 offset-md-3 pt-5">
			<%if(m_id==null||m_id==""){%>
      		<button role="button" type="button" class="btn btn-lg btn-danger" id="writecomment">작성하기</button>			
			<%}else{ %>
      		<button role="button" type="button" class="btn btn-lg btn-danger" data-toggle="modal" data-target="#write" id="writecomment">작성하기</button>
      	<%} %>
      	</div>
  </div> <!-- book Content col end -->     
  </div> <!-- book Content end -->   
  <div class="row">
    <div class="col p-2"> <jsp:include page="../module/bottom.jsp" flush="false" /></div> 
  </div>    


    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<script>
$(document).ready(function(){
	var click_id 
//별점코드
	$('.starRev span').click(function(){		
		  $(this).parent().children('span').removeClass('on'); 
		  $(this).addClass('on').prevAll('span').addClass('on');
		  click_id = $(this).attr('id'); //클릭한 태그 아이디가져오기	 	
		  $('#stari').val(click_id);
		  return false;
		});
   
		
	  //ajax 활용해서 보내기

		
	$("[name='not']").click(function(){
		$("[name='id']").popover('show');
		$("[name='id']").focus();
		
	});
	$("#writecomment").click(function(){
		$("[name='id']").popover('show');
		$("[name='id']").focus();
		
	});	
});


</script>

