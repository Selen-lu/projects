package com.project.nolate.dao;

import java.util.List;
import java.util.Map;

import com.project.nolate.domain.Member;
import com.project.nolate.domain.MemberAuth;

public interface MemberDAO {
	public abstract Member getMember(String id);
	
	public abstract void insertMember(Member member);
	
	public abstract void insertAuth(MemberAuth auth);
	
	public abstract void updateMember(Member member);
	
	public abstract void updatePass(String id, String pass);
	
	public abstract void deleteMember(String id);
	
	public abstract List<String> getId(String email);
	
	public abstract String getPass(String id, String email);
	
	public abstract String confirmPass(String id);
	
	public abstract String getOverlapId(String id);
	
	public abstract Map<String, String> getAddress(String id);
}
