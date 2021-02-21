package com.project.nolate.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.project.nolate.domain.Member;
import com.project.nolate.domain.MemberAuth;


@Repository
public class MemberDAOImpl implements MemberDAO {

	private final String NAME_SPACE = "com.project.nolate.mapper.MemberMapper";
	
	
	private  SqlSessionTemplate sqlSession;
	
	
	
	@Autowired
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public Member getMember(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAME_SPACE + ".getMember", id);
	}

	@Override
	public void insertMember(Member member) {
		// TODO Auto-generated method stub
		sqlSession.insert(NAME_SPACE + ".insertMember", member);
	}
	
	

	@Override
	public void insertAuth(MemberAuth auth) {
		// TODO Auto-generated method stub
		sqlSession.insert(NAME_SPACE + ".insertAuth", auth);
		
	}

	@Override
	public void updateMember(Member member) {
		// TODO Auto-generated method stub
		sqlSession.update(NAME_SPACE + ".updateMember", member);
	}
	
	

	@Override
	public void updatePass(String id, String pass) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("pass", pass);
		
		sqlSession.update(NAME_SPACE + ".updatePass", params);
	}

	@Override
	public void deleteMember(String id) {
		sqlSession.delete(NAME_SPACE + ".deleteMember", id);
		
	}

	@Override
	public List<String> getId(String email) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectList(NAME_SPACE + ".getId", email);
	}

	@Override
	public String getPass(String id, String email) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("email", email);
		
		return sqlSession.selectOne(NAME_SPACE + ".getPass", params);
	}

	@Override
	public String confirmPass(String id) {
		
		
		return sqlSession.selectOne(NAME_SPACE + ".confirmPass", id);

	}

	@Override
	public String getOverlapId(String id) {
		
		return sqlSession.selectOne(NAME_SPACE + ".getOverlapId", id);
	}

	@Override
	public Map<String, String> getAddress(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAME_SPACE + ".getAddress", id);
	}

	
}
