<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="ch12.member.LogonDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

 <jsp:useBean id="member" class="ch12.member.LogonDataBean">
     <jsp:setProperty name="member" property="*"/>
 </jsp:useBean>
 
<%
  member.setReg_date(new Timestamp(System.currentTimeMillis()) );
  LogonDBBean logon = LogonDBBean.getInstance();  
 
  int x=logon.idCheck(member);
   
  if(x==-1){
	  logon.insertMember(member); 

%>

<jsp:getProperty name="member" property="id" />님 회원가입을 축하합니다.

<% 
}else{
%>
	<script>
	  alert("중복된아이디가 있습니다. 다시 입력해주세요");
	  history.go(-1);
	</script>		
<% 	 
}
%>

