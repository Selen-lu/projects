package com.project.nolate.service.member;

import java.util.List;
import java.util.Map;

import com.project.nolate.domain.Member;
import com.project.nolate.domain.MemberAuth;

public interface MemberService {
	
	public abstract Member getMember(String id);
	
	public abstract void insertMember(Member member, MemberAuth auth);
	
	public abstract void updateMember(Member member);
	
	public abstract void updatePass(String id, String pass);
	
	public abstract void deleteMember(String id);
	
	public abstract List<String> getId(String email);
	
	public abstract String getPass(String id, String email);
	
	
	public abstract String confirmPass(String id);
	
	public abstract boolean overlapID(String id);
	
	public abstract Map<String, String> getAddress(String id);
}
