<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %>    
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>   
<%@ page import="b_teampro2.userinfo.UserWaitDataBean" %>   
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>   
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "대기완료";
		
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>
	<!-- waiting_list 객체 생성 -->
	 <jsp:useBean id="waitList" class="b_teampro2.userinfo.UserWaitDataBean">
	     <jsp:setProperty name="waitList" property="*"/>
	 </jsp:useBean>

<!-- 상단 메뉴 -->
   <jsp:include page="../frame/top.jsp" flush="false"/>   
   
<!-- main content -->
   
     <!-- 메인사진 위에 올린 css 가져온거 -->
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
   
  <%
  //DB기본연결
	//system dbbean 객체생성
	//String store_id = waitList.getStore_id();
	String store_id = request.getParameter("store_id");
	String user_id = (String)session.getAttribute("user_id");
 // String user_id  = waitList.getUser_id();
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
	int last_call = system.getLastcall(store_id);
	int team = system.getCurrent_team(store_id);
	String store_name = system.getStore_name(store_id);
	
	String phone_number = request.getParameter("phone_number");
	String name= request.getParameter("name");
	String people_num = request.getParameter("people_num");
	
 %>           
	<!-- 내용 시작 -->
	<div class="container">
    	<div class="container pt-5 pb-5 ">       
        	<img src="/bban/b_teampro2/img/dp.gif" class="rounded-circle" style="bottom:10%;width:25%">
        </div>
	</div>
      
      
	<div class="waiting">
    	<div class="pb-4">
        	<p class="h3">대기신청완료</p>
        </div>
        <p class="h5">입장까지 앞으로 <%=team%>팀 남았습니다.</p>
	</div>
      
	<div class="row justify-content-center">
    	<div class="container col-4">
        	<div class="row pt-5">
        		<div class="col align-items-end d-flex justify-content-start">
            		<p class="h3">대기정보</p>
         		</div>    
      		</div>    
      		<div class="border-bottom pt-1 mb-2 pr-1" style="width: 98%;"></div>   
      		<div class="pt-2 pb-2">   
         		<div class="row d-flex justify-content-start">         
               		<div class="col-sm-3 d-flex align-items-end">
                  		<p class="lead">음식점이름</p>   
               		</div>      
               		<div class="col-sm-9 pt-2 d-flex align-items-end">
                  		<p><%=store_name%></p>
               		</div>   
         		</div><!-- 음식적 이름 end -->        
         		<div class="row d-flex justify-content-start mt-2">         
               		<div class="col-sm-3 d-flex align-items-center">
                  		<p class="lead">신청이름</p>   
               		</div>      
               		<div class="col-sm-9 pt-2 d-flex align-items-end">
                 		<div class="text-sm-left"> 
                  			<p><%=name%></p>
                 		</div> 
               		</div>   
         		</div><!-- 신청자 이름 end -->       
         		<div class="row d-flex justify-content-start mt-2">         
               		<div class="col-sm-3 d-flex align-items-end">
                  		<p class="lead">신청인원</p>   
               		</div>      
               		<div class="col-sm-9 pt-2 d-flex align-items-end">
                  		<p><%=people_num%></p>
               		</div>   
         		</div><!-- 신청 인원 end --> 
         		<div class="row d-flex justify-content-start mt-2">         
               		<div class="col-sm-3 d-flex align-items-end">
                  		<p class="lead">전화번호</p>   
               		</div>      
               		<div class="col-sm-9 pt-2 d-flex align-items-end">
                  		<p><%=phone_number%></p>
               		</div>   
         		</div><!-- 신청 인원 end -->  
         		<div class="row d-flex justify-content-start mt-2">         
               		<div class="col-sm-3 d-flex align-items-end">
                  		<p class="lead">내 번호</p>   
               		</div>      
               		<div class="col-sm-9 pt-1 d-flex align-items-end text-danger">
                  		<p><%=waiting_list.getWait_number()%>번 (최근호출 : <%=last_call%>)</p>
               		</div>   
         		</div><!-- 내 번호 end --> 
            </div><!-- class="pt-2 pb-2" end -->  
           	<!-- 버튼 -->
         	<div class="row justify-content-center pt-4">
            	<div class="col">
              		<a href="main.jsp" class="btn btn-depoon btn-lg btn-block" >메인으로</a>
           		</div>
           		<div class="col">
               		<a href="mypage.jsp" class="btn btn-depoon btn-lg btn-block" >마이페이지</a>
           		</div>
         	</div><!-- 버튼 end -->
       </div><!-- class="container col-4" end -->
	</div>
      
         
   
    <!-- 하단 -->   
   	<jsp:include page="../frame/bottom.jsp" flush="false"/>   

   	<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
   
<!-- jquery -->

 
      