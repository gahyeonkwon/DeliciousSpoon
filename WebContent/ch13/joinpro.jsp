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
		<script>
		alert("Congratulations on your membership. Please login!");
		location.href="home.jsp";
	
		</script>
	  <%
%>


<% 
}else{
%>
	<script>
	  alert("There is a duplicate ID. Enter again.");
	  location.href="join.jsp";
	 </script>	
		
<% 	 

}

%>

