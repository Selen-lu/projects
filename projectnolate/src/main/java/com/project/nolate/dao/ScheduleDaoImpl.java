package com.project.nolate.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nolate.domain.Schedule;
import com.project.nolate.domain.ScheduleCalender;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

	private static final String NAME_SPACE = "com.project.nolate.mapper.ScheduleMapper";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<Schedule> getScheduleList(String id, Integer year, Integer month) {
		
		Map<String, String> params = new HashMap<String, String>();
		String syear = String.valueOf(year);
		String smonth = String.valueOf(month);
		params.put("id", id);
		params.put("year", syear);
		params.put("month", smonth);
		return sqlSession.selectList(NAME_SPACE + ".getScheduleList", params);
	}
	
	

	@Override
	public List<Schedule> getTodayScheduleList(String id, Integer year, Integer month, Integer day) {
		Map<String, String> params = new HashMap<String, String>();
		String syear = String.valueOf(year);
		String smonth = String.valueOf(month);
		String sday = String.valueOf(day);
		params.put("id", id);
		params.put("year", syear);
		params.put("month", smonth);
		params.put("day", sday);
		
		return sqlSession.selectList(NAME_SPACE + ".getTodayScheduleList", params);
	}



	@Override
	public void setScheduleBase(ScheduleCalender scheduleBase) {
		// TODO Auto-generated method stub
		sqlSession.insert(NAME_SPACE + ".setScheduleBase", scheduleBase);
	}

	

	@Override
	public Schedule getSchedule(String id, String no) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("id", id);
		params.put("no", no);
		
		return sqlSession.selectOne(NAME_SPACE + ".getSchedule", params);
	}



	@Override
	public void setSchedule(Schedule schedule) {	
		
		sqlSession.insert(NAME_SPACE + ".setSchedule", schedule);
	}

	@Override
	public void updateSchedule(Schedule schedule) {
		
		sqlSession.update(NAME_SPACE + ".updateSchedule", schedule);
	}



	@Override
	public void deleteSchedule(String id, String no) {
		// TODO Auto-generated method stub
		Map<String, String> params = new HashMap<String, String>();
		params.put("id", id);
		params.put("scheduleNo", no);
		
		sqlSession.delete(NAME_SPACE + ".deleteSchedule", params);
		sqlSession.delete(NAME_SPACE + ".deleteScheduleBase", params);
	}



	@Override
	public Integer getScheduleBaseNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAME_SPACE + ".getScheduleBaseNo");
	}
	
	
	
	
	
	
}
