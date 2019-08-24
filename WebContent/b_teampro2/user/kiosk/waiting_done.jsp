<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %>    
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>   
<%@ page import="b_teampro2.userinfo.UserWaitDataBean" %>   
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>   
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8");%>


	<!-- waiting_list 객체 생성 -->
	 <jsp:useBean id="waitList" class="b_teampro2.userinfo.UserWaitDataBean">
	     <jsp:setProperty name="waitList" property="*"/>
	 </jsp:useBean>

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

	
	response.sendRedirect("tablet_main.jsp");
	

	
 %>           

 
      