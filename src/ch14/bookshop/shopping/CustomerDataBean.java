package ch14.bookshop.shopping;

import java.sql.Timestamp;

public class CustomerDataBean {
	private String id;//아이디
	private String passwd;//비밀번호
	private String name;//이름
	private Timestamp reg_date;//가입일자
	private String tel;//전화번호
	private String address;//주소
	private String address_de;//주소	2
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_de() {
		return address_de;
	}
	public void setAddress_de(String address_de) {
		this.address_de = address_de;
	}

}
