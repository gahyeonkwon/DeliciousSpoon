package b_teampro2.storeinfo;
import b_teampro2.storeinfo.StoreinfoDataBean;
import b_teampro2.storeinfo.StoreinfoDBBean;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.lang.*;
import java.util.*;


	public class System_DBBean {
	 private static System_DBBean instance = new System_DBBean();
	    
	    public static System_DBBean getInstance() {
	        return instance;
	    }
	    
	    private System_DBBean() {}
		private Connection getConnection() throws Exception {
		    Context initCtx = new InitialContext();
		    Context envCtx = (Context) initCtx.lookup("java:comp/env");
		    DataSource ds = (DataSource)envCtx.lookup("jdbc/bban");
		    return ds.getConnection();
		}
		//master 로그인
		public int userCheck(String master_id, String master_passwd) 
				throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbmaster_passwd = "";
		int x = -1;
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement(
			    "select master_passwd from system_admin where master_id = ?");
			pstmt.setString(1, master_id);
			rs= pstmt.executeQuery();

			if(rs.next()){
				dbmaster_passwd= rs.getString("master_passwd"); 
				if(dbmaster_passwd.equals(master_passwd))
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
	}//userCheck end		

		//가입 승인 함수 <--admin/admin_join.jsp 에서 admin_join_done.jsp로 넘어갈 때 수행 되는 함수
		public void insertMember(System_DataBean store) 
	              throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
		
			try{
				conn = getConnection();
				pstmt = conn.prepareStatement("insert into tempo_store(store_id,store_passwd,store_cellphone,name,business_no,category,store_name,address,address_detail,post_num) values (?,?,?,?,?,?,?,?,?,?)");
				
				pstmt.setString(1, store.getStore_id());
				pstmt.setString(2, store.getStore_passwd());
				pstmt.setInt(3, store.getStore_cellphone());
				pstmt.setString(4, store.getName());
				pstmt.setString(5, store.getBusiness_no());
				pstmt.setInt(6, store.getCategory());
				pstmt.setString(7, store.getStore_name());
				pstmt.setString(8, store.getAddress());
				pstmt.setString(9, store.getAddress_detail());
				pstmt.setInt(10, store.getPost_num());
				pstmt.executeUpdate();
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally{			
				if (pstmt != null) 
					try { pstmt.close(); } catch(SQLException ex) {}
				if (conn != null) 
					try { conn.close(); } catch(SQLException ex) {}
				}
		}//insertMember end
		
		//승인 대기를 기다리는 상점 리스트 들 띄우기 <--sysadmin_store.jsp	
		public List<System_DataBean> getStores() // if vector로 여러개 출력 vs 함수 여러개로 출력
	            throws Exception {
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<System_DataBean> storeList=null;
	       try {
	           conn = getConnection();
	 
		           pstmt = conn.prepareStatement("SELECT * from tempo_store order by reg_date");     
		           rs = pstmt.executeQuery();
		
		           if (rs.next()) {
		              storeList = new ArrayList<System_DataBean>();
		               do{
		            	   System_DataBean store= new System_DataBean();	            	   	  
			            	store.setStore_id(rs.getString("store_id"));
			            	store.setStore_passwd(rs.getString("store_passwd"));
			            	store.setStore_cellphone(rs.getInt("store_cellphone"));
			            	store.setName(rs.getString("name"));
			            	store.setBusiness_no(rs.getString("business_no"));
			            	store.setStore_name(rs.getString("store_name"));
			            	store.setCategory(rs.getInt("category"));
			            	store.setPost_num(rs.getInt("post_num"));
			            	store.setAddress(rs.getString("address"));
			            	store.setAddress_detail(rs.getString("address_detail"));
			            	store.setConf(rs.getInt("conf"));
			            	storeList.add(store);
					    }while(rs.next());                       
		               
					}//if end              
	           
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return storeList;	
	   }//getStores end
		
		//상태가 1로바뀌면서  tempo_store 테이블에서 delete 되고 store 테이블로 insert 되는함수
		//상태가 2로바뀌면서 tempoary 테이블에 남아 있게 하는 함수  >> 출력은 다른 페이지에서
		public void updateStatus(String store_id,String opt) 
	              throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StoreinfoDBBean system = StoreinfoDBBean.getInstance();
			StoreinfoDataBean store = new StoreinfoDataBean ();
			try{
				conn = getConnection();
			
				if(opt.equals("1")||opt.equals("4")){
					//yes 를 눌렀을때 시행
					pstmt = conn.prepareStatement("select * from tempo_store where store_id = ?");
					pstmt.setString(1, store_id);
					rs = pstmt.executeQuery();
					 if(rs.next()) {
			            	store.setStore_id(rs.getString("store_id"));
			            	store.setStore_passwd(rs.getString("store_passwd"));
			            	store.setStore_cellphone(rs.getInt("store_cellphone"));
			            	store.setName(rs.getString("name"));
			            	store.setBusiness_no(rs.getString("business_no"));
			            	store.setStore_name(rs.getString("store_name"));
			            	store.setCategory(rs.getInt("category"));
			            	store.setPost_num(rs.getInt("post_num"));
			            	store.setAddress(rs.getString("address"));
			            	store.setAddress_detail(rs.getString("address_detail"));			            		            	
			            	system.insertMember(store);
					 }
					pstmt = conn.prepareStatement("delete from tempo_store where store_id = ?");
					pstmt.setString(1, store_id);
					pstmt.executeUpdate();
					
				}else if(opt.equals("2")){
					// no 를 눌렀을 경우 실행  opt == 2가 오게된다.
					pstmt = conn.prepareStatement("update tempo_store set conf = 2 where store_id = ?");
					pstmt.setString(1, store_id);
					pstmt.executeUpdate();
				}else if(opt.equals("3")){
					// delete 눌렀을경우 opt ==3
					pstmt = conn.prepareStatement("delete from tempo_store where store_id = ?");
					pstmt.setString(1, store_id);
					pstmt.executeUpdate();										
				}else{
					//sms opt ==5
				}
					
			}catch(Exception e) {
				e.printStackTrace();
			}finally{			
				if (pstmt != null) 
					try { pstmt.close(); } catch(SQLException ex) {}
				if (conn != null) 
					try { conn.close(); } catch(SQLException ex) {}
				}
		}//updateStatus end	
		
	}
