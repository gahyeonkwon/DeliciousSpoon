<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	<div class="card mb-3">
		<form action="searchMain.jsp" id="searchForm"><!-- 검색옵션 -->	
	  	<div class="mt-5 pb-5 row justify-content-center">	
				<div class="mr-sm-2">
				      <select name="options" class="form-control">
				        <option value="1" selected>전체</option>
				        <option value="2">제목</option>
				        <option value="3">작성자</option>						        		        
				      </select>	
			    </div> 		 
			    <div class="col-md-4">
			    <input class="form-control" type="text" placeholder="search" name="condition" required> 
			    </div>      
				<div> 	
					<button type="submit" class="btn btn-outline-warning" id="search">
					  <i class="fas fa-search"></i>
					</button>  
				</div>		
		</div>
		</form> <!--  검색옵션 end -->	
	
	</div>
	
