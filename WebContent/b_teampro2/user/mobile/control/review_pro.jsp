<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="b_teampro2.userinfo.*" %>

<% request.setCharacterEncoding("utf-8");


String realFolder = "";//웹 어플리케이션상의 절대 경로
String filename ="";
MultipartRequest imageUp = null; 

String saveFolder = "/imageFile";//파일이 업로드되는 폴더를 지정한다.
String encType = "utf-8"; //엔코딩타입
int maxSize = 1024*1024*1024;  //최대 업로될 파일크기 20Mb
ArrayList<String> imgFiles = new ArrayList<String>();
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
   //getFileNames() : 폼 요소중 input 태그 속성이 file로 된 파라미터의 이름을 반환
   //upload 된 파일이 없ㄷ으면  비어잇는 Enumeration 을반혼
   

   //파일 정보가 있다면
   while(files.hasMoreElements()){
     //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
   		String name = (String)files.nextElement();	
        filename = imageUp.getFilesystemName(name);
        imgFiles.add(filename);
 
  }//element while end
   
}catch(Exception e){
   e.printStackTrace();
}


%>

	 <jsp:useBean id="review" class="b_teampro2.userinfo.UserReviewDataBean">
	     <jsp:setProperty name="review" property="*"/>
	 </jsp:useBean>

<%
	String review_title = imageUp.getParameter("review_title");	
	String review_content = imageUp.getParameter("review_content");	
    int score = Integer.parseInt(imageUp.getParameter("score"));	
 	String user_id = (String)session.getAttribute("user_id");
	String store_id = request.getParameter("store_id");
	
	String review_photo []= imgFiles.toArray(new String[imgFiles.size()]);
	
	review.setReview_title(review_title);
	review.setReview_content(review_content);
	review.setScore(score);
	review.setReview_photo(review_photo);
	UserSystemDBBean system = UserSystemDBBean.getInstance(); 
	system.updateReview(store_id,user_id,review);
	
	response.sendRedirect("../design/mobile_myreview.jsp?user_id="+user_id);

	   
 %>