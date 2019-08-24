<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

	<%
		request.setCharacterEncoding("utf-8");
		String title = "회원가입완료";
	%>
 
 	<jsp:include page="/_template/header.inc_m.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

	 <jsp:useBean id="user_data" class="b_teampro2.userinfo.UserinfoDataBean">
	     <jsp:setProperty name="user_data" property="*"/>
	 </jsp:useBean>
 
<%
	UserinfoDBBean logon = UserinfoDBBean.getInstance();  
	logon.insertMember(user_data); 
 
 %>
 
 <%--위치 다시 --%>
<jsp:include page="../frame/top.jsp" flush="false"/> 
      <div align="center"> 
           <img src="../../../img/logo_red.png" class="d-flex justify-content-center mt-4 mb-2" style="width: 35%; height: 70%;">          
     </div>
      <div class="container d-flex justify-content-center">
         <form method="post" class="d-flex justify-content-center mt-4 mb-2" action="../design/mobile_main.jsp">
               <div class="container d-flex justify-content-center">   
                     <p class="c_text margin_sy">회원가입이 완료되었습니다!</p>
                  <input type="submit" id="mragin_gr" class="btn-lg btn-depoon btn btn-block" value="메인으로">           
            </div>               
         </form>
      </div>

<jsp:include page="../frame/bottom.jsp" flush="false"/>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>