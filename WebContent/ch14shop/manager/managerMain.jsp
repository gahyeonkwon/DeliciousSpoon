<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

    
<% request.setCharacterEncoding("utf-8");%>
   <%!
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
   String title="책관리";
   String managerId ="";
   try{
	   managerId = (String)session.getAttribute("managerId");
	   
	   if(managerId==null || managerId.equals("")){
          response.sendRedirect("logon/managerLoginForm.jsp");
	   }else{

		
				    List<ShopBookDataBean> bookList = null; 
				    int number =0;
				    String book_kind="all";		    
				    ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
				    int count = bookProcess.getBookCount();
				    
				    if (count > 0) {
				    	bookList = bookProcess.getBooks(book_kind);
				    }
		  
	
%>
<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	
	
  <div class="row">
    <div class="col"><jsp:include page="top.jsp" flush="false"/></div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="left.jsp" flush="false" /> </div> 
    <div class="col-8 p-2 m-2">
 		<!-- 상품관련작업 _상품등록 -->				
				  <form method="post" name="writeform" action="productProcess/bookRegisterPro.jsp"  enctype="multipart/form-data">     
						 <div class="card border-light pb-5">	
				   		 <h5 class="card-title pt-3 text-primary">상품 등록</h5>		
						  <div class="card-body">
							 <div class="form-group row">
						    	<label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">분류</label>			
						       <div class="col-md-4">
						       <select class="form-control" name="book_kind">
						           <option value="100">문학</option>
						           <option value="200">외국어</option>
						           <option value="300">컴퓨터</option>
						       </select>
						       </div>
							</div> 			
			 			 <div class="form-group row">
						    <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">책 이름</label>
						    <div class="col-sm-6">
						      <input type="text" name="book_title" class="form-control">
						    </div>
						   <div class="col-sm-4">	
						   	   <label class="custom-file-label" for="customFile">이미지</label>				
						  	   <input type="file" class="custom-file-input" name="book_image">
						  </div>						    
						 </div>								 						 	
			 			 <div class="form-group row">
						    <label class="col-sm-2 col-form-label col-form-label-sm">가격</label>
						    <div class="col-sm-10">
						      <input type="text" name="book_price" class="form-control">
						    </div>
						 </div>							 				  
			 			 <div class="form-group row">
						    <label class="col-sm-2 col-form-label col-form-label-sm">수량</label>
						    <div class="col-sm-10">
						      <input type="text" name="book_count" class="form-control">
						    </div>
						 </div>							
			 			 <div class="form-group row">
						    <label class="col-sm-2 col-form-label col-form-label-sm">저자</label>
						    <div class="col-sm-10">
						      <input type="text" name="author" class="form-control">
						    </div>
						 </div>	
			 			 <div class="form-group row">
						    <label class="col-sm-2 col-form-label col-form-label-sm">출판사</label>
						    <div class="col-sm-10">
						      <input type="text" name="publishing_com" class="form-control">
						    </div>
						 </div>	
			 			 <div class="form-group row">
						    <label class="col-sm-2 col-form-label">출판일</label>
						   	  <div class="col-sm-2">
						      		 <select name="publishing_year" class="form-control">
								        <%
								        Timestamp nowTime  = new Timestamp(System.currentTimeMillis());
								        int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
								           for(int i=lastYear;i>=2010;i--){
								        %>
								             <option value="<%=i %>"><%=i %></option>
								        <%} %>
								        </select>
							  </div>	        
						   	  <div class="col-sm-2">								     
								        <select name="publishing_month" class="form-control">
								        <%
								           for(int i=1;i<=12;i++){
								        %>
								             <option value="<%=i %>"><%=i %></option>
								        <%} %>
								        </select>
							  </div>        
						   	  <div class="col-sm-2">								        
								        <select name="publishing_day" class="form-control">
								        <%
								           for(int i=1;i<=31;i++){
								        %>
								             <option value="<%=i %>"><%=i %></option>
								        <%} %>
								        </select>								       
							  </div>
						 </div>						 						 									
			 			 <div class="form-group row">
						    <label class="col-sm-2 col-form-label col-form-label-sm">내용</label>
						    <div class="col-sm-10">
						       <textarea class="form-control" name="book_content"></textarea>
						    </div>
						 </div>			
			 			 <div class="form-group row">
						    <label class="col-sm-2 col-form-label col-form-label-sm">할인율</label>
						    <div class="col-sm-2">
						       <input class="form-control" name="discount_rate">
						    </div>
						 <div class="pt-2">   
						 <i class="fas fa-percent"></i>
						 </div>
						 </div>			
						<div class="justify-content-center"> 				
						  <input type="submit" class="btn btn-outline-primary" value="책등록">  
						  <input type="reset" class="btn btn-outline-primary" value="다시작성">	
						</div>	
												
					</div>	
					</div>	        
				</form>			   
    </div>   
  </div>

	
			
 </div><!-- row end -->
</div><!-- container end -->


<!-- footer -->
		<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>