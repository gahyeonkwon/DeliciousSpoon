package b_teampro2.storeinfo;

import java.sql.Timestamp;

public class StoreinfoDataBean {
	
	//store 테이블
	private String store_id;
	private String store_passwd;
	private int store_cellphone;
	private String name;
	private String business_no;
	private int category;
	private String store_name;
	private int post_num;
	private String address;
	private String address_detail;
	private int store_phone;
	private int open_close;
	private double avg_mark;
	private String intro;
	private int seat_count;
	private String open_time;
	private String open_day;
	private String main_photo;
	private Timestamp reg_date;
	
	//store_menu, store_photo 테이블
	private int no;
	private String [] menu_name;
	private String [] menu_price;
	private String [] menu_photo;
	private String [] store_photo;

	//출력할때 쓰는 함수
	private String menu_names;
	private String menu_prices;
	private String menu_photos;
	private String store_photos;
	private int avg_price;
		//store 테이블
		public String getStore_id() {
		   return store_id;
		}
		public void setStore_id(String store_id) {
		   this.store_id=store_id;
		}
		public String getStore_passwd() {
		   return store_passwd;
		}
		public void setStore_passwd(String store_passwd) {
		   this.store_passwd=store_passwd;
		}
		public int getStore_cellphone() {
		   return store_cellphone;
		}
		public void setStore_cellphone(int store_cellphone) {
		   this.store_cellphone=store_cellphone;
		}
		public String getName() {
		   return name;
		}
		public void setName(String name) {
		   this.name=name;
		}
		public String getBusiness_no() {
		   return business_no;
		}
		public void setBusiness_no(String business_no) {
		   this.business_no=business_no;
		}
		public int getCategory() {
		   return category;
		}
		public void setCategory(int category) {
		   this.category=category;
		}
		public String getStore_name() {
		   return store_name;
		}
		public void setStore_name(String store_name) {
		   this.store_name=store_name;
		}
		public int getPost_num() {
			return post_num;
		}
		public void setPost_num(int post_num) {
			this.post_num=post_num;
		}
		public String getAddress() {
		   return address;
		}
		public void setAddress(String address) {
		   this.address=address;
		}
		public String getAddress_detail() {
		   return address_detail;
		}
		public void setAddress_detail(String address_detail) {
		   this.address_detail=address_detail;
		}
		public int getStore_phone() {
		   return store_phone;
		}
		public void setStore_phone(int store_phone) {
		   this.store_phone=store_phone;
		}
		public int getOpen_close() {
		   return open_close;
		}
		public void setOpen_close(int open_close) {
		   this.open_close=open_close;
		}
		public double getAvg_mark() {
			return avg_mark;
		}
		public void setAvg_mark(double avg_mark) {
			this.avg_mark=avg_mark;
		}
		public String getIntro() {
		   return intro;
		}
		public void setIntro(String intro) {
		   this.intro=intro;
		}
		public int getSeat_count() {
		   return seat_count;
		}
		public void setSeat_count(int seat_count) {
		   this.seat_count=seat_count;
		}
		public String getOpen_time() {
		   return open_time;
		}
		public void setOpen_time(String open_time) {
		   this.open_time=open_time;
		}
		public String getOpen_day() {
		   return open_day;
		}
		public void setOpen_day(String open_day) {
		   this.open_day=open_day;
		}
		public String getMain_photo() {
			return main_photo;
		}
		public void setMain_photo(String main_photo) {
			this.main_photo=main_photo;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
		}
		
		//store_menu, store_photo 테이블
		public int getNo() {
		   return no;
		}
		public void setNo(int no) {
		   this.no=no;
		}
		public String [] getMenu_name() {
		   return menu_name;
		}
		public void setMenu_name(String [] menu_name) {
		   this.menu_name=menu_name;
		}
		public String [] getMenu_price() {
		   return menu_price;
		}
		public void setMenu_price(String [] menu_price) {
		   this.menu_price=menu_price;
		}
		public String [] getMenu_photo() {
		   return menu_photo;
		}
		public void setMenu_photo(String [] menu_photo) {
		   this.menu_photo=menu_photo;
		}
		public String [] getStore_photo() {
		   return store_photo;
		}
		public void setStore_photo(String [] store_photo) {
		   this.store_photo=store_photo;
		}

		//출력시
		public String getMenu_names() {
			   return menu_names;
			}
			public void setMenu_names(String menu_names) {
			   this.menu_names=menu_names;
			}
			public String getMenu_prices() {
			   return menu_prices;
			}
			public void setMenu_prices(String menu_prices) {
			   this.menu_prices=menu_prices;
			}
			public String getMenu_photos() {
			   return menu_photos;
			}
			public void setMenu_photos(String menu_photos) {
			   this.menu_photos=menu_photos;
			}
			public String getStore_photos() {
			   return store_photos;
			}
			public void setStore_photos(String store_photos) {
			   this.store_photos=store_photos;
			}		
			public int getAvg_price() {
				   return avg_price;
				}
			public void setAvg_price(int avg_price) {
			   this.avg_price=avg_price;
			}					
}


