<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   
<%@ page import="java.util.*" %>   
<%@ page import = "java.text.*" %>

<% request.setCharacterEncoding("utf-8");%>
<%
String title="리뷰확인";
String user_id = (String)session.getAttribute("user_id");%>
<%
try{  
	if(user_id==null||user_id.equals("")){
		response.sendRedirect("../control/error.jsp");
	}else{ 
		 //시스템 객체 생성
		UserSystemDBBean system = UserSystemDBBean.getInstance(); 
		 //날짜 객체 생성
		DateFormat format1 = DateFormat.getDateInstance(DateFormat.LONG);
	       

		//3.리뷰	
			//매장에 달린 리뷰 총갯수
			int review_count = system.getReviewCount2(user_id);				
			//리뷰 출력하는 객체 생성
			List<UserReviewDataBean> reviewList = null;
		    reviewList = system.getReviews2(user_id,0,0);

		
%>   
   
<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/> 
    <div>
     	<p class="c_text margin_sy mt-3 mb-2">내가 쓴 리뷰 확인</p>
    </div> 
     <div class="border-bottom margin_sy" style="width:90%"></div>   
    <div>	   	
	        <ul id="gallery">
	
 <% 	if(reviewList!=null){
						 for (int i = 0 ; i < reviewList.size() ; i++){ 
						  UserReviewDataBean review = reviewList.get(i);
						  ArrayList<String> r_photo= new ArrayList<String>(); 
						  String review_photos = review.getReview_photos();
						  if(review_photos!=null){
						  String review_photo [] = review_photos.split(",");
						
						  for(int j=0;j<review_photo.length;j++){
							  r_photo.add(review_photo[j]);
						  }}		
						  %>
	
						  
				<li  class="mt-1">
				  <a href="mobile_detail.jsp?store_id=<%=review.getStore_id()%>">
					<%-- <span class="thumb_sy"><img  class="rounded" src="/bban/imageFile/<%=review.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span> --%>								
						<div class="padding_sy">	
							<div class="row padding_sy">           
	                         <span class="thumb_sy2" style="padding-top:8px;"><img src="/bban/imageFile/<%=review.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span>	
								<div class="text ul_new" style=" padding-left: 16px; width:230px; height: 50px;">
				                     <span class="title"><%=review.getStore_name()%></span>
					                     <div class="container"> <!--  이부분 mobile detail.jsp에서 따오사ㅓ바꿈 -->
										    <div class="row" style="padding-left: 16px;">						    
											<!--     <div class="mb-1 justify-content-center"> 여기 없어야 묶임-->
												  <span class="starRe<%if(review.getScore()>=1){out.print(" on");}%>">1</span>
												  <span class="starRe<%if(review.getScore()>=2){out.print(" on");}%>">2</span>
												  <span class="starRe<%if(review.getScore()>=3){out.print(" on");}%>">3</span>
												  <span class="starRe<%if(review.getScore()>=4){out.print(" on");}%>">4</span>
												  <span class="starRe<%if(review.getScore()>=5){out.print(" on");}%>">5</span>				   										
											   <!-- </div> -->	
												<span class="detailreview_sy ml-2" style="padding-top: 2px;"><%=format1.format(review.getReg_date())%>방문</span>								
											</div>
											<span class="title" style="margin-top: 12px;">"<%=review.getReview_title()%>"</span>
										</div>                    
				                  </div>
				                  <div class="row">
					                  <span class="text ul_new mt-2" style=" padding-left: 95px; width:350px;">									
										<span class="desc4 padding_sy"><%=review.getReview_content()%></span>
									</span>
								</div>		
								<div style="padding-left: 100px;"> 
								 <%  if(review_photos!=null){
								 for(int j=0;j<r_photo.size();j++){ %>		
		                               <img src="/bban/imageFile/<%=r_photo.get(j)%>" class="mr-2" style="width: 50px; height: 50px;">
		                             
		                                     <%}}%>                                                                        
	                           </div>
				            </div>
						  </div>
					</a>

				</li>
				 <div class="border-bottom margin_sy mt-3" style="width:90%"></div>
				 <%}}else{ %>
				 	<p class="ml-3 mt-3">작성한 리뷰가 없습니다.</p>
				 <% }%>
				</ul>
			 </div>
<%}//로그인 상태 오류

  }catch(Exception e){}
	%>  			 
<jsp:include page="../frame/bottom.jsp" flush="false"/>   		
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

	
	