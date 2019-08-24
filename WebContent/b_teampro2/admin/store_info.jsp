<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDBBean" %>    
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %> 

   <%
      request.setCharacterEncoding("utf-8");
      String title = "매장정보등록";
   %>
   
   <%
      String store_id ="";
   ArrayList<String> menu_name = new ArrayList<String>();
   ArrayList<String> menu_price = new ArrayList<String>();		
   ArrayList<String> menu_photo= new ArrayList<String>();
   ArrayList<String> store_photo= new ArrayList<String>(); 
   try{
         store_id = (String)session.getAttribute("store_id");
         
         if(store_id==null || store_id.equals("")){
            //로그인이 안되었을 경우 이동하는 페이지  
            response.sendRedirect("admin_login.jsp");
         }else{
   %>
   
   <jsp:include page="/_template/header.inc.jsp" flush="false">
     <jsp:param name="title" value="<%=title %>"/>
   </jsp:include>
   
   <jsp:include page="admin_top.jsp" flush="false"/>
   
   <% 
 
      StoreinfoDBBean logon = StoreinfoDBBean.getInstance(); 
    		//출력하는함수
      StoreinfoDataBean store = logon.getStoreinfo(store_id); 
    		
    		if(store.getMenu_names()!=null||store.getMenu_prices()!=null||store.getMenu_photos()!=null||store.getStore_photos()!=null){
 				   			
    			//꺼내와서 , 있는상태로출력
    			String names = store.getMenu_names();
    		 	String prices = store.getMenu_prices();   			
    			String photos = store.getMenu_photos();
    			String store_photos = store.getStore_photos();
    			//배열로옮기기  			
   				String name [] = names.split(",");   				 
   				String price [] = prices.split(",");
   				String photo [] = photos.split(",");
   				String storephoto [] = store_photos.split(",");
   				
    			for (int i = 0; i <name.length; i++) {
    			    menu_name.add(name[i]);
    			}
    			for (int i = 0; i <price.length; i++) {
    			    menu_price.add(price[i]);
    			}
    			for (int i = 0; i <photo.length; i++) {
    			    menu_photo.add(photo[i]);
    			}    			
    			for(int i= 0;i<3;i++){    
    				if(storephoto.length>i){
    					store_photo.add(storephoto[i]);        	    					 			      						
      	  				}else{
      	  				store_photo.add("sample.jpg");  
      	  				}					
    						
    			}       				
    		}else{
    			for(int i=0;i<3;i++){
    			menu_name.add("null");
    			menu_price.add("null");
    			menu_photo.add("sample.jpg");
    			store_photo.add("sample.jpg");
   			
    			}
    		}
   %>

<!-- 왼쪽 메뉴 -->     

<div class="container-fluid">
   <div class="row">
       <nav class="col-md-2 d-none d-md-block bg-light sidebar">
         <div class="sidebar-sticky text-left">
           <ul class="nav flex-column"><br>
             <li class="nav-item">
               <a class="nav-link" href="store_condition.jsp" style="color:black;">
                 <i class="fas fa-store-alt"></i> 매장 현황
               </a>
             </li><br>
             <li class="nav-item">
               <a class="nav-link" href="store_statistics.jsp" style="color:black;">
                 <i class="fas fa-chart-line"></i> 매장 통계
               </a>
             </li><br>
             <li class="nav-item">
               <a class="nav-link font-weight-bold" href="store_info.jsp" style="color:black;">
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
        <form method="post" class="form-horizontal" action="store_info_pro.jsp" enctype="multipart/form-data">
      
         <!-- 첫번째 카드 -->
         <div class="card">
             <h4 class="card-header text-left">매장 정보</h4>
             <div class="card-body">
                  <h5 class="card-title text-left"><i class="fas fa-info"></i> 매장 소개</h5>
                <textarea class="form-control" rows="3" name="intro" required><%=store.getIntro()%></textarea>
            </div>
            <div class="card-body row">
               <div class="col-6">
                     <h5 class="card-title text-left"><i class="fas fa-clock"></i> 매장 영업 시간</h5>
                     <textarea class="form-control" rows="3" name="open_time" required><%=store.getOpen_time()%></textarea>
                  </div>
                  <div class="col-6">
                     <h5 class="card-title text-left"><i class="fas fa-calendar-check"></i> 매장 영업 요일</h5>
                   <textarea class="form-control" rows="3" name="open_day" required><%=store.getOpen_day()%></textarea>
                  </div>
            </div>
            <div class="card-body row">
               <div class="col-6">
                     <h5 class="card-title text-left"><i class="fas fa-phone"></i> 매장 전화 번호</h5>
                     <input type="text" class="form-control" name="store_phone" <%if(store.getStore_phone()==0){out.print(" placeholder=\"-를 빼고 입력해주세요.\"");}
                     else{out.print(" value=\"0");%><%=store.getStore_phone()%><%out.print("\"");}%> required>
               </div>
               <div class="col-6">
                     <h5 class="card-title text-left"><i class="fas fa-couch"></i> 매장 좌석 수</h5>
                     <input type="text" class="form-control text-left" name="seat_count" <%if(store.getSeat_count()==0){out.print(" placeholder=\"총 좌석수를 입력해주세요(숫자만 입력)\"");}
                     else{out.print(" value=\"");%><%=store.getSeat_count()%><%out.print("\"");}%> required>
               </div>
            </div>
            <div class="card-body">
                <h5 class="card-title text-left"><i class="fas fa-store-alt"></i> 매장 사진</h5>
                  <div class="row">
                     <div class="col-6 col-md-4">
               	<%if(store_photo.get(0).equals("sample.jpg")){ %>
						<img class="rounded" src="../img/sample.jpg" id="photo4" style="width: 285px; height: 185px;">		 
					<%}else{ %> 
						<img class="rounded" src="/bban/imageFile/<%=store_photo.get(0)%>" id="photo4" style="width: 285px; height: 185px;"> 	
					<%} %> 
                      <input type="file" class="form-control-file ml-5 mt-2 " name="store_photo1" id="store_photo1">
                      <!-- <button type="button" class="btn btn-block btn-dark ml-5 mt-2" style="width: 285px;">이미지 변경</button> -->
                     </div>
                     <div class="col-6 col-md-4">
               	<%if(store_photo.get(1).equals("sample.jpg")){ %>
						<img class="rounded" src="../img/sample.jpg" id="photo5" style="width: 285px; height: 185px;">		 
					<%}else{ %> 
						<img class="rounded" src="/bban/imageFile/<%=store_photo.get(1)%>" id="photo5" style="width: 285px; height: 185px;"> 	
					<%} %> 
                        <input type="file" class="form-control-file ml-5 mt-2" name="store_photo2" id="store_photo2">
                        <!-- <button type="button" class="btn btn-block btn-dark ml-5 mt-2" style="width: 285px;">이미지 변경</button> -->
                     </div> 
                     <div class="col-6 col-md-4">
               	<%if(store_photo.get(2).equals("sample.jpg")){ %>
						<img class="rounded" src="../img/sample.jpg" id="photo6" style="width: 285px; height: 185px;">		 
					<%}else{ %> 
						<img class="rounded" src="/bban/imageFile/<%=store_photo.get(2)%>" id="photo6" style="width: 285px; height: 185px;"> 	
					<%} %>                       
                        <input type="file" class="form-control-file ml-5 mt-2" name="store_photo3" id="store_photo3">
                        <!-- <button type="button" class="btn btn-block btn-dark ml-5 mt-2" style="width: 285px;">이미지 변경</button> -->
                     </div>
                  </div> 
            </div>
         </div>   
         <br>
         <!-- 두번째 카드 -->
         <div class="card">
             <h4 class="card-header text-left">메뉴 정보</h4>
            <div class="card-body row">
               <div class="col-6 col-md-4">
                  <h5 class="card-title text-center"><i class="fas fa-utensils"></i> 인기 대표 메뉴 1</h5>
               	<%if(menu_photo.get(0).equals("sample.jpg")){ %>
						<img class="rounded" src="../img/sample.jpg" id="photo1" style="width: 285px; height: 185px;">		 
					<%}else{ %> 
						<img class="rounded" src="/bban/imageFile/<%=menu_photo.get(0)%>" id="photo1" style="width: 285px; height: 185px;"> 	
					<%} %> 
					
                  <input type="text" required class="form-control ml-5 mt-2 mb-2"
                   placeholder="메뉴 이름을 입력해주세요." style="width: 285px;" 
                   name="menu_name" id="menu_name1" <%if(!menu_name.get(0).equals("null")){out.print(" value=\"");%><%=menu_name.get(0)%><%out.print("\"");} %>>
                     <input type="text" required class="form-control ml-5 mt-2 mb-2"<%if(!menu_price.get(0).equals("null")){out.print(" value=\"");%><%=menu_price.get(0)%><% out.print("\"");} %> 
  						name="menu_price" placeholder="메뉴 가격을 입력해주세요." style="width: 285px;">
                     <input type="file" class="form-control-file ml-5" name="menu_photo1" id="menu_photo1">
                    <!--  <button type="button" class="btn btn-block btn-dark ml-5 mt-2" style="width: 285px;">메뉴변경</button> -->
               </div>
               
               
        
                <div class="col-6 col-md-4">
                  <h5 class="card-title text-center"><i class="fas fa-utensils"></i> 인기 대표 메뉴 2</h5>
               	<%if(menu_photo.get(1).equals("sample.jpg")||menu_photo.get(1).equals("null")){ %>
						<img class="rounded" src="../img/sample.jpg" id="photo2" style="width: 285px; height: 185px;">		 
					<%}else{ %> 
						<img class="rounded" src="/bban/imageFile/<%=menu_photo.get(1)%>" id="photo2" style="width: 285px; height: 185px;"> 	
					<%} %> 
                  <input type="text" required class="form-control ml-5 mt-2 mb-2"
                   placeholder="메뉴 이름을 입력해주세요." style="width: 285px;" 
                   name="menu_name" id="menu_name2"<%if(!menu_name.get(1).equals("null")){out.print(" value=\"");%><%=menu_name.get(1)%><%out.print("\"");}%>>
                     <input type="text" class="form-control ml-5 mt-2 mb-2"<%if(!menu_price.get(1).equals("null")){out.print(" value=\"");%><%=menu_price.get(1)%><%out.print("\"");}%> name="menu_price" placeholder="메뉴 가격을 입력해주세요." style="width: 285px;" required>
                     <input type="file" class="form-control-file ml-5" name="menu_photo2" id="menu_photo2">
                     <!-- <button type="button" class="btn btn-block btn-dark ml-5 mt-2" style="width: 285px;">메뉴변경</button> -->
               </div>
               
               
               
               <div class="col-6 col-md-4">
                  <h5 class="card-title text-center"><i class="fas fa-utensils"></i> 인기 대표 메뉴 3</h5>
               	<%if(menu_photo.get(2).equals("sample.jpg")){ %>
						<img class="rounded" src="../img/sample.jpg" id="photo3" style="width: 285px; height: 185px;">		 
					<%}else{ %> 
						<img class="rounded" src="/bban/imageFile/<%=menu_photo.get(2)%>" id="photo3" style="width: 285px; height: 185px;"> 	
					<%} %> 
                  <input type="text" required class="form-control ml-5 mt-2 mb-2"
                   placeholder="메뉴 이름을 입력해주세요." style="width: 285px;" 
                   name="menu_name" id="menu_name3"<%if(!menu_name.get(2).equals("null")){out.print(" value=\"");%><%=menu_name.get(2)%><%out.print("\"");}%>>
                     <input type="text" class="form-control ml-5 mt-2 mb-2"<%if(!menu_price.get(1).equals("null")){out.print(" value=\"");%><%=menu_price.get(2)%><%out.print("\"");}%> name="menu_price" placeholder="메뉴 가격을 입력해주세요." style="width: 285px;" required>
                     <%-- <input type="text" class="form-control ml-5 mt-2 mb-2"<%if(!menu_price.get(2).equals("null")){out.print(" value=\"");%><%=menu_price.get(2)%><%out.print("\"");}%> name="menu_price" placeholder="메뉴 가격을 입력해주세요." style="width: 285px;" required> --%>
                     <input type="file" class="form-control-file ml-5" name="menu_photo3" id="menu_photo3">
               <!--       <button type="button" class="btn btn-block btn-dark ml-5 mt-2" style="width: 285px;">메뉴변경</button> -->
               </div>
 
               

            </div>
         </div>
         <br>
         <input type="submit" class="btn btn-lg btn-block btn-dark" value="등 록 하 기">
        </form>
      </div>   
   </div> <!-- row end -->
</div> <!-- container_fluid end -->
  
   <jsp:include page="admin_bottom.jsp" flush="false"/>
   <jsp:include page="/_template/footer.inc.jsp" flush="false" />
   
   <% 
         }
       }catch(Exception e){
         e.printStackTrace();
      }
   %>
   
<script>

var upload = document.getElementById('menu_photo1'),
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

var upload2 = document.getElementById('menu_photo2'),
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

var upload3 = document.getElementById('menu_photo3'),
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

//<!--여기부터 store_photo --- >나중에 수정될 부분-->
var upload4 = document.getElementById('store_photo1'),
holder4 = document.getElementById('photo4');

upload4.onchange = function (e) {
e.preventDefault();

var file4 = upload4.files[0],
reader4 = new FileReader();
	reader4.onload = function (event) {
    var img4 = new Image();
   img4.src = event.target.result;
 
    holder4.appendChild(img4); 
 	var source4 = img4.src;
    $('#photo4').attr('src', source4);    
};
reader4.readAsDataURL(file4);

return false;
};

var upload5 = document.getElementById('store_photo2'),
holder5 = document.getElementById('photo5');

upload5.onchange = function (e) {
e.preventDefault();

var file5 = upload5.files[0],
reader5 = new FileReader();
	reader5.onload = function (event) {
    var img5 = new Image();
   img5.src = event.target.result;
 
    holder5.appendChild(img5); 
 	var source5 = img5.src;
    $('#photo5').attr('src', source5);    
};
reader5.readAsDataURL(file5);

return false;
};


var upload6 = document.getElementById('store_photo3'),
holder6 = document.getElementById('photo6');

upload6.onchange = function (e) {
e.preventDefault();

var file6 = upload6.files[0],
reader6 = new FileReader();
	reader6.onload = function (event) {
    var img6 = new Image();
   img6.src = event.target.result;
 
    holder6.appendChild(img6); 
 	var source6 = img6.src;
    $('#photo6').attr('src', source6);    
};
reader6.readAsDataURL(file6);

return false;
};

</script>


