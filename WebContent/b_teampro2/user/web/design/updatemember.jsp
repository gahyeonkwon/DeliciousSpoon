<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.userinfo.UserinfoDBBean" %>
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>

<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "개인정보수정";
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<!-- 상단 메뉴 -->
<jsp:include page="../frame/top.jsp" flush="false"/>
   
<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserinfoDBBean logon = UserinfoDBBean.getInstance();  
	
	UserinfoDataBean user = null;
	user=logon.selectMember(user_id);

	if(user_id!=null||user_id.equals("")){
	%>

<div class="container">
	
	<p class="h3 pt-5 pb-3">회원정보 수정</p>
	<form method="post" class="form-horizontal" action="../control/updatemember_pro.jsp" enctype="multipart/form-data">
	<div class="align-items-end mb-4"> 
	<%if(user.getUser_photo().equals("profile.jpg")){ %>
			<img class="rounded-circle" src="../../../img/profile.jpg" name="user_photo" id="photo" style="width:10rem; height:10rem;">		 
		<%}else{ %> 
			<img class="rounded-circle" src="/bban/imageFile/<%=user.getUser_photo()%>" id="photo" style="width:10rem; height:10rem;"> 	
		<%} %> 
		<div style="padding-left: 12rem;"><span id="edit"><i class="fas fa-camera"></i></span></div>
		
		<span class="user_photo"><input type="file" name="user_photo" id="user_photo"></span>
	</div>	      
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="text" name="id" class="form-control"  readonly="readonly" value="<%=user.getUser_id()%>" required>
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="password" id="passwd_old" name="passwd_old" class="form-control" placeholder="기존비밀번호를 입력하세요.">               
            </div>
        </div>   
        <div class="form-group row pt-2 justify-content-center">
       	 <span id="passwdcheck" style="color:red;">비밀번호가 일치하지 않습니다. 다시 입력해주세요.</span>
       	 <span id="passwdcheck2" style="color:green;">비밀번호가 일치합니다.정보수정이 가능합니다.</span>
        </div>    
        <div class="form-group row justify-content-center">
            <div class="col-sm-4 col-sm-offset-3">
                <button type="button" id="passwd_button" class="btn btn-depoon btn-block">비밀번호확인</button>
         </div>  
        </div>            
       <div id="update">        
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="password" id="passwd" name="passwd" class="form-control" placeholder="새로운 비밀번호를 입력하세요." required>
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="password" id="passwd2" class="form-control" placeholder="새로운 비밀번호를 한번더 입력하세요." required>
            </div>
        </div>
        <div class="mb-3">
           <span id="pwdconfmsg"></span>
        </div>       
         <div class="row justify-content-md-center pb-3">
            <label class="col-sm-1 col-form-label text-left">성별</label>
            <div class="col-sm-3 pt-2 text-right">
                <label class="radio-inline">
                    <input type="radio" <%if(user.getGender().contains("여자")){out.print(" checked=\"chekced\"");}%> name="gender" value="여자" > 여자
                </label>
                <label class="radio-inline">
                    <input type="radio" <%if(user.getGender().contains("남자")){out.print(" checked=\"chekced\"");}%> name="gender" value="남자"> 남자
                </label>
            </div>
        </div>

        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="text" class="form-control" value="0<%=user.getPhone_number()%>" name="phone_number" placeholder="변경할 휴대폰번호를 입력하세요." required>
                
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-4 col-sm-offset-3">
                <input type="submit" class="btn btn-depoon btn-block" value="정보 수정 완료">
            </div>
        </div>
     </div><!-- 여기까지 비밀번호가 동일하면 출력되는부분 --> 
    </form>  
</div>
<jsp:include page="../frame/bottom.jsp" flush="false"/>   

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<%}else{
 %>
 
<% response.sendRedirect("../control/error.jsp");}%>
<!-- <script>
$(document).ready(function() {
	
	  $("#edit").on('click',function(){  
		 $("#user_photo").click();
	});

});

</script>   -->
<script>
$(document).ready(function() {
	$("#update").hide();
	$("#passwdcheck").hide();	
	$("#passwdcheck2").hide();
	$("#edit").hide();
	$("#user_photo").prop('disabled',true);
	
$('#passwd_button').click(function(){
	// ajax 실행
	var passwd_old = $('#passwd_old').val();
	$.ajax({
	    type : 'POST',
	    url : '../control/check_passwd.jsp',
	    data: "passwd_old="+passwd_old,    
	    cache: false,
	    dataType:"text",
	    success : function(data) {
	        //console.log(data); 
	   		     			                 
	        if(data.match(/-1/)!=null){//true면  패스워드같음
	        	//update
	        	$("#update").show();
	        	$("#passwdcheck").hide();	
	        	$("#passwdcheck2").show();	 
	        	$("#user_photo").prop('disabled',false);
	        	$("#edit").show();	
	        	$("#passwd_button").hide();
	        	$('#passwd_old').prop('readonly','readonly');
	        }
	        else if(data.match(/1/)!=null){
	 		
	 			$("#passwdcheck").show();	//비밀번호가 일치 하지 않습니다. 비밀번호를 올바르게 입력해주세요
	 			$("#update").hide();	
	 			$("#passwdcheck2").hide();
	        }
	   
	    }
		}); // end ajax	 
	});// end click
	
	//프로필 사진 변경 
	  $("#edit").on('click',function(){  
		 $("#user_photo").click();
	});//click end
	
    $("#passwd2").blur(function(){
        var pwd1 = $("#passwd").val();
        var pwd2 = $("#passwd2").val(); 
        $('#pwdcofmsg').hide();
         if(pwd1===pwd2&&pwd1!=""&&pwd2!=""){                       
            $('#pwdconfmsg').text('비밀번호가 동일합니다');
            $('#pwdconfmsg').css('color','green');
            $('#pwdconfmsg').show();
        }else{
                if(pwd1==""){   $('#pwdconfmsg').text('비밀번호를 입력바랍니다.');
                				$('#pwdconfmsg').css('color','red');
                                $('#pwdconfmsg').show();
                                $("passwd2").val("");
                                $("passwd").focus();
                                return;
                            }
             $('#pwdconfmsg').text('비밀번호가 일치하지 않습니다');
             $('#pwdconfmsg').css('color','red');
             $('#pwdconfmsg').show();
             $("#passwd2").val("");
             $("#passwd2").focus();

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
 
