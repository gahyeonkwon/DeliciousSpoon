<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.storeinfo.*" %>     
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>


<% request.setCharacterEncoding("utf-8");
String store_id = (String)session.getAttribute("store_id");
String realFolder = "";//웹 어플리케이션상의 절대 경로
String filename ="";
MultipartRequest imageUp = null; 

String saveFolder = "/imageFile";//파일이 업로드되는 폴더를 지정한다.
String encType = "utf-8"; //엔코딩타입
int maxSize = 50*1024*1024;  //최대 업로될 파일크기 20Mb
//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);  

try{
   //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
   //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
   imageUp = new MultipartRequest(
		 request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
 
   //전송한 파일 정보를 가져와 출력한다
   Enumeration<?> files = imageUp.getFileNames();
 
   //파일 정보가 있다면
   while(files.hasMoreElements()){
     //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
     String name = (String)files.nextElement();
 
     //서버에 저장된 파일 이름
     filename = imageUp.getFilesystemName(name);
   }
}catch(Exception e){
   e.printStackTrace();
}

%>

	<jsp:useBean id="store" scope="page" class="b_teampro2.storeinfo.StoreinfoDataBean">
		<jsp:setProperty name="store" property="*"/>
	</jsp:useBean>


 <% 

  String store_passwd = imageUp.getParameter("store_passwd");
  int store_cellphone = Integer.parseInt(imageUp.getParameter("store_cellphone"));
  String name = imageUp.getParameter("name");
  String business_no = imageUp.getParameter("business_no");
  String store_name = imageUp.getParameter("store_name");
  int category = Integer.parseInt(imageUp.getParameter("category"));
  int post_num = Integer.parseInt(imageUp.getParameter("post_num"));
  String address = imageUp.getParameter("address");
  String address_detail = imageUp.getParameter("address_detail");

  
  store.setStore_passwd(store_passwd);
  store.setStore_cellphone(store_cellphone);
  store.setName(name);
  store.setBusiness_no(business_no);
  store.setStore_name(store_name);
  store.setCategory(category);
  store.setPost_num(post_num);
  store.setAddress(address);
  store.setAddress_detail(address_detail);
  store.setMain_photo(filename);  
  

	StoreinfoDBBean logon = StoreinfoDBBean.getInstance();
 	logon.updateAdmin(store,store_id); 

	response.sendRedirect("admin_info.jsp");

	
 %>