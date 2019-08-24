package ch13.board;

import ch13.member.LogonDataBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class BoardDBBean {
	
    private static BoardDBBean instance = new BoardDBBean();
    //.jsp페이지에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
    public static BoardDBBean getInstance() {
        return instance;
    }
    
    private BoardDBBean() {}
    
    //커넥션풀로부터 Connection객체를 얻어냄
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/bban");
        return ds.getConnection();
    }
 
    

    //제일 최근글 업데이트알림
    public String checktime()
           	throws Exception {
					
    		   Connection conn = null;
    		   PreparedStatement pstmt = null;
    		   ResultSet rs = null;
    		   String time="";
  		
    		   try {
    		       conn = getConnection();
    	       
    		       pstmt = conn.prepareStatement("SELECT TIMESTAMPDIFF(MINUTE, max(reg_date),now()) from board");   
    		       rs=pstmt.executeQuery();
    		           		      
    		       	if(rs.next()) {   		       		
    		       		time = rs.getString(1);
    		       	}
    		       	
    		   } catch(Exception ex) {
    		       ex.printStackTrace();
    		   } finally {
    			   if (rs != null) try { rs.close(); } catch(SQLException ex) {}   		 
    		       if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    		       if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    		   }
    		   return time;
    	
        }		
    	    
    //업데이트 
    public String searchId(String id,int num)
           	throws Exception {
					
    		   Connection conn = null;
    		   PreparedStatement pstmt = null;
    		   ResultSet rs = null;
    		   String userid=null;
  		
    		   try {
    		       conn = getConnection();
    	       
    		       pstmt = conn.prepareStatement("select writer from board where writer = ? and num=?");
    	           pstmt.setString(1,id);   
    	           pstmt.setInt(2,num);    	           
    		       rs=pstmt.executeQuery();
    		           		      
    		       	if(rs.next()) {      		       		
    		       		 userid=rs.getString("writer");
    		       	}
    		       	
    		   } catch(Exception ex) {
    		       ex.printStackTrace();
    		   } finally {
    			   if (rs != null) try { rs.close(); } catch(SQLException ex) {}   		 
    		       if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    		       if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    		   }
    		   return userid;
    	
        }		   
    
    //id로 회원의 nikname 조회하기 <= top(nav) / home 에서 사용함.
    //id로 회원의 passwd 조회하기 <= write (list.jsp ) 에서 사용함.
    public LogonDataBean searchData(String id)
           	throws Exception {
					
    		   Connection conn = null;
    		   PreparedStatement pstmt = null;
    		   ResultSet rs = null;
    		   LogonDataBean member = new LogonDataBean();;
  		
    		   try {
    		       conn = getConnection();
    	       
    		       pstmt = conn.prepareStatement("select name,passwd from member where id = ?");
    	           pstmt.setString(1, id);   
    		       rs=pstmt.executeQuery();
    		           		      
    		       	if(rs.next()) {   
    		       		
    		       		member.setName(rs.getString("name"));  		 
    		       		member.setPasswd(rs.getString("passwd"));    		       	
    		       	}
    		       	
    		   } catch(Exception ex) {
    		       ex.printStackTrace();
    		   } finally {
    			   if (rs != null) try { rs.close(); } catch(SQLException ex) {}   		 
    		       if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    		       if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    		   }
    		   return member;
    	
        }		
    	
    
    //글 갯수 초기 화  <= list.jsp/diary.jsp 에서 사용함
    public void countRefresh()
        	throws Exception {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		
		
		   try {
		       conn = getConnection();
	       
		       pstmt = conn.prepareStatement("alter table board auto_increment = 1;");
		       pstmt.executeUpdate();
		       pstmt = conn.prepareStatement("set @count = 0;");
		       pstmt.executeUpdate();
		       pstmt = conn.prepareStatement("update board set auto_increment num = @count:= @count+1;");
		       pstmt.executeUpdate();
		      
		   } catch(Exception ex) {
		       ex.printStackTrace();
		   } finally {
		 
		       if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		       if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		   }
	
    }		
    
    //diary테이블에 글을 추가
    public void insertArticle2(BoardDataBean article) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;
        String sql="";


        try {
            conn = getConnection();
            // 쿼리를 작성
           
		    sql = "insert into diary(id,subject,reg_date,content) values(?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
                
            pstmt.setString(1, article.getWriter());           
            pstmt.setString(2, article.getSubject());
			pstmt.setTimestamp(3, article.getReg_date());
			pstmt.setString(4, article.getContent());

            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
       
    //board테이블에 글을 추가(insert문)<=writePro.jsp페이지에서 사용
    public void insertArticle(BoardDataBean article) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num=article.getNum();
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		int number=0;
        String sql="";


        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(num) from board");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		   
		    if (num!=0) {  
		      sql="update board set re_step=re_step+1 ";
		      sql += "where ref= ? and re_step> ?";
              pstmt = conn.prepareStatement(sql);
              pstmt.setInt(1, ref);
			  pstmt.setInt(2, re_step);
			  pstmt.executeUpdate();
			  re_step=re_step+1;
			  re_level=re_level+1;
		     }else{
		  	  ref=number;
			  re_step=0;
			  re_level=0;
		     }	 
            // 쿼리를 작성
           
		    sql = "insert into board(writer,passwd,subject,reg_date,ref,re_step,re_level,content,ip,check_m) values(?,?,?,?,?,?,?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            
           
            pstmt.setString(1, article.getWriter());
            pstmt.setString(2, article.getPasswd());            
            pstmt.setString(3, article.getSubject());
			pstmt.setTimestamp(4, article.getReg_date());
            pstmt.setInt(5, ref);
            pstmt.setInt(6, re_step);
            pstmt.setInt(7, re_level);
			pstmt.setString(8, article.getContent());
			pstmt.setString(9, article.getIp());
			//멤버가 글을 썼을경우 1, 아닐경우 0 <== 기본값이 0 으로 sql에서 설정해둠
			pstmt.setInt(10, article.getCheck_m());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    //board테이블에 저장된 전체글의 수를 얻어냄(select문)<=list.jsp에서 사용.
	public int getArticleCount(int opt,String condition) //opt가 0이면 검색결과가 없을 때
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
   
        int x=0;

        try {
            conn = getConnection();
             if(opt==0||condition==null||condition=="") {
                pstmt = conn.prepareStatement("select count(*) from board");
             }else if(opt==1){
                pstmt = conn.prepareStatement(
                		"SELECT count(*)"
                				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
                				+" where content like ? or subject like ? or name like ? or writer like ?");
                pstmt.setString(1, "%"+condition+"%");
    			pstmt.setString(2, "%"+condition+"%");
    			pstmt.setString(3, "%"+condition+"%");
    			pstmt.setString(4, "%"+condition+"%");                   
             }else if(opt==2){
                 pstmt = conn.prepareStatement(
                 		"SELECT count(*)"
                 				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
                 				+" where name like ? or writer like ?");
                 pstmt.setString(1, "%"+condition+"%");
     			 pstmt.setString(2, "%"+condition+"%");
    	 
             }else if(opt==3){
                 pstmt = conn.prepareStatement(
                  		"SELECT count(*)"
                  				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
                  				+" where subject like ?");
                  pstmt.setString(1, "%"+condition+"%");
     	            	 
             }else if(opt==4) {
                 pstmt = conn.prepareStatement(
                   		"SELECT count(*)"
                   				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
                   				+" where content like ?");
                   pstmt.setString(1, "%"+condition+"%");
      	            	             	 
             }
             
             
             
                rs = pstmt.executeQuery();
            if (rs.next()) {
               x= rs.getInt(1);
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
    
    //diary 저장된 전체글의 수를 얻어냄(select문)<=list.jsp에서 사용,diary.jsp 에서사용 , 단 dairy에서 쓸 때는 해당 id관련해서 글갯수얻어옴
	public int getArticleCount(String id,int opt,String condition)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            if(opt==0||condition==null||condition=="") {//일반검색
                pstmt = conn.prepareStatement("SELECT count(*) FROM diary WHERE id= ?");
                pstmt.setString(1, id);
            }else{
                pstmt = conn.prepareStatement(
                		"SELECT count(*)"
                				+" FROM diary"
                				+" WHERE content LIKE ? or subject LIKE ?");
                pstmt.setString(1, "%"+condition+"%");
    			pstmt.setString(2, "%"+condition+"%");
           	
            }
                rs = pstmt.executeQuery();

            if (rs.next()) {
               x= rs.getInt(1);
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

	//글의 목록(복수개의 글)을 가져옴(select문) <=list.jsp에서 사용
	public List<BoardDataBean> getArticles(int start,int end,int opt,String condition)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BoardDataBean> articleList=null;
        try {
            conn = getConnection();
            
            if(opt==0||condition==null||condition==""){//list.jsp에서 일반
       	
            pstmt = conn.prepareStatement(
            		"SELECT b.num,b.subject,b.reg_date,b.readcount,b.ref,b.re_step,b.re_level,b.content,b.ip,m.name,b.writer " 
            				+"FROM member m" 
            				+" RIGHT JOIN board b ON b.writer=m.id order by ref desc, re_step asc limit ?,?");
            pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<BoardDataBean>(end);
                do{
                  BoardDataBean article= new BoardDataBean();
				  article.setNum(rs.getInt("num"));
				  if(rs.getString("name")!=null)
					  {article.setWriter(rs.getString("name"));}
				  else
					  {article.setWriter(rs.getString("writer"));}
                  article.setSubject(rs.getString("subject"));
			      article.setReg_date(rs.getTimestamp("reg_date"));
				  article.setReadcount(rs.getInt("readcount"));
                  article.setRef(rs.getInt("ref"));
                  article.setRe_step(rs.getInt("re_step"));
				  article.setRe_level(rs.getInt("re_level"));
                  article.setContent(rs.getString("content"));
			      article.setIp(rs.getString("ip")); 
				  
                  articleList.add(article);
			    }while(rs.next());
                        
                
				}//if end
            }else if(opt==1){
            	//전체검색결과 얻어오는 쿼리
                pstmt = conn.prepareStatement(
                		"CREATE OR REPLACE VIEW search AS SELECT b.num,b.subject,b.reg_date,b.readcount,b.ref,b.re_step,b.re_level,b.content,b.ip,m.name,b.writer"
                				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
                				+" where content like ? or subject like ? or name like ? or writer like ?");
                pstmt.setString(1, "%"+condition+"%");
    			pstmt.setString(2, "%"+condition+"%");
    			pstmt.setString(3, "%"+condition+"%");
    			pstmt.setString(4, "%"+condition+"%");    			
    			pstmt.executeUpdate(); 
    			
                pstmt = conn.prepareStatement(
                		"SELECT * from search order by ref desc, re_step asc limit ?,?");
                pstmt.setInt(1, start-1);
    			pstmt.setInt(2, end);
                rs = pstmt.executeQuery();
 
                if (rs.next()) {
                    articleList = new ArrayList<BoardDataBean>(end);
                    do{
                      BoardDataBean article= new BoardDataBean();
    				  article.setNum(rs.getInt("num"));
    				  if(rs.getString("name")!=null)
    					  {article.setWriter(rs.getString("name"));}
    				  else
    					  {article.setWriter(rs.getString("writer"));}
                      article.setSubject(rs.getString("subject"));
    			      article.setReg_date(rs.getTimestamp("reg_date"));
    				  article.setReadcount(rs.getInt("readcount"));
                      article.setRef(rs.getInt("ref"));
                      article.setRe_step(rs.getInt("re_step"));
    				  article.setRe_level(rs.getInt("re_level"));
                      article.setContent(rs.getString("content"));
    			      article.setIp(rs.getString("ip")); 
    				  
                      articleList.add(article);
    			    }while(rs.next());
                                        	       	
                	}
          }else if(opt==2){
              pstmt = conn.prepareStatement(
              		"CREATE OR REPLACE VIEW search AS SELECT b.num,b.subject,b.reg_date,b.readcount,b.ref,b.re_step,b.re_level,b.content,b.ip,m.name,b.writer"
              				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
              				+" where name like ? or writer like ?");
              pstmt.setString(1, "%"+condition+"%");
  			pstmt.setString(2, "%"+condition+"%");   			
  			pstmt.executeUpdate(); 
  			
              pstmt = conn.prepareStatement(
              		"SELECT * from search order by ref desc, re_step asc limit ?,?");
              pstmt.setInt(1, start-1);
  			pstmt.setInt(2, end);
              rs = pstmt.executeQuery();

              if (rs.next()) {
                  articleList = new ArrayList<BoardDataBean>(end);
                  do{
                    BoardDataBean article= new BoardDataBean();
  				  article.setNum(rs.getInt("num"));
  				  if(rs.getString("name")!=null)
  					  {article.setWriter(rs.getString("name"));}
  				  else
  					  {article.setWriter(rs.getString("writer"));}
                    article.setSubject(rs.getString("subject"));
  			      article.setReg_date(rs.getTimestamp("reg_date"));
  				  article.setReadcount(rs.getInt("readcount"));
                    article.setRef(rs.getInt("ref"));
                    article.setRe_step(rs.getInt("re_step"));
  				  article.setRe_level(rs.getInt("re_level"));
                    article.setContent(rs.getString("content"));
  			      article.setIp(rs.getString("ip")); 
  				  
                    articleList.add(article);
  			    }while(rs.next());
                                      	       	
              	}               	                       	
         }else if(opt==3){
             pstmt = conn.prepareStatement(
               		"CREATE OR REPLACE VIEW search AS SELECT b.num,b.subject,b.reg_date,b.readcount,b.ref,b.re_step,b.re_level,b.content,b.ip,m.name,b.writer"
               				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
               				+" where subject like ?");
               pstmt.setString(1, "%"+condition+"%");			
   			pstmt.executeUpdate(); 
   			
               pstmt = conn.prepareStatement(
               		"SELECT * from search order by ref desc, re_step asc limit ?,?");
               pstmt.setInt(1, start-1);
   			pstmt.setInt(2, end);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   articleList = new ArrayList<BoardDataBean>(end);
                   do{
                     BoardDataBean article= new BoardDataBean();
   				  article.setNum(rs.getInt("num"));
   				  if(rs.getString("name")!=null)
   					  {article.setWriter(rs.getString("name"));}
   				  else
   					  {article.setWriter(rs.getString("writer"));}
                     article.setSubject(rs.getString("subject"));
   			      article.setReg_date(rs.getTimestamp("reg_date"));
   				  article.setReadcount(rs.getInt("readcount"));
                     article.setRef(rs.getInt("ref"));
                     article.setRe_step(rs.getInt("re_step"));
   				  article.setRe_level(rs.getInt("re_level"));
                     article.setContent(rs.getString("content"));
   			      article.setIp(rs.getString("ip")); 
   				  
                     articleList.add(article);
   			    }while(rs.next());
                                       	       	
               	}         	 
         }else if(opt==4){
             pstmt = conn.prepareStatement(
               		"CREATE OR REPLACE VIEW search AS SELECT b.num,b.subject,b.reg_date,b.readcount,b.ref,b.re_step,b.re_level,b.content,b.ip,m.name,b.writer"
               				+" FROM member m RIGHT JOIN board b ON b.writer=m.id"
               				+" where content like ?");
               pstmt.setString(1, "%"+condition+"%");			
   			pstmt.executeUpdate(); 
   			
               pstmt = conn.prepareStatement(
               		"SELECT * from search order by ref desc, re_step asc limit ?,?");
               pstmt.setInt(1, start-1);
   			pstmt.setInt(2, end);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   articleList = new ArrayList<BoardDataBean>(end);
                   do{
                     BoardDataBean article= new BoardDataBean();
   				  article.setNum(rs.getInt("num"));
   				  if(rs.getString("name")!=null)
   					  {article.setWriter(rs.getString("name"));}
   				  else
   					  {article.setWriter(rs.getString("writer"));}
                     article.setSubject(rs.getString("subject"));
   			      article.setReg_date(rs.getTimestamp("reg_date"));
   				  article.setReadcount(rs.getInt("readcount"));
                     article.setRef(rs.getInt("ref"));
                     article.setRe_step(rs.getInt("re_step"));
   				  article.setRe_level(rs.getInt("re_level"));
                     article.setContent(rs.getString("content"));
   			      article.setIp(rs.getString("ip")); 
   				  
                     articleList.add(article);
   			    }while(rs.next());
                                       	       	
               	}         	 
        	 
        	 
         }        	 
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return articleList;
    }
	
	//복수글 가져옴 <-diary
	public List<BoardDataBean> getArticles(String id,int opt,String condition)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<BoardDataBean> articleList=null;
       try {
           conn = getConnection();
           if(opt==0||condition==null||condition==""){//list.jsp에서 일반
	           pstmt = conn.prepareStatement("SELECT * from diary where id = ? order by reg_date desc");
	           pstmt.setString(1,id);
	           rs = pstmt.executeQuery();
	
	           if (rs.next()) {
	               articleList = new ArrayList<BoardDataBean>();
	               do{
	                 BoardDataBean article= new BoardDataBean();
					  article.setNum(rs.getInt("num"));
	                  article.setSubject(rs.getString("subject"));
				      article.setReg_date(rs.getTimestamp("reg_date"));
				      article.setContent(rs.getString("content"));
				  
	                 articleList.add(article);
				    }while(rs.next());
	                       
	               
				}//if end
           }else if(opt==1){
           	//검색결과 얻어오는 쿼리
	                pstmt = conn.prepareStatement(
	               		"SELECT * FROM diary where id=? and content like ? or subject like ? order by reg_date desc");
	                pstmt.setString(1,id);
		   			pstmt.setString(2, "%"+condition+"%");
		   			pstmt.setString(3, "%"+condition+"%");
 			
			        rs = pstmt.executeQuery();
		   		
			           if (rs.next()) {
			               articleList = new ArrayList<BoardDataBean>();
			               do{
			                 BoardDataBean article= new BoardDataBean();
							  article.setNum(rs.getInt("num"));
			                  article.setSubject(rs.getString("subject"));
						      article.setReg_date(rs.getTimestamp("reg_date"));
						      article.setContent(rs.getString("content"));
						  
			                 articleList.add(article);
						    }while(rs.next());    	
	           	
	           }
	               }        	   
         
           
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return articleList;
   }
 
	//이전글/다음글 가져오는 쿼리 <= content.jsp  에서사용
	   public int selectBeforeAfter(int num,int check)//이전글을 눌렀으면 check가 1, 이후(right)글은 -1
		          throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
				int result=0;
				String sql = null;

		        try {
		            conn = getConnection();

	            		if(check==1) {
			            		 // 이전글
			            		  sql = "select num from board where num=(select max(num) from board where num < ?)";
			            		  pstmt = conn.prepareStatement(sql);
			            		  pstmt.setInt(1, num);
	            		}else{
			            		  // 다음글
			            		  sql = "select num from board where num=(select min(num) from board where num > ?)";
			            		  pstmt = conn.prepareStatement(sql);
			            		  pstmt.setInt(1, num);

	            		}
	            		  rs = pstmt.executeQuery();       		  
	           		  if(rs.next()) {
	            		   result = rs.getInt("num");            		 
	           
	           		  }
		        } catch(Exception ex) {
		            ex.printStackTrace();
		        } finally{
		            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		        }
		        return result;
		    }

	//글의 내용을 보기(1개의 글)(select문)<=content.jsp페이지에서 사용
	public BoardDataBean getArticle(int num)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDataBean article=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"update board set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
						
            pstmt = conn.prepareStatement(
            		"CREATE OR REPLACE VIEW content_file AS SELECT b.num,b.check_m,b.subject,b.reg_date,b.readcount,b.ref,b.re_step,b.re_level,b.content,b.ip,m.name,b.writer FROM member m RIGHT JOIN board b ON b.writer=m.id");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("SELECT * from content_file where num=?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardDataBean();
                article.setNum(rs.getInt("num"));
                article.setCheck_m(rs.getInt("check_m"));
				  if(rs.getString("name")!=null)
				  {article.setWriter(rs.getString("name"));}
				  else
				  {article.setWriter(rs.getString("writer"));}
                article.setSubject(rs.getString("subject"));
			    article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
                article.setRef(rs.getInt("ref"));
                article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
                article.setContent(rs.getString("content"));
			    article.setIp(rs.getString("ip"));     
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return article;
    }
	
	
    
	//글 수정폼에서 사용할 글의 내용(1개의 글)(select문)<=updateForm.jsp에서 사용
//    public BoardDataBean updateGetArticle(int num)
//          throws Exception {
//        Connection conn = null;
//        PreparedStatement pstmt = null;
//        ResultSet rs = null;
//        BoardDataBean article=null;
//        try {
//            conn = getConnection();
//
//            pstmt = conn.prepareStatement(
//            	"select * from board where num = ?");
//            pstmt.setInt(1, num);
//            rs = pstmt.executeQuery();
//
//            if (rs.next()) {
//                article = new BoardDataBean();
//                article.setNum(rs.getInt("num"));
//				article.setWriter(rs.getString("writer"));
//                article.setSubject(rs.getString("subject"));
//                article.setPasswd(rs.getString("passwd"));
//			    article.setReg_date(rs.getTimestamp("reg_date"));
//				article.setReadcount(rs.getInt("readcount"));
//                article.setRef(rs.getInt("ref"));
//                article.setRe_step(rs.getInt("re_step"));
//				article.setRe_level(rs.getInt("re_level"));
//                article.setContent(rs.getString("content"));
//			    article.setIp(rs.getString("ip"));     
//			}
//        } catch(Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
//            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
//            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
//        }
//		return article;
//    }

    //글 수정처리에서 사용(update문)<=updatePro.jsp에서 사용
    public int updateArticle(BoardDataBean article)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;

        String dbpasswd="";
        String sql="";
		int x=-1;
        try {
            conn = getConnection();
            
			pstmt = conn.prepareStatement(
            	"select passwd from board where num = ?");
            pstmt.setInt(1, article.getNum());
            rs = pstmt.executeQuery();
            
			if(rs.next()){
			  dbpasswd= rs.getString("passwd"); 
			  if(dbpasswd.equals(article.getPasswd())){
                sql="update board set writer=?,subject=?,passwd=?";
			    sql+=",content=? where num=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, article.getWriter());
                pstmt.setString(2, article.getSubject());
                pstmt.setString(3, article.getPasswd());
                pstmt.setString(4, article.getContent());
			    pstmt.setInt(5, article.getNum());
                pstmt.executeUpdate();
				x= 1;
			  }else{
				x= 0;
			  }
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
    
    //글삭제처리시 사용(delete문)<=deletePro.jsp페이지에서 사용
    public int deleteArticle(int num, String passwd)
        throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        int ref=-1;
        int count,re_step;
        int x=-1;
        try {
			conn = getConnection();     
			//셀프조인사용
        	pstmt = conn.prepareStatement("SELECT b.ref,count(b.ref),b.passwd,b.re_step from board b,board bb where b.ref=bb.ref and b.re_step=bb.re_step and b.num = ?"); 
            pstmt.setInt(1,num);
        	rs = pstmt.executeQuery();
                        
			if(rs.next()){				
				ref=rs.getInt(1);
            	count=rs.getInt(2);    
				dbpasswd= rs.getString(3); 
            	re_step=rs.getInt(4);				
						if(dbpasswd.equals(passwd)){
					           if(count>1&&re_step==0){ //답글있는지 검사 ,답글이 있을경우 답글도 함께 지워짐
					        	   //원글인경우 관련 그룹글 모두 지워지는쿼리실행 
				            		pstmt = conn.prepareStatement("delete from board where ref=?");
				                    pstmt.setInt(1,ref);				        	   
					            }else{ //원글이 아닌 경우 본인만지워짐
									pstmt = conn.prepareStatement("delete from board where num=?");
				                    pstmt.setInt(1, num);                  
			                    }					             
					             pstmt.executeUpdate();
							x= 1; //글삭제 성공
						}else {
							x= 0; //비밀번호 틀림
						}
					
		            	
			}//rs.next end
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
    
    //diary 에서 딜리트기능
    public void deleteArticle(int num)
            throws Exception {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs= null;


            try {
    			conn = getConnection();

						pstmt = conn.prepareStatement("delete from diary where num=?");
						pstmt.setInt(1,num);
						pstmt.executeUpdate();														            	
  
            } catch(Exception ex) {
                ex.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch(SQLException ex) {}
                if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
                if (conn != null) try { conn.close(); } catch(SQLException ex) {}
            }
    		
        }
    

    

}