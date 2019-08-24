<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.lang.*" %>

				<%
				  String title="searchMain";
				  List<ShopBookDataBean> bookLists  = null;
				  int number =0;
				  String options=request.getParameter("options");
				  int opt=Integer.parseInt(options);
				  String cd=request.getParameter("condition");
				  ShopBookDBBean bookProcess = ShopBookDBBean.getInstance(); //instance 생성
				//public ShopBookDataBean[] searchBooks(String cd,int opt)
				  bookLists = bookProcess.searchBooks(cd,1);  
				  if(bookLists == null){response.sendRedirect("shopMain.jsp");}
				%>

<!-- header  -->
	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>

 
  <div class="row">
    <div class="col"><jsp:include page="../module/top.jsp" flush="false" /> </div> 
  </div>
  <div class="row">
 	<div class="col"><jsp:include page="introList2.jsp" flush="false" /> </div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../module/left.jsp" flush="false" /> </div> 
    <div class="col-8 p-2 m-2">

				<div class="row justify-content-start pl-2 mt-3 pt-2 pb-2 mb-2">			
					<p class="h3"><i class="fas fa-question-circle"></i>&nbsp;&nbsp;이  정보를 원하셨나요?&nbsp;&nbsp;
					<small class="text-muted">'<%=cd%>' 에 대한 검색결과</small>		
					</p>		    
				</div>
				<div class="card-columns mb-3">
				<%             
				for (int i = 0 ; i < bookLists.size() ; i++) {
				    ShopBookDataBean book = bookLists.get(i);
				%>
				  <div class="card">
					    <a href="bookContent.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>">
					    <img class="card-img-top" src="../../imageFile/<%=book.getBook_image()%>" alt="Card image cap">
					    </a>
				    <div class="card-body">
				      <h5 class="card-title"><a id="title" href="bookContent.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>">
				              <%=book.getBook_title() %></a></h5>
				      <p class="card-text text-danger"><%if(book.getBook_count()==0){ %>
				              일시품절
				          <%}else{ %>
				               &nbsp;
				          <%} %></p>
				      <p class="card-text"><small class="text-muted">출판사 : <%=book.getPublishing_com()%></small></p>
				      <p class="card-text"><small class="text-muted">저자 : <%=book.getAuthor()%></small></p>
				      <p class="card-text"><small class="text-muted">정가:<%=NumberFormat.getInstance().format(book.getBook_price())%>원</small></p>
				      <p class="card-text"><small class="text-muted">판매가: <%=NumberFormat.getInstance().format((int)(book.getBook_price()*((double)(100-book.getDiscount_rate())/100)))%></small></p>                    				
				    </div>    
				  </div>				       
				<%
				  }//for end
				%>
				  </div><!-- deck end -->  		
   </div>   
  </div>


    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

