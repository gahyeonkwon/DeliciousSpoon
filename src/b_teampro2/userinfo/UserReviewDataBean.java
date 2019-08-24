package b_teampro2.userinfo;
import java.sql.Timestamp;

public class UserReviewDataBean {
	
	//review 테이블
	private int no;
	private int check_review;
	private String user_id;
	private String store_id;
	private String review_title;
	private String review_content;
	private int score;
	private Timestamp reg_date;
	private Timestamp reg_date2;
	private String [] review_photo;
	private String review_photos;
	
	//UserSystemDBBean getReviews 에서 사용하기 위한 객체
	private String main_photo;
	private String store_name;
	private String user_photo;
	
	//mobile 에서 방문한 곳 출력하기 위한 객체
	private String date_format ;
	
		//review 테이블
		public int getNo() {
		   return no;
		}
		public void setNo(int no) {
		   this.no=no;
		}	
		public int getCheck_review() {
		   return check_review;
		}
		public void setCheck_review(int check_review) {
		   this.check_review=check_review;
		}
		public String getUser_id() {
		   return user_id;
		}
		public void setUser_id(String user_id) {
		   this.user_id=user_id;
		}
		public String getStore_id() {
		   return store_id;
		}
		public void setStore_id(String store_id) {
		   this.store_id=store_id;
		}
		public String getReview_title() {
		   return review_title;
		}
		public void setReview_title(String review_title) {
		   this.review_title=review_title;
		}
		public String getReview_content() {
		   return review_content;
		}
		public void setReview_content(String review_content) {
		   this.review_content=review_content;
		}
		public int getScore() {
		   return score;
		}
		public void setScore(int score) {
		   this.score=score;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
		}
		public Timestamp getReg_date2() {
			return reg_date2;
		}
		public void setReg_date2(Timestamp reg_date2) {
			this.reg_date2 = reg_date2;
		}		
		public String [] getReview_photo() {
			   return review_photo;
			}
		public void setReview_photo(String [] review_photo) {
		   this.review_photo=review_photo;
		}	
		public String getReview_photos(){
			   return review_photos;
			}
		public void setReview_photos(String  review_photos) {
		   this.review_photos=review_photos;
		}			
		
		//추가 객체
		public String getMain_photo() {
			return main_photo;
		}
		public void setMain_photo(String main_photo) {
			this.main_photo=main_photo;
		}

		public String getStore_name() {
		   return store_name;
		}
		public void setStore_name(String store_name) {
		   this.store_name=store_name;
		}	
		
		public String getUser_photo() {
			   return user_photo;
			}
		public void setUser_photo(String user_photo) {
		   this.user_photo=user_photo;
		}
		
		public String getDate_format() {
			   return date_format;
			}
		public void setDate_format(String date_format) {
		   this.date_format = date_format;
		}

						
}


