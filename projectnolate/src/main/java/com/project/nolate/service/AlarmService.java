package com.project.nolate.service;

import com.project.nolate.domain.AlarmOption;

public interface AlarmService {
	public abstract void setAlarm(AlarmOption alarm);
	public abstract void updateAlarm(AlarmOption alarm);
	public abstract void deleteAlarm(Integer alarmNo);
	public abstract AlarmOption getAlarm(Integer alarmNo);
	public abstract Integer getAlarmNo();
	
}
