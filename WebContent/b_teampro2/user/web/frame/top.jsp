<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 
<%
   String user_id ="";
   try{
	  user_id = (String)session.getAttribute("user_id");
%>
<style>
a:hover {
  color: #ffffff;
  text-decoration: none;
}
</style>

<nav class="navbar navbar-expand-lg" style="background-color: #FC7765; color: white; text-decoration">
 <!-- <img src="../../../img/logo_white_lg.png" width="35" height="35" class="d-inline-block align-top" alt=""> -->
  <a class="navbar-brand ml-3" href="main.jsp">Delicious Spoon</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="../design/category.jsp?category=5">홈<span class="sr-only">(current)</span></a>
      </li>    
      <li class="nav-item active">
        <a class="nav-link" href="../design/category.jsp?category=5">카테고리<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="../design/search_done.jsp">검색<span class="sr-only">(current)</span></a>
      </li>      
      <%if(user_id==null||user_id.equals("")){ //해당사항없음. 마이페이지 뜨지않음. %>
 
    	<%}else{%>
         <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	<%=user_id%>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="../design/updatemember.jsp">개인정보수정</a>
          <a class="dropdown-item" href="../design/mypage.jsp">마이페이지</a>
        </div>
      </li> 	
    	
   <%}%>
     </ul>
  </div>
<%  	   if(user_id==null ||user_id.equals("")){
%>
    <form class="form-inline my-2 my-md-0">
    <a class="nav-link" href="/bban/b_teampro2/user/web/design/login.jsp" style="color:white;">로그인</a>
    |
    <a class="nav-link" href="join.jsp" style="color:white;">회원가입</a>
 </form>  
<%            
}else{
%>  
         <form class="form-inline my-2 my-md-0">
           <a class="nav-link" href="../control/logout.jsp" style="color:white;">로그아웃</a>
        </form>  

<% 
}
%> 
</nav>	
  <% 
	  
    }catch(Exception e){
		e.printStackTrace();
	}
%>