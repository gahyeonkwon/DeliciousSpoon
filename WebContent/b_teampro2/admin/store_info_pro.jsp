<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>    
<%@ page import="java.sql.*"%>
<%@ page import="b_teampro2.storeinfo.StoreinfoDBBean" %>     
<%@ page import="b_teampro2.storeinfo.StoreinfoDataBean" %>  
<% request.setCharacterEncoding("utf-8");%>

	
<%
	String store_id = (String)session.getAttribute("store_id");

	StoreinfoDBBean logon = StoreinfoDBBean.getInstance();
	  
	StoreinfoDataBean photoData = logon.getPhotoinfo(store_id);
	  String menuphotos = photoData.getMenu_photos();	
	 String storephotos = photoData.getStore_photos();	

	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename ="";
	MultipartRequest imageUp = null; 
	
	String saveFolder = "/imageFile";//파일이 업로드되는 폴더를 지정한다.
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 1024*1024*1024;  //최대 업로될 파일크기 20Mb
	ArrayList<String> menuFiles = new ArrayList<String>();
	ArrayList<String> storeFiles = new ArrayList<String>();
	String sample = "sample.jpg";
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
	   //생략			 	
		   if(name.equals("store_photo1")||name.equals("store_photo2")||name.equals("store_photo3")){
			   filename=imageUp.getFilesystemName(name);
			   if(photoData.getStore_photos()!=null){//수정일경우 

					 String store_photos [] = storephotos.split(",");					   

			   
						if(name.equals("store_photo1")){	
							if(filename!=null){
								storeFiles.add(filename);								
							}else{
								if(storephotos!=null){
								storeFiles.add(store_photos[0]);
								}else{
									storeFiles.add(sample);
								}							
							}
						}else if(name.equals("store_photo2")){
							if(filename!=null){
								storeFiles.add(filename);								
							}else{
						
								if(storephotos!=null){
									storeFiles.add(store_photos[1]);	
									}else{
										storeFiles.add(sample);
									}
							}								
						}else{
							if(filename!=null){
								storeFiles.add(filename);	
															
							}else{
								if(storephotos!=null){
									storeFiles.add(store_photos[2]);	
									}else{
										storeFiles.add(sample);
									}										
							}								
						}	
			   }else{
			   	storeFiles.add(filename);	
			   } 
		   }else{//메뉴사진일경우		 		
					   filename=imageUp.getFilesystemName(name);
					   if(photoData.getMenu_photos()!=null){//수정일경우 
							 
						   String menu_photos [] = menuphotos.split(",");	
							 
								if(name.equals("menu_photo1")){	
									if(filename!=null){
										menuFiles.add(filename);								
									}else{
										if(menuphotos!=null){
										menuFiles.add(menu_photos[0]);
										}else{
										menuFiles.add(sample);
										}
																				
									}
								}else if(name.equals("menu_photo2")){
									if(filename!=null){
										menuFiles.add(filename);								
									}else{
										if(menuphotos!=null){
											menuFiles.add(menu_photos[1]);
											}else{
											menuFiles.add(sample);
											}	
									}								
								}else{
									if(filename!=null){
										menuFiles.add(filename);	
																	
									}else{
										if(menuphotos!=null){
											menuFiles.add(menu_photos[2]);
											}else{
											menuFiles.add(sample);
											}										
									}								
								}	
					   }else{
					   	menuFiles.add(filename);	
					   } 				   
				
		   	}//메뉴또는 매장사진 조건 end
	 	 
	     
	     //서버에 저장된 파일 이름
			//filename=imageUp.getFilesystemName(name);
	   //getFilesystemName("사용자가 지정해서 서버에 실제로 업로드된 파일명 반환. 파일명이 중복되는 경우 변경된 파일 명 반환")
	   		
	 
	  }//element while end
	   
	}catch(Exception e){
	   e.printStackTrace();
	}
	
%>	
	 <jsp:useBean id="store" scope="page" class="b_teampro2.storeinfo.StoreinfoDataBean">
	 </jsp:useBean>
	 
	 
	<%

	String intro = imageUp.getParameter("intro");
	String open_time = imageUp.getParameter("open_time");
	String open_day = imageUp.getParameter("open_day");
	int store_phone = Integer.parseInt(imageUp.getParameter("store_phone"));
	int seat_count = Integer.parseInt(imageUp.getParameter("seat_count"));
	String main_photo = imageUp.getParameter("main_photo");
	String menu_name [] = imageUp.getParameterValues("menu_name");
	String menu_price [] = imageUp.getParameterValues("menu_price");
		
		String menu_photo2 []= menuFiles.toArray(new String[menuFiles.size()]);
		String menu_photo [] = new String [3];
		menu_photo[0] = menu_photo2[2];
		menu_photo[1] = menu_photo2[1];
		menu_photo[2] = menu_photo2[0];

	 	store.setMenu_photo(menu_photo);

		String store_photo2 []= storeFiles.toArray(new String[storeFiles.size()]);
		String store_photo []  = new String [3];
		store_photo[0] = store_photo2[2];
		store_photo[1] = store_photo2[1];
		store_photo[2] = store_photo2[0];
		
		store.setStore_photo(store_photo);


	
 	store.setIntro(intro);
 	store.setOpen_time(open_time);
 	store.setOpen_day(open_day);
 	store.setStore_phone(store_phone);
 	store.setSeat_count(seat_count);
 	store.setMain_photo(main_photo);
 	store.setMenu_name(menu_name);
 	store.setMenu_price(menu_price);	


  

	
 	int x = logon.updateStore(store,store_id);
		
	response.sendRedirect("store_info.jsp");

%>
