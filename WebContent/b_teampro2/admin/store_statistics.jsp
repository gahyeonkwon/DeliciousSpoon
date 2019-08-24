<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%
		request.setCharacterEncoding("utf-8");
		String title = "매장 통계";
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
	            <a class="nav-link font-weight-bold" href="store_statistics.jsp" style="color:black;">
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
			<div class="card">
 				<h4 class="card-header text-left">검색 기간</h4>
 				<div class="card-body">
   					<div class="form-group row justify-content-center">
						<input type="date" value="2018-10-01">
						<a class="pl-3 pr-3 pt-2">~</a>
						<input type="date" value="2018-10-01">
						<button type="button" class="btn btn-dark">검색</button>
					</div>
				</div>
			</div>
			<br>
			<div class="card">
 				<h4 class="card-header text-left">시간별 통계 <a name="refresh"><i class="fas fa-redo-alt"></i></a></h4>
 				<div class="card-body">
   					<div class="form-group row">
  						<div class="offset-2" id="chart_div1" style="width:900px; height:500px;"></div>
					</div>
				</div>
			</div>
			<br>
			<div class="card">
 				<h4 class="card-header text-left">성별 통계 <a name="refresh"><i class="fas fa-redo-alt"></i></a></h4>
 				<div class="card-body">
   					<div class="form-group row">
    					<div class="offset-3" id="chart_div3" style="width: 900px; height: 500px;"></div>
					</div>
				</div>
			</div>									
		 </div>	
	</div><!-- row end -->
</div>	<!-- container_fluid end -->
	
	<jsp:include page="admin_bottom.jsp" flush="false"/>
	<jsp:include page="/_template/footer.inc.jsp" flush="false" />
	
	<% 
		   }
	    }catch(Exception e){
			e.printStackTrace();
		}
	%>
	
	<script>
	$('[name=refresh]').click(function() {
		location.reload();
		});
	</script>

	<!-- 시간별 통계  -->	
	<script type="text/javascript">
	
    var queryObject = "";
    var queryObjectLen = "";
    $.ajax({
        type : 'POST',
        url : 'chart_sample.jsp',
        dataType : 'json',
        success : function(data) {            
            
            queryObject = eval('(' + JSON.stringify(data,null, 2) + ')');             
            // stringify : 인자로 전달된 자바스크립트의 데이터(배열)를 JSON문자열로 바꾸기.   
            // eval: javascript 코드가 맞는지 검증하고 문자열을 자바스크립트 코드로 처리하는 함수 
 	//       queryObject.linelist[0].city ="korea"
 
            queryObjectLen = queryObject.linelist.length;
            // queryObject.empdetails 에는 4개의 Json 객체가 있음 
 
            //alert('ㅋㅋ' + queryObjectLen);
            // alert(queryObject.barlist[0].city +queryObject.barlist[0].per );
        },
        error : function(xhr, type) {
            alert('server error occoured')
        }
    });
    
	google.charts.load('current', {packages: ['corechart', 'line']});
	google.charts.setOnLoadCallback(drawAxisTickColors);

	function drawAxisTickColors() {
	      var data = new google.visualization.DataTable();
	      data.addColumn('number', '시간');
	      data.addColumn('number', '총인원수');
	      //data.addColumn('number', '방문팀수');
	  		
	    data.addRows([[2,6],[3,5],[4,6],[5,25],[6,33],[7,89],[8,33]]);
	/*       for (var i=0;i<queryObjectLen; i++){
	    	  var people_num = queryObject.linelist[i].people_num;
	          var reg_date = queryObject.linelist[i].reg_date;
	          var team = queryObject.linelist[i].team;
		      data.addRows([
		    	[reg_date,people_num,team]
		      ]);
	      } */

	      var options = {
	        hAxis: {
	          title: '시간',
	          textStyle: {
	            color: 'black',
	            fontSize: 15,
	            fontName: 'Arial',
	            bold: true
	          },
	          titleTextStyle: {
	            color: 'black',
	            fontSize: 15,
	            fontName: 'Arial',
	            bold: true
	          }
	        },
	        vAxis: {
	          title: '인원',
	          textStyle: {
	            color: 'black',
	            fontSize: 15,
	            bold: true
	          },
	          titleTextStyle: {
	            color: 'black',
	            fontSize: 15,
	            bold: true
	          }
	        },
	        colors: ['#a52714']
	      };
	      var chart = new google.visualization.LineChart(document.getElementById('chart_div1'));
	      chart.draw(data, options);
	    }
	</script>
	
	<!-- 성별 통계 -->	
	<script type="text/javascript">
	google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = google.visualization.arrayToDataTable([
        ['Gender', 'percent'],
        ['남', 42],
        ['여', 58]
      ]);

      var options = {
        
      };

      var chart = new google.visualization.PieChart(document.getElementById('chart_div3'));

      chart.draw(data, options);
    }
	</script>