<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="b_teampro2.storeinfo.*" %>    
<%@ page import="b_teampro2.userinfo.*" %>   

<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.text.*" %>

<%String title="검색페이지";

	String user_id = (String)session.getAttribute("user_id");
	//페이지에 위치 정보에 따른 데이터 불러오는 설정
	UserSystemDBBean system = UserSystemDBBean.getInstance(); 

	int category = 5;
	//조회순
	List<StoreinfoDataBean> storeList3 = null; 
	storeList3 = system.getStoresMobile(category,3);
%>

<jsp:include page="/_template/header.inc_m.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
  <jsp:include page="../frame/top.jsp" flush="false"/> 
    	   	
  <input type="hidden" value=<%=user_id%> id="user_id">	
    <form action="mobile_search_done.jsp" method="post">
       <div class="input-group" style="margin-top: 16px;">
    	<div class="margin_sy">
		   	<ul style="width: 100%;">
		        <li_sy1>
		           <input style="width: 295px"class="form-control" name="key" type="text" placeholder="검색" >
		        </li_sy1>
		        <li_sy2>
		           <button class="btn btn-small btn-depoon" type="submit" style="margin-bottom:5px;margin-left: 31px; height: 35px;">
		           <i  class="fas fa-search"></i></button>
		        </li_sy2>
		   	</ul>
		 </div>  	

		</div>
	</form>    
	 
	 	<p class="c_text margin_sy mt-3">이런 매장은 어떠세요?</p>         
       	<p class="detail_sy margin_sy mb-3">Delicious Spoon이 추천하는 맛집이에요</p>       
		<div class="border-bottom margin_sy" style="width:90%"></div>	   	
	        <ul id="gallery">
	<%  try{
		if(storeList3!=null){
	
			 for (int i = 0 ; i < storeList3.size() ; i++){
			       StoreinfoDataBean store = storeList3.get(i);
			       	String names = storeList3.get(i).getMenu_names();
					String name [] = names.split(",");   %>  	     
		<input type="hidden" value="<%=store.getStore_id()%>" class="store_id">
	    <input type="hidden" value="<%=system.getFavoriteCount(store.getStore_id(),user_id)%>" class="favorite">	   
				<li class="mt-1">
                 <div class="photo_main_mobile2 padding_sy"> 
                        <div class="row padding_sy">           
                         <span class="thumb_sy2" style="padding-top:8px; padding-bottom: 8px;"><img src="/bban/imageFile/<%=store.getMain_photo()%>" style="width: 80px; height: 78px" alt="이미지1" /></span>
                    <div class="text padding_sy ul_new" style="width:200px;">
                     <span class="title"><%=store.getStore_name()%></span>
                     <span class="desc"><%for(int j=0;j<name.length;j++){out.print(name[j]+" ");}%></span>
                     <span class="desc2"><i class="far fa-heart mr-1"></i><%=system.getFavoriteCount2(store.getStore_id())%>
                     <i class="far fa-comment mr-1 ml-3"></i><%=system.getReviewCount(store.getStore_id())%>                     
                  </div>
                  </div>
                  <div class="photo_main_up_mobile2 padding_sy">
                     <span class="heart  w3-display-topright pb-1 mt-2 mr-3" style="padding-right:30px;">
                       <div style="position: absolute;">
                          <span class="linelike">
                             <img style="width: 25px; height: 25px;" src="../../../img/linelike_red.png"/>
                          </span>
                      </div>
                      <div style="position: absolute;">
                          <span class="like">
                             <img style="width: 25px; height: 25px;" src="../../../img/heart_red.png"/>
                         </span>
                      </div>
                   </span>
                  <span class="w3-display-bottomright mb-1" style="padding-right:20px; font-size:1.5rem;">
                            <i class=" wait_sy fas fa-user mr-1 ml-3"></i><%=system.getCurrent_team(store.getStore_id())%>                
                   </span>
                  <a href="mobile_detail.jsp?store_id=<%=store.getStore_id()%>" >
                     <div class="img_area4 w3-display-bottomleft padding_sy"></div>
                        <div class="img_area3 w3-display-topleft padding_sy"></div>                        
                     </a> 
                  </div>                  
               </div>       

            </li>
				<div class="border-bottom margin_sy" style="width:90%"></div>
				  <%}}
}catch(Exception e){}
				  %>  	
			  </ul>
			 </div> 
			 	
<jsp:include page="../frame/bottom.jsp" flush="false"/>   			  
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<!-- JQUERY -->
<!-- 즐겨찾기  -->
 <script>

	$(document).ready(function(){
		let opt = 1;
		let user_id = $('#user_id').val();
		var favorite_length = $('.favorite').length;
		for(var i=0;i<favorite_length;i++){
			var favorite = $('.favorite').eq(i).val();
			 console.log(i+": "+favorite);
				if(favorite==0){
					$(".linelike").eq(i).show();	
					$(".like").eq(i).hide();
				}else{
					$(".like").eq(i).show();
				};
		}
		
		$(".linelike").click(function(){	
		
		if(user_id=="null"||user_id==""){
			swal({
			     title: "즐겨찾기",
			     text: "로그인 후 이용 가능 합니다. 로그인으로 이동할까요?",
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
		var index = $(".linelike").index(this);
			console.log(index); 
			$(".like").eq(index).show();
	
			var store_id =$(".store_id").eq(index).val();	
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
				     text: "로그인 후 이용 가능 합니다.\n로그인으로 이동할까요?",
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
			var index = $(".like").index(this);
			$(".like").eq(index).hide();
			var store_id =$(".store_id").eq(index).val();	
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

	});

</script>	

	