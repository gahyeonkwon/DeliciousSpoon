
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.shopping.BuyDataBean" %>
<%@ page import = "ch14.bookshop.shopping.BuyDBBean" %>

<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>

<%
	 String title = "orderedList"; //title 
 	 String buyer = (String)session.getAttribute("id");
%>
 

<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	

  <div class="row">
    <div class="col"><jsp:include page="../top.jsp" flush="false"/></div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../left.jsp" flush="false" /> </div> 
    <div class="col-8 p-2 m-2">
 		<!-- 주문목록조회 -->
		 		 
		<%
		List<BuyDataBean> buyLists = null;
		BuyDataBean buyList = null; 
		int count = 0;
		
		BuyDBBean buyProcess = BuyDBBean.getInstance();
		count = buyProcess.getListCount();
		
		if(count == 0){
		%>

			<div class="alert alert-danger mt-5 pt-5 pb-5" role="alert">
			   <i class="fas fa-exclamation-circle"></i>
			 <div class="pt-5">
			 	 주문상품이 없습니다. 장사가 안되요 ㅠㅠ
			 </div>
			</div>

<%
}else{
   buyLists = buyProcess.getBuyList();
%>
  
  <table class="table table-sm table-hover"> 
   <thead>
    <tr>
      <th scope="col">주문번호</th>
      <th scope="col">주문자</th>
      <th scope="col">책이름</th>
      <th scope="col">주문가격</th>
      <th scope="col">주문수량</th> 
      <th scope="col">주문일</th>     
      <th scope="col">결제계좌</th>       
      <th scope="col">배송명</th> 
      <th scope="col">배송지전화</th> 
      <th scope="col">배송지주소</th>                   
      <th scope="col">배송지상황</th>
    </tr>
  </thead> 
  <tbody>
<%
  for(int i=0;i<buyLists.size();i++){
    buyList = (BuyDataBean)buyLists.get(i);	     	 
%>	
    <tr> 
      <td><%=buyList.getBuy_id() %></td> 
      <td><%=buyList.getBuyer() %></td> 
      <td><%=buyList.getBook_title() %></td>
      <td><%=buyList.getBuy_price() %></td> 
      <td><%=buyList.getBuy_count()%></td>
      <td><%=buyList.getBuy_date().toString() %></td>
      <td><%=buyList.getAccount() %></td>
      <td><%=buyList.getDeliveryName() %></td>
      <td><%=buyList.getDeliveryTel() %></td>
      <td><%=buyList.getDeliveryAddress() %></td>
      <td><%=buyList.getSanction() %></td>
    </tr>
<%}%>
</tbody>
</table>
<%}%>
		</div>	   	
		</div><!-- content-end -->
    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>