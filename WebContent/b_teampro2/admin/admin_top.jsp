<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.userinfo.*" %>  
<%@ page import="b_teampro2.storeinfo.*" %> 
 
    <% String store_id = (String)session.getAttribute("store_id");%>
 

<!-- 상단 네비 -->
<%
	StoreinfoDBBean system = StoreinfoDBBean.getInstance();	
	int open_close = system.getOpen_close(store_id);
    UserSystemDBBean log = UserSystemDBBean.getInstance();
	
	%>
		
	    <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 bg-white border-bottom">
	    <input type="hidden" value="<%=store_id%>" id="s">
	    <input type="hidden" value="<%=open_close%>" id="o">
	    	<img src="../img/logo_sm.png" alt="logo" style="width:30px; height:30px;">
	      	<h5 class="ml-md-3 my-0 mr-md-auto font-weight-bold">Delicious Spoon 관리자 페이지</h5>
	      	<nav class="my-2 my-md-0 mr-md-3">	
			<%if(open_close==1){ %>
						<button name="btn" type="button" class="btn mr-3 btn-depoon">대기가능</button>
			<%}else{ %>
						<button name="btn" type="button" class="btn mr-3 btn-secondary">대기불가</button>
			<%} %>
	      	<%=log.getStore_name(store_id)%>님  반갑습니다! 
	        	<a class="p-2 " href="admin_logout.jsp" style="text-decoration:none; color: black;">로그아웃</a>
	      	</nav>
	    </div> 
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script>
$(document).ready(function(){
	$('[name=btn]').click(function(){  		
	            var store_id = $('#s').val();
	            var open_close = $('#o').val();        
	      			console.log(store_id);
	            // ajax 실행
	            $.ajax({
	                type : 'POST',
	                url : 'check2.jsp',
	                data:{                 
	                   store_id : store_id,
	                   open_close : open_close	                   
	                },
	                cache: false,
	                dataType:"text",
	                success : 
	                	function(){             
	                	console.log("yes"); 
	                	location.reload();                	
	                }
	            }); // end ajax
           });

});
</script>    

		