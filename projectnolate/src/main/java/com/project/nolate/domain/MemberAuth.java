package com.project.nolate.domain;

public class MemberAuth {
	private String id;
	private String auth;
	
	
	public MemberAuth() {
		// TODO Auto-generated constructor stub
	}
	
	public MemberAuth(String id, String auth) {
		super();
		this.id = id;
		this.auth = auth;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	
	
}
