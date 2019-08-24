<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String title="shopMain"; %>
<!-- header  -->
 
	<jsp:include page="/_template/header.inc.jsp" flush="false">
		<jsp:param name="title" value="<%=title%>"/>
	</jsp:include>	

  <div class="row">
    <div class="col"><jsp:include page="../module/top.jsp" flush="false" /> </div> 
  </div>
  <div class="row">
 	<div class="col"><jsp:include page="introList2.jsp" flush="false" /> </div> 
  </div>
  <div class="row">
    <div class="col-2 m-4"> <jsp:include page="../module/left.jsp" flush="false" /> </div> 
    <div class="col-8 p-2 m-2"><jsp:include page="introList.jsp" flush="false"/></div>   
  </div>





    <!-- footer -->
<jsp:include page="/_template/footer.inc.jsp" flush="false"/>
<script>
$(document).ready(function(){
	$("#search").click(function(){
		var formData = $("#searchForm").serialize();

     $.ajax({
         type: "GET",
         url: "searchMain.jsp", 
         data: formData,
         success: function(){     	 
        			 }

         });	 
	 
	  
 });
});

</script>