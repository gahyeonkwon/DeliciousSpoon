<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDBBean" %>    
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %>
   
	<%
		request.setCharacterEncoding("utf-8");
		String title = "관리자정보수정";
	%>
	
	<%
	   String store_id ="";
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
		StoreinfoDataBean store = logon.getAdmininfo(store_id); 
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
	            <a class="nav-link" href="store_info.jsp" style="color:black;">
	              <i class="fas fa-edit"></i> 매장 정보 등록
	            </a>
	          </li><br>
	          <li class="nav-item">
	            <a class="nav-link  font-weight-bold" href="admin_info.jsp" style="color:black;">
	              <i class="fas fa-cog"></i> 관리자 정보 수정
	            </a>
	          </li><br>	
	        </ul>
	      </div>
	    </nav>
		
		<div class="col-8"><br><br>
		  <form method="post" class="form-horizontal" action="admin_info_pro.jsp"  enctype="multipart/form-data">
			<!-- 첫번째 카드 -->
			<div class="card">
 				<h4 class="card-header text-left">관리자 정보 사항</h4>
 				<div class="card-body">
   					<div class="form-group row">
    					<label class="col-2 col-form-label">아이디</label>
    					<div class="col-9">
      						<input type="text" class="form-control" name="store_id" disabled="disabled" value="<%=store.getStore_id()%>" required>
    					</div>
  					</div>
  					<div class="form-group row">
    					<label class="col-2 col-form-label">비밀번호</label>
    					<div class="col-9">
      						<input type="password" class="form-control" name="store_passwd" placeholder="영문 대소문자/숫자를 조합 8~16자로 입력해주세요." required>
    					</div>
  					</div>
  					<div class="form-group row">
    					<label class="col-2 col-form-label">비밀번호 확인</label>
    					<div class="col-9">
      						<input type="password" class="form-control" placeholder="비밀번호를 한 번 더 입력해주세요." required>
    					</div>
  					</div>
  					<div class="form-group row">
    					<label class="col-2 col-form-label">전화번호</label>
    					<div class="col-9">
      						<input type="text" name="store_cellphone" class="form-control" value="0<%=store.getStore_cellphone()%>" placeholder="-를빼고 입력해주세요" required>
    					</div>
  					</div>
  					<div class="form-group row">
    					<label class="col-2 col-form-label">이름 (대표명)</label>
    					<div class="col-9">
      						<input type="text" class="form-control" name="name" disabled="disabled" value="<%=store.getName()%>" required>
    					</div>
  					</div>
  					<div class="form-group row">
    					<label class="col-2 col-form-label">사업자번호</label>
    					<div class="col-9">
      						<input type="text" class="form-control" name="business_no" value="<%=store.getBusiness_no() %>" readonly required>
    					</div>
  					</div>
  					<div class="form-group row">
    					<label class="col-2 col-form-label">상호</label>
    					<div class="col-9">
      						<input type="text" class="form-control" name="store_name" disabled="disabled" value="<%=store.getStore_name()%>" required>
    					</div>
  					</div>
  					<div class="form-group row">
   						<label class="col-2 col-form-label">매장 정보</label>
   						<div class="col-9">
   							<select class="form-control" name="category" required>
        						<option <%if(store.getCategory()==0){out.print("selected");}%> value="0">한식</option>
        						<option <%if(store.getCategory()==1){out.print("selected");}%> value="1">일식</option>
        						<option <%if(store.getCategory()==2){out.print("selected");}%> value="2">중식</option>
        						<option <%if(store.getCategory()==3){out.print("selected");}%> value="3">양식</option>
        						<option <%if(store.getCategory()==4){out.print("selected");}%> value="4">기타</option>
      						</select>
      					</div>
					</div>
					<div class="form-group row">
						<label class="col-2 col-form-label">주소</label>
    					<div class="col-3">
    						<input type="text" class="form-control" id="sample6_postcode"  placeholder="우편번호" <%if(store.getPost_num()==0){out.print(" value=\"\"");}
    						else{out.print(" value=\"0");%><%=store.getPost_num()%><%out.print("\"");}%> required>
    						<input type="hidden" name="post_num" value="<%=store.getPost_num()%>">
    					</div>
    					<div class="col-2">
    						<input type="button" class="btn btn-block btn-light" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
    					</div>
					</div>
					<div class="form-group row">
						<div class="col-6 offset-2">
							<input type="text" class="form-control" id="sample6_address" name="address" placeholder="주소" value="<%=store.getAddress()%>" required>
    					</div>
    					<div class="col-3">
    						<input type="text" class="form-control" id="sample6_address2" name="address_detail" placeholder="상세주소" value="<%=store.getAddress_detail()%>" required>
    					</div>
					</div>
               		<div class="form-group row">
                  		<label class="col-2 col-form-label">메인 사진</label>
                   		<div class="col-2 pt-2">
  		<%if(store.getMain_photo().equals("sample.jpg")||store.getMain_photo()==null){ %>
			<img class="rounded" src="../img/sample.jpg" name="user_photo" id="photo" style="width: 200px; height: 120px;">		 
		<%}else{ %> 
			<img class="rounded" src="/bban/imageFile/<%=store.getMain_photo()%>" id="photo" style="width: 200px; height: 120px;"> 	
		<%} %>                  		
                   		</div>
                   		<div class="col-3 pt-5 mt-5 pl-4">
                      		<input type="file" name="main_photo" id="main_photo" class="form-control-file">
                   		</div>
               		</div>
				</div>
			</div>
			<br>
			<input type="submit" class="btn btn-lg btn-block btn-dark" value="수 정 하 기">
		  </form>
		</div>	
	</div> <!-- row end -->
</div> <!-- container_fluid end -->
	<% 
		   }
	    }catch(Exception e){
			e.printStackTrace();
		}
	%>
	

	
	<jsp:include page="admin_bottom.jsp" flush="false"/>
	<jsp:include page="/_template/footer.inc.jsp" flush="false" />
	

<script>

var upload = document.getElementById('main_photo'),
    holder = document.getElementById('photo');

	upload.onchange = function (e) {
  e.preventDefault();

  var file = upload.files[0],
      reader = new FileReader();
  	reader.onload = function (event) {
    var img = new Image();
   img.src = event.target.result;
 
    holder.appendChild(img); 
 	var source = img.src;
    $('#photo').attr('src', source);    
  };
  reader.readAsDataURL(file);

  return false;
};
</script>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
    
</script>
 	