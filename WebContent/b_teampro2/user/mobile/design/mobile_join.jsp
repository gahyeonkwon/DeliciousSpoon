<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%String title="회원가입";%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/> 
      <div align="center"> 
      	  <img src="../../../img/logo_red.png" class="d-flex justify-content-center mt-5 mb-5" style="width: 35%; height: 70%;"> 			
	  </div>
	  <form method="post" class="form-horizontal" action="../control/join_pro.jsp">
		  <div class="container">	  
			   <div class="input-group input-group-lg">	   	
			     <input name="user_id" id="mragin_gr" type="text" class="form-control" placeholder="아이디">
			    <div class="margin_sy mt-1">
			        <span name="idcheck1" class="detail_sy">아이디는 영어와 숫자를 혼합하여 6자 이상입력하세요</span>
			        <span name="user_ok" class="detail_sy" style="color:green;">가입 가능한 아이디입니다.</span>
			        <span name="user_no" class="detail_sy" style="color:red;">중복된 아이디 입니다.다른아이디를 입력해주세요.</span>
			        </div>
			   </div> 

			   <div class="input-group input-group-lg">	  
			     <input name="passwd" id="mragin_gr" type="password" class="form-control"  placeholder="비밀번호를 입력해주세요" required>
			   </div>  
			   <div class="input-group input-group-lg">	
			     <input name="passwd2" id="mragin_gr" type="password" class="form-control" placeholder="비밀번호를 한번 더 입력해주세요" required>
			   	 <div class="margin_sy mt-1">
				   	<span name="pwdconfmsg" class="detail_sy"></span>
				   </div>
			   </div>
		   </div>
		    
		   <div class="container">    
			   <div class="input-group input-group-lg mt-3">	
			     <input name="phone_number" id="mragin_gr" type="text" class="form-control" placeholder="전화번호" required>
			     <div class="margin_sy mt-1">
		        	<span name ="phonecheck" class="detail_sy">올바른번호를 입력하세요.</span>
		           </div>
			   </div>  
		   </div>
		  <div class="container">	
			   <div class="row  mt-3">	   
			   		<p class="c_text align-middle" style="margin-left:32px; margin-right:16px; margin-top: 18px;">성별</p>   
			   		<div class="btn-group btn-group-toggle" style="padding-top:10px; padding-bottom:10px;" data-toggle="buttons">
					  <label class="btn btn-lg btn-outline-dark">
					    <input type="radio" style="border-color: #dee2e6;" class="c_text" id="option1" name="gender" autocomplete="off" value="여자" required>여자
					  </label>
					  <label class="btn btn-lg btn-outline-dark">
					    <input type="radio" style="border-color: #dee2e6;" class="c_text" id="option2" name="gender" autocomplete="off" value="남자" required>남자
					  </label> 
					</div>  
			   </div>
			</div>  

	        <div class="container "> 
	          <div class="input-group mt-3" id="restaurant">   
	             <div class="container">  
	                <div class="custom-control custom-checkbox">
					  <input type="checkbox" class="custom-control-input" id="customCheck1" name="consent">
					  <label class="custom-control-label" for="customCheck1">Delicious Spoon 이용약관 동의</label>
					</div>      		            
				 </div>
				 <div class="container">	
					<div class="custom-control custom-checkbox">
					  <input type="checkbox" class="custom-control-input" id="customCheck2" name="consent">
					  <label class="custom-control-label" for="customCheck2">개인정보 수집 및 이용안내 동의</label>
					</div> 
				 </div>
				 <div class="container mb-2">	
					<div class="custom-control custom-checkbox">
					  <input type="checkbox" class="custom-control-input pt-1" id="customCheck3" name="consents">
					  <label class="custom-control-label" for="customCheck3" style="font-size: 1.2rem;">모두 선택</label>
					</div> 
				</div>	
             </div>
            </div>
	             
		<div class="container">
			<input type="submit" name="join" id="mragin_gr" class="btn btn-block btn-lg btn-depoon" value="회원가입">		  	
		</div>
		<input type="hidden" id="tr" value="-1">
	  </form>


<jsp:include page="../frame/bottom.jsp" flush="false"/>   	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<!-- id 중복 체크 코드 -->
<script>

$(document).ready(function(){
	$("[name=user_no]").hide();	                       
	$("[name=user_ok]").hide();
	$("[name=user_id]").focus();
	$("[name=idcheck1]").hide();
	$("[name=idcheck2]").hide();	
	$("[name=phonecheck]").hide();  	
	
    $('[name=user_id]').blur(function(){  	
        if ( $('[name=user_id]').val().length > 6) {

            var user_id = $('[name=user_id]').val();
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
                		$("[name=idcheck1]").hide();
                    	$("[name=user_ok]").show();
                    	$("[name=user_no]").hide();
                    	$("[name=user_id]").css('background-color','#E4F7BA'); 
                    	           	
                    	$("[name=passwd]").focus();
                    }
                    else if(data.match(/1/)!=null){
                		$("[name=idcheck1]").hide();
                    	$("[name=user_ok]").hide();
                    	$("[name=user_no]").show();
                    	$("[name=user_id]").css('background-color','#FFD8D8'); 
        
                    	$("[name=user_id]").focus();
                    }else{
                    	$("[name=user_id]").css('background-color','#F4F4F4');
                    }
               
                }
            }); // end ajax
                     
        }else{
        	$("[name=join]").attr('disabled',true);
        	$("[name=join]").css('background-color','#F2F2F2');
    		$("[name=idcheck1]").show();       	
        	$('[name=user_id]').val("");
        	$('[name=user_id]').focus(""); 
        	$("[name=user_no]").hide();	                       
        	$("[name=user_ok]").hide();
        	
        }
        
        var re_id = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
        var txt = $('#user_id').val();
     if(re_id.test(txt)){
    		$("[name=idcheck1]").show();
            $("[name=user_id]").val("");
            $("[name=user_id]").focus();    
        
        	$("[name=user_no]").hide();	                       
        	$("[name=user_ok]").hide();
         }
    
    }); // end blur
    
    //비밀번호가 동일한지 값을 체크 
    $("[name=passwd2]").blur(function(){
       var pwd1 = $("[name=passwd]").val();
       var pwd2 = $("[name=passwd2]").val(); 
       $('[name=pwdcofmsg]').hide();
        if(pwd1===pwd2&&pwd1!=""&&pwd2!=""){                       
           $('[name=pwdconfmsg]').text('비밀번호가 동일합니다');
           $('[name=pwdconfmsg]').show();
       }else{
               if(pwd1==""){   $('[name=pwdconfmsg]').text('비밀번호를 입력바랍니다.');
                               $('[name=pwdconfmsg]').show();
                               $("[name=passwd2]").val("");
                               $("[name=passwd]").focus();
                               return;
                           }
            $('[name=pwdconfmsg]').text('비밀번호가 일치하지 않습니다');
            $('[name=pwdconfmsg]').show();
            $("[name=passwd2]").val("");
            $("[name=passwd2]").focus();

       }
        

    });//end blur   
   
    //전화번호가 숫자인치 체크
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
 		$("[name=phonecheck]").show();
        $("[name=phone_number]").val("");
        $("[name=phone_number]").focus();    
     }
     	});//end blur

    

    
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

