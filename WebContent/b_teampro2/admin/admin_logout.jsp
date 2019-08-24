<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% session.invalidate(); %>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<script>
    swal("로그아웃 되었습니다.");
	location.href="admin_login.jsp";
</script>
        
        
 
