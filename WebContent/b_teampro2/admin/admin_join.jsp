<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%
		request.setCharacterEncoding("utf-8");
		String title = "관리자회원가입";
	%>

	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<img src="../img/logo_md.png">
<div class="container">
   <p class="h3 pt-5 pb-3">관리자 회원가입</p>
    <form method="post" class="form-horizontal" action="admin_join_done.jsp">
        <div class="form-group row justify-content-center">
            <div class="col-sm-5">
                <input type="text" id="store_id" name="store_id" class="form-control" placeholder="아이디를 입력하세요." required>
            </div>
        </div>
        <div class="form-group row justify-content-center">
        <span id="idcheck1">아이디는 6자 이상으로 입력해주세요.</span>
        <span id="admin_ok" style="color:green;">가입 가능한 아이디입니다.</span>
        <span id="admin_no" style="color:red;">중복된 아이디 입니다.다른아이디를 입력해주세요.</span>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-5">
                <input type="password" id="store_passwd" name="store_passwd" class="form-control"  placeholder="비밀번호를 입력해주세요" required>
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <div class="col-sm-5">
                <input type="password" id="store_passwd2" name="store_passwd2"  class="form-control" placeholder="비밀번호를 한 번 더 입력해주세요." required>
            </div>
        </div>
        <div class="mb-2">
        <span id="pwdconfmsg"></span>
        </div>
        <div class="form-group row justify-content-center">
           <div class="col-sm-5">
            <div class="input-group">
			  <input type="text" class="form-control" id="store_cellphone" name="store_cellphone" placeholder="-를 빼고 전화번호를 입력해주세요." required>
			</div> 
		  </div>
        </div>
         <div class="mb-2">
          <span id ="phonecheck" style="color :red;">올바른번호를 입력하세요.</span>
         </div>
       		<br><br>
        		<div class="form-group row justify-content-center">
       				<font size=5>사업자 인증</font>
        		</div>
        		<div class="form-group row justify-content-center">
            		<div class="col-sm-5">
               		 <input type="text" class="form-control" name="name" placeholder="이름 (대표명)" required>
            		</div>
        		</div>
        		<div class="form-group row justify-content-center">
            		<div class="col-sm-5">
               		 <input type="text" class="form-control" name="business_no" placeholder="사업자번호" required>
            		</div>
        		</div>
        		<div class="form-group row justify-content-center" id="businesscheck">
            		<div class="col-sm-5">
            		  <p style="color:red;">사업자번호를 올바르게 입력하세요</p>
            		</div>
        		</div>        		
        	<br><br>
        		<div class="form-group row justify-content-center">
       				<font size=5>매장 정보</font>
        		</div>	  			
        	 <div class="form-group row justify-content-center">
            	<div class="col-sm-5">    
            		<select class="form-control" name="category" required>
        				<option selected>카테고리 선택</option>
        				<option value="0">한식</option>
        				<option value="1">일식</option>
        				<option value="2">중식</option>
        				<option value="3">양식</option>
        				<option value="4">기타</option>
      				</select>           
            	</div>
       		 </div>
       		 <div class="form-group row justify-content-center">
            		<div class="col-sm-5">
               		 <input type="text" class="form-control" name="store_name" placeholder="상호" required>
            		</div>
        	 </div>
        	 <div class="form-group row justify-content-center">
    			<div class="col-sm-3">
    				<input type="text" class="form-control" id="sample6_postcode" name="post_num" placeholder="우편번호" required>
    			</div>
    			<div class="col-sm-2">
    				<input type="button" class="btn btn-block btn-light" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
    			</div>
			 </div>
			 <div class="form-group row justify-content-center">
					<div class="col-sm-5">
						<input type="text" class="form-control" id="sample6_address" name="address" placeholder="주소" required>
    				</div>
			 </div>
			 <div class="form-group row justify-content-center">
					<div class="col-sm-5">
        				<input type="text" class="form-control" id="sample6_address2" name="address_detail" placeholder="상세주소" required>
        			</div>
        	 </div>
        	 
        	 <div class="form-group">
			<div class="row">
				<div class="col-3 offset-4">Delicious Spoon 이용약관 동의</div>
				<div class="col-2">
					<input class="form-check-input" type="checkbox" name="consent" value="option1" required>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-3 offset-4">개인정보 수집 및 이용안내 동의</div>
				<div class="col-2">
					<input class="form-check-input" type="checkbox" name="consent" value="option1" required>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-3 offset-4">
					<p class="h3 pt-2">모두 선택</p>
				</div>
				<div class="col-2">
				
					<input class="form-check-input" type="checkbox" name="consents" value="option1">
				</div>
			</div>
		</div>
        	 
       		 <div class="form-group row justify-content-center">
           	 	<div class="col-sm-5 col-sm-offset-3">
                <input type="submit" class="btn btn-light btn-block" value="join">
                </div>
             </div>
    </form>  
</div>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>  

<jsp:include page="admin_bottom.jsp" flush="false"/>
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<script>

$(document).ready(function(){
	$("#admin_no").hide();	                       
	$("#admin_ok").hide();
	$("#store_id").focus();
	$("#idcheck1").hide();
	$("#idcheck2").hide();	
	$("#phonecheck").hide();  	
	$("#businesscheck").hide();
	
    $('#store_id').blur(function(){  	
        if ( $('#store_id').val().length > 6) {

            var store_id = $('#store_id').val();
            // ajax 실행
            $.ajax({
                type : 'POST',
                url : 'admin_check_id.jsp',
                data:{
                   store_id : store_id
                },
                cache: false,
                dataType:"text",
                success : function(data) {
                  /*  console.log(data); */
                  			                 
                    if(data.match(/-1/)!=null){//true면 가입가능
                		$("#idcheck1").hide();
                    	$("#admin_ok").show();
                    	$("#admin_no").hide();
                    	$("#store_id").css('background-color','#E4F7BA'); 
                    	$("#join").attr('disabled',false);
                    	$("#join").css('background-color','#000000');	
                    	//초록             	
                    	$("#passwd").focus();
                    }
                    else if(data.match(/1/)!=null){
                		$("#idcheck1").hide();
                    	$("#admin_ok").hide();
                    	$("#admin_no").show();
                    	$("#store_id").css('background-color','#FFD8D8'); 
                    	$("#join").attr('disabled',true);
                    	$("#join").css('background-color','#F2F2F2');
                    	$("#store_id").focus();
                    }else{
                    	$("#store_id").css('background-color','#F4F4F4');
                    }
               
                }
            }); // end ajax
                     
        }else{
        	$("#join").attr('disabled',true);
        	$("#join").css('background-color','#F2F2F2');
    		$("#idcheck1").show();       	
        	$('#store_id').val("");
        	$('#store_id').focus(""); 
        	$("#admin_no").hide();	                       
        	$("#admin_ok").hide();
        	
        }
        
        var re_id = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
        var txt = $('#store_id').val();
     if(re_id.test(txt)){
    		$("#idcheck1").show();
            $("#store_id").val("");
            $("#store_id").focus();    
        	$("#join").attr('disabled',true);
        	$("#join").css('background-color','#F2F2F2');
        	$("#admin_no").hide();	                       
        	$("#admin_ok").hide();
         }
    
    }); // end blur
    
    //비밀번호가 동일한지 값을 체크 
    $("#store_passwd2").blur(function(){
       var pwd1 = $("#store_passwd").val();
       var pwd2 = $("#store_passwd2").val(); 
       $('#pwdcofmsg').hide();
        if(pwd1===pwd2&&pwd1!=""&&pwd2!=""){                       
           $('#pwdconfmsg').text('비밀번호가 동일합니다');
           $('#pwdconfmsg').show();
       }else{
               if(pwd1==""){   $('#pwdconfmsg').text('비밀번호를 입력바랍니다.');
                               $('#pwdconfmsg').show();
                               $("store_passwd2").val("");
                               $("store_passwd").focus();
                               return;
                           }
            $('#pwdconfmsg').text('비밀번호가 일치하지 않습니다');
            $('#pwdconfmsg').show();
            $("#store_passwd2").val("");
            $("#store_passwd2").focus();

       }
        

    });//end blur   
   
    //전화번호가 숫자인치 체크
     $("#store_cellphone").blur(function(){   
    	 
    var re_phone = /[01](0|1|6|7|8|9)(\d{4}|\d{3})\d{4}$/g;  

    var txt = $('#store_cellphone').val();
    if(txt.length!=11){ $("#phonecheck").show();
    $("#store_cellphone").val("");; return false;}
 	if(re_phone.test(txt)){  
    	$("#phonecheck").hide();    	                   
     }else{
 		$("#phonecheck").show();
        $("#store_cellphone").val("");
        $("#store_cellphone").focus();    
     }
     	});//end keyup

  //비즈니스 넘버가 숫자인지 체크
  
     $('[name=business_no]').keyup(function(e) {
    	    var reg = /[^0-9]/gi;
    	    var v = $('[name=business_no]').val();
    	  
    	    if (reg.test(v)) {  
    	    	$('[name=business_no]').val(v.replace(reg, ''));
    	    	$("#businesscheck").show();
    	        $('[name=business_no]').val("");
    	        $('[name=business_no]').focus();
    	        return false;    	
    	     }else{
    	    	 
    	    	 $("#businesscheck").hide();
    	     };

    	});

    
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
