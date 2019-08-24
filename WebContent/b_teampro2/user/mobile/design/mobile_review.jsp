<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<% request.setCharacterEncoding("utf-8");%>
<%
String title="리뷰쓰기";
String user_id = (String)session.getAttribute("user_id");
String store_id = request.getParameter("store_id");
%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/> 
 <% try{  
	if(user_id==null||user_id.equals("")||store_id==null||store_id.equals("")){
		response.sendRedirect("../control/error.jsp");
	}else{ 
		//페이지에 매장 정보 받아오기 위한 객체 생성
		UserSystemDBBean system = UserSystemDBBean.getInstance(); 
		//날짜 객체 생성
		DateFormat format1 = DateFormat.getDateInstance(DateFormat.LONG);
		//store 정보 받아올 객체 생성
		StoreinfoDataBean store = null;
		store = system.getStoreinfo(store_id);
	
		String review_date = system.getVisitedDate_Mobile(user_id,store_id);
		%>
   
    <div class="container">	
     	<img src="/bban/imageFile/<%=store.getMain_photo()%>" id="detail_img_sy" class="padding_sy" />        		
	</div>
	<div class="container">
		<p class="c_text margin_sy mt-3 mb-1"><%=store.getStore_name()%></p>
	</div>
	<div class="container">	
		<p class="detail_sy margin_sy align-bottom mb-1"><%=review_date%> 방문</p>
	</div>
	<form action="../control/review_pro.jsp?store_id=<%=store_id%>" method="post" enctype="multipart/form-data">   
	<div class="container mt-4">
		<p class="c_text margin_sy">별점을 입력해주세요</p><br>
		<!-- 별표 5개 -->
	</div>
	<div class="container">	
			<div class="starRev container margin_sy" id="review">
				<span id="1" class="starR" style="width:1.0rem; height:1.0rem;"></span>
				<span id="2" class="starR" style="width:1.0rem; height:1.0rem;"></span>
				<span id="3" class="starR" style="width:1.0rem; height:1.0rem;"></span>			
				<span id="4" class="starR" style="width:1.0rem; height:1.0rem;"></span>
				<span id="5" class="starR" style="width:1.0rem; height:1.0rem;"></span>
				<input type="hidden" name="score" id="stari">
			</div>
	<div class="container">	
		<div class="container mt-2">
			<input type="text" name="review_title" id="review" required class="margin_sy form-control text_area" placeholder="매장에대한 평가를 한마디로 한다면">
		</div>		
		<div class="container mt-2">
			<textarea name="review_content"  id="review" required class="margin_sy form-control text_area" placeholder="상세한 리뷰는 다른 사람에게 좋은 정보가 됩니다!"></textarea>
		</div>		
	</div>
	<!-- 여기서 부터  이미지  인풋 권가현이추가 -->
	<div class="container mt-4">
   		 <p class="margin_sy">사진첨부 (최대 3장까지 가능)</p>
   	</div>
   	<div class="container mt-2">	 
   		
	   		 <div class="col-2">
	   		 <span class="plus1"><img class="circle" src="../../../img/plus.png" name="user_photo" id="photo1" style="width:2.5rem; height:2.5rem;"></span><br>
	   		 <span class="review_photo1"><input type="file" name="review_photo1" id="review_photo1"></span>		
	   		 </div>   		   	
	   		 
	   		 <div class="col-2">	 
	   		 <span class="plus2"><img class="circle" src="../../../img/plus.png" name="user_photo" id="photo2" style="width:2.5rem; height:2.5rem;"></span><br>
	   		 <span class="review_photo2"><input type="file" name="review_photo2" id="review_photo2"></span>	
	   		 </div>
	   		 
	   		 <div class="col-2">
	   		 <span class="plus3"><img class="circle" src="../../../img/plus.png" name="user_photo" id="photo3" style="width:2.5rem; height:2.5rem;"></span><br>
	   		 <span class="review_photo3"><input type="file" name="review_photo3" id="review_photo3"></span>		
	   		 </div>		   		 	   		 
    	
    </div>	
    <!-- 여기가 이미지 인풋 끝 --> 		
	<div class="container mt-2">
	   <div class="col-6">
		  <button type="submit" class="btn btn-depoon btn-block" id="cancel">취소</button>
	   </div>
	   <div class="col-6">  
		  <button type="submit" class="btn btn-depoon btn-block" id="join">작성</button>
	   </div>
	</div>	
	</form>
	
	</div>
	<%}//로그인 상태 오류

 }catch(Exception e){}
	%> 	
	
<jsp:include page="../frame/bottom.jsp" flush="false"/>   	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQEURY -->
<script>
$(document).ready(function(){
	$("[name=review_photo1]").prop('disabled',true);
	$("[name=review_photo2]").prop('disabled',true);
	$("[name=review_photo3]").prop('disabled',true);	
	$(".review_photo1").hide();
	$(".plus2").hide();
	$(".review_photo2").hide();
	$(".plus3").hide();
	$(".review_photo3").hide();
	var click_id 
	//별점코드
	$('.starRev span').click(function(){		
		  $(this).parent().children('span').removeClass('on'); 
		  $(this).addClass('on').prevAll('span').addClass('on');
		  click_id = $(this).attr('id'); //클릭한 태그 아이디가져오기	 	
		  $('#stari').val(click_id);
		  return false;
		});
	//별점 코드 submit 제한
	$('#join').click(function(){		
		 	
		  var stari = $('#stari').val();	
			if(stari==""){
				swal('별점을 입력해주세요');
				return false;
			}
		});	
	//reveiw 사진
	$(".plus1").on('click',function(){  
		$("[name=review_photo1]").prop('disabled',false);	
		$("[name=review_photo1]").click();	
		$(".plus2").show();
	});  
	$(".plus2").on('click',function(){  
		$("[name=review_photo2]").prop('disabled',false);	
		$("[name=review_photo2]").click();	
		$(".plus3").show();
	});  		 
	$(".plus3").on('click',function(){  
		$("[name=review_photo3]").prop('disabled',false);	
		$("[name=review_photo3]").click();
	
	});  
	
	$("#cancel").on('click',function(){  
		history.go(-1);
	
	}); 
});
</script>
<script>
var upload = document.getElementById('review_photo1'),
    holder = document.getElementById('photo1');

upload.onchange = function (e) {
  e.preventDefault();

  var file = upload.files[0],
    reader = new FileReader();
  	reader.onload = function (event) {
	    var img = new Image();
	   img.src = event.target.result;
	 
	    holder.appendChild(img); 
	 	var source = img.src;
	    $('#photo1').attr('src', source);    
  };
  reader.readAsDataURL(file);

  return false;
};

var upload2 = document.getElementById('review_photo2'),
    holder2 = document.getElementById('photo2');

upload2.onchange = function (e) {
  e.preventDefault();

  var file2 = upload2.files[0],
    reader2 = new FileReader();
  	reader2.onload = function (event) {
	    var img2 = new Image();
	   img2.src = event.target.result;
	 
	    holder2.appendChild(img2); 
	 	var source2 = img2.src;
	    $('#photo2').attr('src', source2);    
  };
  reader2.readAsDataURL(file2);

  return false;
};

var upload3 = document.getElementById('review_photo3'),
holder3 = document.getElementById('photo3');

upload3.onchange = function (e) {
e.preventDefault();

var file3 = upload3.files[0],
reader3 = new FileReader();
	reader3.onload = function (event) {
    var img3 = new Image();
   img3.src = event.target.result;
 
    holder3.appendChild(img3); 
 	var source3 = img3.src;
    $('#photo3').attr('src', source3);    
};
reader3.readAsDataURL(file3);

return false;
};
</script>
	