<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<%String title="tablet_join";%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:include page="/_template/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>

 <style>
	.o_font_gr{
	   padding-top:35px;
	   font-size:10.0rem;
	}
	
	.back{
	    background-image: url("../../img/main_img5.jpg");
	    height: 775px;
	}
 
	#tablet-btn{
	   background-color: #FC5F4A;
	   border-color: #FC5F4A;
	   color:#FFFFFF;
	   font-size:4.0rem;	
	   height:30rem;	  
     }  
     #tablet-join{
       background-color: #FC5F4A;
       border-color: #FFFFFF;
	   color:#FFFFFF;
     } 
     
     #ck_gender{
     color:#FFFFFF;
     height:34px;
     }
     
     .row{
     height:600px;
     }
     
     body{
     padding-bottom:0;
     }
	     
 </style>
<body style="padding-bottm:0;">
 <div class="back"  style="background-repeat: no-repeat;background-size: cover;">
	<img style="width: 270px; height: 270px;" class="" src="../../img/white.png">
		<p class="text-center pt-1" style="font-size:2.0rem; margin-bottm:0; color:#ffffff">회원가입</p>
<div class="conatiner justify-content-center">   
<form action = "joinpro.jsp" method="post">
  <div class="row center" style="height:400px;"> 
      <div class="pt-4" style="padding-left: 500px; padding-right: 500px; width:1523px;"> 
             <div class=" text-center mb-3  mt-2 pt-2" > 
                    <input type="text" name="user_id" id="user_id" class="form-control pt-2 pb-2" placeholder="아이디" required>
             </div>
             <div class=" text-center mb-3" > 
                    <input type="password" name="passwd" id="passwd" class="form-control pt-2 pb-2" placeholder="비밀번호" required>
             </div>
             <div class=" text-center mb-3" >
                    <input type="password" name="passwd2" id="passwd2" class="form-control pt-2 pb-2" placeholder="비밀번호 확인" required>
             </div>
             <div class=" text-center mb-2" >
                    <input type="text" class="form-control pt-2 pb-2" id="phone_number" name="phone_number" placeholder="전화번호" required>
             </div>  
             <div class=" text-left mb-2" id="ck_gender"> 
           	   <label class="col-form-label pr-4">성별</label>          
                <label class="radio-inline">
                    <input type="radio" name="gender" value="여자" required> 여자
                </label>
                <label class="radio-inline">
                    <input type="radio" name="gender" value="남자" required> 남자
               </label>
            </div>
             <div class=" text-center mb-3">
             <input type="submit" id="tablet-join" class="btn btn-block pt-2 pb-2" style="border:;" value="대기 신청">    
             </div>
       </div>
   </div>   
   </form>   
</div>

</div>
</body>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>