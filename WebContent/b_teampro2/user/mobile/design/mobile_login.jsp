<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%String title="로그인";%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>

<%
   String user_id ="";
   try{
	  user_id = (String)session.getAttribute("user_id");
	  String url = request.getHeader("referer");
%>

  <jsp:include page="../frame/top.jsp" flush="false"/> 
  
  <%  	   
  	if(user_id==null ||user_id.equals("")){
  %>
  <input type="hidden" id="re" value="<%=url %>">		
      <div align="center"> 
		<img src="../../../img/logo_red.png" class="mt-5 mb-5"  style="width:150px; height:150px;"/>			 		 	 
	  </div>
	   	
		  <div class="container">	  
			   <div class="input-group input-group-lg">	   	
			     <input id="mragin_gr" type="text" class="form-control" name="user_id" placeholder="아이디">
			   </div>  
			   <div class="input-group input-group-lg">	  
			     <input id="mragin_gr" type="password" class="form-control" name="passwd" placeholder="비밀번호">
			   </div>  
			   
			   <div class="container mt-5" id="btn1">
			      <div class="col-6" style="padding-left:0px; padding-right:8px"> 
				  	<button type="button" class="btn btn-depoon btn-lg btn-block login">로그인</button>
				  </div>
				  <div class="col-6" style="padding-left:8px; padding-right:0px"> 
				  	<a class="btn-lg btn-depoon btn btn-block" href="mobile_join.jsp">회원가입</a>
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

<%

   try{
	  user_id = (String)session.getAttribute("user_id");
%>    
    
    <footer class="fixed-bottom container-content-center mt-4" id="footer">	
   	   <div align="center">  
           <p class="pt-2">개인정보 보호 정책 | 이용약관 </p>
<%  	   
	if(user_id==null ||user_id.equals("")){
%>           
		<form>
           <a href="../design/mobile_login.jsp" class="pr-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">로그인</a>
           
           <a href="../design/mobile_join.jsp" class="pl-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">회원가입</a>
		</form>
<%             
}else{
%>		
		<form>           
           <a href="../control/logout.jsp" id="footer_btn" style="text-decoration:none; color: #2478FF;">로그아웃</a>
        </form>
<% 
}
%>  
           <p class="pb-2">&copy; 2017-2018 Company, Inc. &middot;</p>
      	</div> 
        <div class="fixed-bottom" style="margin-bottom: 50px; margin-right: 10px;">
        </div> 
       
   </footer>
   <br>
<% 
	  
    }catch(Exception e){
		e.printStackTrace();
	}
%>  	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- jquery -->


<script>
$('.login').click(function(){     
     var url = $('#re').val();
      var user_id = $('[name=user_id]').val();
      var passwd = $('[name=passwd]').val();
   $.ajax({
   
       type : 'POST',
       url : '../control/login_pro.jsp',
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
    	   }else{
    		   swal("아이디나 비밀번호가 맞지 않습니다.");
    			 return false;
    	   }  
             
       }
      }); // end ajax
});
</script>

	