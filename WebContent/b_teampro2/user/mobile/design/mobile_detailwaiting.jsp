<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %>    
<%@ page import="b_teampro2.userinfo.UserSystemDBBean" %>   
<%@ page import="b_teampro2.userinfo.UserWaitDataBean" %>   
<%@ page import="b_teampro2.userinfo.UserinfoDataBean" %>   
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8");%>
<%String title="대기 신청 확인";%>


 <%
  //DB기본연결
	//system dbbean 객체생성
	String store_id = request.getParameter("store_id");
	String user_id  = (String)session.getAttribute("user_id");
	
	UserSystemDBBean system = UserSystemDBBean.getInstance(); 
	
	//내 waiting_list 출력하기
	UserWaitDataBean waiting_list = system.getMywaiting(store_id,user_id);
	//대기상태 출력하기
	int team = system.getCurrent_team(store_id);
	String store_name = system.getStore_name(store_id);

	
 %>           
<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/> 
  <input type="hidden" value="<%=store_id%>" class="store_id">
  <input type="hidden" value="<%=user_id%>" class="user_id">  
   <div class="container">
      <div class="container">
		<div class="card margin_sy" id="card_size_sy">
		   <img style="height: 269px" class="card-img" src="../../../img/waitingimg.png" alt="Card image">
	 		<div class="card-img-overlay">
		 		<p class="title3_sy text-center mt-2" style="color:white;"><%=store_name%></p>
		 		    <div class="text-center">
						  <p class="c_text margin_sy" style="color:white;">내 번호</p>
						  <p class="number_sy" style="color:white;"><%=waiting_list.getWait_number()%></p>
						  <p class="c_text margin_sy" style="color:white;"><%=team%>팀 남았습니다!</p>
					</div>   
			</div>	 	    
		</div>   	
	  <div class="container">
	   <div class="input-group">	   	
	     <input id="mragin_gr" type="text" value="<%=waiting_list.getName()%>" class="form-control" placeholder="신청이름" readonly>
	     <input id="mragin_gr" type="text" value="0<%=waiting_list.getPhone_number()%>" class="form-control" placeholder="전화번호" readonly>
	     <select id="mragin_gr" class="custom-select mb-1" disabled>
		  <option selected>인원</option>
		  <option  <%if(waiting_list.getPeople_num()==1){out.print("selected");}%>>1명</option>
		  <option  <%if(waiting_list.getPeople_num()==2){out.print("selected");}%>>2명</option>
		  <option  <%if(waiting_list.getPeople_num()==3){out.print("selected");}%>>3명</option>
		  <option  <%if(waiting_list.getPeople_num()==4){out.print("selected");}%>>4명</option>
		  <option  <%if(waiting_list.getPeople_num()==5){out.print("selected");}%>>5명</option>
		  <option  <%if(waiting_list.getPeople_num()==6){out.print("selected");}%>>6명</option>
		</select>
	   </div>
	  <p class="detail_sy margin_gr ml-3 mb-2">최대 6명까지 선택가능합니다.</p> 
	  </div>  
		<div class="container"> 
		  <button id="mragin_gr" type="submit" class="btn btn-depoon btn-block wait_delete">취소하기</button>			  	
		</div>
	</div>	
  </div>
	
<jsp:include page="../frame/bottom.jsp" flush="false"/>   	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<!-- JQUERY -->
<script>
 // 대기 취소
		$(".wait_delete").click(function(){
			 var store_id = $('.store_id').val();		 
			 var user_id = $('.user_id').val();
							//ajax 사용
			    $.ajax({
			        type : 'POST',
			        url : '../control/update_waitingcancel.jsp',
			        data:{
			         store_id : store_id,
			         user_id : user_id
			        },
			        cache: false,
			        dataType:"text",
			        success: function(){	        	
			       		 location.href="mobile_waitinglist.jsp?user_id="+user_id;
			       			      
			        }
		
			    }); // end ajax				
						
		});
 
</script>
	