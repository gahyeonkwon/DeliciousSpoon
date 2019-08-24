<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %> 
<%@ page import="b_teampro2.storeinfo.StoreinfoDBBean" %> 
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>   
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %> 
<%@ page import="java.util.*" %>  
<%
request.setCharacterEncoding("utf-8");
String title="대기신청";
String user_id = (String)session.getAttribute("user_id");

String store_id = request.getParameter("store_id");		
try{
if(user_id!=null||!user_id.equals("")){
//DB기본연결
//출력 데이터 함수
	//페이지에 매장 정보 받아오기 위한 객체 생성
	UserSystemDBBean system = UserSystemDBBean.getInstance(); 
	//store 정보 받아올 객체 생성
	StoreinfoDataBean store = null;
	store = system.getStoreinfo(store_id);
	  	
 	//내가 받게 될번호 출력
 	  int my_num = system.getCurrent_num(store_id);
 	//남은 팀 수 출력
 	  int team = system.getCurrent_team(store_id);
%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/>   
  <div class="container">
	  <div class="container">
		<div class="card margin_sy" id="card_size_sy">
		   <img style="height: 269px" class="card-img" src="../../../img/waitingimg.png" alt="Card image">
	 		<div class="card-img-overlay">
		 		<p class="title3_sy text-center mt-2" style="color:white;"><%=store.getStore_name()%></p>
		 		    <div class="text-center">
						  <p class="c_text margin_sy" style="color:white;">내 번호</p>
						  <p class="number_sy" style="color:white;"><%=my_num %></p>
						  <p class="s margin_sy" style="color:white;"><%=team %>팀 남았습니다!</p>
					</div>   	    
			</div>
		</div>
	  	   	
 	  <form action="mobile_waiting_done.jsp" method="post">
	  <div class="container  mt-3">
		   <div class="input-group">	
	         <input type="hidden" name="store_id" value="<%=store_id %>">
	         <input type="hidden" name="user_id" value="<%=user_id %>">   	
		     <input id="mragin_gr" name="name" type="text" class="form-control mb-3" placeholder="신청이름">
		     
		     <select id="mragin_gr" name="people_num" class="custom-select mb-1">
			  <option selected>인원</option>
			  <option value="1">1명</option>
			  <option value="2">2명</option>
			  <option value="3">3명</option>
			  <option value="4">4명</option>
			  <option value="5">5명</option>
			  <option value="6">6명</option>
			</select>
			<p class="detail_sy padding_sy">최대 6명까지 선택가능합니다.</p>
			<input id="mragin_gr" name="phone_number" type="text" class="form-control" placeholder="전화번호">
		   </div>
	  </div>  
		<div class="container"> 
		  <button id="mragin_gr" type="submit" class=" btn-depoon btn btn-block mt-4">신청하기</button>			  	
		</div>
		
	</form>	
	<div class="container margin_sy mt-4 mb-3">
		    <p class="detail_sy"> * 대기 내용 변경시 매장으로 연락 부탁드립니다.</p>										
			<p class="detail_sy"> * 인원이 변경될 시 불이익을 받을 수 있습니다.</p>
			<p class="detail_sy"> * 대기 알람을  받으면 매장 근처에서 대기 바랍니다.</p>									
		  </div>
	</div>	
  </div>
  <%} 
  }catch(Exception e){}%>
<jsp:include page="../frame/bottom.jsp" flush="false"/>   	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQUERY -->
<!-- 데이터 입력제어 -->	
<script>
$('[name=people_num]').keyup(function(e) {
    var reg = /[^0-9]/gi;
    var v = $('[name=people_num]').val();
  
    if (reg.test(v)) {  
    	$('[name=people_num]').val(v.replace(reg, ''));
        swal('숫자만 입력가능합니다');
        $('[name=people_num]').focus();
        return false;    	
     };

});

$('.go').click(function(e) {
      var reg = /[01](0|1|6|7|8|9)(\d{4}|\d{3})\d{4}$/g;  
      var v = $('[name=phone_number]').val();
      if(txt.length>11){
      	$("[name=phonecheck]").show();
      	$("[name=phone_number]").val("");
          $("[name=phone_number]").focus();   
      	return false;}
   	if(re_phone.test(txt)){  
      	$("[name=phonecheck]").hide();    //true 반환 하면 	  실행                  
       }else{
   		$("[name=phonecheck]").show();
          $("[name=phone_number]").val("");
          $("[name=phone_number]").focus();    
       }
  
});
</script>

	