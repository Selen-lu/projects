package com.project.nolate.dao;

import com.project.nolate.domain.AlarmOption;

public interface AlarmDAO {
	public abstract void setAlarm(AlarmOption alarm);
	public abstract void updateAlarm(AlarmOption alarm);
	public abstract void deleteAlarm(Integer alarmNo);
	public abstract AlarmOption getAlarm(Integer alarmNo);
	public abstract Integer getAlarmNo();
	
}
