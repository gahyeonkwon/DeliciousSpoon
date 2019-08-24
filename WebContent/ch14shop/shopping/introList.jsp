<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.text.NumberFormat" %>


<div class="row justify-content-center mt-3">
 	 	<i class="fas fa-quote-left"></i>  		  	
		<h5 class="card-title">&nbsp;&nbsp;&nbsp;NEW&nbsp; &nbsp;</h5>
	<i class="fas fa-quote-right"></i>	    
</div>

<%
  ShopBookDataBean bookLists[] = null;
  int number =0;
  String book_kindName="";
  
  ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
  for(int i=1; i<=3;i++){
	  bookLists = bookProcess.getBooks(i+"00",4);
	   if(bookLists == null) continue;
     if(bookLists[0].getBook_kind().equals("100")){
	      book_kindName="문학";
     }else if(bookLists[0].getBook_kind().equals("200")){
	      book_kindName="외국어";  
     }else if(bookLists[0].getBook_kind().equals("300")){
	      book_kindName="컴퓨터";
     }

%>

	<div class="m-3 p-2">
	<h3><span class="badge badge-warning"><%=book_kindName%></span></h3>
 	
	</div>

  <div class="card-columns mb-3">
<%             
  for(int j=0;j<bookLists.length;j++){
	   if(bookLists[j] == null) continue;
%>
  <div class="card">
	    <a href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
	    <img class="card-img-top" src="../../imageFile/<%=bookLists[j].getBook_image()%>" alt="Card image cap">
	    </a>
    <div class="card-body">
      <h5 class="card-title"><a id="title" href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
              <%=bookLists[j].getBook_title() %></a></h5>
      <p class="card-text text-danger"><%if(bookLists[j].getBook_count()==0){ %>
              일시품절
          <%}else{ %>
               &nbsp;
          <%} %></p>
      <p class="card-text"><small class="text-muted">출판사 : <%=bookLists[j].getPublishing_com()%></small></p>
      <p class="card-text"><small class="text-muted">저자 : <%=bookLists[j].getAuthor()%></small></p>
      <p class="card-text"><small class="text-muted">정가:<%=NumberFormat.getInstance().format(bookLists[j].getBook_price())%>원</small></p>
      <p class="card-text"><small class="text-muted">판매가: <%=NumberFormat.getInstance().format((int)(bookLists[j].getBook_price()*((double)(100-bookLists[j].getDiscount_rate())/100)))%></small></p>                    

    </div>    
  </div>
       
<%
  }//for end
%>

  </div><!-- deck end -->  
  		<div class="justify-content-center">
		<h4><span class="badge"><a href="list.jsp?book_kind=<%=bookLists[0].getBook_kind()%>"><i class="fas fa-plus"></i></a></span></h4>
  		</div>
<% 
}
%>

