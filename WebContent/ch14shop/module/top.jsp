<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>

		
<%

String m_id = (String)session.getAttribute("id");
//스테디셀러 조회 - public List<ShopBookDataBean> getSteadySell()
ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
List<ShopBookDataBean> steadyList = bookProcess.getSteadySell();
 try{
   if(session.getAttribute("id")==null){%>
 	
<div class="pos-f-t">
  <div class="collapse" id="navbarToggleExternalContent">
    <div class="bg-dark p-4">
      <h4 class="text-white">이달의 책</h4><br>
      <!-- 여기에는 추천책목록 들어갈 것 -->
        <div class="row justify-content-center">
      <!-- 여기에는 추천책목록 들어갈 것 -->
	<%   if(steadyList!=null){
		   for (int i = 0 ; i < steadyList.size(); i++) {
		       ShopBookDataBean steady = steadyList.get(i);%>
		        <div class="col">
		        <p class="text-white">Best<%=i+1%></p>
				<img src="../../imageFile/<%=steady.getBook_image()%>" style="width:80; height:100;">
				</div>

	
	<%}}%>
		</div>     
      <span class="text-muted">회원가입후 더 많은 혜택을 받아가세요 !</span>
    </div>
  </div>
  <nav class="navbar navbar-dark bg-dark">
    <a href="shopMain.jsp"> <span class="navbar-brand mb-0 h1">ZIGOBOOKS</span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
    <i class="fas fa-thumbs-up"></i> &nbsp;&nbsp;PICK!
    </button>
    <form class="form-inline my-2 my-lg-0" name="inform" method="post" action="loginPro.jsp">
      <input class="form-control mr-sm-2" type="text" name="id" placeholder="Id" data-toggle="popover" data-placement="bottom" data-content="로그인 후 이용해주세용!">
      <input class="form-control mr-sm-2" type="password" name="passwd" placeholder="PW">    
      <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">Login</button>
    </form>
  </nav>
</div>      

  
 <%}else{%>
<div class="pos-f-t">
  <div class="collapse" id="navbarToggleExternalContent">
    <div class="bg-dark p-4">
      <h4 class="text-white">이달의 책</h4>
      			<div class="row justify-content-center">
      <!-- 여기에는 추천책목록 들어갈 것 -->
	<%   if(steadyList!=null){
		   for (int i = 0 ; i < steadyList.size(); i++) {
		       ShopBookDataBean steady = steadyList.get(i);%>
		        <div class="col">
		        <p class="text-white">Best<%=i+1%></p>
				<img src="../../imageFile/<%=steady.getBook_image()%>" style="width:80; height:100;">
				</div>

	
	<%}}%>
		</div>
     <span class="text-muted"><%=session.getAttribute("id")%>님 환영합니다.</span>
    </div>
  </div>
  <nav class="navbar navbar-dark bg-dark"> 
    <a href="shopMain.jsp"> <span class="navbar-brand mb-0 h1">ZIGOBOOKS</span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
    <i class="fas fa-thumbs-up"></i> &nbsp;&nbsp;PICK!
    </button>
			<a class="nav-item btn btn-dark btn-sm" href="../shopping/cartList.jsp?book_kind=all">장바구니보기<i class="fas fa-shopping-cart"></i></a> 			
			<a class="nav-item btn btn-dark btn-sm" href="../shopping/buyList.jsp">구매목록보기<i class="fas fa-shopping-cart"></i></a> 	 
     	 	<a class="nav-item btn btn-dark btn-sm" href="../shopping/list.jsp?book_kind=all">책 목록<i class="fas fa-book"></i></a>       
 	<button class="btn btn-dark my-2 my-sm-0 btn-sm" type="button" onclick="javascript:window.location='../shopping/logout.jsp'" >로그아웃</button>

  </nav>
</div>    

 <%}
 }catch(NullPointerException e){
	 e.printStackTrace();
 }
 %>
   

