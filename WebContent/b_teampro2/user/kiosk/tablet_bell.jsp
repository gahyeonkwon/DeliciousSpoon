<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<%String title="tablet_bell";%>
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
<% 
String store_id = "mrpizza76";
UserSystemDBBean system = UserSystemDBBean.getInstance();  %>

<div class="back" style="background-repeat: no-repeat;background-size: cover;">
<p class="text-center" style="font-size:4.0rem; padding-top:5%;color:#ffffff"><%=system.getStore_name(store_id)%></p>
<div class="conatiner justify-content-center">   
  <div class="row center" style="padding:5%">
       <div class="col-6">
            <div>
            <div class="card text-center mr-4" style="height:30rem">
                 <div class="card-header" style="background-color:#FC5F4A;color:#ffffff">
                   <h1 class="card-title">대기팀</h5>
                 </div>
                 <div class="card-body center">
                   <p class="o_font_gr"><%=system.getCurrent_team(store_id)%></h5>
                 </div>
            </div>
         </div>   
      </div>
      <div class="col-6">
            <div>
            <div class="card text-center" style="height:30rem">
                 <div class="card-header"  style="background-color:#FC5F4A;color:#ffffff">
                   <h1 class="card-title">최근 호출</h5>
                 </div>
                 <div class="card-body center">
                   <p class="o_font_gr center" style="color:#FC5F4A;"><%=system.getLastcall(store_id) %></h5>
                 </div>
            </div>             
           </div>
      </div>
   </div>      
</div>

</div>

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>