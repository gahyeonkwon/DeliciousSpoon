
package b_teampro2.userinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import b_teampro2.storeinfo.*;



//검색,리뷰,즐겨찾기,대기,기타출력 구현
public class UserSystemDBBean {
	 private static UserSystemDBBean instance = new UserSystemDBBean();
	    
	    public static UserSystemDBBean getInstance() {
	        return instance;
	    }
	    
	    private UserSystemDBBean() {}
	    
		private Connection getConnection() throws Exception {
		    Context initCtx = new InitialContext();
		    Context envCtx = (Context) initCtx.lookup("java:comp/env");
    DataSource ds = (DataSource)envCtx.lookup("jdbc/bban");
    return ds.getConnection();
}	
//주소 얻어오기<--detailpage.jsp / search_done.jsp
public String getAddress(String store_id)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String address="";
        try {
        	
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select address from store where store_id=?");
            pstmt.setString(1, store_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {	  
            	address=rs.getString("address");
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return address;
    }//getAddress end


//매장 정보 출력하기 <--detailpage.jsp,review.jsp
public StoreinfoDataBean getStoreinfo(String store_id)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        StoreinfoDataBean store = new StoreinfoDataBean();
        try {
        	
            conn = getConnection();
            
            //조회순
            pstmt = conn.prepareStatement(
                	"update store set read_count=read_count+1 where store_id = ?");
			pstmt.setString(1,store_id);
			pstmt.executeUpdate();
			
            pstmt = conn.prepareStatement(
            	"select * from store where store_id=?");
            pstmt.setString(1, store_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            
            	store.setStore_id(rs.getString("store_id"));
            	store.setStore_name(rs.getString("store_name"));
            	store.setStore_phone(rs.getInt("store_phone"));
            	store.setAddress(rs.getString("address"));
            	store.setAddress_detail(rs.getString("address_detail"));	
              	store.setOpen_close(rs.getInt("open_close"));
            	store.setCategory(rs.getInt("category"));
            	store.setAvg_mark(rs.getDouble("avg_mark"));
            	store.setIntro(rs.getString("intro"));
            	store.setSeat_count(rs.getInt("seat_count"));            	
            	store.setOpen_time(rs.getString("open_time"));
            	store.setOpen_day(rs.getString("open_day"));
            	store.setMain_photo(rs.getString("main_photo"));
            	//메뉴정보 추가하기

			}
            
            
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
    }//getStoreinfo end
    
  //카테고리랜덤추천 <-- 매장 한개 추천 detailpage.jsp (날개 배너 제어에 들어감)
public StoreinfoDataBean getStore(int category,String store_id) 
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   StoreinfoDataBean store=new StoreinfoDataBean();
   try {
       conn = getConnection();
           pstmt = conn.prepareStatement("SELECT * FROM store where not store_id = ? and category = ? and open_close = 1 order by RAND(store_id) LIMIT 1");   
           pstmt.setInt(1, category);
           pstmt.setString(2, store_id);
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	          store.setStore_id(rs.getString("store_id"));
					  store.setMain_photo(rs.getString("main_photo"));
	                  store.setStore_name(rs.getString("store_name"));
               
			}//if end              
           
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return store;	
   }//getStores end	

//WEB 출력    
// 최근등록순(reg_date),가격순(avg(s.menu_price),조회순(t.read_count),랜덤(t.store_id)<--main.jsp ,category.jsp
public List<StoreinfoDataBean> getStores(int category,int opt,int end) 
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String sql = "";
   List<StoreinfoDataBean> storeList=null;
   try {
       conn = getConnection();
       if(category==5) {
    	   if(opt==1) {
    		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id group by s.store_id order by reg_date limit ?";
		   	   
	   }else if(opt==2) { 
		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
           		+ "on s.store_id = t.store_id group by s.store_id order by avg(s.menu_price) asc limit ?";
		   
	   }else if(opt==3) {
		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id group by s.store_id order by t.read_count desc limit ?";   
	   }else {
		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id group by s.store_id order by RAND(s.store_id) limit ?";		   
	   };
	   
 	   pstmt = conn.prepareStatement(sql); 
 	   pstmt.setInt(1,end);
   }else {
	
    	   if(opt==1) {
    		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
    	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
    	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by reg_date limit ?";
    		   	   
    	   }else if(opt==2) { 
    		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by avg(s.menu_price) asc limit ?";
    		   
    	   }else if(opt==3) {
    		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
    	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
    	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by t.read_count desc limit ?";   
    	   }else {
    		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
    	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
    	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by RAND(s.store_id) limit ?";		   
    	   };	 
    	   
    	   
    	   pstmt = conn.prepareStatement(sql);   
    	   pstmt.setInt(1,category);
    	   pstmt.setInt(2,end);
    	   
   };

       rs = pstmt.executeQuery();

       if (rs.next()) {
    	   storeList=new ArrayList<StoreinfoDataBean>();
           do{
        	   StoreinfoDataBean store= new StoreinfoDataBean();	            	   	  
				  store.setStore_id(rs.getString("store_id"));
				  store.setMain_photo(rs.getString("main_photo"));
                  store.setStore_name(rs.getString("store_name"));
                  store.setAvg_mark(rs.getDouble("avg_mark"));
                  store.setAvg_price(rs.getInt(2));
          
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

// 최근등록순(reg_date),가격순(avg(s.menu_price),조회순(t.read_count),랜덤(t.store_id)<--mobile_main.jsp
public List<StoreinfoDataBean> getStoresMobile(int category,int opt) 
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String sql = "";
   List<StoreinfoDataBean> storeList=null;
   try {

       conn = getConnection();
       if(category==5) {
    	   if(opt==1) {
    		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo," + 
	           		"t.store_name from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id group by s.store_id order by reg_date limit 4";
		   	   
	   }else if(opt==2) { 
		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo," + 
           		"t.store_name from store_menu s INNER JOIN store t "
           		+ "on s.store_id = t.store_id group by s.store_id order by avg(s.menu_price) asc limit 4";
		   
	   }else if(opt==3) {
		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo," + 
	           		"t.store_name from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id group by s.store_id order by t.read_count desc limit 4";   
	   }else {
		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo," + 
	           		"t.store_name from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id group by s.store_id order by RAND(s.store_id) limit 4";		   
	   };
	   
 	   pstmt = conn.prepareStatement(sql);    
   }else {
	
    	   if(opt==1) {
    		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ','),t.main_photo," + 
    	           		"t.store_name from store_menu s INNER JOIN store t "
    	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by reg_date limit 8";
    		   	   
    	   }else if(opt==2) { 
    		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ','),t.main_photo," + 
	           		"t.store_name from store_menu s INNER JOIN store t "
	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by avg(s.menu_price) asc limit 8";
    		   
    	   }else if(opt==3) {
    		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ','),t.main_photo," + 
    	           		"t.store_name from store_menu s INNER JOIN store t "
    	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by t.read_count desc limit 8";   
    	   }else {
    		   sql =  "select s.store_id,group_concat(menu_name order by no asc separator ','),t.main_photo," + 
    	           		"t.store_name from store_menu s INNER JOIN store t "
    	           		+ "on s.store_id = t.store_id and t.category = ? group by s.store_id order by RAND(s.store_id) limit 8";		   
    	   };	 
    	   
    	   
    	   pstmt = conn.prepareStatement(sql);   
    	   pstmt.setInt(1,category);
    	   
   };

       rs = pstmt.executeQuery();

       if (rs.next()) {
    	   storeList=new ArrayList<StoreinfoDataBean>();
           do{
        	   StoreinfoDataBean store= new StoreinfoDataBean();	            	   	  
				  store.setStore_id(rs.getString("store_id"));
				  store.setMain_photo(rs.getString("main_photo"));
                  store.setStore_name(rs.getString("store_name"));
                  store.setMenu_names(rs.getString(2));
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
   }//getStoresMobile end	

// 랜덤으로 출력하는 함수 해당 매장 불포함<--detail.page 
public List<StoreinfoDataBean> getStores(int category,String store_id) 
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String sql = "";
   List<StoreinfoDataBean> storeList=null;
   try {
       conn = getConnection();
     	        	  
    		   sql =  "select s.store_id,round(avg(s.menu_price),-3),t.main_photo," + 
    	           		"t.store_name,t.avg_mark from store_menu s INNER JOIN store t "
    	           		+ "on not t.store_id = ? and s.store_id = t.store_id and t.category = ? "
    	           		+ "group by s.store_id order by RAND(s.store_id) limit 4";
    		   	       	   
    	   pstmt = conn.prepareStatement(sql);   
    	   pstmt.setString(1, store_id);
    	   pstmt.setInt(2,category);
    	   

       rs = pstmt.executeQuery();

       if (rs.next()) {
    	   storeList=new ArrayList<StoreinfoDataBean>();
           do{
        	   StoreinfoDataBean store= new StoreinfoDataBean();	            	   	  
				  store.setStore_id(rs.getString("store_id"));
				  store.setMain_photo(rs.getString("main_photo"));
                  store.setStore_name(rs.getString("store_name"));
                  store.setAvg_mark(rs.getDouble("avg_mark"));
                  store.setAvg_price(rs.getInt(2));
          
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

//매장에서 평균 평점 출력하기 <--detailpage.jsp
public double getAvg_score(String store_id)  
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   double avg_score = 0.0;
   try {
       conn = getConnection();
           pstmt = conn.prepareStatement("SELECT round(avg(score),1) FROM review where store_id = ?");   
       pstmt.setString(1, store_id);
       rs = pstmt.executeQuery();

       if (rs.next()) {
    	   	avg_score =rs.getDouble(1);               
		}//if end              
           
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return avg_score;	
   }//getStores end		

//대기 시스템 함수  : 대기 리스트 생성하기< -- waiting_done.jsp 
   public int makeWaiting_list(UserWaitDataBean waitList)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;    
	        int x = -1; //한 매장에 같은대기를 여러번 걸 수 없을 때 -- > 1 이면 대기성공
        int check2 = -1; //매장 개수 3개이상
        int check3 = -1; //매장에서 노쇼처리			        
        int check = -1;
        int open_close  = -1;
        int waiting = -1;
        
        try {
        	
            conn = getConnection();
            // 0.기본조건 : 매장이 대기 가능 상태인가?
            pstmt =  conn.prepareStatement("select open_close from store where store_id = ?");
            pstmt.setString(1, waitList.getStore_id());
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	open_close = rs.getInt(1);
            
	            if(open_close==0) {
	            	x=0;
	            	return x;}
            }
	            // 1. 같은 아이디로는 한매장에 한개만 가능하므로 조건을 건다
	            pstmt = conn.prepareStatement(
	            	"select count(user_id) from waiting_list where store_id = ? and user_id=? and (check_list = 0 OR check_list = 2)");
	            pstmt.setString(1, waitList.getStore_id());
	            pstmt.setString(2, waitList.getUser_id());
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	            	check = rs.getInt(1); 
	            }
	            //2.대기 총 갯수가 몇개인지 제약을 건다
	            pstmt = conn.prepareStatement(
		            	"select count(user_id) from waiting_list where user_id=? and (check_list = 0 OR check_list =2)");
		            pstmt.setString(1, waitList.getUser_id());
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		            	check2 = rs.getInt(1); 
		            }	
		        //3.노쇼 처리된 매장일 경우    
	            pstmt = conn.prepareStatement(
		            	"select count(user_id) from waiting_list where store_id = ? and user_id=? and check_list =2");
	            pstmt.setString(1, waitList.getStore_id());
	            pstmt.setString(2, waitList.getUser_id());
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		            	check3 = rs.getInt(1); 
		            }					            
            //4.wait_number을 위한 값 설정  <-- 현재 store_id 로 들어간 총 대기팀이 몇팀인가?
            pstmt = conn.prepareStatement(
	            	"select count(store_id) from waiting_list where store_id = ?");
	            pstmt.setString(1, waitList.getStore_id());
	            rs = pstmt.executeQuery();				            
	        
           if(rs.next()){
        	   waiting = rs.getInt(1);
        	   if(check>0||check2>=3||check3>0){
        		   return x;//만약 같은아이디로 한개라도 값이 카운트되면 , 더이상 대기를 할 수 없다
        		   			// 대기 갯수가 3개 이상이거나, 노쇼 상태여도 대기는 불가능 하다.
	           }else{
	        	   //user_id가 없는 경우에만
	        	   x=1;    	  
	        	   ++waiting; //한개를 더한 값이 내번호가 될것이다.
		            pstmt = conn.prepareStatement("insert into waiting_list(user_id,store_id,name,people_num,phone_number,wait_number) values(?,?,?,?,?,?)");
		            	pstmt.setString(1, waitList.getUser_id());
		            	pstmt.setString(2, waitList.getStore_id());
			            pstmt.setString(3, waitList.getName());
			            pstmt.setInt(4, waitList.getPeople_num());
			            pstmt.setInt(5, waitList.getPhone_number());
			            pstmt.setInt(6, waiting);
			            pstmt.executeUpdate();  
	           
	        	   }
    	   }
                
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x; // waiting_done.jsp 에서  1 일경우에만 완료 페이지가 뜨고 -1 이면 error.jsp 로 이동하도록 바꾸자
		//0일경우에는 매장 상태가 대기 불가 상태이므로 alert를 출력한다.
    }//makeWaiting_list end	
   
	   //대기 시스템 함수  : 내가 현재 받을 번호 출력 <-- waiting.jsp/waiting_done.jsp/detailpage.jsp
   public int getCurrent_num(String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;   
	        int my_num = -1;

	        try {
	        	
	            conn = getConnection();
	            
	            pstmt =  conn.prepareStatement("select count(store_id)+1 from waiting_list where store_id = ?");
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	            	my_num = rs.getInt(1);
	            }
         
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return my_num; //0값은 내가 받게 될 번호
			
	    }//getCurrent_num end
   
   //대기 시스템 함수 : 남은 팀수 출력<--main.jsp, waiting.jsp/waiting_done.jsp/detailpage.jsp 날개배너
   public int getCurrent_team(String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;   
	        int team = -1;
	        try {
	        	
	            conn = getConnection();
	            
	            pstmt =  conn.prepareStatement("select count(*) from waiting_list where check_list=0 and store_id = ?");
	            pstmt.setString(1, store_id);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	            	team = rs.getInt(1);
	            }
	            
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return team; //남은 대기 팀수 출력
			
	    }//getCurrent_team end	
   		   
//대기 시스템 함수 : 대기 리스트 출력하기< --store_condition.jsp 
   public List<UserWaitDataBean> getWaiting_list(String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;   
	        List<UserWaitDataBean> waitingList = null;
	        try {
	        	
	            conn = getConnection();
	         
	            pstmt = conn.prepareStatement(
	            	"select * from waiting_list where store_id = ? and check_list=0 order by reg_date");
            pstmt.setString(1, store_id);
            rs = pstmt.executeQuery();
	           if (rs.next()) {
		              waitingList = new ArrayList<UserWaitDataBean>();
		               do{
		            	   UserWaitDataBean waiting= new UserWaitDataBean();
		            	   waiting.setNo(rs.getInt("no"));
		               	   waiting.setStore_id(rs.getString("store_id"));	
		            	   waiting.setUser_id(rs.getString("user_id"));				           
		            	   waiting.setName(rs.getString("name"));
		            	   waiting.setPeople_num(rs.getInt("people_num"));
		            	   waiting.setCheck_list(rs.getInt("check_list"));
		            	   waiting.setPhone_number(rs.getInt("phone_number"));
		            	   waiting.setWait_number(rs.getInt("wait_number"));
		            	   waitingList.add(waiting);
					    }while(rs.next());                       
		               
					}//if end 
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return waitingList; // waiting_done.jsp 에서  1 일경우에만 완료 페이지가 뜨고 -1 이면 error.jsp 로 이동하도록 바꾸자(-1 : 같은아이디가 이미존재)
    }//getWaiting_list end	
   
	//대기 시스템 함수  : 노쇼,취소된 대기 리스트 출력하기< --store_condition.jsp 
   public List<UserWaitDataBean> getWaiting_list2(String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;   
	        List<UserWaitDataBean> waitingList = null;
	        try {
	        	
	            conn = getConnection();
	         
	            pstmt = conn.prepareStatement(
	            	"select * from waiting_list where store_id = ? and (check_list=2 OR check_list = 3) order by reg_date");
            pstmt.setString(1, store_id);
            rs = pstmt.executeQuery();
	           if (rs.next()) {
		              waitingList = new ArrayList<UserWaitDataBean>();
		               do{
		            	   UserWaitDataBean waiting= new UserWaitDataBean();
		            	   waiting.setNo(rs.getInt("no"));
		            	   waiting.setStore_id(rs.getString("store_id"));		   
		            	   waiting.setUser_id(rs.getString("user_id"));				           
		            	   waiting.setName(rs.getString("name"));
		            	   waiting.setPeople_num(rs.getInt("people_num"));
		            	   waiting.setCheck_list(rs.getInt("check_list"));
		            	   waiting.setPhone_number(rs.getInt("phone_number"));
		            	   waiting.setWait_number(rs.getInt("wait_number"));
		            	   waitingList.add(waiting);
					    }while(rs.next());                       
		               
					}//if end 
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return waitingList; // waiting_done.jsp 에서  1 일경우에만 완료 페이지가 뜨고 -1 이면 error.jsp 로 이동하도록 바꾸자(-1 : 같은아이디가 이미존재)
    }//getWaiting_list2 end
   
	//대기 시스템 함수  : 이미 내가 대기한 상태라면 날개 배너에 제어가 들어간다 <--detailpage.jsp			
   public int check_Waiting(String user_id,String store_id)
	          throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;    
	        int x = -1; //한 매장에 같은대기를 여러번 걸 수 없을 때 -- > 1 이면 대기성공
        int check = -1;
        int check2 = -1; //매장 개수 3개이상
        int check3 = -1; //매장에서 노쇼처리			       
        int open_close  = -1;
        int waiting = -1;
        
        try {
        	
            conn = getConnection();
            // 0.기본조건 : 매장이 대기 가능 상태인가?
            pstmt =  conn.prepareStatement("select open_close from store where store_id = ?");
            pstmt.setString(1, store_id);
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	open_close = rs.getInt(1);	            
	            if(open_close==0) {
	            	x=0;
	            	return x;}
            }
            // 1. 같은 아이디로는 한매장에 한개만 가능하므로 조건을 건다
            pstmt = conn.prepareStatement(
            	"select count(user_id) from waiting_list where store_id = ? and user_id=? and check_list = 0");
            pstmt.setString(1, store_id);
            pstmt.setString(2, user_id);
            rs = pstmt.executeQuery();
            if(rs.next()) {
             	check = rs.getInt(1); 
            }
            
            //2.대기 총 갯수가 몇개인지 제약을 건다
            pstmt = conn.prepareStatement(
	            	"select count(user_id) from waiting_list where user_id=? and (check_list = 0 OR check_list =2)");
	            pstmt.setString(1, user_id);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	            	check2 = rs.getInt(1); 
	            }	
	        //3.노쇼 처리된 매장일 경우    
            pstmt = conn.prepareStatement(
	            	"select count(user_id) from waiting_list where store_id = ? and user_id=? and check_list =2");
            pstmt.setString(1, store_id);
            pstmt.setString(2, user_id);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	            	check3 = rs.getInt(1); 
	            }				           
    

            	if(check>0){return x;//만약 같은아이디로 한개라도 값이 카운트되면 , 더이상 대기를 할 수 없다 --> -1 : 이미 대기를 한 상태
	            }else if(check2>=3){ //대기가 3개이상 찬 상태 
	           		x=3;
	           		return x;			           		
	           }else if(check3>0){
	        	   x=2;
	        	   return x;  		            	 
	           }else{
	        	   //user_id가 없는 경우에만 1 반환 --> 1 : 대기가능 상태
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
		//1 : 대기가능 상태 , 배너에 바로가기 뜸
		//-1 : 이미 대기를 한 상태 / 다른 추천 배너 뜸
		//0 : 매장자체가 대기불가능상태 / 다른 추천 배너 뜸  
		//2 :  노쇼
		//3 : 대기 갯수 초과
    }//check_Waiting end		   

//대기 시스템 함수 : 입장확인, 즉  check_list 상태가 업데이트됨 (입장상태)< --store_condition.jsp
					//또한 jsp 화면에서 입장 되었다고 메세지 출력 또는 색깔 바뀜   				
   public void updateWait_status(String store_id,String user_id,int opt,int no)//for문 안에있는 user_id가 각각 다를것이므로 user_id를 받아올 수 있음
																	// opt : 1 이면 yes ,2 면 no <-- store_condition.jsp  에서 조건걸기 
	   throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
    		     
        try {
        	
            conn = getConnection();
         
            pstmt = conn.prepareStatement(		            		
            	"update waiting_list set check_list = ? where store_id = ? and user_id = ? and no = ?");
            pstmt.setInt(1,opt);
            pstmt.setString(2, store_id);
            pstmt.setString(3, user_id);
            pstmt.setInt(4, no);
            pstmt.executeUpdate();

        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {		      
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		 
    }//updateWait_status end	
   
	//대기 시스템 함수 : 나의 대기 상태 출력  : 대기이름,인원,내번호,매장이름이 떠야함 <--waiting_done.jsp,detailpage.jsp		
	   //매장이름과 store_id는 waiting.jsp 에서 request 로, user_id는 session 값에서 받아온다		
   public UserWaitDataBean getMywaiting(String store_id,String user_id)
		   throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        UserWaitDataBean waitinfo = new UserWaitDataBean();
	        try {
	        	
	            conn = getConnection();
	         
	            pstmt = conn.prepareStatement(		            		
	            	"select name,wait_number,people_num,phone_number from waiting_list "
            	+ "where store_id = ? and user_id = ? and check_list = 0");			           
            pstmt.setString(1, store_id);
            pstmt.setString(2, user_id);
            rs=pstmt.executeQuery();
            if(rs.next()) {
            	waitinfo.setName(rs.getString("name"));
            	waitinfo.setWait_number(rs.getInt("wait_number"));
            	waitinfo.setPeople_num(rs.getInt("people_num"));
            	waitinfo.setPhone_number(rs.getInt("phone_number"));
            }
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {		      
        	if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		 return waitinfo;
    }//getMywaiting end	 
   
   //실시간 대기상태 출력 <-- mypage.jsp
   public List<UserWaitDataBean> getMywaiting2(String user_id)
		   throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<UserWaitDataBean> waitinfoList = null;
	     
	        try {
	        	
	            conn = getConnection();
	         
	            pstmt = conn.prepareStatement(		            		
	            	"select w.check_list,w.store_id,w.name,w.wait_number,w.people_num,s.main_photo,s.store_name "
            	+ "from waiting_list w,store s where w.store_id = s.store_id and user_id = ? and (check_list = 0 or check_list=2)");			           
            pstmt.setString(1, user_id);
            rs=pstmt.executeQuery();
            if (rs.next()) {
            	waitinfoList = new ArrayList<UserWaitDataBean>();
	               do{
	            	   UserWaitDataBean waitinfo =  new UserWaitDataBean();
		            	waitinfo.setName(rs.getString("name"));
		              	waitinfo.setCheck_list(rs.getInt("check_list"));
		            	waitinfo.setStore_id(rs.getString("store_id"));
		            	waitinfo.setMain_photo(rs.getString("main_photo"));
		            	waitinfo.setStore_name(rs.getString("store_name"));
		            	waitinfo.setWait_number(rs.getInt("wait_number"));
		            	waitinfo.setPeople_num(rs.getInt("people_num"));
	            	 waitinfoList.add(waitinfo);
				    }while(rs.next());                       
	               
				}//if end
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {		      
        	if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		 return waitinfoList;
    }//getMywaiting2 end	
   
        //대기 시스템 함수  : 매장이름 구해오기<--waiting_done.jsp
   public String getStore_name(String store_id)
		   throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String store_name = "";
	        try {
	        	
	            conn = getConnection();
	         
	            pstmt = conn.prepareStatement(		            		
	            	"select store_name from store where store_id = ?");			           
	            pstmt.setString(1, store_id);			           
	            rs=pstmt.executeQuery();
	            if(rs.next()) {
	            	store_name = rs.getString(1);
	            }
	            
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {		      
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			 return store_name;
	    }//getStore_name end	  
   
//대기 시스템 함수 : 최근 호출 번호<--detailpage.jsp/main.jsp/waiting.jsp/waiting_done.jsp		
   public int getLastcall(String store_id)
		   throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int lastcall = -1;
	       
	        try {		        	
	            conn = getConnection();
	         
	            pstmt = conn.prepareStatement(		 
      		
	            // 최근호출번호 = 0의 최소값(다음입장번호) - 1 
            // 다음입장번호 = 1의 최대값(최근호출번호) + 1
            //다음으로 입장할 번호는 상태가 0 인것들 (대기) 에서 wait_number 가 가장 작은것  것이 되므로
    		//select min(wait_number) from waiting_list where store_id = ? amd check_list = 0");
        		 //마지막 입장으로 한 번호는(최근호출번호) 상태가 1인것들 중에서 ( 입장 한 번호 ) 가장 wait_number 가 큰것이됨		
            	"select max(wait_number) from waiting_list where store_id = ? and check_list = 1");	
  
	            pstmt.setString(1, store_id);
	            rs=pstmt.executeQuery();
	            if(rs.next()) {
	            	lastcall = rs.getInt(1);
	            }
	            
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {		      
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			 return lastcall; //-1 이면 함수 동작하지 않음
    }//getLastcall end	  

   //대기 시스템 함수 : 대기 취소 기능  <--waiting_done.jsp 에서 대기를 취소하거나, mypage.jsp 에서 대기를 삭제할 경우 발생하는 함수
   public void deletetWaiting(String store_id,String user_id)
		   throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;

	        try {		        	
	            conn = getConnection();      
	            		 pstmt = conn.prepareStatement(		 	
	     		            	"update waiting_list set check_list = 3 where store_id =? and user_id = ?");
            		 	//이때 review 에서  check_review 0이면 방문한 상태, 리뷰작성전
            		 pstmt.setString(1, store_id);
            		 pstmt.setString(2, user_id);     		 
            		 pstmt.executeUpdate();

        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {		      

            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		 
    }//deletetWaiting end	   	   
   		   
   //대기 시스템 함수  / 리뷰함수  : 관리자에서 입장을 누르면 그 순간, reveiw 테이블로 들어가게 된다.  <-- check.jsp (admin 에서) , mypage.jsp(방문한곳과 review 에 동시출력)  
   public void insertVisited(String store_id,String user_id,int people_num)
		   throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {		        	
	            conn = getConnection();
    		//opt 1이면 방문상태
            		 pstmt = conn.prepareStatement(		 	
     		            	"insert into review(check_review,store_id,user_id,people_num) values(0,?,?,?)");
            		 	//이때 review 에서  check_review 0이면 방문한 상태, 리뷰작성전
            		 pstmt.setString(1, store_id);
            		 pstmt.setString(2, user_id);
             		 pstmt.setInt(3, people_num);        		 
            		 pstmt.executeUpdate();
    

        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {		      
        	if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		 
    }//insertVisited end	   	   
   
   //리뷰 함수 : 대기 시스템에서 들어온 데이터를 update 하여 리뷰를 작성하도록 구현한다 .<-- review.jsp / review_pro.jsp
   public void updateReview(String store_id,String user_id,UserReviewDataBean review)		
		throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int index = -1;
		try {
		
		conn = getConnection();
		pstmt = conn.prepareStatement(		            		
		"select no from review where store_id = ? and user_id = ? and check_review = 0");	
	pstmt.setString(1, store_id);			
	pstmt.setString(2, user_id);		
	rs = pstmt.executeQuery();
	
	if(rs.next()) {
		index = rs.getInt("no");
			pstmt = conn.prepareStatement(		            		
			"update review set check_review = 1,review_title = ?,review_content = ?,score = ?"
			+ " where store_id = ? and user_id = ? and no = ?");
			pstmt.setString(1, review.getReview_title());
			pstmt.setString(2, review.getReview_content());
			pstmt.setInt(3, review.getScore());
			pstmt.setString(4, store_id);
			pstmt.setString(5, user_id);
			pstmt.setInt(6, index);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("update store set avg_mark = (SELECT round(avg(score),1) FROM review where store_id = ? and check_review = 1) where store_id = ? ");
			pstmt.setString(1, store_id);
			pstmt.setString(2, store_id);
			pstmt.executeUpdate();		
			
			String review_photo [] = review.getReview_photo();
			
			for(int i=0;i<review_photo.length;i++) {
				pstmt = conn.prepareStatement(		            		
				"insert into review_photo(review_index,review_photo) values(?,?)");
				pstmt.setInt(1, index);
				pstmt.setString(2, review_photo[i]);
				pstmt.executeUpdate();
			}
								
			}//end rs.next()
	} catch(Exception ex) {
	ex.printStackTrace();
	} finally {		      
	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
	
	}//updateReview end		   
   
   //리뷰 함수 : 매장별 리뷰 총갯수를 출력하는 함수 < -- detailpage.jsp
public int getReviewCount(String store_id)
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   int x=-1;
   try {
           conn = getConnection();
           pstmt = conn.prepareStatement("select count(*) from review where store_id= ? and check_review = 1");
           pstmt.setString(1, store_id);
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   x= rs.getInt(1);
			}//if end

   } catch(Exception ex) {
       ex.printStackTrace();
   } finally {
       if (rs != null) try { rs.close(); } catch(SQLException ex) {}
       if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
       if (conn != null) try { conn.close(); } catch(SQLException ex) {}
   }
	return x; //-1이오면 동작 오류
}// getReviewCount end

   //리뷰 함수  : 개인별 작성한 리뷰 총갯수를 출력하는 함수 < -- mypage.jsp
	public int getReviewCount2(String user_id)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=-1;
       try {
	           conn = getConnection();
	           pstmt = conn.prepareStatement("select count(*) from review where user_id = ?");
	           pstmt.setString(1, user_id);
	           rs = pstmt.executeQuery();
	
	           if (rs.next()) {
	        	   x= rs.getInt(1);
				}//if end

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return x; //-1이오면 동작 오류
   }//getReviewCount2 end
		
   //리뷰 함수 : 리뷰 출력하기 <-- detailpage.jsp
public List<UserReviewDataBean> getReviews(String store_id,int start,int end)
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   ResultSet pt = null;
   int index = -1;
   List<UserReviewDataBean> reviewList=null;
   try {
       conn = getConnection();

           pstmt = conn.prepareStatement("SELECT r.*,r.user_id,u.user_photo from review r,user_data u where r.store_id = ? and r.user_id=u.user_id and r.check_review = 1 order by r.reg_date2 desc limit ?,?");
           pstmt.setString(1,store_id);
           pstmt.setInt(2,start-1);
           pstmt.setInt(3,end);
           rs = pstmt.executeQuery();
          
           if (rs.next()) {
        	   reviewList = new ArrayList<UserReviewDataBean>();
        	  
               do{
            	 UserReviewDataBean review =  new UserReviewDataBean();
            	 index = rs.getInt("no"); //review 고유식별번호 가져오는 함수  
            	 //review 에 해당하는 고유식별번호로 review_photo table에서 사진을 셀렉해오는 쿼리문
            	 pstmt = conn.prepareStatement("select group_concat(review_photo separator ',') as review_photos"
 	            		+ " From review_photo where review_index=?");
		           pstmt.setInt(1,index);
		           pt = pstmt.executeQuery();
		           if(pt.next()) {
		            	 review.setReview_photos(pt.getString(1));
		            	 review.setUser_id(rs.getString("user_id"));
		            	 review.setUser_photo(rs.getString("user_photo"));
		            	 review.setReview_title(rs.getString("review_title"));
		            	 review.setReview_content(rs.getString("review_content"));
		            	 review.setScore(rs.getInt("score"));
		            	 review.setReg_date2(rs.getTimestamp("reg_date2"));
		            	 review.setReg_date(rs.getTimestamp("reg_date"));
		           }

                 reviewList.add(review);
			    }while(rs.next());                       
               
			}//if end

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (pt != null) try { rs.close(); } catch(SQLException ex) {}
    	   if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return reviewList;
   }//getReviews end

//리뷰 출력함수 <--detailpage.jsp
public List<UserReviewDataBean> getReviewSimple(String store_id)
        throws Exception {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   ResultSet pt = null;
   int index = -1;
   List<UserReviewDataBean> reviewList=null;
   try {
       conn = getConnection();

           pstmt = conn.prepareStatement("SELECT r.*,r.user_id,u.user_photo from review r,user_data u where r.store_id = ? and r.user_id=u.user_id and r.check_review = 1 order by r.reg_date2 desc limit 3");
           pstmt.setString(1,store_id);
     
           rs = pstmt.executeQuery();
          
           if (rs.next()) {
        	   reviewList = new ArrayList<UserReviewDataBean>();
        	  
               do{
            	 UserReviewDataBean review =  new UserReviewDataBean();
            	 index = rs.getInt("no"); //review 고유식별번호 가져오는 함수  
            	 //review 에 해당하는 고유식별번호로 review_photo table에서 사진을 셀렉해오는 쿼리문
            	 pstmt = conn.prepareStatement("select group_concat(review_photo separator ',') as review_photos"
 	            		+ " From review_photo where review_index=?");
		           pstmt.setInt(1,index);
		           pt = pstmt.executeQuery();
		           if(pt.next()) {
		            	 review.setReview_photos(pt.getString(1));
		            	 review.setUser_id(rs.getString("user_id"));
		            	 review.setUser_photo(rs.getString("user_photo"));
		            	 review.setReview_title(rs.getString("review_title"));
		            	 review.setReview_content(rs.getString("review_content"));
		            	 review.setScore(rs.getInt("score"));
		            	 review.setReg_date2(rs.getTimestamp("reg_date2"));
		           }

                 reviewList.add(review);
			    }while(rs.next());                       
               
			}//if end

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (pt != null) try { rs.close(); } catch(SQLException ex) {}
    	   if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return reviewList;
   }//getReviewSimple end

   //리뷰 함수  : 리뷰 출력하기 2<-- mypage.jsp 
	public List<UserReviewDataBean> getReviews2(String user_id,int start,int end)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       ResultSet pt = null;
       int index = -1;
       List<UserReviewDataBean> reviewList=null;
       try {
           conn = getConnection();
           	
           if(end==0){ //mobile_myreview.jsp 에서 뜬다
        	   pstmt = conn.prepareStatement("SELECT r.*,s.main_photo,s.store_name from review r,store s where r.store_id=s.store_id and r.user_id = ?"
		           		+ " and r.check_review = 1 order by r.reg_date2 desc");
		           pstmt.setString(1,user_id);
		        
	 	   
           }else {
        	   pstmt = conn.prepareStatement("SELECT r.*,s.main_photo,s.store_name from review r,store s where r.store_id=s.store_id and r.user_id = ?"
		           		+ " and r.check_review = 1 order by r.reg_date2 desc limit ?,?");
		           pstmt.setString(1,user_id);
		           pstmt.setInt(2, start-1);
		           pstmt.setInt(3, end);
           }
	          
           rs = pstmt.executeQuery();
           if (rs.next()) {
	              reviewList = new ArrayList<UserReviewDataBean>();
	              
	               do{
	            	   UserReviewDataBean review =  new UserReviewDataBean();
		            	 index = rs.getInt("no");
		            	 pstmt = conn.prepareStatement("select group_concat(review_photo separator ',') as review_photos"
		 	            		+ " From review_photo where review_index=?");
				           pstmt.setInt(1,index);
				           pt = pstmt.executeQuery();
				           if(pt.next()) {
				            	 review.setReview_photos(pt.getString(1));
				            	 review.setStore_id(rs.getString("store_id"));
				            	 review.setCheck_review(rs.getInt("check_review"));
				            	 review.setReview_title(rs.getString("review_title"));
				            	 review.setReview_content(rs.getString("review_content"));
				            	 review.setScore(rs.getInt("score"));
				            	 review.setReg_date2(rs.getTimestamp("reg_date2"));
				            	 review.setReg_date(rs.getTimestamp("reg_date"));
				            	 //이부분 join 해서 출력함
				            	 review.setMain_photo(rs.getString("main_photo"));
				            	 review.setStore_name(rs.getString("store_name"));
				           }            	           
	                  reviewList.add(review);
				    }while(rs.next());                       
	               
				}//if end
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return reviewList;
   }//getReviews2
	
   //리뷰 함수  : 리뷰 갯수 출력하기 <--mypage.jsp
	public int getReviews2Count(String user_id)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       ResultSet pt = null;
       int index = -1;
 
       try {
           conn = getConnection();

	           pstmt = conn.prepareStatement("SELECT count(*) from review r,store s where r.store_id=s.store_id and r.user_id = ?"
	           		+ " and r.check_review = 1");
	           pstmt.setString(1,user_id);
	           
	           rs = pstmt.executeQuery();
	
	           if (rs.next()) {
	        	   	index = rs.getInt(1);
				}//if end

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return index;
   }//getReviews2Count end
	
	   //리뷰 함수  : 방문한곳 출력하기 2<-- mypage.jsp // 
		public List<UserReviewDataBean> getReviews3(String user_id,int start,int end)
	            throws Exception {
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<UserReviewDataBean> reviewList=null;
	       try {
	           conn = getConnection();

		           pstmt = conn.prepareStatement("SELECT r.check_review,s.store_name,r.reg_date,s.store_id "
		           		+ "from review r,store s where r.store_id=s.store_id "
		           		+ "and r.user_id = ? order by r.reg_date desc limit ?,? "
		           		+ "");
		           pstmt.setString(1,user_id);
		           pstmt.setInt(2, start-1);
		           pstmt.setInt(3, end);
		           rs = pstmt.executeQuery();
		
		           if (rs.next()) {
		              reviewList = new ArrayList<UserReviewDataBean>();
		               do{
		            	   UserReviewDataBean review =  new UserReviewDataBean();
		            	 review.setCheck_review(rs.getInt("check_review"));				            	
		            	 review.setStore_id(rs.getString("store_id"));	
		            	 review.setReg_date(rs.getTimestamp("reg_date"));
		            	 //이부분 join 해서 출력함
		            	 review.setStore_name(rs.getString("store_name"));
		                  reviewList.add(review);
					    }while(rs.next());                       
		               
					}//if end

	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return reviewList;
	   }//getReviews3	
						
		//방문한곳 출력 <-- mobile_visit.jsp
		public List<UserReviewDataBean> getVisitedMobile(String user_id)
	            throws Exception {
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<UserReviewDataBean> reviewList=null;
	       try {
	           conn = getConnection();

		           pstmt = conn.prepareStatement("SELECT r.no,r.check_review,s.store_name,"
		           		+ "date_format(r.reg_date,'%Y년 %c월 %e일') as date_format,s.store_id "
		           		+ "from review r,store s where r.store_id=s.store_id "
		           		+ "and r.user_id = ? order by r.reg_date desc "
		           		);
		           pstmt.setString(1,user_id);
		   
		           rs = pstmt.executeQuery();
		
		           if (rs.next()) {
		              reviewList = new ArrayList<UserReviewDataBean>();
		               do{
		            	   UserReviewDataBean review =  new UserReviewDataBean();
		            	 review.setNo(rs.getInt("no"));
		            	 review.setCheck_review(rs.getInt("check_review"));				            	
		            	 review.setStore_id(rs.getString("store_id"));	
		            	 review.setDate_format(rs.getString("date_format"));
		            	 //이부분 join 해서 출력함
		            	 review.setStore_name(rs.getString("store_name"));
		                  reviewList.add(review);
					    }while(rs.next());                       
		               
					}//if end

	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return reviewList;
	   }//getVisitedMobile end			
		
		//방문한 곳 날짜 출력 <-- mobile_visit
		public List<UserReviewDataBean> getVisitedDate_Mobile(String user_id)
	            throws Exception {
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<UserReviewDataBean> dateList=null;
	      
	      
	       try {
	           conn = getConnection();

		           pstmt = conn.prepareStatement("select DISTINCT "
		           		+ "date_format(reg_date,'%Y년 %c월 %e일') from review where user_id = ? order by reg_date desc "
		           		);
		           pstmt.setString(1,user_id);
		         
		           rs = pstmt.executeQuery();
		
		           if (rs.next()) {
			              dateList = new ArrayList<UserReviewDataBean>();
			               do{
			            	   
			            	  UserReviewDataBean review_date =  new UserReviewDataBean();
			            	  review_date.setDate_format(rs.getString(1));
			                  dateList.add(review_date);
						    }while(rs.next());                       
			               
						}//if end 
		           

	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return dateList;
	   }//getVisitedDate_Mobile end
		
		//방문한 곳 날짜 출력 <-- mobile_review.jsp 에서 날짜 출력
		public String getVisitedDate_Mobile(String user_id,String store_id)
	            throws Exception {
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       String review_date = "";
	      
	       try {
	           conn = getConnection();

		           pstmt = conn.prepareStatement("select "
		           		+ "date_format(reg_date,'%Y년 %c월 %e일') from review where user_id = ? and store_id = ? and check_review = 0 "
		           		);
		           pstmt.setString(1,user_id);
		           pstmt.setString(2, store_id);
		         
		           rs = pstmt.executeQuery();
		
		           if (rs.next()) {
		        	   			review_date = rs.getString(1);
						}//if end 
		           

	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return review_date;
	   }//getVisitedDate_Mobile
		
		   //리뷰 함수 3.4 : 방문한 곳 갯수 출력하기 <--mypage.jsp
			public int getReviews3Count(String user_id)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       ResultSet pt = null;
		       int index = -1;
		 
		       try {
		           conn = getConnection();

			           pstmt = conn.prepareStatement("SELECT count(*) "
			           		+ "from review r,store s where r.store_id=s.store_id and r.user_id = ? order by r.reg_date desc");
			           pstmt.setString(1,user_id);
			           
			           rs = pstmt.executeQuery();
			
			           if (rs.next()) {
			        	   	index = rs.getInt(1);
						}//if end

		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return index;
		   }//getReviews3Count end							
				
	// 모바일에서 gps이용하여 주변에있는 데이터불러오기 <--mobile_main.jsp
			public ArrayList<StoreinfoDataBean> getLocation_info(String key,int opt)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       ArrayList<StoreinfoDataBean> searchList=null;
		       String sql = "";
		       try {
		           conn = getConnection();
		           		if(opt==3){
		           			sql = "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo, "
					           		+ "t.store_name,t.address from store_menu s INNER JOIN store t on s.store_id = t.store_id and address like ? "
					           		+ "group by t.store_id  limit ?";
		           		   pstmt = conn.prepareStatement(sql);
				           pstmt.setString(1,"%"+key+"%");
				           pstmt.setInt(2, opt);
				
		           		}else{
		           			sql = "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo, "
					           		+ "t.store_name,t.address from store_menu s INNER JOIN store t on s.store_id = t.store_id and address like ? "
					           		+ "group by t.store_id";
		           	      pstmt = conn.prepareStatement(sql);
		           	      pstmt.setString(1,"%"+key+"%"); 
		           		}
			     
			           rs = pstmt.executeQuery();
		 
			               						
			           if (rs.next()) {
			              searchList = new ArrayList<StoreinfoDataBean>();
			               do{			     
			            	  StoreinfoDataBean search = new StoreinfoDataBean();
			            	   search.setStore_id(rs.getString("store_id"));
			            	   search.setMain_photo(rs.getString("main_photo"));
			            	   search.setStore_name(rs.getString("store_name"));
			            	   search.setMenu_names(rs.getString("menu_name"));	  
			            	   search.setAddress(rs.getString("address"));
			                   searchList.add(search);
						    }while(rs.next());                       
			               
						}//if end

		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return searchList;
		   }//getLocation_info end		
			
			//검색함수 : main과 category 에서 검색하기 <--search_done.jsp
			public ArrayList<StoreinfoDataBean> getMainSearch(String key,int category,int opt,int start,int end)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       ArrayList<StoreinfoDataBean> searchList=null;
		       String sql = "";
		 		   
		       try {
		           conn = getConnection();
		           System.out.print(category); 
		          if(category==5){
		        	  if(opt==0){//최신순

  
					        		  sql = "select s.*,group_concat(menu_name order by no asc separator ',') as menu_name "
		        				  + "from store s inner join store_menu m on (s.store_id=m.store_id) "
		        				  + "and (s.store_name like ? or s.address like ?) group by s.store_id order by reg_date desc limit ?,?" ;
		        	  }else if(opt==1){//평점순
		        		  sql = "select s.*,group_concat(menu_name order by no asc separator ',') as menu_name "
		        				  + "from store s inner join store_menu m on (s.store_id=m.store_id) "
		        				  + "and (s.store_name like ? or s.address like ?) group by s.store_id order by avg_mark desc limit ?,?" ;
		        	  }else{//인기순
		        		  sql = "select s.*,group_concat(menu_name order by no asc separator ',') as menu_name "
		        				  + "from store s inner join store_menu m on (s.store_id=m.store_id) "
		        				  + "and (s.store_name like ? or s.address like ?) group by s.store_id order by read_count desc limit ?,?" ;       		  
		        	  }

		        	   pstmt = conn.prepareStatement(sql);
			           pstmt.setString(1,"%"+key+"%");
			           pstmt.setString(2,"%"+key+"%");				        
			           pstmt.setInt(3,start-1);
			           pstmt.setInt(4,end);
			           
		          }else{
		        	  if(opt==0){//최신순
		        		  sql ="select s.*,group_concat(menu_name order by no asc separator ',') as menu_name "
		        				  + "from store s inner join store_menu m on (s.store_id=m.store_id and category = ? ) "
		        				  + "and (s.store_name like ? or s.address like ?) group by s.store_id order by reg_date desc limit ?,?" ;
		        	  }else if(opt==1){//평점순
		        		  sql = "select s.*,group_concat(menu_name order by no asc separator ',') as menu_name "
		        				  + "from store s inner join store_menu m on (s.store_id=m.store_id and category = ? ) "
		        				  + "and (s.store_name like ? or s.address like ?) group by s.store_id order by avg_mark desc limit ?,?" ;
		        	  }else{//가격순
		        		  sql = "select s.*,group_concat(menu_name order by no asc separator ',') as menu_name "
		        				  + "from store s inner join store_menu m on (s.store_id=m.store_id and category = ? ) "
		        				  + "and (s.store_name like ? or s.address like ?) group by s.store_id order by read_count desc limit ?,?" ;      		  
		        	  }					        	  
		        
		        	   pstmt = conn.prepareStatement(sql);
		        	   pstmt.setInt(1,category);
			           pstmt.setString(2,"%"+key+"%");
			           pstmt.setString(3,"%"+key+"%");						          
			           pstmt.setInt(4,start-1);
			           pstmt.setInt(5,end);
		          }
			        			          		  					        
				       rs = pstmt.executeQuery();
				
			           if (rs.next()) {
			              searchList = new ArrayList<StoreinfoDataBean>();
			               do{			            
			            	   StoreinfoDataBean search =  new StoreinfoDataBean();
			            	   search.setStore_id(rs.getString("store_id"));
			            	   search.setStore_name(rs.getString("store_name"));
			            	   search.setMain_photo(rs.getString("main_photo"));
			            	   search.setStore_id(rs.getString("store_id"));
			            	   search.setCategory(rs.getInt("category"));
			            	   search.setAvg_mark(rs.getDouble("avg_mark"));					            	
			            	   search.setAddress(rs.getString("address"));
			            	   search.setMenu_names(rs.getString("menu_name"));
			                  searchList.add(search);
						    }while(rs.next());                       
			               
						}//if end
	        	  
		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return searchList;
		   }//getMainSearch end
			
			//검색함수 : 검색결과 갯수 출력 <-- search_done.jsp
			public int getSearchCount(String key,int category)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       int index  = -1;
		       String sql = "";
		       
		       try {
		           conn = getConnection();
		           if(category==5){
		        	  
			        	  sql ="select count(*) from store where store_name like ?"
					           		+ " or address like ?";
			        	   pstmt = conn.prepareStatement(sql);
				           pstmt.setString(1,"%"+key+"%");
				           pstmt.setString(2,"%"+key+"%");
				          
			          }else{
			        	  sql = "select count(*) from store where (category = ? ) and (store_name like ?"
					           		+ " or address like ?)";
			        	   pstmt = conn.prepareStatement(sql);
			        	   pstmt.setInt(1,category);
				           pstmt.setString(2,"%"+key+"%");
				           pstmt.setString(3,"%"+key+"%");
				         
			          }				           
			         
			           rs = pstmt.executeQuery();
			
			           if (rs.next()) {
			        	   	index = rs.getInt(1);
			               
						}//if end

		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return index;
		   }//getSearchCount end				
			
			//모바일 서치 
			public ArrayList<StoreinfoDataBean> getSearchMobile(String key,int category)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       ArrayList<StoreinfoDataBean> searchList=null;
		       String sql = "";
		 		   
		       try {
		           conn = getConnection();
		        
		          if(category==5){
		        	  sql =  "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo," + 
		    	           		"t.store_name from store_menu s INNER JOIN store t "
		    	           		+ "on (s.store_id = t.store_id) and (t.store_name like ? OR t.address like ?) group by s.store_id order by reg_date";
		        
		        	   pstmt = conn.prepareStatement(sql);
			        	
			           pstmt.setString(1,"%"+key+"%");
			           pstmt.setString(2,"%"+key+"%");	
		          }else{
		        	
		        	  sql =  "select s.store_id,group_concat(menu_name order by no asc separator ',') as menu_name,t.main_photo," + 
		    	           		"t.store_name from store_menu s INNER JOIN store t "
		    	           		+ "on (s.store_id = t.store_id and category = ?) and (t.store_name like ? OR t.address like ?) group by s.store_id order by reg_date";
		        
		        	   pstmt = conn.prepareStatement(sql);
			           pstmt.setInt(1,category);
			           pstmt.setString(2,"%"+key+"%");
			           pstmt.setString(3,"%"+key+"%");						        	  					          
			           
		          }
			        			          		  					        
				       rs = pstmt.executeQuery();
				
				       if (rs.next()) {
			        	   searchList=new ArrayList<StoreinfoDataBean>();
			               do{
			            	   StoreinfoDataBean search= new StoreinfoDataBean();	            	   	  
								  search.setStore_id(rs.getString("store_id"));
								  search.setMain_photo(rs.getString("main_photo"));
								  search.setStore_name(rs.getString("store_name"));
								  search.setMenu_names(rs.getString(2));
			                 searchList.add(search);
						    }while(rs.next());                       
			               
						}//if end      
	        	  
		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return searchList;
		   }//getSearchMobile end
					
			//검색함수 : 리뷰에서 검색 <-- detailpage.jsp
			public ArrayList<UserReviewDataBean> getReviewSearch(String key,String store_id,int start,int end)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       ResultSet pt = null;
		       int index = -1;

		       ArrayList<UserReviewDataBean> searchList=null;
		       try {
		           conn = getConnection();
			           pstmt = conn.prepareStatement("select r.*,u.user_photo from review r,user_data u where (store_id =? and check_review = 1 and r.user_id=u.user_id) and (review_title like ? or review_content like ? or r.user_id like ?) order by reg_date2 desc limit ?,?");
			           pstmt.setString(1,store_id);
			           pstmt.setString(2,"%"+key+"%");
			           pstmt.setString(3,"%"+key+"%");
			           pstmt.setString(4,"%"+key+"%");
			           pstmt.setInt(5,start-1);
			           pstmt.setInt(6,end);					           
			           rs = pstmt.executeQuery();
			
			           if (rs.next()) {
			              searchList = new ArrayList<UserReviewDataBean>();
			               do{			            
			            	   UserReviewDataBean search =  new UserReviewDataBean();

			            	   index = rs.getInt("no"); //review 고유식별번호 가져오는 함수  
  		            	  //review 에 해당하는 고유식별번호로 review_photo table에서 사진을 셀렉해오는 쿼리문
			               pstmt = conn.prepareStatement("select group_concat(review_photo separator ',') as review_photos"
  		 	            		+ " From review_photo where review_index=?");
  				           pstmt.setInt(1,index);
  				           pt = pstmt.executeQuery();
  				           if(pt.next()) {
  				            	 search.setReview_photos(pt.getString(1));
  				            	 search.setUser_id(rs.getString("user_id"));
  				            	 search.setUser_photo(rs.getString("user_photo"));
  				            	 search.setReview_title(rs.getString("review_title"));
  				            	 search.setReview_content(rs.getString("review_content"));
  				            	 search.setScore(rs.getInt("score"));
  				            	 search.setReg_date2(rs.getTimestamp("reg_date2"));
  				           }

			                  searchList.add(search);
						    }while(rs.next());                       
			               
						}//if end

		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return searchList;
		   }//getReviewSearch end
			
			//검색함수 : 리뷰에서 검색 갯수 출력 <-- detailpage.jsp
			public int getReviewSearchCount(String key,String store_id)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       int index = -1;

		       ArrayList<UserReviewDataBean> searchList=null;
		       try {
		           conn = getConnection();
			           pstmt = conn.prepareStatement("select count(*) from review r,user_data u "
			           		+ "where (store_id =? and check_review = 1  and r.user_id=u.user_id) and (review_title like ? or review_content like ? or r.user_id like ?)");
			           pstmt.setString(1,store_id);
			           pstmt.setString(2,"%"+key+"%");
			           pstmt.setString(3,"%"+key+"%");
			           pstmt.setString(4,"%"+key+"%");
			           rs = pstmt.executeQuery();
			
			           if (rs.next()) {
			             index = rs.getInt(1);
						}//if end

		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return index;
		   }//getReviewSearchCount end
			
			//매장별 즐겨찾기 갯수 출력 <--mobile_main.jsp
			public int getFavoriteCount(String store_id,String user_id)
		            throws Exception {
		       Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       int count = -1; //오류일시 -1가 출력됨 
		       try {
		           conn = getConnection();
			           pstmt = conn.prepareStatement("select count(*) from favorite where store_id = ? and user_id = ?");
			           
			           pstmt.setString(1,store_id);
			           pstmt.setString(2,user_id);
			           rs = pstmt.executeQuery();
			
			           if (rs.next()) {
			        	   count = rs.getInt(1);
						}//if end

		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return count;
		   }//getFavoriteCount end		

	//즐겨찾기 관련함수 <-- 하트아이콘이 있는 모든 페이지에  연결 됨 . main,category,detailpage,waiting 에서 적용
	public int updateFavorite(String store_id,String user_id)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int count = -1; //오류일시 -1가 출력됨 
       try {
           conn = getConnection();
	           pstmt = conn.prepareStatement("select count(*) from favorite where store_id = ? and user_id = ?");
	           pstmt.setString(1,store_id);
	           pstmt.setString(2,user_id);
	           rs = pstmt.executeQuery();
	
	           if (rs.next()) {
	        	   count = rs.getInt(1);
	        	   if(count > 0 ) { // 존재하면
	        		    pstmt = conn.prepareStatement("delete from favorite where store_id = ? and user_id = ?");
	        		    pstmt.setString(1,store_id);
	        		    pstmt.setString(2,user_id);
	        		    pstmt.executeUpdate();
	        	   }else{//초기값 -1 또는 존재하지않아서 0일경우
	        		    pstmt = conn.prepareStatement("insert into favorite(store_id,user_id) values(?,?)");
	        		    pstmt.setString(1, store_id);
	        		    pstmt.setString(2, user_id);
	        		    pstmt.executeUpdate();
	        	   }
				}//if end

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return count;
   }//update Favorite end	
	
	//즐겨찾기 갯수출력 <-- 하트아이콘이 있는 모든 페이지에  연결 됨 . main,category,detailpage,waiting 에서 적용
	//내가 즐겨찾기 하고 있는 갯수 출력<--mobile_favorite.jsp
	public int getFavoriteCount(String user_id)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int count = -1; //오류일시 -1가 출력됨 
       try {
           conn = getConnection();
	           pstmt = conn.prepareStatement("select count(*) from favorite where user_id = ?");				        
	           pstmt.setString(1,user_id);
	           rs = pstmt.executeQuery();
	
	           if (rs.next()) {
	        	   	count = rs.getInt(1);
				}//if end

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return count;
   }//getFavoriteCount end		
	
	//즐겨찾기 삭제함수 <-- mypage.jsp	에서 사용
	public void deleteFavorite(String store_id,String user_id)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       try {
           conn = getConnection();
               pstmt = conn.prepareStatement("delete from favorite where store_id = ? and user_id = ?");
	           pstmt.setString(1,store_id);
	           pstmt.setString(2,user_id);
	           pstmt.executeUpdate();

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }				
   }//delete favorite end  		
	
	//즐겨찾기  출력함수 <-- mypage.jsp 
	public ArrayList<UserFavoriteDataBean> getFavorite(String user_id,int start,int end)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       ArrayList<UserFavoriteDataBean> favoriteList = null;
       try {
           conn = getConnection();
               pstmt = conn.prepareStatement("select f.store_id,s.store_name,s.main_photo,s.avg_mark from favorite f,"
               		+ "store s where f.user_id = ? and f.store_id=s.store_id order by f.reg_date desc limit ?,?");			  
	           pstmt.setString(1,user_id);
	           pstmt.setInt(2, start-1);
	           pstmt.setInt(3, end);
	           
	           rs = pstmt.executeQuery();
	           if(rs.next()){
	        	   favoriteList = new ArrayList<UserFavoriteDataBean>();
	               do{			            
	            	   UserFavoriteDataBean favorite =  new UserFavoriteDataBean();
	            	   favorite.setStore_id(rs.getString("store_id"));
	            	   favorite.setStore_name(rs.getString("store_name"));
	            	   favorite.setAvg_mark(rs.getDouble("avg_mark"));
	            	   favorite.setMain_photo(rs.getString("main_photo"));
	                   favoriteList.add(favorite);
				    }while(rs.next());  
	           }

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }				
       
       return favoriteList;
   }//getfavorite end  
	
	//즐겨찾기  출력함수 <-- mypage.jsp 
	public ArrayList<UserFavoriteDataBean> getFavoriteMobile(String user_id)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       ArrayList<UserFavoriteDataBean> favoriteList = null;
       try {
           conn = getConnection();
               pstmt = conn.prepareStatement("select f.store_id,s.store_name,s.main_photo,s.avg_mark from favorite f,"
               		+ "store s where f.user_id = ? and f.store_id=s.store_id order by f.reg_date desc");			  
	           pstmt.setString(1,user_id);
	
	           
	           rs = pstmt.executeQuery();
	           if(rs.next()){
	        	   favoriteList = new ArrayList<UserFavoriteDataBean>();
	               do{			            
	            	   UserFavoriteDataBean favorite =  new UserFavoriteDataBean();
	            	   favorite.setStore_id(rs.getString("store_id"));
	            	   favorite.setStore_name(rs.getString("store_name"));
	            	   favorite.setAvg_mark(rs.getDouble("avg_mark"));
	            	   favorite.setMain_photo(rs.getString("main_photo"));
	                   favoriteList.add(favorite);
				    }while(rs.next());  
	           }

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }				
       
       return favoriteList;
   }//getFavoriteMobile end  				
	
	//즐겨찾기 갯수 띄우기 ( 매장별 총 출력 ) <--mypage.jsp , mobile_favorite.jsp
	public int getFavoriteCount2(String store_id)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int count = -1;
       try {
           conn = getConnection();
               pstmt = conn.prepareStatement("select count(store_id) from favorite where store_id = ?");
	           pstmt.setString(1,store_id);				           
	           rs =pstmt.executeQuery();
	           
	           if(rs.next()) {
	        	   count = rs.getInt(1);
	           }

       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }			
         return count;
   }//delete favorite end  				
			
}//class end
