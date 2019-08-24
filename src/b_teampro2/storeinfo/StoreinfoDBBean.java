package b_teampro2.storeinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import b_teampro2.storeinfo.StoreinfoDataBean;

public class StoreinfoDBBean {
	 private static StoreinfoDBBean instance = new StoreinfoDBBean();
	    
	    public static StoreinfoDBBean getInstance() {
	        return instance;
	    }
	    
	    private StoreinfoDBBean() {}
		private Connection getConnection() throws Exception {
		    Context initCtx = new InitialContext();
		    Context envCtx = (Context) initCtx.lookup("java:comp/env");
		    DataSource ds = (DataSource)envCtx.lookup("jdbc/bban");
		    return ds.getConnection();
		}

		//회원가입	 <-- admin_join.jsp
		public void insertMember(StoreinfoDataBean store) 
			              throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;

			try{
				conn = getConnection();
				pstmt = conn.prepareStatement("insert into store(store_id,store_passwd,store_cellphone,name,business_no,category,store_name,address,address_detail,post_num) values (?,?,?,?,?,?,?,?,?,?)");
				
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
			
		//로그인 사용 <-- admin_login.jsp
		public int userCheck(String store_id, String store_passwd) 
					throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String dbstore_passwd = "";
			int x = -1;
			
			try{
				conn = getConnection();
				            
				pstmt = conn.prepareStatement(
				    "select store_passwd from STORE where store_id = ?");
				pstmt.setString(1, store_id);
				rs= pstmt.executeQuery();

				if(rs.next()){
					dbstore_passwd= rs.getString("store_passwd"); 
					if(dbstore_passwd.equals(store_passwd))
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
		
		//로그인 중복체크 <--admin_join.jsp
		public int store_idCheck(String store_id) 
				throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userstore_id= "";
		int x=-1;
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement("select store_id from store where store_id = ?");
			pstmt.setString(1, store_id);
			
			rs= pstmt.executeQuery();

			if(rs.next()){
				 userstore_id = rs.getString("store_id");
				if(userstore_id.equals(store_id)){
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
	}//store_idCheck end
		
		//--------관리자 정보 수정 --------
		//mysql 정보 출력 <--admin_info.jsp
	    public StoreinfoDataBean getAdmininfo(String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        StoreinfoDataBean store = new StoreinfoDataBean();
	        try {
	            conn = getConnection();

	            pstmt = conn.prepareStatement(
	            	"select * from store where store_id=?");
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	            	//store = new StoreinfoDataBean(); list 할 때만 필요
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
	            	store.setMain_photo(rs.getString("main_photo"));
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return store;
	    }//getAdmininfo end

	  //관리자 정보 수정사항 업데이트<--admin_info_pro.jsp
	    public void updateAdmin(StoreinfoDataBean store,String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs= null;

	        String sql="";
	        try {
	            conn = getConnection();
	            
				pstmt = conn.prepareStatement(
	            	"select * from store where store_id=?");
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();
	            
				if(rs.next()){
	                sql="update store set store_passwd=?,store_cellphone=?,category=?,address=?,address_detail=?,post_num=?,main_photo=? where store_id=?";
	                pstmt = conn.prepareStatement(sql);	                
	                pstmt.setString(1, store.getStore_passwd());
				    pstmt.setInt(2, store.getStore_cellphone());
				    pstmt.setInt(3, store.getCategory());
				    pstmt.setString(4, store.getAddress());
				    pstmt.setString(5, store.getAddress_detail());
				    pstmt.setInt(6, store.getPost_num());
				    pstmt.setString(7, store.getMain_photo());
				    pstmt.setString(8, store_id);
	                
				    pstmt.executeUpdate();
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
				if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	    }//updatAdmin end		  
	    
	    //-------- 매장 정보 등록 --------
		//매장 추가정보 출력<--store_info.jsp
	    public StoreinfoDataBean getStoreinfo(String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        StoreinfoDataBean store = new StoreinfoDataBean();
	        try {
	            conn = getConnection();

	            pstmt = conn.prepareStatement("select intro,open_time,open_day,store_phone,seat_count,main_photo"+
	            		" from all_store" + 
	            		" where store_id=?");
	            		//기본출력 데이터
//	            		"select * from store,store_menu,store_photo where store_id=store_id"
	            		//view 생성 <-- db 에 이미 존재해야하는 view
//	            		"CREATE OR REPLACE VIEW all_store AS"+
//	            		"SELECT store.* ,store_menu.no as no1,menu_name,menu_price,menu_photo,store_photo.no as no2,store_photo"+
//	            		"FROM store LEFT JOIN store_menu"+
//	            		"ON store.? = store_menu.?"+
//	            		"LEFT JOIN store_photo"+
//	            		"ON store.? = store_photo.?"); 
	            		            		
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {           	
	            
	            	store.setIntro(rs.getString("intro"));
	            	store.setOpen_time(rs.getString("open_time"));
	            	store.setOpen_day(rs.getString("open_day"));
	            	store.setStore_phone(rs.getInt("store_phone"));
	            	store.setSeat_count(rs.getInt("seat_count"));	            	
	             	store.setMain_photo(rs.getString("main_photo"));

	            
				}
	            
	            pstmt = conn.prepareStatement("select group_concat(menu_name order by no separator ',') as menu_name,"
	            		+ " group_concat(menu_price order by no separator ',') as menu_price,"
	            		+ " group_concat(menu_photo order by no separator ',') as menu_photo"
	            		+ " From store_menu where store_id=?");
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();	  
	            if (rs.next()) {           	
	             	store.setMenu_names(rs.getString("menu_name"));	            	
	             	store.setMenu_prices(rs.getString("menu_price"));	
	             	store.setMenu_photos(rs.getString("menu_photo"));             
				}	            
	            
	            pstmt = conn.prepareStatement("select group_concat(store_photo order by no separator ',') as store_photo" + 
	            		" From store_photo" + 
	            		" where store_id=?");
	            		            		
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();	            
	            if (rs.next()) {           	
	            	store.setStore_photos(rs.getString("store_photo"));   	            
				}
	            
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return store;
	    }//select end

		//매장 추가정보 출력<--store_info.jsp
	    public StoreinfoDataBean getPhotoinfo(String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        StoreinfoDataBean store = new StoreinfoDataBean();
	        try {
	            conn = getConnection();
          
	            pstmt = conn.prepareStatement("select group_concat(menu_name order by no asc separator ',') as menu_name,"
	            		+ " group_concat(menu_price order by no asc separator ',') as menu_price,"
	            		+ " group_concat(menu_photo order by no asc separator ',') as menu_photo"
	            		+ " From store_menu where store_id=?");
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();	  
	            if (rs.next()) {           	
	             	store.setMenu_names(rs.getString("menu_name"));	            	
	             	store.setMenu_prices(rs.getString("menu_price"));	
	             	store.setMenu_photos(rs.getString("menu_photo"));             
				}	            
	            
	            pstmt = conn.prepareStatement("select group_concat(store_photo order by no asc separator ',') as store_photo" + 
	            		" From store_photo" + 
	            		" where store_id=?");
	            		            		
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();	            
	            if (rs.next()) {           	
	            	store.setStore_photos(rs.getString("store_photo"));   	            
				}
	            
	            
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return store;
	    }//select end	    
	  //<--매장추가정보 수정 store_info_pro.jsp
	    public int updateStore(StoreinfoDataBean store,String store_id)
	          throws Exception {
	    	int x = -1; //update완료
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs= null;
	        String [] menu_name = store.getMenu_name();
	        String [] menu_price = store.getMenu_price();
	        String [] menu_photo = store.getMenu_photo();
	        String [] store_photo= store.getStore_photo();

	        String sql="";
	        try {
	            conn = getConnection();
	            
				pstmt = conn.prepareStatement(
	            	"select * from store where store_id=?");
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();
	            
				if(rs.next()){
	                sql="update store set intro=?,open_time=?,open_day=?,store_phone=?,seat_count=? where store_id=?";
	                pstmt = conn.prepareStatement(sql);	                
	                pstmt.setString(1, store.getIntro());
	                pstmt.setString(2, store.getOpen_time());
	                pstmt.setString(3, store.getOpen_day());
				    pstmt.setInt(4, store.getStore_phone());
				    pstmt.setInt(5, store.getSeat_count());
				    pstmt.setString(6, store_id);
	                pstmt.executeUpdate();
				}
				
				pstmt = conn.prepareStatement(
		            	"select count(*),no from store_menu where store_id=?");
		            pstmt.setString(1, store_id);
		            rs = pstmt.executeQuery();
 
					if(rs.next()){
						  int count = Integer.parseInt(rs.getString(1));
						  int no = rs.getInt(2);
						   if(count<3) {
							   
							   sql="insert into store_menu(store_id,menu_name,menu_price,menu_photo) values (?,?,?,?)";
							   pstmt = conn.prepareStatement(sql);	     
							   for(int i=0;i<menu_name.length;i++){							 
									pstmt.setString(1, store_id);
									pstmt.setString(2,menu_name[i]);
									pstmt.setString(3,menu_price[i]);
									pstmt.setString(4,menu_photo[i]);		
									pstmt.executeUpdate();
									//pstmt.clearParameters();	
								   }
						   }else{
				 				   x=1; // update 
				 			
				 				  sql="update store_menu set menu_name=?,menu_price=?,menu_photo=? where store_id=? and no=?"; 
				 				  pstmt = conn.prepareStatement(sql);	 
				 				  for(int i=0;i<menu_name.length;i++){	
									pstmt.setString(1,menu_name[i]);
									pstmt.setString(2,menu_price[i]);
									pstmt.setString(3,menu_photo[i]);
									pstmt.setString(4,store_id);
									pstmt.setInt(5,no+i);
								    pstmt.executeUpdate();  
								  //  pstmt.clearParameters();
				 				  }
						   }								  
				   }//end rs.next;				
					
					pstmt = conn.prepareStatement(
			            	"select count(*),no from store_photo where store_id=?");
			            pstmt.setString(1, store_id);
			            rs = pstmt.executeQuery();		
			            
						if(rs.next()){
							  int count = Integer.parseInt(rs.getString(1));
							  int no = rs.getInt(2);
							   if(count<3) {						   
								   sql="insert into store_photo(store_id,store_photo) values (?,?)";
								   pstmt = conn.prepareStatement(sql);	     
								   for(int i=0;i<store_photo.length;i++){							 
										pstmt.setString(1, store_id);
										pstmt.setString(2,store_photo[i]);	
										pstmt.executeUpdate();
										//pstmt.clearParameters();	
									   }
							   }else{
					 				   x=1; // update 
					 				  sql="update store_photo set store_photo=? where store_id=? and no=?"; 
					 				  pstmt = conn.prepareStatement(sql);	 
					 				  for(int i=0;i<store_photo.length;i++){	
										pstmt.setString(1,store_photo[i]);
										pstmt.setString(2,store_id);
										pstmt.setInt(3,no+i);
									    pstmt.executeUpdate();  
									  //  pstmt.clearParameters();
					 				  }
							   }								  
					   }//end rs.next;				
					
					
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
				if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	        return x;
	    }//updateStore end		
	    public int getOpen_close(String store_id) // <-- admin_top.jsp 에서 상태표시할 때 사용
		          throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        int open_close = -1;
		        try {
		            conn = getConnection();

		            pstmt = conn.prepareStatement(
		            	"select open_close from store where store_id=?");
		            pstmt.setString(1, store_id);
		            rs = pstmt.executeQuery();
		            if (rs.next()) {
		            	open_close = rs.getInt("open_close");
					}
		        } catch(Exception ex) {
		            ex.printStackTrace();
		        } finally {
		            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		        }
				return open_close;
		    }//getOpen_close end	
	    
	    public void updateOpen_close(String store_id,int open_close)
		          throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;

		        try {
		            conn = getConnection();
		            
					pstmt = conn.prepareStatement(
		            	"update store set open_close = ? where store_id = ?");
					if(open_close==1){//open_close ==1 면 매자잉 대기가능상태 
					pstmt.setInt(1, 0);
					pstmt.setString(2, store_id);
					}else{
						pstmt.setInt(1, 1);
						pstmt.setString(2, store_id);						
					}
		            pstmt.executeUpdate();	          
		        } catch(Exception ex) {
		            ex.printStackTrace();
		        } finally {
					
		            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		        }
		    }//updatAdmin end		  	    
}//class end

