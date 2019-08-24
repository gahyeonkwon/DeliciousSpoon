<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>

<% request.setCharacterEncoding("utf-8");%>
<%  String title="대기목록";
	String user_id = (String)session.getAttribute("user_id");%>
<%
try{  
	if(user_id==null||user_id.equals("")){
		response.sendRedirect("../design/mobile_login.jsp");
	}else{ 
		 //시스템 객체 생성
		UserSystemDBBean system = UserSystemDBBean.getInstance(); 
		 //날짜 객체 생성
		DateFormat format1 = DateFormat.getDateInstance(DateFormat.LONG);
		//대기리스트 출력
		List<UserWaitDataBean> waitinfoList = null;
		waitinfoList = system.getMywaiting2(user_id);
		
		
%>   
<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/>   
    <div>
     	<p class="c_text margin_sy mt-3 mb-2">현재대기</p>
    </div>
    <div class="countarea">
 		<p class="title_my_gr w3-display-topright padding_sy" style="padding-top:58px; padding-right: 20px; color:#5D5D5D"><span class="refresh"><i class="fas fa-redo-alt ml-2"></i></span></p>
	</div>
	 <div class="border-bottom margin_sy" style="width:90%"></div>
	        <ul id="gallery">
	        <%	 if(waitinfoList!=null){
	   		 for (int i = 0 ; i < waitinfoList.size() ; i++){
				 UserWaitDataBean waitinfo = waitinfoList.get(i); %>
				<li>
				  <input class="check_list" type="hidden" value="<%=waitinfo.getCheck_list()%>">
          		  <input class="store_id2" type="hidden" value="<%=waitinfo.getStore_id()%>">
				  <a href="mobile_detailwaiting.jsp?store_id=<%=waitinfo.getStore_id()%>&user_id=<%=user_id%>">				  
						<div class="container">	
							<div class="row padding_sy">           
		                         <span class="thumb_sy2 padding_sy" style="padding-top:16px; padding-bottom: 16px;"><img src="/bban/imageFile/<%=waitinfo.getMain_photo()%>" style="width: 100px; height: 100px" alt="이미지1" /></span>
			                    <div class="text padding_sy ul_new" style="width:250px; padding-left: 60px; padding-top: 12px;">
			                     <span class="title"><%=waitinfo.getStore_name()%></span>
			                     <div class="container mt-2">	    
								    <div class="row" style="width: 100%;">
								    		<div class="col-7" style="padding-right:0px; padding-left:0px;">
									       		<span class="desc3" style="padding-left: 17px;">최근 호출 번호</span>
									       		<span class="number2_sy pl-2 text-center" style="color:#FC5F4A"><%=system.getLastcall(waitinfo.getStore_id())%></span>
									       </div>						    
									       <div class="col-5" style="padding-right:0px; padding-left:0px;">
									       		<span class="desc3 pl-3">내번호</span>
									       		<span class="number2_sy text-center"><%=waitinfo.getWait_number()%></span>
									       </div>					       
									  </div>     
								</div>       
			                  </div>
			                  </div>
			               </div>   
						
							
					</a>
				</li><!-- 대기 한개 끝 -->
				<div class="border-bottom margin_sy" style="width:90%"></div>
		 <%}}else{%>
		 		<p class="mt-3" style="margin-left:17px;">신청한 대기가 없습니다.</p> <!-- 가현이가 추가 -->
		 <%} %>	
				</ul>

 			     
<%}//로그인 상태 오류

  }catch(Exception e){}
	%>        	

<%

   try{
	  user_id = (String)session.getAttribute("user_id");
%>    
    
    <footer class="fixed-bottom container-content-center mt-4" id="footer">	
   	   <div align="center">  
           <p class="pt-2">개인정보 보호 정책 | 이용약관 </p>
<%  	   
	if(user_id==null ||user_id.equals("")){
%>           
		<form>
           <a href="../design/mobile_login.jsp" class="pr-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">로그인</a>
           
           <a href="../design/mobile_join.jsp" class="pl-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">회원가입</a>
		</form>
<%             
}else{
%>		
		<form>           
           <a href="../control/logout.jsp" id="footer_btn" style="text-decoration:none; color: #2478FF;">로그아웃</a>
        </form>
<% 
}
%>  
           <p class="pb-2">&copy; 2017-2018 Company, Inc. &middot;</p>
      	</div> 
        <div class="fixed-bottom" style="margin-bottom: 50px; margin-right: 10px;">
        </div> 
       
   </footer>
   <br>
<% 
	  
    }catch(Exception e){
		e.printStackTrace();
	}
%>    

	
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQERUY -->
<script>
 $('.refresh').click(function(){
		location.reload(true); 
 });

</script>
	