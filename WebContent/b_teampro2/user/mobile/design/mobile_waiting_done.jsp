<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %>    
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>   
<%@ page import="b_teampro2.userinfo.UserWaitDataBean" %>   
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>   
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<% 
request.setCharacterEncoding("utf-8");
String title="회원가입";
%>

	<!-- waiting_list 객체 생성 -->
	 <jsp:useBean id="waitList" class="b_teampro2.userinfo.UserWaitDataBean">
	     <jsp:setProperty name="waitList" property="*"/>
	 </jsp:useBean>
<%

//system dbbean 객체생성
String store_id = request.getParameter("store_id");
String user_id  = (String)session.getAttribute("user_id");
try{
	if(user_id!=null||!user_id.equals("")){
	UserSystemDBBean system = UserSystemDBBean.getInstance(); 

int check = system.makeWaiting_list(waitList);
//waitinglist 후  waiting 이 되는 지 확인하는 함수 <-- 1이면 웨이팅가능
//- 1이면 같은매장에는 웨이팅을 걸 수 없습니다. 
//0이면 매장오픈이아직안되었습니다.
//2이면 노쇼 상태 입니다
//3이면 일일 대기 갯수 초과
	//내 waiting_list 출력하기
	UserWaitDataBean waiting_list = system.getMywaiting(store_id,user_id);
	//대기상태 출력하기
	int team = system.getCurrent_team(store_id);
	String store_name = system.getStore_name(store_id);

%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/> 
  <input type="hidden" id="user_id" value="<%=user_id%>">
      <div align="center"> 
      	  <img src="../../../img/dp.gif" class="rounded-circle d-flex justify-content-center mt-5 mb-5" style="width: 35%; height: 70%;"> 			
	  </div>
	  <div class="text-center">
	  	<p class="title_d mb-2">대기완료!</p>
	  	<p class="desc2">입장까지 <%=team%>팀 남았습니다.</p>
	  </div>
	  <p class="c_text margin_sy mt-5">대기정보</p> 
	  <div class="border-bottom margin_sy" style="width:90%"></div>
  			<div class="contianer  mt-4">
                <p class="title margin_sy" style="color: #FC5F4A">음식점 이름</p> 
                <p class="desc2 padding_sy"><%=store_name%></p>
            </div>
            <div class="contianer  mt-4">
                <p class="title margin_sy" style="color: #FC5F4A">이름</p> 
                <p class="desc2 padding_sy"><%=waiting_list.getName()%></p>
            </div>
            <div class="contianer  mt-4">
                <p class="title margin_sy" style="color: #FC5F4A">인원</p> 
                <p class="desc2 padding_sy"><%=waiting_list.getPeople_num()%>명</p>
            </div>
            <div class="contianer  mt-4">
                <p class="title margin_sy" style="color: #FC5F4A">전화번호</p> 
                <p class="desc2 padding_sy">0<%=waiting_list.getPhone_number()%></p>
            </div>
            <div class="contianer  mt-4">
                <p class="title margin_sy" style="color: #FC5F4A">내번호</p> 
                <p class="desc2 padding_sy"><%=waiting_list.getWait_number()%>번(최근호출번호 : <%=system.getLastcall(store_id)%>번)</p>
            </div>
	  			
         	<div class="container mt-5" id="btn1">
			      <div class="col-6" style="padding-left:0px; padding-right:8px"> 
				  	<button type="button" class="btn btn-depoon btn-lg btn-block go_main">메인으로</button>
				  </div>
				  <div class="col-6" style="padding-left:8px; padding-right:0px"> 
				  	<button type="button" class="btn btn-depoon btn-lg btn-block go_mypage">마이페이지</button>
				  </div> 
				</div> 
<%}else{
	response.sendRedirect("../design/mobile_login.jsp");
	}
}catch(Exception e){} %>

<jsp:include page="../frame/bottom.jsp" flush="false"/>   	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<!-- JQUERY -->

<script>
 $('.go_main').click(function(){
	location.href='mobile_main.jsp';
 });
 
  $('.go_mypage').click(function(){
	  var user_id = $('#user_id').val();
	  location.href='mobile_mypage.jsp?user_id'+user_id;
 });
</script>



