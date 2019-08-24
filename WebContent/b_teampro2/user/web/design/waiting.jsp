<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %> 
<%@ page import="b_teampro2.storeinfo.StoreinfoDBBean" %> 
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>   
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %> 
<%@ page import="b_teampro2.userinfo.UserinfoDBBean" %> 
<%@ page import="java.util.*" %>  
<!-- header  -->
	<%
		request.setCharacterEncoding("utf-8");
		String title = "대기신청";
		String user_id = (String)session.getAttribute("user_id");
		//String store_id = "susi";
		String store_id = request.getParameter("store_id");		
	%>
 
 	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<!-- 상단 메뉴 -->
	<jsp:include page="../frame/top.jsp" flush="false"/>	
	

<%   
//DB기본연결
//출력 데이터 함수
	//페이지에 매장 정보 받아오기 위한 객체 생성
	UserSystemDBBean system = UserSystemDBBean.getInstance(); 
	//store 정보 받아올 객체 생성
	StoreinfoDataBean store = null;
	store = system.getStoreinfo(store_id);
	
	//메뉴정보와 사진정보 출력
	//리스트 값 생성
    			String names = store.getMenu_names();   			
   				String name [] = names.split(",");   	
   	//내가 받게 될번호 출력
   	  int my_num = system.getCurrent_num(store_id);
   	//남은 팀 수 출력
   	  int team = system.getCurrent_team(store_id);
   	  
   	//유저 정보생성
   	UserinfoDBBean user = UserinfoDBBean.getInstance();
   	

%>	
<!-- main content -->
	<div class="container">
		<div class="row pl-1 pt-2 pb-4">
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
				<div class="row ">
					<div class="ml-4" style="padding-left:14px;">
						<p class="h2"><%=store.getStore_name()%></p>
					</div>
					<div class="mt-1 mr-3 ml-3">
					<div style="position: absolute;">
				        <span class="linelike">
					        <img style="width: 20px; height: 20px; margin-top:10px;" src="../../../img/linelike_red.png"/>
				        </span>
				    </div>
				    <div style="position: absolute;">
				        <span class="like">
				        	<img style="width: 20px; height: 20px; margin-top:10px;" src="../../../img/heart_red.png"/>
				    	</span>
				  	</div>
						<h5 style="margin-left:25px;">저장하기</h5>
					</div>    
		   		</div>
		   		
		   			
 		       
<!-- 대기 신청 폼 -->    
				<div class="row pb-5 pl-4 mt-3"><!-- 헤더 -->
					<div class="container col-7" >
		   				<div class="col-sm">
                     <div class="row">
                        <div class="card">
                           <img class="card-img" src="../../../img/waitingimg.png" style="width:600px; height:400px;" alt="Card image">
                           <div class="card-img-overlay">
                              <div class="" style="margin-top:80px;">
                                 <div class="text-center pt-2">
                                    <p class="c_text margin_gr" style="color: #ffffff;">내 번호</p>
                                    <p class="number_sy" style="color: #ffffff;"><%=my_num%></p>
                                    <p class="c_text margin_gr" style="color : #ffffff;"><%=team%> 팀 남았어요!</p>
                                 </div>
                              </div>
                           </div>
                        </div><!-- card end -->
                     </div>
                  </div><!-- col-4 end -->
      				</div>
            		<div class="container col-5">
      					    
                  <div class="row pl-3">
                     <p class="h3">대기신청</p>
                     <div class="border-bottom mb-3 pr-5" style="width: 98%;"></div>
                                       
                  <form action="waiting_done.jsp">
                     <input type="hidden" name="store_id" value="<%=store_id %>">
                     <input type="hidden" name="user_id" value="<%=user_id %>">
                     <div class="row">                     
                        <div class="container pt-1">
                             <div class="form-group row">
                               <label class="text-left col-sm-3 col-form-label">이름</label>
                               <div class="col-sm-5">
                                     <input type="text" class="form-control" name="name" placeholder="" required>
                               </div>
                             </div>
                             <div class="form-group row">
                               <label class="text-left col-sm-3 col-form-label">인원</label>
                               <div class="col-sm-5">
                               		     <select id="mragin_gr" name="people_num" class="custom-select mb-1" required>
										  <option selected>인원</option>
										  <option value="1">1명</option>
										  <option value="2">2명</option>
										  <option value="3">3명</option>
										  <option value="4">4명</option>
										  <option value="5">5명</option>
										  <option value="6">6명</option>
										</select>                              
                               </div>
                             </div>
                             <div class="form-group row">
                               <label class="text-left col-sm-3 col-form-label">전화번호</label>
                               <div class="col-sm-5">
                                    <input type="text" class="form-control" name="phone_number" value="0<%=user.selectMember(user_id).getPhone_number()%>" placeholder="" required>
                               </div>
                            </div>
                           
			                     <div class="border-bottom pt-1 mb-3" style="width: 98%;"></div>
			                        <div class="row justify-content-start pl-3">
			                           <p> * 대기 내용 변경시 매장으로 연락 부탁드립니다.</p>                              
			                           <p class="pt-1"> * 인원이 변경될 시 불이익을 받을 수 있습니다.</p>
			                           <p class="pt-1"> * 대기 알람을 받으면 근처에서 대기 바랍니다.</p>                         
			                        </div>   
			                  </div><!-- col-3 end -->
                            
                            
                             <div class=" justify-content-end pt-1" style="margin-left:300px;">
                                 <button type="submit" class="go btn btn-depoon btn-lg" style="width:150px;height:50px;">대기하기</button>
                           </div>
                         </div>                      
                     
                  </form>   
             	</div>
	 				</div>                  
				</div>      
	</div><!-- 음식점 상세정보 end --> 
   						<div class="container mb-5">
   						 <div class="row pb-5"><!-- 헤더 -->
							<div class="container col-7 mr-4">
		   				        
         					<div class="col-sm-2">
               				 	<img src="/bban/imageFile/<%=store.getMain_photo()%>" class="rounded" style="width:600px; height:400px;">            
         					</div>   
      				
      				</div>
            		<div class="row col-5">   
	   					<div class="border-bottom pt-3 mb-3 pr-1" style="width: 98%;"></div>   
	   					<div class="pt-2 pb-2">   
	     					<div class="row">         
	            				<div class="col-sm-3 d-flex align-items-end">
	               					<p class="lead">카테고리</p>   
	            				</div>      
	            				<div class="col-sm-9 d-flex align-items-end">
	               					<p>
	               					<%if(store.getCategory()==0){out.print("한식");}
					            	else if(store.getCategory()==1){out.print("일식");}
					            	else if(store.getCategory()==2){out.print("중식");}
					            	else if(store.getCategory()==3){out.print("양식");}
					            	else{out.print("기타");}%>
	               					</p>
	            				</div>   
	      					</div>         
	      					<div class="row mt-1">         
	            				<div class="col-sm-3 d-flex align-items-center">
	               					<p class="lead">소개</p>   
	            				</div>      
	            				<div class="col-sm-9 d-flex align-items-end">
	              					<div class="text-sm-left"> 
	               						<p><%=store.getIntro()%></p>
	              					</div> 
	            				</div>   
	      					</div>      
	      					<div class="row d-flex justify-content-start mt-2">         
	            				<div class="col-sm-3 d-flex align-items-end">
	               					<p class="lead">영업시간</p>   
	            				</div>      
	            				<div class="col-sm-9 d-flex align-items-end">
	               					<p><%=store.getOpen_time()%></p>
	            				</div>   
	      					</div>
	      					<div class="row d-flex justify-content-start mt-2">         
	            				<div class="col-sm-3 d-flex align-items-end">
	               					<p class="lead">영업요일</p>   
	            				</div>      
	            				<div class="col-sm-9 d-flex align-items-end">
	               					<p><%=store.getOpen_day()%></p>
	            				</div>   
	      					</div>	      
	      					<div class="row d-flex justify-content-start mt-2">         
	            				<div class="col-sm-3 d-flex align-items-end">
	               					<p class="lead">대표번호</p>   
	            				</div>      
	            				<div class="col-sm-9 d-flex align-items-end">
	               					<p><%=store.getStore_phone()%></p>
	            				</div>   
	      					</div>
	      					<div class="row d-flex justify-content-start mt-2">         
	            				<div class="col-sm-3 d-flex align-items-start">
	               					<p class="lead">대표메뉴</p>   
	            				</div>      
	            				<div class="col-sm-9 d-flex align-items-end mt-1">
	               					<div class="row" style="padding-left: 14px;">
			                    <%for(int i=0;i<3;i++){%>			                        
			                        <p><%=name[i]%> &nbsp; </p>                              		                        
			                     <%} %>   
	               					</div>               
	           	 				</div>                  
      						</div>      
   						</div><!-- 음식점 상세정보 end -->   
   						<div class="border-bottom pt-1 mb-2 pr-1" style="width: 98%;"></div>                   
         			</div>        
      			</div> <!-- 헤더 end-->                    
         			</div>        
      			

           
	 <!-- 하단 -->	
	<jsp:include page="../frame/bottom.jsp" flush="false"/>	

	<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<!-- JQUERY -->
<!-- 데이터 입력제어 -->	
<script>
$('[name=people_num]').keyup(function(e) {
    var reg = /[^0-9]/gi;
    var v = $('[name=people_num]').val();
  
    if (reg.test(v)) {  
    	$('[name=people_num]').val(v.replace(reg, ''));
        swal('숫자만 입력가능합니다');
        $('[name=people_num]').focus();
        return false;    	
     };

});

$('.go').click(function(e) {
      var reg = /[01](0|1|6|7|8|9)(\d{4}|\d{3})\d{4}$/g;  
      var v = $('[name=phone_number]').val();
      if(v.length!=11){ 
    	  swal("전화번호를 확인하세요");  
    	  return false;}
	      if (reg.test(v)) {  
	 			return true;
	       }else{
	           $('[name=phone_number]').val(v.replace(reg, ''));
	           alert('전화번호 형식을 입력해주세요');
	           $('[name=phone_number]').val("");
	           $('[name=phone_number]').focus();
	           return false;    	   
	       }
  
});
</script>
<!-- 즐겨찾기 -->	
<script>
	$(document).ready(function(){
		let opt = 1;
		let user_id = $('#user_id').val();
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
	/* 		if(confirm('즐겨찾기 로그인 후 이용가능합니다. 로그인 페이지로 이동할까요?')!=0){
				location.href=('login.jsp');
			}else{ return;} */
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
			/* 	if(confirm('즐겨찾기 로그인 후 이용가능합니다. 로그인 페이지로 이동할까요?')!=0){
					location.href=('login.jsp');
				}else{ return;} */
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