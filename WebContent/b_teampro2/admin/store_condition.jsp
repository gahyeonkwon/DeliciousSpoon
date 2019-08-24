<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>  
<%@ page import="b_teampro2.userinfo.UserWaitDataBean" %>    
<%@ page import="java.util.*" %>    
	<%
		request.setCharacterEncoding("utf-8");
		String title = "store_condition";
	%>
	<%
	   String store_id ="";
	   try{
		   store_id = (String)session.getAttribute("store_id");
		   
		   if(store_id==null || store_id.equals("")){
			   //로그인이 안되었을 경우 이동하는 페이지  
			   response.sendRedirect("admin_login.jsp");
		   }else{			   
				//대기중인 손님 리스트 출력
				UserSystemDBBean system = UserSystemDBBean.getInstance();
				List<UserWaitDataBean> waitingList = null;
				waitingList = system.getWaiting_list(store_id);			   
				//노쇼 , 취소 리스트 출력
				List<UserWaitDataBean> waitingList2 = null;
				waitingList2 = system.getWaiting_list2(store_id);					

	%>
	<jsp:include page="/_template/header.inc.jsp" flush="false">
	  <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

<body onload="loadJSON()">	
	<jsp:include page="admin_top.jsp" flush="false"/>
<!-- 왼쪽 메뉴 --> 	 
<input type="hidden" id="store_name" value="<%=system.getStore_name(store_id)%>">
<div class="container-fluid">
	<div class="row">
	    <nav class="col-md-2 d-none d-md-block bg-light sidebar">
	      <div class="sidebar-sticky text-left">
	        <ul class="nav flex-column"><br>
	          <li class="nav-item">
	            <a class="nav-link font-weight-bold" href="store_condition.jsp" style="color:black;">
	              <i class="fas fa-store-alt"></i> 매장 현황
	            </a>
	          </li><br>
	          <li class="nav-item">
	            <a class="nav-link" href="store_statistics.jsp" style="color:black;">
	              <i class="fas fa-chart-line"></i> 매장 통계
	            </a>
	          </li><br>
	          <li class="nav-item">
	            <a class="nav-link" href="store_info.jsp" style="color:black;">
	              <i class="fas fa-edit"></i> 매장 정보 등록
	            </a>
	          </li><br>
	          <li class="nav-item">
	            <a class="nav-link" href="admin_info.jsp" style="color:black;">
	              <i class="fas fa-cog"></i> 관리자 정보 수정
	            </a>
	          </li><br>	
	        </ul>
	      </div>
	    </nav>
		<div class="col-8"><br><br>
		<!-- 첫번째 카드 -->			
			<div>
 					<h4 class="card-header text-white text-left" style=" background-color: #fc5f4a">실시간 대기<a id="refresh"><i class="fas fa-redo-alt"></i></a></h4>				
 				<div class="card-body">
   					<div class="form-group row">
    					<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">이름</th>
						      <th scope="col">인원</th>
						      <th scope="col">대기번호</th>
						      <th scope="col">H.P</th>
						      <th scope="col">입장 여부</th>
						    </tr>
						  </thead>
						  <tbody>
			<% if(waitingList!=null){
			 		for (int i = 0 ; i < waitingList.size() ; i++){
			 			UserWaitDataBean waiting = (UserWaitDataBean)waitingList.get(i);
		  					if(waiting.getCheck_list()==1||waiting.getCheck_list()==2||waiting.getCheck_list()==3){
	  								continue;
	  						}
	  						%>

	  						<input type="hidden" class="store_id" value="<%=waiting.getStore_id()%>">								
	  						<input type="hidden" class="check_list" value="<%=waiting.getCheck_list()%>">
	  						<input type="hidden" class="user_id" value="<%=waiting.getUser_id()%>">
	  					    <input type="hidden" class="people_num" value="<%=waiting.getPeople_num()%>">
	  					     <input type="hidden" class="number" value="<%=waiting.getNo()%>">
						    <tr name="b">						    
						      <th scope="row"><%=waiting.getName()%></th><!-- 아래위 마진 맞추기 -->
						      <td><%=waiting.getPeople_num()%></td>
						      <td><%=waiting.getWait_number()%></td>
						      <td>0<%=waiting.getPhone_number()%></td>
						      
						      <td>
						      <button type="button" value="1" class="btn btn-depoon btn-sm yes">입장</button>
						      <button type="button" value="2" class="btn btn-dark btn-sm no">no show</button>						      
						      <button type="button" class="btn btn-light btn-warning sms" data-toggle="modal" data-target=".bd-example-modal-sm">SMS전송</button>
						    
						      </td>
						    </tr>
			<%}} %>			    
						  </tbody>
						</table>
					</div>					
				</div>
			</div>
		 </div>	
	</div><!-- row end -->
	<!--노쇼/취소 출력-->
	<div class="row">
			<div class="col-8 offset-md-2"><br><br>
			<!-- 첫번째 카드 -->
				<div>
	 					<h4 class="card-header text-left">노쇼/취소 <a id="refresh"><i class="fas fa-redo-alt"></i></a></h4>				
	 				<div class="card-body">
	   					<div class="form-group row">
	    					<table class="table">
							  <thead>
							    <tr>
							      <th scope="col">이름</th>
							      <th scope="col">인원</th>
							      <th scope="col">대기번호</th>
							      <th scope="col">H.P</th>
							      <th scope="col">입장 여부</th>
							    </tr>
							  </thead>
							  <tbody>
				<% if(waitingList2!=null){
				 		for (int i = 0 ; i < waitingList2.size() ; i++){
				 			UserWaitDataBean waiting = (UserWaitDataBean)waitingList2.get(i);
			  					if(waiting.getCheck_list()==1||waiting.getCheck_list()==0){
		  								continue;
		  						}
		  				
		  						%>
		  						<input type="hidden" class="store_id" value="<%=waiting.getStore_id()%>">								
		  						<input type="hidden" class="check_list" value="<%=waiting.getCheck_list()%>">
		  						<input type="hidden" class="user_id" value="<%=waiting.getUser_id()%>">
		  					    <input type="hidden" class="people_num" value="<%=waiting.getPeople_num()%>">
		  					    <input type="hidden" class="number" value="<%=waiting.getNo()%>">
		  					    
							    <tr name="b">						    
							      <th scope="row"><%=waiting.getName()%></th><!-- 아래위 마진 맞추기 -->
							      <td><%=waiting.getPeople_num()%></td>
							      <td><%=waiting.getWait_number()%></td>
							      <td>0<%=waiting.getPhone_number()%></td>
							   
							    <%if(waiting.getCheck_list()!=3){ %>  
							       <td>
							      <button type="button" value="1" class="btn btn-depoon btn-sm yes">재입장</button>							    
							      <button type="button" class="btn btn-warning btn-sm sms" data-toggle="modal" data-target=".bd-example-modal-sm">SMS전송</button>
							 	   </td>	
							    <%}else{
							    	
							    	%>
							    <td>
							    <input type="hidden" class="yes" value="1">
							   
							    <p>취소된 대기입니다.</p>
							    </td>
							    <%} %>
							     
							    </tr>
				<%}} %>			    
					  </tbody>
							</table>
						</div>					
					</div>
				</div>
			 </div>	
		</div><!-- row end -->	
</div>	<!-- container_fluid end -->

	<!-- SmS modal-->
<div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
   <form method="post" name="smsForm" action="sendpro.jsp">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">sms보내기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>    
       <input type="hidden" name="action" value="go"><!-- 발송타입 -->
        <input type="hidden" name="sphone1" value="010">
        <input type="hidden" name="sphone2" value="5769">
        <input type="hidden" name="sphone3" value="7531">
      <div class="modal-body">   
				<div class="container">										    				
					<div class="form-group row">
				    	<label class="col-sm-3 col-form-label">이름</label>
				    	<div class="col-sm-6">
				      	<input type="text" class="form-control" id="name" readonly>
				    	</div>
				  	</div> 
					<div class="form-group row">
				    	<label class="col-sm-3 col-form-label">H/P</label>
				    	<div class="col-sm-8">
				      	 <input type="text"  class="form-control" name="rphone" id="rphone">
				    	</div>
				  	</div>  																			
				  	<div class="form-group row">
				    	<label class="col-sm-5 col-form-label">보낼내용</label>
				    	<div class="col-sm-12">
				    		<textarea class="form-control" rows="3" name="msg" id="msg" required></textarea>
				    	</div>	
				    </div>										
				</div>								   
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-depoon">보내기</button>	        
      </div>
      </form>       
    </div>
  </div>
</div>	
	<jsp:include page="admin_bottom.jsp" flush="false"/>
	<jsp:include page="/_template/footer.inc.jsp" flush="false" />

	<% 
		   }
	    }catch(Exception e){
			e.printStackTrace();
		}
	%>
	<script>
	
$(document).ready(function(){

	$('.yes').click(function(){  	
		
		 swal({
	     title: "착석여부",
	     text: "입장처리 하시겠습니까?",
	     icon: "warning",
	     buttons: true,
	     dangerMode: true,
	   })
	   .then((willDelete) => {
	     if (willDelete) {
	    
		   	var index =$('.yes').index(this);
			var user_id  = $('.user_id').eq(index).val();
			var store_id = $('.store_id').eq(index).val();
			var opt = $('.yes').eq(index).val();
			var people_num = $('.people_num').eq(index).val();
			var number = $('.number').eq(index).val();
			console.log(index);
			console.log(people_num);
			console.log(number);
		
	        // ajax 실행
 	       $.ajax({
	            type : 'POST',
	            url : 'check.jsp',
	            data:{
	               user_id : user_id,
	               store_id : store_id,
	               people_num : people_num,
	               opt : opt,
	               number : number
	            },
	            cache: false,
	            dataType:"text",
	            success : 
	            	function(){    
	            	   swal("입장이 완료 되었습니다!", {
	          	         icon: "success",
	          	       })
	            	   .then((value) => {
	            		   location.reload(true);
           	         });
	            			                	
	            }
	        }); // end ajax 	 			
	     } else {
	      return false;
	     }
	   }); /* 
				if(confirm('입장확인')!=0){
					var index =$('.yes').index(this);
					var user_id  = $('.user_id').eq(index).val();
					var store_id = $('.store_id').eq(index).val();
					var opt = $('.yes').eq(index).val();
					var people_num = $('.people_num').eq(index).val();
					console.log(people_num);
				
		            // ajax 실행
		            $.ajax({
		                type : 'POST',
		                url : 'check.jsp',
		                data:{
		                   user_id : user_id,
		                   store_id : store_id,
		                   people_num : people_num,
		                   opt : opt
		                },
		                cache: false,
		                dataType:"text",
		                success : 
		                	function(){             
		                	location.reload(true);		                	
		                }
		            }); // end ajax					
				}else{ return false;}		 */	
	     
           });
	
	$('.no').click(function(){  	
			var index =$('.no').index(this);			
			var user_id  = $('.user_id').eq(index).val();
			var store_id = $('.store_id').eq(index).val();
			var opt = $('.no').eq(index).val();
			var number = $('.number').eq(index).val();
			console.log(index);
			console.log(store_id);
			console.log(user_id);
			console.log(opt);
           // ajax 실행
             $.ajax({
                type : 'POST',
                url : 'check.jsp',
                data:{
                   user_id : user_id,
                   store_id : store_id,
                   opt : opt,
                   number : number
                },
                cache: false,
                dataType:"text",
                success : 
                	function(){             
                	location.reload(true);		                	
                }
            }); // end ajax	 	 		 

   });

       $(".sms").click(function(){ 		
			var str = ""
			var tdArr = new Array();	// 배열 선언
			var checkBtn = $(this);		
			// checkBtn.parent() : checkBtn의 부모는 <td>이다.
			// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkBtn.parent().parent();
			var td = tr.children();
			
			console.log("클릭한 Row의 모든 데이터 : "+tr.text());
			
			var name = td.eq(0).text();
			var phone_number = td.eq(3).text();
			var p1 = phone_number.substr(0,3);
			var p2 = phone_number.substr(3,4);
			var p3 = phone_number.substr(7,4);
			var store_name = $('#store_name').val();
			$('#name').val(name);
			$('#rphone').val(p1+"-"+p2+"-"+p3);	
			$('#msg').html("[알림] <"+store_name+"> 고객님의 순서가 다가옵니다.매장 근처에서 대기해주세요 !");
			
		});
       
       
	$('#refresh').click(function(){
		location.reload(true);
	});	
	
});
</script>
 <script type="text/javascript">
          function setPhoneNumber(val) {
              var numList = val.split("-");
              document.smsForm.sphone1.value = numList[0];
              document.smsForm.sphone2.value = numList[1];
          if(numList[2] != undefined){
                  document.smsForm.sphone3.value = numList[2];
      }
          }

          function loadJSON() {
              var data_file = "/calljson.jsp";
              var http_request = new XMLHttpRequest();
              try {
                  // Opera 8.0+, Firefox, Chrome, Safari
                  http_request = new XMLHttpRequest();
              } catch (e) {
                  // Internet Explorer Browsers
                  try {
                      http_request = new ActiveXObject("Msxml2.XMLHTTP");

                  } catch (e) {

                      try {
                          http_request = new ActiveXObject("Microsoft.XMLHTTP");
                      } catch (e) {
                          // Eror
                          alert("지원하지 않는브라우저!");
                          return false;
                      }

                  }
              }
              http_request.onreadystatechange = function() {
                  if (http_request.readyState == 4) {
                      // Javascript function JSON.parse to parse JSON data
                      var jsonObj = JSON.parse(http_request.responseText);
                      if (jsonObj['result'] == "Success") {
                          var aList = jsonObj['list'];
                          var selectHtml = "<select name=\"sendPhone\" onchange=\"setPhoneNumber(this.value)\">";
                          selectHtml += "<option value='' selected>발신번호를 선택해주세요</option>";
                          for (var i = 0; i < aList.length; i++) {
                              selectHtml += "<option value=\"" + aList[i] + "\">";
                              selectHtml += aList[i];
                              selectHtml += "</option>";
                          }
                          selectHtml += "</select>";
                          document.getElementById("sendPhoneList").innerHTML = selectHtml;
                      }
                  }
              }

              http_request.open("GET", data_file, true);
              http_request.send();
          }
  </script>		 