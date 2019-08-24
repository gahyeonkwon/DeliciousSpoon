<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String title="마스터로그인";%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:include page="/_template/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
<div class="mt-5">
<img src="../img/logo_naming.png" width=200 height=200 class="mt-5">
</div>
<div class="container">
   <p class="h3 pt-3 pb-3">시스템 관리자 로그인</p>
    <form method="post" class="form-horizontal" action="sysadmin_login_pro.jsp">
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="text" name="master_id" class="form-control" placeholder="아이디를 입력하세요">
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="password" name="master_passwd" class="form-control" placeholder="비밀번호를 입력하세요">
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-4 col-sm-offset-3">
                <input type="submit" class="btn btn-block" value="Login">
            </div>
        </div>
    </form>  
</div>

 <br><br><br><br><br><br><br><br><br><br>
<jsp:include page="sysadmin_bottom.jsp" flush="false"/>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>