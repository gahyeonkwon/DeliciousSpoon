<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>

<% request.setCharacterEncoding("utf-8");%>
<%
    //커넥션 선언
    Connection con = null;
    try {
        //드라이버 호출, 커넥션 연결
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bban", "bban", "1234");
 
        //ResultSet : 쿼리문에 대한 반환값
        ResultSet rs = null;
 
        //DB에서 뽑아온 데이터(JSON) 을 담을 객체. 후에 responseObj에 담기는 값
      		List linelist = new LinkedList();
 
      
 
        //String query = "SELECT sum(people_num),DATE_FORMAT(reg_date, '%H') FROM waiting_list group by (reg_date)";
 		  String query = "select store_id,sum(people_num), HOUR(reg_date),count(user_id),reg_date from waiting_list group by HOUR(reg_date) having DATE_FORMAT(reg_date, '%d')=DATE_FORMAT(CURRENT_DATE,'%d') and store_id='aaaa'";      
        //String query = "SELECT people_num,DATE_FORMAT(reg_date, '%H') FROM waiting_list where DATE_FORMAT(reg_date, '%d')=DATE_FORMAT(CURRENT_DATE,'%d')";
        PreparedStatement pstm = con.prepareStatement(query);
 
        rs = pstm.executeQuery();
        
        //ajax에 반환할 JSON 생성
        JSONObject responseObj = new JSONObject();
        JSONObject lineObj = null;
        
        //소수점 2번째 이하로 자름
      //  DecimalFormat f1 = new DecimalFormat("");
        //rs의 다음값이 존재할 경우
        while (rs.next()) {
        	int people_num = rs.getInt(2);
        	int reg_date = rs.getInt(3);
        	int team = rs.getInt(4);
        	//int no = rs.getInt("no");
            System.out.print(reg_date+"\n");
          
            lineObj = new JSONObject();
            lineObj.put("people_num", (int)people_num);
            lineObj.put("reg_date", (int)reg_date);
            lineObj.put("team",(int)team);
            //lineObj.put("no", (int)no);
            linelist.add(lineObj);
        }
 
        responseObj.put("linelist", linelist);
        out.print(responseObj.toString());
 
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (con != null) {
            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
 
    }
%>