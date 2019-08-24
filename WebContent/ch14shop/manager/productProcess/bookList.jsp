<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
String title="bookList";
String managerId ="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")){
       response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
%> 

<%!
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
    List<ShopBookDataBean> bookList = null; 
    int number =0;
    String book_kind="";
    
    book_kind = request.getParameter("book_kind");
 
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
    <div class="col"><jsp:include page="../top.jsp" flush="false"/></div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../left.jsp" flush="false"/></div> 
    <div class="col-8 p-2 m-2">
			 <!--전체상품보기_수정/삭제-->
			
								<%if(book_kind.equals("all")){%>
				<%}else{%>
				  
				<%} %>				
				    		 				
				<%
				  if (count == 0) {
				%>				
				           등록된 책이 없습니다.
					<%} else {%>
					
								<table class="table table-sm table-hover">
								  <caption><%=bookList.size() %>개</caption>
								  <thead>
								    <tr style="padding: 15px;">
								      <th scope="col">번호</th>
								      <th scope="col">책분류</th>
								      <th scope="col">제목</th>
								      <th scope="col">가격</th>
								      <th scope="col">수량</th>
								      <th scope="col">저자</th>
								      <th scope="col">출판사</th>
								      <th scope="col">출판일</th>
								      <th scope="col">책이미지</th>
								      <th scope="col">할인율</th>
								      <th scope="col">등록일</th>
								      <th scope="col">관리</th>		      	      
								    </tr>
								  </thead>
								  <tbody>			  
						<%  
						    for (int i = 0 ; i <bookList.size() ; i++) {
						      ShopBookDataBean book = 
						    		  (ShopBookDataBean)bookList.get(i);
						%>
									 <input type="hidden" value="<%=book_kind%>" id="book_kind">
									 <input type="hidden" value="<%=book.getBook_id()%>" id="book_id">
									 <tr> 
										 
								      <th scope="row"><%=++number%></th>			
									  <td><%=book.getBook_kind()%></td> 
									  <td><%=book.getBook_title()%></td>	
								  	  <td><%=book.getBook_price()%></td> 	      
								      <td>
								      <% if(book.getBook_count()==0) {%>
								         <font color="red"><%="일시품절"%></font>
								      <% }else{ %>
								         <%=book.getBook_count()%>
								      <%} %>
								      </td> 		
								      <td><%=book.getAuthor()%></td>
								      <td><%=book.getPublishing_com()%></td>
								      <td><%=book.getPublishing_date()%></td>
								      <td><%=book.getBook_image()%></td>
								      <td><%=book.getDiscount_rate()%></td>
								      <td><%=sdf.format(book.getReg_date())%></td>
								      <td>
								         <a class="btn btn-primary" href="/bban/ch14shop/manager/productProcess/bookUpdateForm.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>">수정</a>
										 <a class="btn btn-danger text-white" href="/bban/ch14shop/manager/productProcess/bookDeletePro.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>" id="delete">삭제</a>							     
								      <td>  
								   </tr>
								<%}%>		
								
									 </tbody>
								</table>
								<%}%>				  
			  </div>		
	
    </div>   
	

<!-- footer -->
		<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<% 
   }
}catch(Exception e){
   e.printStackTrace();
}
%>
