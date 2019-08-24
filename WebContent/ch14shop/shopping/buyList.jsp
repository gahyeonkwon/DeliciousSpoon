
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.shopping.BuyDataBean" %>
<%@ page import = "ch14.bookshop.shopping.BuyDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>


<%
  String title="buyList";
  String buyer = (String)session.getAttribute("id");
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
<%
List<BuyDataBean> buyLists = null;
BuyDataBean buyList = null;
int count = 0;
int number = 0;
int total = 0;
long compareId=0;
long preId=0;

if(session.getAttribute("id")==null){
   response.sendRedirect("shopMain.jsp");        
}else{
   BuyDBBean buyProcess = BuyDBBean.getInstance();
   count = buyProcess.getListCount(buyer);
   %>
	<div class="p-3 mb-2">
		<h3 class="text-left text-danger">
		 STEP-2
		 <small class="text-muted">주문목록</small>
		</h3>
	</div>   
   
   <% 
   if(count == 0){
%>	
    	<div class="alert alert-secondary" role="alert">
 					구매목록이 없습니다.
		</div>
<%
  }else{
    buyLists = buyProcess.getBuyList(buyer);
%>		
		
    <table><tr><td>
<%
    for(int i=0;i<buyLists.size();i++){
       buyList = buyLists.get(i);
    	 
       if(i<buyLists.size()-1){
    	  BuyDataBean compare = buyLists.get(i+1);
    	  compareId = compare.getBuy_id();
    		 
    	  BuyDataBean pre = buyLists.get(buyLists.size()-2);
    	  preId = pre.getBuy_id();
    	  
    	  if(compareId==preId){}
       }  	 
%>		 
				 <table class="table table-bordered">
				  <thead>
				    <tr>	    
				      <th scope="col">번호</th>	      
				      <th scope="col">책이름</th>				      
				      <th scope="col">판매가격</th>
				      <th scope="col">수량</th>
				      <th scope="col">금액</th>	           
				    </tr>
				  </thead>	  		
				  <tbody>
				    <tr>
				      <th class="pt-3" scope="row"><%=buyList.getBuy_id()%></th>
				      <td class="pt-3"><%=buyList.getBook_title()%></td>
				      <td class="pt-3"><%=NumberFormat.getInstance().format(buyList.getBuy_price())%></td>
				      <td class="pt-3"><%=buyList.getBuy_count()%></td>
				      <td><%total += buyList.getBuy_count()*buyList.getBuy_price();%>
           <%=NumberFormat.getInstance().format(buyList.getBuy_count()*buyList.getBuy_price()) %></td>
					</tr>


<%
if(buyList.getBuy_id() != compareId || ((i == buyLists.size()-1 && preId != buyList.getBuy_id()))) {
%>

					<tr>	 
		 			 <td colspan="5" class="text-right"><b>총 금액 : <%=NumberFormat.getInstance().format(total)%></b></td>	      		      
				    </tr>
		
				  </tbody>
				</table>  
<% 
      compareId = buyList.getBuy_id();
       total = 0;
   }else{
%>
  		
		    	
		<%} %>


 </td></tr></table><br>
<%
   }
 }

 }

%>


    </div>     <!-- content_end -->  
   </div>
  <div class="row">
    <div class="col p-2"> <jsp:include page="../module/bottom.jsp" flush="false" /></div> 
  </div>    




    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>   


