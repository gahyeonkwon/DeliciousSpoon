package ch13.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import ch12.member.LogonDataBean;

public class LogonDBBean {
	
    private static LogonDBBean instance = new LogonDBBean();
    
    public static LogonDBBean getInstance() {
        return instance;
    }
    
    private LogonDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/bban");
	    return ds.getConnection();
	}
//회원가입	
	public void insertMember(LogonDataBean member) 
		              throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
	
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into MEMBER values (?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getReg_date());
			pstmt.executeUpdate();
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally{			
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
			}
	}
		
		
	

	//로그인 사용
	public int userCheck(String id, String passwd) 
				throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement(
			    "select passwd from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(passwd))
					x = 1; //인증 성공
				else
					x = 0; //비밀번호 틀림
			}else
				x = -1;//해당 아이디 없음
						
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally{
			if (rs != null) 
				try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}//usercheck end
	public int idCheck(LogonDataBean member) 
			throws Exception {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String userid= "";
	int x=-1;
	
	try{
		conn = getConnection();
		            
		pstmt = conn.prepareStatement("select id from member where id = ?");
		pstmt.setString(1, member.getId());
		
		rs= pstmt.executeQuery();

		if(rs.next()){
			 userid = rs.getString("id");
			if(userid.equals(member.getId())){
				x = 1; //해당아이디 있음,가입불가
			}
		
		}
	}catch(Exception ex) {
		ex.printStackTrace();
	}finally{
		if (rs != null) 
			try { rs.close(); } catch(SQLException ex) {}
		if (pstmt != null) 
			try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) 
			try { conn.close(); } catch(SQLException ex) {}
	}
	return x;
}//회원가입시 중복확인 end
		

	
}//class end