<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<%
   String user_id ="";
   try{
	  user_id = (String)session.getAttribute("user_id");
%>  
   <!-- nav-->
   <div class="navbar navbar_b">
        <div class="container d-flex justify-content-between">
          <a href="../design/mobile_main.jsp">
          <img src="../../../img/logo_white_lg.png" width="200px" alt="logo">
          </a>
<%  	   
	if(user_id==null ||user_id.equals("")){
%>
		<form>
          <a href="../design/mobile_login.jsp">
          <i id="user_circle" class="fas fa-user-circle"></i>
          </a>
        </form>
<%  }else{%>
		<form>
          <a href="../design/mobile_mypage.jsp?user_id=<%=user_id%>" style="width: 2.3rem; height: 2.3rem;">
          <i id="user_circle" class="fas fa-user-circle"></i>
          </a>
        </form>
<% }%>           
        </div>
      </div>
<% 
    }catch(Exception e){
		e.printStackTrace();
	}
%>