<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean" %>
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>
<% request.setCharacterEncoding("utf-8");%>
<%String title="회원정보수정";%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>

  <jsp:include page="../frame/top.jsp" flush="false"/>  
<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserinfoDBBean logon = UserinfoDBBean.getInstance();  
	
	UserinfoDataBean user = null;
	user=logon.selectMember(user_id);

	if(user_id!=null||user_id.equals("")){
%>  
<form method="post" class="form-horizontal" action="../control/updatemember_pro.jsp" enctype="multipart/form-data">
      <div align="center"> 
      <div class="form-group justify-content-center mt-4 mb-3 ml-10">        
      <div class="w3-display-middle-top">
			<a class ="pull-left">
			  <%if(user.getUser_photo().equals("profile.jpg")){ %>
				<img class="rounded-circle" src="../../../img/profile.jpg" name="user_photo" id="photo" style="width:120px; height:120px;">		 
			  <%}else{ %> 
				<img class="rounded-circle" src="/bban/imageFile/<%=user.getUser_photo()%>" id="photo" style="width:120px; height:120px;"> 	
			  <%} %> 
				<div style="padding-left: 10rem;"><span id="edit"><i class="fas fa-camera mb-1" style="color:#5D5D5D;"></i> </span></div>
				<span class="user_photo"><input type="file" name="user_photo" id="user_photo"></span>
			</a>      
      </div>     
      </div>    
     </div>      
     <div class="container">     
            <div class="input-group input-group-lg">         
              <input name="user_id" id="mragin_gr" type="text" class="form-control" placeholder="아이디" readonly="readonly" value="<%=user.getUser_id()%>" required>       
            </div> 
            
            <div class="input-group input-group-lg mt-3">     
              <input name="passwd" id="mragin_gr" type="password" class="form-control"  placeholder="비밀번호를 입력하세요." required>
            </div>  
            <div class="input-group input-group-lg">   
              <input name="passwd2" id="mragin_gr" type="password" class="form-control" placeholder="비밀번호를 한 번 더 입력하세요." required>
                <div class="margin_sy mt-1">
                  <span id="pwdconfmsg" class="detail_sy"></span>
               </div>
            </div>               
               
          
         <div class="container">    
            <div class="input-group input-group-lg mt-3">   
              <input id="mragin_gr" type="text" class="form-control"  value="0<%=user.getPhone_number()%>" name="phone_number" placeholder="변경할 휴대폰번호를 입력하세요." required>
              <div class="margin_sy mt-1">
                 <span name ="phonecheck" class="detail_sy">올바른 번호를 입력하세요.</span>
                 </div>
            </div>  
         </div>
         <div class="container">   
            <div class="row  mt-3">      
                  <p class="c_text align-middle" style="margin-left:32px; margin-right:16px; margin-top: 18px;">성별</p>   
                  <div class="btn-group btn-group-toggle" style="padding-top:10px; padding-bottom:10px;" data-toggle="buttons">
                 <label class="btn btn-lg btn-outline-secondary<%if(user.getGender().contains("여자")){out.print(" active focus");}%>">
                   <input type="radio" style="border-color: #dee2e6;" class="c_text" id="option1" name="gender" autocomplete="off" value="여자">여자
                 </label>
                 <label class="btn btn-lg btn-outline-secondary<%if(user.getGender().contains("남자")){out.print(" active focus");}%>">
                   <input type="radio" style="border-color: #dee2e6;" class="c_text" id="option2" name="gender" autocomplete="off" value="남자">남자
                 </label> 
               </div>  
            </div>
         </div>    
                     
      <div class="container"> 
        <button id="mragin_gr" type="submit" class="btn-lg btn-depoon btn btn-block mt-4 mb-4" ">정보수정완료</button>              
      </div>
	</div>
</form>
<%}else{
 %>
 
<% response.sendRedirect("../control/error.jsp");}%>
<jsp:include page="../frame/bottom.jsp" flush="false"/>      
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<script>
$(document).ready(function() {	
	$("#user_photo").hide();
	$("[name=phonecheck]").hide();
	//프로필 사진 변경 
	  $("#edit").on('click',function(){  
		 $("#user_photo").click();
	});//click end
	
    $("[name=passwd2]").blur(function(){
        var pwd1 = $("[name=passwd]").val();
        var pwd2 = $("[name=passwd2]").val(); 
        $('#pwdcofmsg').hide();
         if(pwd1===pwd2&&pwd1!=""&&pwd2!=""){                       
            $('#pwdconfmsg').text('비밀번호가 동일합니다');
            $('#pwdconfmsg').css('color','green');
            $('#pwdconfmsg').show();
        }else{
                if(pwd1==""){   $('#pwdconfmsg').text('비밀번호를 입력바랍니다.');
                                $('#pwdconfmsg').show();
                                $("[name=passwd2]").val("");
                                $("[name=passwd2]").focus();
                                return;
                            }
             $('#pwdconfmsg').text('비밀번호가 일치하지 않습니다');
             $('#pwdconfmsg').css('color','red');
             $('#pwdconfmsg').show();
             $("[name=passwd2]").val("");
             //$("#passwd2").focus();

        }

     });//end blur  
     
    $('[name=phone_number]').blur(function(){   
   	 
        var re_phone = /[01](0|1|6|7|8|9)(\d{4}|\d{3})\d{4}$/g;  

        var txt = $('[name=phone_number]').val();
        if(txt.length!=11){
        	$("[name=phonecheck]").show();
        	$("[name=phone_number]").val("");
            $("[name=phone_number]").focus();   
        	return false;}
     	if(re_phone.test(txt)){  
        	$("[name=phonecheck]").hide();    //true 반환 하면 	  실행                  
         }else{
        	 $('[name=phonecheck]').css('color','green');
     		$("[name=phonecheck]").show();
            $("[name=phone_number]").val("");
            $("[name=phone_number]").focus();    
         }
         	});//end blur
    
});
</script>
<script>

var upload = document.getElementById('user_photo'),
    holder = document.getElementById('photo');

	upload.onchange = function (e) {
  e.preventDefault();

  var file = upload.files[0],
      reader = new FileReader();
  	reader.onload = function (event) {
    var img = new Image();
   img.src = event.target.result;
 
    holder.appendChild(img); 
 	var source = img.src;
    $('#photo').attr('src', source);    
  };
  reader.readAsDataURL(file);

  return false;
};
</script>
 

   