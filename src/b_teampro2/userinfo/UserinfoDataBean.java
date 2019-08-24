package b_teampro2.userinfo;

public class UserinfoDataBean {
	private String user_id;
	private String passwd;
	private String gender;
	//private int age;
	private int phone_number;
	private String user_photo;

		public String getUser_id() {
		   return user_id;
		}
		public void setUser_id(String user_id) {
		   this.user_id=user_id;
		}
		public String getPasswd() {
		   return passwd;
		}
		public void setPasswd(String passwd) {
		   this.passwd=passwd;
		}
		public String getGender() {
		   return gender;
		}
		public void setGender(String gender) {
		   this.gender=gender;
		}

		public int getPhone_number() {
		   return phone_number;
		}
		public void setPhone_number(int phone_number) {
		   this.phone_number=phone_number;
		}
		public String getUser_photo() {
		   return user_photo;
		}
		public void setUser_photo(String user_photo) {
		   this.user_photo=user_photo;
		}

}


