package com.project.nolate.dao;

import java.sql.Date;
import java.util.List;

import com.project.nolate.domain.Schedule;
import com.project.nolate.domain.ScheduleCalender;

public interface ScheduleDao {
	public abstract List<Schedule> getScheduleList(String id, Integer year, Integer month);
	
	public abstract Schedule getSchedule(String id, String no);
	
	public abstract List<Schedule> getTodayScheduleList(String id, Integer year, Integer month, Integer day);
	
	public abstract void setScheduleBase(ScheduleCalender scheduleBase);
	
	public abstract void setSchedule(Schedule schedule);
	
	public abstract void updateSchedule(Schedule schedule);

	public abstract void deleteSchedule(String id, String no);
	
	public abstract Integer getScheduleBaseNo();
}
