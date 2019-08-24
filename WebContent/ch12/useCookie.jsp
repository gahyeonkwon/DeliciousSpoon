<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>

</head>
<body>
  <h2>웹 브라우저에 저장된 쿠키를 가져오는 페이지</h2>
<%
  String book_id = "";
  Cookie[] cookies = request.getCookies();
  if(cookies!=null){
	for(int i=0; i<cookies.length;++i){
		if(cookies[i].getName().equals("id")){
			
			book_id = cool
			ShopBookDataBean bookList = null;

			ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
			
			bookList = bookProcess.getBook(Integer.parseInt(book_id));
		

		}
	}
  }
%>
</body>
</html>