<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "ch14.bookshop.shopping.CartDataBean" %>
<%@ page import = "ch14.bookshop.shopping.CartDBBean" %>
<%@ page import = "ch14.bookshop.shopping.CustomerDataBean" %>
<%@ page import = "ch14.bookshop.shopping.CustomerDBBean" %>
<%@ page import = "ch14.bookshop.shopping.BuyDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>



<%
	int buy_price=0; 
	String opt=""; 	
   String title="buyFrom";	
   String buy = request.getParameter("buy"); //바로 구매옵션
   String book_kind = request.getParameter("book_kind");
   String book_id = request.getParameter("book_id");//바로구매옵션  
   String buy_count = request.getParameter("buy_count");//바로구매옵션
   String buyer = (String)session.getAttribute("id");%>



<!-- header  -->

	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	



<% 
//일반 구매
List<CartDataBean> cartLists = null;
List<String> accountLists = null;
CartDataBean cartList = null;
CustomerDataBean member= null;
int number = 0;
int total = 0;

if(session.getAttribute("id")==null){
	response.sendRedirect("shopMain.jsp");        
}else{
	
	CartDBBean bookProcess = CartDBBean.getInstance();
    cartLists = bookProcess.getCart(buyer);
    
    CustomerDBBean memberProcess = CustomerDBBean.getInstance();
    member = memberProcess.getMember(buyer);
    
    BuyDBBean buyProcess = BuyDBBean.getInstance();
   
    //여기부터 바로구매

	
	ShopBookDataBean bookList = null; 	
	ShopBookDBBean bookProcess2 = ShopBookDBBean.getInstance();


%>    
    

  <div class="row">
    <div class="col"><jsp:include page="../module/top.jsp" flush="false" /> </div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../module/left.jsp" flush="false" /> </div> 
  
    <!-- content_cartList -->
	<div class="col-8 p-2 m-2">
	<div class="p-3 mb-2 d-flex justify-content-start">	
	    <button class="btn btn-lg btn-secondary" type="button"
       onclick="javascript:window.location='http://localhost:8080/bban/ch14shop/shopping/cartList.jsp?book_kind=all.jsp'"><i class="fas fa-arrow-left"></i></button>    
	</div>	
	<div class="p-3 mb-2">
		<h3 class="text-left text-danger">
		 STEP-2
		 <small class="text-muted">주문목록</small>
		</h3>
	</div>
		  <form name="inform" method="post" action="updateCart2.jsp">
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
				  
	  <%if(buy!=null&&book_id!=null&&buy_count!=null){ 			
		  if(buy.equals("buy")){
			  opt="buy";			  
	 bookList = bookProcess2.getBook(Integer.parseInt(book_id));
	 buy_price = (int)(bookList.getBook_price()*((double)(100-bookList.getDiscount_rate())/100)) ;	
	 %>  
	 			<tr>
				      <th class="pt-3" scope="row">1</th>
				      <td class="pt-3"><%=bookList.getBook_title()%></td>
				      <td class="pt-3"> <%=NumberFormat.getInstance().format((int)(buy_price))%></td>
				      <td class="pt-3"><%=buy_count%></td>
				      <td><%=NumberFormat.getInstance().format((int)(buy_price))%></td>
					</tr>
					<%
					total += Integer.parseInt(buy_count)*buy_price;			
		  } }else{ 
			  opt="cart";
		  for(int i=0;i<cartLists.size();i++){
		     cartList = cartLists.get(i);
		%>  
				    <tr>
				      <th class="pt-3" scope="row"><%=++number %></th>
				      <td class="pt-3"><%=cartList.getBook_title()%></td>
				      <td class="pt-3"><%=NumberFormat.getInstance().format(cartList.getBuy_price())%></td>
				      <td class="pt-3"><%=cartList.getBuy_count()%></td>
				      <td><%total += cartList.getBuy_count()*cartList.getBuy_price();%>
		            <%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getBuy_price()) %></td>
					</tr>
					<%}	  }//buy 옵션%>
					<tr>	 
		 			 <td colspan="5" class="text-right"><b>총 금액 : <%=NumberFormat.getInstance().format(total)%></b></td>	      		      
				    </tr>
		
				  </tbody>
				</table>  
		
		    	
<%}
%>
		
		   </form>
		   
	<!-- 배송지 컨텐츠 -->
	
 	<form method="post" action="buyPro.jsp" name="buyinput">  
 		<input type="hidden" name="book_id" value="<%=book_id%>">
 	 	<input type="hidden" name="buy_count" value="<%=buy_count%>">
  	    <input type="hidden" name="buy_price" value="<%=buy_price%>">			
 		<input type="hidden" name="opt" value="<%=opt%>">
   

	<div class="p-3 mb-2 mt-3">
		<h3 class="text-left text-danger">
		 STEP-3
		 <small class="text-muted">배송정보</small>
		</h3>
	</div> 	
	   <div class="pt-2 mt-3">
	   		<table class="table table-bordered">
				  <tbody>
					 <tr>
					 	<th>배송지 선택</th>
					 	<td>
					 	<div class="row pl-3">
					 	<div class="form-check">
						  <input class="form-check-input" type="radio" name="exampleRadios" value="addr_m" name="addr" id="addr">
						  <label class="form-check-label" for="exampleRadios1">
						    	주문자정보와 동일
						  </label>
						</div>							
					 	<div class="form-check ml-3">
						  <input class="form-check-input" type="radio" name="exampleRadios" value="addr_n" name="addr" id="addr2">
						  <label class="form-check-label" for="exampleRadios1">
						    	새 주소 입력
						  </label>
						</div>			
						</div>			
					</td>
					 </tr>
					 <tr>
					 	<th>주문인</th>
					 	<td class="text-left"><%=member.getName()%></td>
					 	  <input type="hidden" name="deliveryName" value="<%=member.getName()%>">
					 </tr>	
					 <tr>
					 	<th>수령인</th>
					 	<td><input class="form-control col-sm-4" name="suname" value="<%=member.getName()%>" /></td>
					 </tr>						 
					 <tr>
					 	<th>주문인전화번호</th>
					 	<td class="text-left"><%=member.getTel()%></td>
					 	<input type="hidden" name="deliveryTel" value="<%=member.getTel()%>">
					 </tr>	  	
					 <tr>
					 	<th>연락받을번호</th>
					 	<td><input class="form-control col-sm-4" name="deliveryTel2" value="<%=member.getTel()%>" /></td>
					 </tr>						 
					 <tr>
					 	<th>주소</th>
					 	<td>
						<input type="hidden" id="address" value="<%=member.getAddress()%>">
						<input type="hidden" id="address_de" value="<%=member.getAddress_de()%>">				 	
						    <div class="form-group row">
						      <div class="col-sm-4">
						        <div class="input-group mb-3">
						          <input type="text" class="form-control" name="postcode" id="postcode" readonly="readonly">
						          <div class="input-group-append">
						            <button class="btn btn-outline-secondary" id="postcodeBtn" type="button">우편번호</button>
						          </div>
						        </div>
						        <input type="text" name="deliveryAddress" class="form-control" id="deliveryAddress">
						        <input type="text" name="deliveryAddress2" class="form-control" placeholder="상세주소입력" id="deliveryAddress2">									        
						      </div>
						    </div>
					 	</td>
					 </tr>	  		  						 					 					   	
				  </tbody>
			 </table>
   		</div>   		
   		<button class="btn btn-danger btn-lg" type="submit" >구매완료</button> 
   	</form>

    </div>     <!-- content_end -->  
   </div>
  <div class="row">
    <div class="col p-2"> <jsp:include page="../module/bottom.jsp" flush="false" /></div> 
  </div>    




    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>   


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$(document).ready(function(){
  $('#postcode').click(function(){
    //fetchDaumPostcode();
    $('#postcodeBtn').trigger('click');
  });
  $('#postcodeBtn').click(function(){
    fetchDaumPostcode();
  });
  
  //주소값 설정
  var address = $('#address').val();
  var address_de = $('#address_de').val();
  
  $("#addr").change(function() {
		  $('#deliveryAddress').val(address);
		  $('#deliveryAddress2').val(address_de);		  
   });
  
  $("#addr2").change(function() {
		  $('#deliveryAddress').val('');
		  $('#deliveryAddress2').val('');		  
 
  });
});


function fetchDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            $('#postcode').val(data.zonecode);
            $('input[name="deliveryAddress"]').val(fullRoadAddr);
        }
    }).open();
}

</script>
<script>

</script>
