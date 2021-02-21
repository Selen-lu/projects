package com.project.nolate.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nolate.domain.AlarmOption;

@Repository
public class AlarmDaoImpl implements AlarmDAO {

	public static final String NAME_SPACE = "com.project.nolate.mapper.AlarmMapper";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public void setAlarm(AlarmOption alarm) {
		sqlSession.insert(NAME_SPACE + ".setAlarm", alarm);
	}

	@Override
	public void updateAlarm(AlarmOption alarm) {
		sqlSession.update(NAME_SPACE + ".updateAlarm", alarm);
	}

	@Override
	public void deleteAlarm(Integer alarmNo) {
		sqlSession.delete(NAME_SPACE + ".deleteAlarm", alarmNo);
	}

	@Override
	public AlarmOption getAlarm(Integer alarmNo) {
		
		return sqlSession.selectOne(NAME_SPACE + ".getAlarm", alarmNo);
	}

	@Override
	public Integer getAlarmNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAME_SPACE + ".getAlarmNo") ;
	}
	
	
}
