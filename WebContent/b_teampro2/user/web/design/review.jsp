<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>
<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "리뷰";
		String user_id = (String)session.getAttribute("user_id");
		String store_id = request.getParameter("store_id");
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>   
	
<!-- 상단 메뉴 -->
	<jsp:include page="../frame/top.jsp" flush="false"/>	
	
	<!-- 메인사진 위에 올린 css 가져온거 -->
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%
try{  
	if(user_id==null||user_id.equals("")||store_id==null||store_id.equals("")){
		response.sendRedirect("../control/error.jsp");
	}else{ 
		
		//출력 데이터 함수	
			//페이지에 매장 정보 받아오기 위한 객체 생성
			UserSystemDBBean system = UserSystemDBBean.getInstance(); 
			//날짜 객체 생성
			DateFormat format1 = DateFormat.getDateInstance(DateFormat.LONG);
			//store 정보 받아올 객체 생성
			StoreinfoDataBean store = null;
			store = system.getStoreinfo(store_id);			
			//메뉴정보 출력
   			String names = store.getMenu_names();	    			
  			String name [] = names.split(",");   		

%>   	
<!-- main content -->
	<div class="container">
		<div class="row pl-4 pt-2 pb-3">
			<a href="main.jsp" class="btn btn-link" style="color:black;">홈</a>
			<span class="pt-2">></span>
			<a href="category.jsp?category=<%=store.getCategory()%>" class="btn btn-link" style="color:black;">
			<%if(store.getCategory()==0){out.print("한식");}
        	else if(store.getCategory()==1){out.print("일식");}
        	else if(store.getCategory()==2){out.print("중식");}
        	else if(store.getCategory()==3){out.print("양식");}
        	else{out.print("기타");} %></a>
			<span class="pt-2">></span>
			<a href="detailpage.jsp?store_id=<%=store_id%>" class="btn btn-link" style="color:black;"><%=store.getStore_name()%></a>

		</div>
	</div>
  <div class="row">
	<div class="container">
				<div class="row justify-content-between">
					<div class="ml-5">
						<h2><%=store.getStore_name()%></h2>
					</div>
					<div class="mt-2">
					   <div style="position: absolute;">
					        <span class="linelike">
						        <img style="width: 20px; height: 20px;margin-top:10px;" src="../../../img/linelike_red.png"/>
					        </span>
					    </div>
					    <div style="position: absolute;">
					        <span class="like">
					        	<img style="width: 20px; height: 20px;margin-top:10px;" src="../../../img/heart_red.png"/>
					    	</span>
					    </div>					
						<h5 style="margin-left:25px;">저장하기</h5>
					</div>    
		   		</div>
	
		<div class="row pl-3"><!-- 헤더 -->		   
		   <div class="container col-7" >
		   <div class="row d-flex justify-content-start">         
         <div class="col-sm-2 d-flex align-items-start">
            <div>   
               <img src="/bban/imageFile/<%=store.getMain_photo()%>" class="rounded" style="width:600px; height:400px;">            
            </div>
         </div>   
      		</div>
      		</div>
        <div class="container col-5">
      <div class="row pt-2 ">
      <div class="col align-items-end d-flex justify-content-start">
         <p class="h3">음식점 정보</p>
      </div>    
	   </div>    
	   <div class="border-bottom pt-1 mb-2 pr-1" style="width: 98%;"></div>   
	   <div class="pt-2 pb-2">   
	      <div class="row d-flex justify-content-start">         
	            <div class="col-sm-3 d-flex align-items-end">
	               <p class="lead">카테고리</p>   
	            </div>      
	            <div class="col-sm-9 pt-2 d-flex align-items-end">
	               <p><%if(store.getCategory()==0){out.print("한식");}
	            	else if(store.getCategory()==1){out.print("일식");}
	            	else if(store.getCategory()==2){out.print("중식");}
	            	else if(store.getCategory()==3){out.print("양식");}
	            	else{out.print("기타");}%>
	               </p>
	            </div>   
	      </div>         
	      <div class="row d-flex justify-content-start mt-3">         
	            <div class="col-sm-3 d-flex align-items-center">
	               <p class="lead">소개</p>   
	            </div>      
	            <div class="col-sm-9 pt-2 d-flex align-items-end">
	              <div class="text-sm-left"> 
	               <p><%=store.getIntro()%></p>
	              </div> 
	            </div>   
	      </div>      
	      <div class="row d-flex justify-content-start mt-3">         
	            <div class="col-sm-3 d-flex align-items-end">
	               <p class="lead">영업시간</p>   
	            </div>      
	            <div class="col-sm-9 pt-2 d-flex align-items-end">
	               <p><%=store.getOpen_time()%></p>
	            </div>   
	      </div>
	      <div class="row d-flex justify-content-start mt-3">         
	            <div class="col-sm-3 d-flex align-items-end">
	               <p class="lead">영업요일</p>   
	            </div>      
	            <div class="col-sm-9 pt-2 d-flex align-items-end">
	               <p><%=store.getOpen_day()%></p>
	            </div>   
	      </div>
	      <div class="row d-flex justify-content-start mt-3">         
	            <div class="col-sm-3 d-flex align-items-end">
	               <p class="lead">대표번호</p>   
	            </div>      
	            <div class="col-sm-9 pt-2 d-flex align-items-end">
	               <p><%=store.getStore_phone()%></p>
	            </div>   
	      </div>
	      <div class="row d-flex justify-content-start mt-3">         
	            <div class="col-sm-3 d-flex align-items-start">
	               <p class="lead">대표메뉴</p>   
	            </div>      
	            <div class="col-sm-9 pt-2 d-flex align-items-end">
	               <div>
	               <%for(int i=0;i<name.length;i++){%>
	                  <div class="row" style="padding-left: 14px;">
	                  <p><%=name[i]%></p>	                                                         
	                  </div>  
	               <%}%>                           
	               </div>               
	            </div>                  
      		</div>      
   		</div><!-- 음식점 상세정보end -->                    
         </div>          
      </div>
        <!-- 리뷰 내용 시작 -->    
	        <form action="../control/review_pro.jsp?store_id=<%=store_id%>" method="post" enctype="multipart/form-data">   
	        <div class="review-align pl-3">
				<p class="h3">리뷰쓰기</p><br>
				<p class="h6 pb-2">별점을 입력해주세요</p>
				<!-- 별표 5개 -->
				<div class="starRev">
				<span id="1" class="starR" style="width:2.0rem; height:2.0rem;"></span>
				<span id="2" class="starR" style="width:2.0rem; height:2.0rem;"></span>
				<span id="3" class="starR" style="width:2.0rem; height:2.0rem;"></span>			
				<span id="4" class="starR" style="width:2.0rem; height:2.0rem;"></span>
				<span id="5" class="starR" style="width:2.0rem; height:2.0rem;"></span>
				<input type="hidden" name="score" id="stari">
				</div>
			</div><br>		
			<div class="container ml-3">
				<div  class="row justify-content-center mb-3">
				  <input name="review_title" class="form-control" placeholder="매장에대한 평가를 한마디로 한다면" required>
			    </div>
				<div class="row justify-content-center">
				  <textarea  id="review" name="review_content"  required class="form-control" required placeholder="상세한 리뷰는 다른 사람에게 좋은 정보가 됩니다!"></textarea>
			    </div>
			</div> 

			<div class="review-align2 pl-3">
		   		 <p class="h6">사진첨부 (최대 3장까지 가능)</p>
		   		 <div class="row">
			   		 <div class="col-2">
			   		 <span class="plus1"><img class="circle" src="../../../img/plus.png" name="user_photo" id="photo1" style="width:10rem; height:10rem;"></span><br>
			   		 <span class="review_photo1"><input type="file" name="review_photo1" id="review_photo1"></span>		
			   		 </div>   		   	
			   		 
			   		 <div class="col-2">	 
			   		 <span class="plus2"><img class="circle" src="../../../img/plus.png" name="user_photo" id="photo2" style="width:10rem; height:10rem;"></span><br>
			   		 <span class="review_photo2"><input type="file" name="review_photo2" id="review_photo2"></span>	
			   		 </div>
			   		 
			   		 <div class="col-2">
			   		 <span class="plus3"><img class="circle" src="../../../img/plus.png" name="user_photo" id="photo3" style="width:10rem; height:10rem;"></span><br>
			   		 <span class="review_photo3"><input type="file" name="review_photo3" id="review_photo3"></span>		
			   		 </div>
		   		 	   		 
		    	 </div>
		    </div>	 		
			<!-- 버튼 --> 
			<div class="row justify-content-center pl-4 mt-3">
			  <div class="col">
	  			<button type="button" class="btn btn-lg btn-block btn-depoon" id="cancel">취소</button>
			  </div>
			  <div class="col">
			   	<button type="submit" id="join" class="btn btn-depoon btn-lg btn-block">작성</button>
			  </div>
			</div>
			</form>
		</div> 
	</div>		

<%}//로그인 상태 오류

  }catch(Exception e){}
	%>  	
    <!-- 하단 -->
	<jsp:include page="../frame/bottom.jsp" flush="false"/>	

	<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- jquery -->

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
	
	//취소 버튼 연결
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
 <!-- 즐겨찾기 -->
<script>
	$(document).ready(function(){
		var opt = 1;
		var user_id = $('#user_id').val();
		var favorite = $('.favorite').val();
		
		if(favorite==0){
			$(".linelike").show();	
			
			$(".like").hide();
		}else{
			$(".like").show();
		};
			
		$(".linelike").click(function(){	
		
		if(user_id=="null"||user_id==""){
			swal({
			     title: "즐겨찾기",
			     text: "로그인 후 이용 가능 합니다. 로그인으로 이동할까요?",
			     icon: "info",
			     buttons: true,
			     dangerMode: true,
			   })
			   .then((willDelete) => {
			     if (willDelete) {
			         location.href='login.jsp'
			     } else {
			       return false;
			     }
			   }); 
		}
			
			$(".like").show();
			var store_id =$(".store_id").val();	
			//ajax 사용
		    $.ajax({
		        type : 'POST',
		        url : '../control/check_favorite.jsp',
		        data:{
		         store_id : store_id,
		         user_id : user_id,
		         opt : opt
		        },
		        cache: false,
		        dataType:"text",

		    }); // end ajax

		});

		$(".like").click(function(){
			if(user_id=="null"||user_id==""){
				swal({
				     title: "즐겨찾기",
				     text: "로그인 후 이용 가능 합니다. 로그인으로 이동할까요?",
				     icon: "info",
				     buttons: true,
				     dangerMode: true,
				   })
				   .then((willDelete) => {
				     if (willDelete) {
				         location.href='login.jsp'
				     } else {
				       return false;
				     }
				   }); 
			}			
			$(".like").hide();
			var store_id =$(".store_id").val();	
			//ajax 사용
		    $.ajax({
		        type : 'POST',
		        url : '../control/check_favorite.jsp',
		        data:{
		         store_id : store_id,
		         user_id : user_id,
		         opt:opt
		        },
		        cache: false,
		        dataType:"text",
	
		    }); // end ajax
		});

	});
</script>	
		