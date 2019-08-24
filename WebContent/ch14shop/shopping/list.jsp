<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>



<%
 String title="list";
  String book_kind = request.getParameter("book_kind");
%>
        
		<%
		 List<ShopBookDataBean> bookLists = null;
		 ShopBookDataBean bookList = null;
		 String book_kindName="";
		  
		 ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
		 
		 bookLists = bookProcess.getBooks(book_kind);
		 if(book_kind.equals("100"))
			      book_kindName="문학";
		 else if(book_kind.equals("200"))
			      book_kindName="외국어";  
		 else if(book_kind.equals("300"))
			      book_kindName="컴퓨터";
		 else if(book_kind.equals("all"))
			      book_kindName="전체";
		
		
%>
<!-- header  -->
	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	

  <div class="row">
    <div class="col"><jsp:include page="../module/top.jsp" flush="false" /> </div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../module/left.jsp" flush="false" /></div> 


    <!-- bookContent -->
     		      
    <div class="col-8 p-5">
        
	<div class="m-3">
	<h3><span class="badge badge-warning"><%=book_kindName%></span></h3> 	
	</div>
	<%    
		 for(int i=0;i<bookLists.size();i++){
		    bookList = (ShopBookDataBean)bookLists.get(i);
	%>
			<div class="p-2 m-2">
			<div class="row">
				<div class="col">
					<div class="card">
					  <div class="card-header text-left">
							         <a href="bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>">
        							 <%=bookList.getBook_title() %></a>	
         <%if(bookList.getBook_count()==0){ %>
              <b class="text-danger">일시품절</b>
        <%}else{ %>
              &nbsp;
        <%} %>       							 					  
					  </div>
					</div> 
				</div>
			</div>	
			<div class="row">
				<div class="col">
					<div class="row">					
						<div class="col-2 m-2">
								<div class="text-center">
										<a href="bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>"><img src="../../imageFile/<%=bookList.getBook_image()%>" alt="Card image" style="width:130; height:150;"></a>
								</div>
						</div>
						<div class="col m-1">
								<div class="card m-1">
									<div class="card-body">						
										      <p class="card-text"><small class="text-muted">저자 : <%=bookList.getAuthor()%></small></p>
										      <p class="card-text"><small class="text-muted">출판사 : <%=bookList.getPublishing_com()%></small></p>
										      <p class="card-text"><small class="text-muted">출판일:<%=bookList.getPublishing_date()%></small></p>
										      <p class="card-text"><small class="text-muted">정가 : <%=NumberFormat.getInstance().format(bookList.getBook_price())%>원</small></p>
										      <p class="card-text"><small class="text-muted">판매가: <%=NumberFormat.getInstance().format((int)(bookList.getBook_price()*((double)(100-bookList.getDiscount_rate())/100)))%>원</small></p>  	
	
									</div>
								</div><!-- card end -->
					</div>
					</div>
				</div>
			</div>
			</div>
		  <%} %>		

  </div> 

    <!-- book Content end -->
  </div>       
  <div class="row">
    <div class="col p-2"> <jsp:include page="../module/bottom.jsp" flush="false" /></div> 
  </div>    


    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>


