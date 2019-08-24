<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.shopping.CartDataBean" %>
<%@ page import = "ch14.bookshop.shopping.CartDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>


<%
 String title="cartList";
 String book_kind = request.getParameter("book_kind");
 String buyer = (String)session.getAttribute("id");
 String opt="";
%>


<%
List<CartDataBean> cartLists = null;
CartDataBean cartList = null;
int count = 0;
int number = 0;
int total = 0;

if(session.getAttribute("id")==null){
   response.sendRedirect("shopMain.jsp");        
}else{
   CartDBBean bookProcess = CartDBBean.getInstance();
   count = bookProcess.getListCount(buyer);



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
  
    <!-- content_cartList -->
	<div class="col-8 p-2 m-2">	
	<div class="p-3 mb-2">
		<h3 class="text-left text-danger">
		 STEP-1
		 <small class="text-muted">장바구니</small>
		</h3>
	</div>

<%       if(count == 0){
%>
    	<div class="alert alert-secondary" role="alert">
 					장바구니에 담긴 물품이 없습니다.
 					
     <input class="btn btn-sm btn-dark pl-2" type="button" value="쇼핑계속" 
     onclick="javascript:window.location='list.jsp?book_kind=<%=book_kind%>'">
		</div>
		
<%
   }else{
	  opt="cart";
     cartLists = bookProcess.getCart(buyer);
 %>    
 
 
    <form name="cartform">
    	<div class="table-responsive">
		 <table class="table">
		  <thead>
		    <tr>	    
		      <th scope="col">번호</th>
			  <th scope="col"></th>		      
		      <th scope="col">책이름</th>				      
		      <th scope="col">판매가격</th>
		      <th scope="col">수량</th>
		      <th scope="col">금액</th>
		      <th scope="col">삭제 </th>		           
		    </tr>
		  </thead>	  

		  <tbody>
<%
   for(int i=0;i<cartLists.size();i++){
     cartList = (CartDataBean)cartLists.get(i);
 
%> 	
		  
		    <tr>
		      <th class="pt-3" scope="row"><%=++number %></th>
		      <td><img src="../../imageFile/<%=cartList.getBook_image()%>" 
             border="0" width="40" height="60" align="middle"></td>
		      <td class="pt-3"><a href="bookContent.jsp?book_id=<%=cartList.getBook_id()%>&book_kind=<%=book_kind%>"><%=cartList.getBook_title()%></a></td>
		      <td class="pt-3"><%=NumberFormat.getInstance().format(cartList.getBuy_price())%></td>
		      <td class="pt-3"><input class="from-control col-4" id="buy_count" type="text" name="buy_count" size="5" value="<%=cartList.getBuy_count()%>">
          <% 
          String url = "updateCartForm.jsp?cart_id="+cartList.getCart_id()+
            "&book_kind="+book_kind + "&buy_count="+cartList.getBuy_count();
          
          %>
<!-- onclick="javascript:window.location='<%=url%>'"  --> 
			<input type="hidden" id="book_kind" value="<%=book_kind %>">
			<input type="hidden" id="cart_id" value="<%=cartList.getCart_id()%>">			
          <button class="btn btn-sm btn-secondary" id="update" type="button"
          >수정</button></td>
		      <td><%total += cartList.getBuy_count()*cartList.getBuy_price();%>
            <%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getBuy_price()) %></td>
		      <td>
		      		<div class="row m-2">
		      		<input class="btn btn-sm btn-secondary" type="button" value="삭제" 
		            onclick="javascript:window.location=
		            'cartListDel.jsp?list=<%=cartList.getCart_id()%>&book_kind=<%=book_kind%>'">
 
					</div>
			 </td>  	
			</tr>
			<%}%>
			<tr>	
			 <th></th> 
 			 <td colspan="6" class="text-right"><b>총 금액 : <%=NumberFormat.getInstance().format(total)%></b></td>	      		      
		    </tr>

		  </tbody>
		</table>  
   </div>
    	
	<div class="justify-content-center">
         <input class="btn btn btn-danger" type="button" value="구매하기" 
            onclick="javascript:window.location='buyForm.jsp'">
         <input class="btn btn btn-dark" type="button" value="쇼핑계속" 
            onclick="javascript:window.location='list.jsp?book_kind=<%=book_kind%>'">
         <input class="btn btn btn-secondary" type="button" value="장바구니비우기" 
            onclick="javascript:window.location='cartListDel.jsp?list=all&book_kind=<%=book_kind%>'">
 	</div>
   </form>
 
 
    </div>     <!-- content_end -->  

  </div>
  <div class="row">
    <div class="col p-2"> <jsp:include page="../module/bottom.jsp" flush="false" /></div> 
  </div>    



<%
  } 
}
%>



    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<script>
$(document).ready(function(){
	$("#update").click(function(){
     var buy_count = $('#buy_count').val();
	 var cart_id = $('#cart_id').val();
	 var book_kind = $('#book_kind').val();
     $.ajax({
         type: "POST",
         url: "updateCart.jsp", 
         data: "buy_count="+buy_count+"&cart_id="+cart_id+"&book_kind="+book_kind,
         success: function(){
        	 location.href="cartList.jsp";       	 
        			 }

         });	 

 });
});

</script>

