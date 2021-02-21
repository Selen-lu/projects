package com.project.nolate.service.schedule;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nolate.dao.ScheduleDao;
import com.project.nolate.domain.Schedule;
import com.project.nolate.domain.ScheduleCalender;

@Service
public class ScheduleServiceImpl implements ScheduleService{

	@Autowired
	private ScheduleDao scheduleDao;
	
	
	@Override
	public List<Schedule> getScheduleList(String id, Integer year, Integer month) {
		
		return scheduleDao.getScheduleList(id, year, month);
	}
	
	@Override
	public Schedule getSchedule(String id, String no) {
		
		return scheduleDao.getSchedule(id, no);
	}
	
	
	@Override
	public List<Schedule> getTodayScheduleList(String id, Integer year, Integer month, Integer day) {
		// TODO Auto-generated method stub
		return scheduleDao.getTodayScheduleList(id, year, month, day);
	}

	@Override
	public void setSchedule(ScheduleCalender scheduleBase, Schedule schedule) {
		// TODO Auto-generated method stub
		scheduleDao.setScheduleBase(scheduleBase);
		scheduleDao.setSchedule(schedule);
	}

	@Override
	public void updateSchedule(Schedule schedule) {
		// TODO Auto-generated method stub
		scheduleDao.updateSchedule(schedule);
	}

	@Override
	public void deleteSchedule(String id, String no) {
		// TODO Auto-generated method stub
		scheduleDao.deleteSchedule(id, no);
	}

	@Override
	public Integer getScheduleBaseNo() {
		// TODO Auto-generated method stub
		return scheduleDao.getScheduleBaseNo();
	}
	
	
	
	
}
