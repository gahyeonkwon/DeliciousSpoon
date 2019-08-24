package b_teampro2.userinfo;
import java.sql.Timestamp;

public class UserFavoriteDataBean {

	//favorite 테이블
	private int no;
	private String user_id;
	private String store_id;
	private String name;
	private Timestamp reg_date;
	
	//UserSystemDBBean getFavorite 에서 사용하기 위한 객체
	private String main_photo;
	private String store_name;
	private double avg_mark;
	
		//favorite 테이블
		public int getNo() {
		   return no;
		}
		public void setNo(int no) {
		   this.no=no;
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
		public String getName() {
		   return name;
		}
		public void setName(String name) {
		   this.name=name;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
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
		
		public double getAvg_mark() {
			return avg_mark;
		}
		public void setAvg_mark(double avg_mark) {
			this.avg_mark=avg_mark;
		}
}


