<%@ page language="java" contentType="text/html; charsetUTF-8"
    pageEncoding="UTF-8"%>

<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "로그인";
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<%
   String user_id ="";
   try{
	  user_id = (String)session.getAttribute("user_id");
	  String url = request.getHeader("referer");

%>

<!-- 상단 메뉴 -->
	<jsp:include page="../frame/top.jsp" flush="false"/>	
	
<%  	   if(user_id==null ||user_id.equals("")){
%>
	
<!-- main content -->
  <div class="pt-5">
	<img src="../../../img/logo_naming.png" style="width: 200px;heigth: 200px;">
  </div>	
	<div class="container">
		<p class="h3">로그인</p><br>
		<div class="row justify-content-center">
			<div class="col-md-4">
				<input type="hidden" id="re" value="<%=url %>">			
					  <div class="form-group">
					    <input type="text" class="form-control" name="user_id"  placeholder="아이디">
					  </div>
					  <div class="form-group">
					    <input type="password" class="form-control" name="passwd" placeholder="비밀번호">
					  </div>				  
				  <button type="button" class="btn btn-depoon btn-lg btn-block login" >로그인</button>
				  <div class="row justify-content-end align-items-center">
  				  <a class="nav-link text-right mt-2" href="#" style="color:black;">아이디/비밀번호찾기</a>
  				  <p class="pt-2">|</p>
				  <a class="nav-link text-right mt-2" href="join.jsp" style="color:black;">회원가입</a>
				  </div>
				
			</div>
		</div>
	</div>
    
 <%            
}else{
%>  
     
<script>
	location.href="../control/error.jsp";
</script>    

<% 
}
%> 
  <% 
	  
    }catch(Exception e){
		e.printStackTrace();
	}
%>	   
	<jsp:include page="../frame/bottom.jsp" flush="false"/>	

	<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
	
<!-- jquery -->


<script>
$('.login').click(function(){     
     var url = $('#re').val();
      var user_id = $('[name=user_id]').val();
      var passwd = $('[name=passwd]').val();
   $.ajax({
   
       type : 'POST',
       url : '../control/loginpro.jsp',
       data:{
         user_id :user_id,
         passwd : passwd
       },
       cache: false,
       dataType:"text",
       success : 
          function(data){    
    	  
    	   if(data.match(/-1/)!=null){
    		   location.href=url;   
    		   if(url=="http://localhost:8080/bban/b_teampro2/user/web/control/error.jsp"){
    			   location.href='mypage.jsp';
    		   }
    	   }else{
    		   swal("아이디나 비밀번호가 맞지 않습니다.");
    			 return false;
    	   } 
             
       }
      }); // end ajax
});
</script>