<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="b_teampro2.storeinfo.System_DBBean" %>   
<%@ page import="b_teampro2.storeinfo.System_DataBean" %>       
<%@ page import="java.util.*" %>  

<%
request.setCharacterEncoding("utf-8");
String title = "거절 리스트";
String master_id=(String)session.getAttribute("master_id"); 
%>

<jsp:include page="/_template/header.inc.jsp" flush="false">
<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="sysadmin_top.jsp" flush="false"/>
<%if(master_id==null||master_id.equals("")){
	response.sendRedirect("sysadmin_error.jsp");
}else{

	//대기중인 매장 리스트 출력
	System_DBBean system = System_DBBean.getInstance();
	List<System_DataBean> storeList = null;
	storeList = system.getStores();
		
%>

<div class="col-8 ml-4"><br><br>
<!-- 첫번째 카드 -->
     <h4 class="c_text text-right pr-4 ">매장리스트 <i class="fas fa-redo-alt" id="refresh"></i></h4>
<div class="accordion" id="accordionExample">
<% if(storeList!=null){
for (int i = 0 ; i < storeList.size() ; i++){
    		System_DataBean store = storeList.get(i);
    		
    		if(store.getConf()==0||store.getConf()==1){
    		//승인된 테이블이거나 , 대기중인 상태라면
    			continue;
    		}	
%>
<div class="card">
<input type="hidden" value="<%=store.getStore_id()%>" id="store_id">
<div class="card-header" id="1">
  <h5 class="mb-0">
    <button class="btn btn-link" type="button" style="color:black;" data-toggle="collapse" data-target="#1" aria-expanded="true" aria-controls="1">
<%=store.getStore_name()%>
    </button>
  </h5>
</div>					
<div id="1" class="collapse show" aria-labelledby="1" data-parent="#accordionExample">
  <div class="card-body">
  	<table class="table">
<thead>
  <tr>
    <th scope="col">사업자번호</th>
    <th scope="col">대표명</th>
    <th scope="col">아이디</th>
    <th scope="col">전화번호</th>
  </tr>
</thead>
<tbody>
  <tr>
    <th scope="row" class="align-middle"><%=store.getBusiness_no()%></th><!-- 아래위 마진 맞추기 -->
<th class="align-middle"><%=store.getName()%></th>
<th class="align-middle"><%=store.getStore_id()%></th>
<th class="align-middle">0<%=store.getStore_cellphone()%></th>
</tr>
<tr>
  <th class="align-middle">우편번호</th>
  <th colspan="2">주소</th>
  <th class="align-middle">재승인여부</th>
</tr>
<tr>
  <th class="align-middle"><%=store.getPost_num()%></th>
<th colspan="2"><%=store.getAddress()%><%out.print("  ");%><%=store.getAddress_detail()%></th>
      <th class="aling-middle">							      	
      	<button type="button" id="delete" value="3" class="btn btn-outline-dark">삭제</button>
      	<button type="button" id="reconf" value="4" class="btn btn-outline-dark">재승인</button>
      	<button type="button" id="sms" value="5" class="btn btn-outline-dark">sms</button>
      </th>
    </tr>  
        </tbody>
      </table>  
    </div>
  </div>
</div>
<div class="border-bottom"></div>


<%}} %>		

			</div>
</div>	 			  

<%}%>

<jsp:include page="sysadmin_bottom.jsp" flush="false"/>
<jsp:include page="/_template/footer.inc.jsp" flush="false" />
<JQUERY>
<script>
$(document).ready(function(){
	$('#delete').click(function(){  		  
	            var store_id = $('#store_id').val();
	            var opt = $('#delete').val();//0
	            // ajax 실행
	            $.ajax({
	                type : 'POST',
	                url : 'check.jsp',
	                data:{
	                   store_id : store_id,
	                   opt : opt
	                },
	                cache: false,
	                dataType:"text",
	                success : 
	                	function(){
	                	console.log("delete"); 
	                	location.reload();
	                }
	            }); // end ajax
           });

	$('#reconf').click(function(){  		  
        var store_id = $('#store_id').val();
        var opt = $('#reconf').val();//1
        // ajax 실행
        $.ajax({
            type : 'POST',
            url : 'check.jsp',
            data:{
               store_id : store_id,
               opt : opt
            },
            cache: false,
            dataType:"text",
            success :
            	function(){
            	console.log("reconf");
            	location.reload();
           			 }
            
        }); // end ajax
       });
	
	$('#refresh').click(function(){
		location.reload();
	});
	
});
	</script>

