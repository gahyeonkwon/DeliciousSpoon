<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
   String user_id ="";
   try{
	  user_id = (String)session.getAttribute("user_id");
%>    
    
    <footer class="container-content-center mt-4" id="footer">	
   	   <div align="center">  
           <p class="pt-2">�������� ��ȣ ��å | �̿��� </p>
<%  	   
	if(user_id==null ||user_id.equals("")){
%>           
		<form>
           <a href="../design/mobile_login.jsp" class="pr-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">�α���</a>
           
           <a href="../design/mobile_join.jsp" class="pl-1" id="footer_btn" style="text-decoration:none; color: #2478FF;">ȸ������</a>
		</form>
<%             
}else{
%>		
		<form>           
           <a href="../control/logout.jsp" id="footer_btn" style="text-decoration:none; color: #2478FF;">�α׾ƿ�</a>
        </form>
<% 
}
%>  
           <p class="pb-2">&copy; 2017-2018 Company, Inc. &middot;</p>
      	</div> 
        <div class="fixed-bottom" style="margin-bottom: 50px; margin-right: 10px;">
           <p class="float-right"><a href="#" style="color:#FC5F4A;"><i id="bottom_sy" class=" fas fa-arrow-circle-up"></i></a></p>  
        </div> 
   </footer>
<% 
	  
    }catch(Exception e){
		e.printStackTrace();
	}
%>    
