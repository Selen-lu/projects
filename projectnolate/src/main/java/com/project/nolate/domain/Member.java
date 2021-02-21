package com.project.nolate.domain;

import java.sql.Date;
import java.util.List;

public class Member{
	private String id;
	private String pass;
	private String email;
	private Date birthday;
	private String homeAddress;
	private String companyAddress;
	private List<MemberAuth> authList;
	private boolean enabled;
	
	
	public Member() {}
	
	public Member(String id, String pass, String email, Date birthday, String homeAddress, String companyAddress) {
		super();
		this.id = id;
		this.pass = pass;
		this.email = email;
		this.birthday = birthday;
		this.homeAddress = homeAddress;
		this.companyAddress = companyAddress;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getHome_Address() {
		return homeAddress;
	}

	public void setHome_Address(String home_Address) {
		this.homeAddress = home_Address;
	}

	public String getCompany_Address() {
		return companyAddress;
	}

	public void setCompany_Address(String company_Address) {
		this.companyAddress = company_Address;
	}

	public List<MemberAuth> getAuthList() {
		return authList;
	}

	public void setAuthList(List<MemberAuth> authList) {
		this.authList = authList;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	
	
	
	
	
}
