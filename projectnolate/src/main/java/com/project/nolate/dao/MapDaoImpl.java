package com.project.nolate.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nolate.domain.Mapp;

@Repository
public class MapDaoImpl implements MapDao {

	private final String NAME_SPACE = "com.project.nolate.mapper.MapMapper";
	
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSessionTemplate sqlSession) {
	this.sqlSession = sqlSession;
	}
	
	@Override
	public List<Mapp> mapList(String id) {
		
		return sqlSession.selectList(NAME_SPACE + ".mapList", id);
	}

	@Override
	public Mapp getMap(int no) {
		
		return sqlSession.selectOne(NAME_SPACE + ".getMap", no);
	}

	@Override
	public void insertMap(Mapp map) {
		// TODO Auto-generated method stub
		sqlSession.insert(NAME_SPACE + ".insertMap", map);
	}

	@Override
	public void updateMap(Mapp map) {
		// TODO Auto-generated method stub
		sqlSession.update(NAME_SPACE + ".updateMap", map);
	}

	@Override
	public void deleteMap(int no) {
		// TODO Auto-generated method stub
		sqlSession.delete(NAME_SPACE + ".deleteMap", no);
	}

	@Override
	public String maps_str(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAME_SPACE + ".maps_str", no);
	}

	@Override
	public String mape_str(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAME_SPACE + ".mape_str", no);
	}

	@Override
	public int countMap() {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne(NAME_SPACE + ".countMap");
	}

	@Override
	public Integer getMapNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAME_SPACE + ".getMapNo");
	}
	
	

}
