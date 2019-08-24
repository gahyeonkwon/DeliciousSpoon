<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "회원가입";
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<!-- 상단 메뉴 -->

<jsp:include page="../frame/top.jsp" flush="false"/>  

<!-- main content --> 
  <div class="pt-5">
	<img src="../../../img/logo_naming.png"  style="width: 200px;heigth: 200px;">
  </div>
<div class="container">
	<p class="h3 pb-3">회원가입</p>
    <form method="post" class="form-horizontal" action="../control/joinpro.jsp">
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="text" id="user_id" name="user_id" class="form-control" placeholder="아이디를 입력하세요" required>
            </div>
        </div>
        <div class="form-group row justify-content-center">
        <span id="idcheck1">아이디는 영어와 숫자를 혼합하여 6자 이상입력하세요</span>
        <span id="user_ok" style="color:green;">가입 가능한 아이디입니다.</span>
        <span id="user_no" style="color:red;">중복된 아이디 입니다.다른아이디를 입력해주세요.</span>
        </div>
        <div class="form-group row justify-content-center mt-4">
            <div class="col-sm-4">
                <input type="password" name="passwd" id="passwd" class="form-control" placeholder="비밀번호를 입력하세요" required>
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-4">
                <input type="password" name="passwd2" id="passwd2" class="form-control" placeholder="비밀번호와 동일하게 입력하세요" required>
            </div>
        </div>
        <div class="mb-2">
        <span id="pwdconfmsg" class="mb-2 mt-1"></span>
        </div>
         <div class="row d-flex justify-content-md-center pb-3 mt-5">
            <label class="col-sm-1 col-form-label text-left">성별</label>
            <div class="col-sm-3 pt-2 text-right pt-2">
                <label class="radio-inline">
                    <input type="radio" name="gender" value="여자" required> 여자
                </label>
                <label class="radio-inline">
                    <input type="radio" name="gender" value="남자" required> 남자
                </label>
            </div>
        </div>
        <!-- <div class="row justify-content-md-center pb-3">
            <label class="col col-lg-1">연령대</label>
            <div class="col-sm-4">
                <label class="radio-inline">
                    <input type="radio" name="age" value="10" required>10대
                </label>
                <label class="radio-inline">
                    <input type="radio" name="age" value="20" required>20대
                </label>
                <label class="radio-inline">
                    <input type="radio" name="age" value="30" required>30대
                </label>
                <label class="radio-inline">
                    <input type="radio" name="age" value="40" required>40대
                </label>
                <label class="radio-inline">
                    <input type="radio" name="age" value="50" required>50대 이상
                </label>
            </div>
        </div> -->
        <div class="form-group row justify-content-center mt-3">
            <div class="col-sm-4">
                <input type="text" class="form-control" id="phone_number" name="phone_number" placeholder="핸드폰 번호를 입력해주세요" required>
            </div>
        </div>
        <div class="mb-2">
        <span id ="phonecheck" style="color:red;">올바른번호를 입력하세요.</span>
        </div>

		<div class="form-group pr-4 mt-5">
			<div class="row">
				<div class="col-3 offset-4">Delicious Spoon 이용약관 동의</div>
				<div class="col-2">
					<input class="form-check-input" type="checkbox" name="consent" value="option1" required>
				</div>
			</div>
		</div>
		<div class="form-group pr-4">
			<div class="row">
				<div class="col-3 offset-4">개인정보 수집 및 이용안내 동의</div>
				<div class="col-2">
					<input class="form-check-input" type="checkbox" name="consent" value="option1" required>
				</div>
			</div>
		</div>
		<div class="form-group pr-4 mt-2">
			<div class="row">
				<div class="col-3 offset-4">
					<p class="h3 pt-2">모두 선택</p>
				</div>
				<div class="col-2 pt-2">
					<input class="form-check-input" type="checkbox" name="consents" value="option1">
				</div>
			</div>
		</div>
		
        <div class="form-group row justify-content-center">
            <div class="col-sm-4 col-sm-offset-3">
                <input type="submit" id="join" class="btn btn-depoon btn-block" value="회원가입">
            </div>
        </div>
        <input type="hidden" id="tr" value="-1">
    </form>  
</div>
<jsp:include page="../frame/bottom.jsp" flush="false"/>   

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQUERY -->
<!-- id 중복 체크 코드 -->
<script>

$(document).ready(function(){
	$("#user_no").hide();	                       
	$("#user_ok").hide();
	$("#user_id").focus();
	$("#idcheck1").hide();
	$("#idcheck2").hide();	
	$("#phonecheck").hide();  	
	
    $('#user_id').blur(function(){  	
        if ( $('#user_id').val().length > 6) {

            var user_id = $('#user_id').val();
            // ajax 실행
            $.ajax({
                type : 'POST',
                url : '../control/check_id.jsp',
                data:{
                   user_id : user_id
                },
                cache: false,
                dataType:"text",
                success : function(data) {
                  /*  console.log(data); */
                  			                 
                    if(data.match(/-1/)!=null){//true면 가입가능
                		$("#idcheck1").hide();
                    	$("#user_ok").show();
                    	$("#user_no").hide();
                    	$("#user_id").css('background-color','#E4F7BA'); 
                   	
                    	$("#passwd").focus();
                    }
                    else if(data.match(/1/)!=null){
                		$("#idcheck1").hide();
                    	$("#user_ok").hide();
                    	$("#user_no").show();
                    	$("#user_id").css('background-color','#FFD8D8'); 
               
                    	$("#user_id").focus();
                    }else{
                    	$("#user_id").css('background-color','#F4F4F4');
                    }
               
                }
            }); // end ajax
                     
        }else{
        
    		$("#idcheck1").show();       	
        	$('#user_id').val("");
        	$('#user_id').focus(""); 
        	$("#user_no").hide();	                       
        	$("#user_ok").hide();
        	
        }
        
        var re_id = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
        var txt = $('#user_id').val();
     if(re_id.test(txt)){
    		$("#idcheck1").show();
            $("#user_id").val("");
            $("#user_id").focus();    
        	$("#user_no").hide();	                       
        	$("#user_ok").hide();
         }
    
    }); // end blur
    
    //비밀번호가 동일한지 값을 체크 
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
   
    //전화번호가 숫자인치 체크
     $("#phone_number").blur(function(){   
    	 
    var re_phone = /[01](0|1|6|7|8|9)(\d{4}|\d{3})\d{4}$/g;  

    var txt = $('#phone_number').val();
    if(txt.length!=11){ $("#phonecheck").show();
    $("#phone_number").val("");; return false;}
 	if(re_phone.test(txt)){  
    	$("#phonecheck").hide();    	                   
     }else{
 		$("#phonecheck").show();
        $("#phone_number").val("");
        $("#phone_number").focus();    
     }
     	});//end keyup

    

    
});
</script>
<script>

/* 체크박스 체크시 전체선택 체크 여부 */
$('[name=consents]').click(function(){
		if($('[name=consents]').is(':checked')){
 $('[name=consent]').prop('checked',true);
}else{
 $('[name=consent]').prop('checked',false);
}

});


$('[name=consent]').click(function(){
		if($('input[name=consent]:checked').length==3){
 		$('[name=consents]').prop('checked',true);
}else{
 $('[name=consents]').prop('checked',false);
}

});
</script>




