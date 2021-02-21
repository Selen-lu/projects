package com.project.nolate.service.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nolate.dao.MapDao;
import com.project.nolate.dao.MemberDAO;
import com.project.nolate.domain.Member;
import com.project.nolate.domain.MemberAuth;


@Service
public class MemberSignInService implements MemberService{

	
	@Autowired
	private MemberDAO memberDao;

	public void setMemberDao(MemberDAO memberDao) {
		this.memberDao = memberDao;
	}

	@Override
	public Member getMember(String id) {
		// TODO Auto-generated method stub
		return memberDao.getMember(id);
	}

	@Override
	public void insertMember(Member member, MemberAuth auth) {
		// TODO Auto-generated method stub
		memberDao.insertMember(member);
		memberDao.insertAuth(auth);
	}

	@Override
	public void updateMember(Member member) {
		// TODO Auto-generated method stub
		memberDao.updateMember(member);
	}
	
	

	@Override
	public void updatePass(String id, String pass) {
		// TODO Auto-generated method stub
		memberDao.updatePass(id, pass);
	}


	@Override
	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		memberDao.deleteMember(id);
	}

	@Override
	public List<String> getId(String email) {
		// TODO Auto-generated method stub
		return memberDao.getId(email);
	}

	@Override
	public String getPass(String id, String email) {
		// TODO Auto-generated method stub
		return memberDao.getPass(id, email);
	}


	@Override
	public String confirmPass(String id) {
		// TODO Auto-generated method stub

		return memberDao.confirmPass(id);
	}


	@Override
	public boolean overlapID(String id) {
		// TODO Auto-generated method stub
		String overlapId = memberDao.getOverlapId(id);
		
		return !(overlapId.isEmpty());
	}


	@Override
	public Map<String, String> getAddress(String id) {
		
		return memberDao.getAddress(id);
	}
	
}
