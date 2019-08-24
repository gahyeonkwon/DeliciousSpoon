<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<%request.setCharacterEncoding("utf-8");%>
<%
String title="tablet_waiting";
UserSystemDBBean system = UserSystemDBBean.getInstance();


%>

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
 
 <%	
 String store_id = request.getParameter("store_id");
 String user_id = (String)session.getAttribute("user_id");
 

 if(user_id==null||user_id.equals("")){ response.sendRedirect("tablet_main.jsp");}
 else{

	 UserinfoDBBean logon = UserinfoDBBean.getInstance();
	 int phone =  logon.selectMember(user_id).getPhone_number();
 %>
<body style="padding-bottm:0;">
 <div class="back"  style="background-repeat: no-repeat;background-size: cover;">
	<img style="width: 270px; height: 270px;" class="" src="../../img/white.png">
	<p class="text-center pt-1" style="font-size:2.0rem; margin-bottm:0; color:#ffffff"><%=system.getStore_name(store_id)%>에 오신 것을 환영합니다!</p>
    <p class="text-center pt-1" style="font-size:3.0rem; margin-bottm:0; color:#ffffff">현재 <%=system.getCurrent_team(store_id)%>팀 대기중</p>
    <p class="text-center mb-0" style="font-size:1.0rem; margin-bottm:0; color:#ffffff">고객님의 정보를 입력해주세요.</p>
<div class="conatiner justify-content-center">   
     <form action="waiting_done.jsp" method="post">
  <div class="row center" style="height:300px;"> 
      <div class="pt-3" style="padding-left: 500px; padding-right: 500px; width:1523px;"> 
            <div class=" text-center mb-3 mt-2 pt-2" >          
                    <input type="text" id="user_id" name="name" class="form-control pt-2 pb-2" placeholder="이름" required>
             </div>
       
                    <input type="hidden" name="store_id" value="<%=store_id %>">
                   <input type="hidden" name="user_id" value="<%=user_id %>">
             <div class=" text-center mb-3" > 
                        
                        <select id="mragin_gr" name="people_num" class="custom-select mb-1" required>
						  <option selected>인원</option>
						  <option value="1">1명</option>
						  <option value="2">2명</option>
						  <option value="3">3명</option>
						  <option value="4">4명</option>
						  <option value="5">5명</option>
						  <option value="6">6명</option>
						</select>                              
                                        
                    <!-- <input type="password" name="people" id="people" class="form-control pt-2 pb-2" placeholder="인원" required> -->
             </div>
             <div class=" text-center mb-3" >
                    <input type="text" class="form-control pt-2 pb-2" id="phone_number" name="phone_number" value="0<%=phone%>" placeholder="전화번호" required>
             </div>  
             <div class=" text-center mb-3">
             <input type="submit" id="tablet-join" class="btn btn-block pt-2 pb-2" value="대기하기">    
             </div>
            
       </div>
   </div>  
    </form>    
</div>

</div>
</body>
<%} %>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>