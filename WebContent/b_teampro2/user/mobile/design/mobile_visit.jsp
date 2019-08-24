<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>

<% request.setCharacterEncoding("utf-8");%>
<%
String title="방문한 곳";
String user_id = (String)session.getAttribute("user_id");



try{  
	if(user_id==null||user_id.equals("")){
		response.sendRedirect("../design/mobile_login.jsp");
	}else{ 
		 //시스템 객체 생성
		UserSystemDBBean system = UserSystemDBBean.getInstance(); 
		List<UserReviewDataBean> dateList = null;
		List<UserReviewDataBean> reviewList = null;
		
		reviewList = system.getVisitedMobile(user_id);
		dateList = system.getVisitedDate_Mobile(user_id);

		
%>   
   
  
<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/>    
      <div class="container">
      	   <p class="c_text margin_sy mt-3">방문한곳</p>
      </div>
      <% 
      if(dateList!=null){
      for(int i=0;i<dateList.size();i++){
      	String date = dateList.get(i).getDate_format();
    	 %>
      <div class="container">
      	   <p class="s_title margin_sy mt-2"><%=date%> 방문</p>   
      	   
      	   <table class="table text-center margin_sy" style="width: 90%">
			  <tbody>
     	   <%  for(int j=0;j<reviewList.size();j++){
    		  UserReviewDataBean review = reviewList.get(j);
	    		  if(date.equals(review.getDate_format())){ 	
    	  %>  
			    <tr>
 			    
			      <td>
			      	<p class="title_visit" style="width:175px; margin-bottom:0px;"><%=review.getStore_name()%></p>
			      </td>
			      <td style="width: 145px">		
			      <%if(review.getCheck_review()==0){//작성전%>      	
	        		<a href="mobile_review.jsp?store_id=<%=review.getStore_id()%>" >
			        	<p class="align-middle" style="margin-bottom:0px;">리뷰쓰기        	
			        	<img  src="../../../img/write.png" class="ml-1"style="width: 20px; height: 20px;" /></p>
	        		</a>
	        		<%}else{//작성후%>
	        		<a href="mobile_myreview.jsp?store_id=<%=review.getStore_id()%>" >
			        	<p class="align-middle" style="margin-bottom:0px;">리뷰확인		        
			        	<img  src="../../../img/reviewlist.png" class="ml-1"style="width: 20px; height: 20px;" /></p>
	        		</a>	
	        	 <%}%>		        		
			      </td>			      
			    </tr>
			    <%}} %>

			  </tbody>
		 </table>
    </div>
    <%}}else{ %>
     <p style="margin-left:18px;">방문한 매장이 없습니다.</p>
    <%}%>
  
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