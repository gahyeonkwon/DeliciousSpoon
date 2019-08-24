package b_teampro2.storeinfo;

import java.sql.Timestamp;

public class System_DataBean {

	//system_admin 테이블
	private String master_id;
	private String master_passwd;
	
	//tempo_store 테이블
	private String store_id;
	private String store_passwd;
	private String store_name;
	private String name;
	private String business_no;
	private int store_cellphone;
	private int post_num;
	private String address;
	private String address_detail;
	private int category;
	private Timestamp reg_date;
	private int conf;
	
		//system_admin 테이블
		public String getMaster_id() {
			return master_id;
		}
		public void setMaster_id(String master_id) {
			this.master_id=master_id;
		}
		public String getMaster_passwd() {
			return master_passwd;
		}
		public void setMaster_passwd(String master_passwd) {
			this.master_passwd=master_passwd;
		}
	
		//tempo_store 테이블
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
		public String getStore_name() {
		   return store_name;
		}
		public void setStore_name(String store_name) {
		   this.store_name=store_name;
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
		public int getStore_cellphone() {
		   return store_cellphone;
		}
		public void setStore_cellphone(int store_cellphone) {
		   this.store_cellphone=store_cellphone;
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
		public int getCategory() {
		   return category;
		}
		public void setCategory(int category) {
		   this.category=category;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
		}
		public int getConf() {
		   return conf;
		}
		public void setConf(int conf) {
		   this.conf=conf;
		}
}
