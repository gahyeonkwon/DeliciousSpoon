package b_teampro2.userinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import b_teampro2.userinfo.UserinfoDataBean;

public class UserinfoDBBean {
	 private static UserinfoDBBean instance = new UserinfoDBBean();
	    
	    public static UserinfoDBBean getInstance() {
	        return instance;
	    }
	    
	    private UserinfoDBBean() {}
		private Connection getConnection() throws Exception {
		    Context initCtx = new InitialContext();
		    Context envCtx = (Context) initCtx.lookup("java:comp/env");
		    DataSource ds = (DataSource)envCtx.lookup("jdbc/bban");
		    return ds.getConnection();
		}

		//회원가입	 <-- joinpro.jsp
		public void insertMember(UserinfoDataBean user) 
			              throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;

			try{
				conn = getConnection();
				pstmt = conn.prepareStatement("insert into user_data(user_id,passwd,gender,phone_number) values (?,?,?,?)");
				pstmt.setString(1, user.getUser_id());
				pstmt.setString(2, user.getPasswd());
				pstmt.setString(3, user.getGender());
				//pstmt.setInt(4, user.getAge());
				pstmt.setInt(4, user.getPhone_number());
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
			
		//로그인 사용  <--login.jsp
		public int userCheck(String user_id, String passwd) 
					throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String dbpasswd = "";
			int x = -1;
			
			try{
				conn = getConnection();
				            
				pstmt = conn.prepareStatement(
				    "select passwd from user_data where user_id = ?");
				pstmt.setString(1, user_id);
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
		
		//아이디 중복 확인 <-- join.jsp
		public int idCheck(String user_id) 
				throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userid= "";
		int x=-1; //해당 아이디로 가입 가능
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement("select user_id from user_data where user_id = ?");
			pstmt.setString(1, user_id);
			
			rs= pstmt.executeQuery();

			if(rs.next()){
				 userid = rs.getString("user_id");
				if(userid.equals(user_id)){
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
				
		//회원정보 출력<--updatemember.jsp
		public UserinfoDataBean selectMember(String user_id) 
					throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			UserinfoDataBean user =  new UserinfoDataBean();

			try{
				conn = getConnection();
				            
				pstmt = conn.prepareStatement("select * from user_data where user_id = ?");
				pstmt.setString(1, user_id);
				rs= pstmt.executeQuery();

				if(rs.next()){			  		 
					user.setUser_id(rs.getString("user_id"));
					user.setPasswd(rs.getString("passwd"));
					user.setGender(rs.getString("gender"));
					//user.setAge(rs.getInt("age"));
					user.setPhone_number(rs.getInt("phone_number"));
					user.setUser_photo(rs.getString("user_photo"));					
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
			return user;
		}
	    //id로 회원의 passwd 조회하기  <--updatemember.jsp , check_passwd.jsp
	    public int selectPasswd(String user_id,String old_passwd)
	           	throws Exception {
						
	    		   Connection conn = null;
	    		   PreparedStatement pstmt = null;
	    		   ResultSet rs = null;	
	    		   String passwd2="";
	    		   int x = -1;
	    		   
	  		
	    		   try {
	    		       conn = getConnection();
	    	       
	    		       pstmt = conn.prepareStatement("select passwd from user_data where user_id = ?");
	    	           pstmt.setString(1, user_id);   
	    		       rs=pstmt.executeQuery();
	    		       
	    		       	if(rs.next()){   	 
	    		       	
	    		       	 passwd2 = rs.getString("passwd");	
	    		       			if(passwd2.equals(old_passwd))
	    		       				x=-1; // 비밀번호 동일할 경우 사용
	    		       			else 
	    		       				x=1;
	    		       	}
	    		       	       	
	    		   } catch(Exception ex) {
	    		       ex.printStackTrace();
	    		   } finally {
	    			   if (rs != null) try { rs.close(); } catch(SQLException ex) {}   		 
	    		       if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	    		       if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	    		   }
	    		   return x;
	    	
	        }		
	    	
	
		//프로필사진 및 데이터 업데이트 <-- updatemember_pro.jsp
		public void updateProfile(String user_id,UserinfoDataBean user) 
	              throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
		
			try{
				conn = getConnection();
				pstmt = conn.prepareStatement("update user_data set passwd = ?, gender = ? , phone_number = ? where user_id = ?");
				pstmt.setString(1, user.getPasswd());
				pstmt.setString(2, user.getGender());				
				pstmt.setInt(3, user.getPhone_number());
				pstmt.setString(4, user_id);
				pstmt.executeUpdate();
				
				if(user.getUser_photo()!=null){
					pstmt = conn.prepareStatement("update user_data set user_photo = ? where user_id = ?");
					pstmt.setString(1, user.getUser_photo());
					pstmt.setString(2, user_id);
					pstmt.executeUpdate();
				}
						
			}catch(Exception e) {
				e.printStackTrace();
			}finally{			
				if (pstmt != null) 
					try { pstmt.close(); } catch(SQLException ex) {}
				if (conn != null) 
					try { conn.close(); } catch(SQLException ex) {}
				}
		}		



}//class end



   
    
   




	
