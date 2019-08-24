<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<% String master_id=(String)session.getAttribute("master_id"); %>
<% String title = request.getParameter("title"); %>
<!-- 상단 네비 -->
    <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 bg-white border-bottom">
    	<img src="../img/logo_sm.png" alt="logo">
      	<h5 class="ml-md-3 my-0 mr-md-auto font-weight-normal">Delicious Spoon 시스템 관리자 페이지</h5>
      	<nav class="my-2 my-md-0 mr-md-3">
      	<%if(master_id==null||master_id.equals("")){ 
      		response.sendRedirect("sysadmin_error.jsp");
		}else{%>
        	<a class="p-2 text-dark" href="sysadmin_logout.jsp">로그아웃</a>
        <%} %>	
      	</nav>
    </div>
  
<!-- 왼쪽 메뉴 -->	 
    <div class="container-fluid">
 	  <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky text-left">
            <ul class="nav flex-column"><br>
              <li class="nav-item">
             
                <a class="nav-link" href="sysadmin_store.jsp" style="color: black;">
                  <i class="fas fa-store-alt"></i> 대기 신청 매장 확인
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="sysadmin_reject.jsp" style="color: black;">
                  <i class="fas fa-store-alt"></i> 거절 된 매장 확인
                </a>
              </li> 
            </ul>
          </div>
        </nav> 
 
               
