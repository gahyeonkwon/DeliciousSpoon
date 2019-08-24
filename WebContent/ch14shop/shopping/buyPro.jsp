<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.shopping.CartDataBean" %>
<%@ page import = "ch14.bookshop.shopping.CartDBBean" %>
<%@ page import = "ch14.bookshop.shopping.BuyDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.*" %>
<% request.setCharacterEncoding("utf-8");%>
<%
//바로구매옵션
   String opt = request.getParameter("opt");
   String buy_count = request.getParameter("buy_count");
   String book_id = request.getParameter("book_id"); 
   String buy_price = request.getParameter("buy_price");
   String deliveryName = request.getParameter("deliveryName");
   String deliveryTel = request.getParameter("deliveryTel");
   String deliveryTel2 = request.getParameter("deliveryTel2");  
   String suname = request.getParameter("suname"); 
   String deliveryAddress = request.getParameter("deliveryAddress");
   String deliveryAddress2 = request.getParameter("deliveryAddress2");   
   String buyer = (String)session.getAttribute("id");



 
   BuyDBBean buyProcess = BuyDBBean.getInstance();
   
  if(opt.equals("cart")){ 
	   
	   CartDBBean cartProcess = CartDBBean.getInstance();
	   List<CartDataBean> cartLists = cartProcess.getCart(buyer);
		
   buyProcess.insertBuy(cartLists,buyer, 
		   deliveryName, deliveryTel, deliveryAddress, deliveryAddress2,deliveryTel2,suname);
  }  
  
  if(opt.equals("buy")){
	   ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
	   int book_idd =Integer.parseInt(book_id);
	   ShopBookDataBean bookList=bookProcess.getBook(book_idd);
	  		 buyProcess.insertBuy(bookList,buyer, 
			   deliveryName,deliveryTel,deliveryAddress,deliveryAddress2,buy_count,deliveryTel2,suname,buy_price,book_idd);	  
  }
   
   response.sendRedirect("buyList.jsp");   
   

%>
