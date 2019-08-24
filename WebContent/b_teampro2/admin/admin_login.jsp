<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
request.setCharacterEncoding("utf-8");
String title = "관리자로그인";
%>

<jsp:include page="/_template/header.inc.jsp" flush="false">
 <jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<%--위치 다시 --%>
 <br><br><br><br><br><br><br><br><br><br>
<img src="../img/logo_md.png">
<div class="container">
	<p class="h3 pt-5 pb-3">관리자 로그인</p>
    <form method="post" class="form-horizontal" action="admin_login_pro.jsp">
        <div class="form-group row justify-content-center">
            <div class="col-sm-5">
                <input type="text" id="store_id" name="store_id" class="form-control" placeholder="아이디를 입력하세요">
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-5">
                <input type="password" id="store_passwd" name="store_passwd" class="form-control" placeholder="비밀번호를 입력하세요">
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-5 col-sm-offset-3">
                <input type="submit" class="btn btn-light btn-block" value="Login">
            </div>
        </div>
    </form>  
    <div class="col-sm-10 offset-sm-3">
    	<a href="admin_join.jsp">회원가입</a>
    </div>
</div>

<jsp:include page="admin_bottom.jsp" flush="false"/>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>