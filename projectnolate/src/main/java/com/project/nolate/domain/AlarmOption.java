package com.project.nolate.domain;

import java.sql.Time;
import java.sql.Timestamp;

public class AlarmOption {
	private String id;
	private Integer alarmNo;
	private Time alarmTime;
	private boolean weatherCheck;
	private boolean bbsCheck;
	private boolean coronaCheck;
	private boolean scheduleCheck;
	private boolean starluckCheck;
	
	public AlarmOption() {}
	
	public AlarmOption(String id, Time alarmTime, boolean weatherCheck, boolean bbsCheck,
			boolean coronaCheck, boolean scheduleCheck, boolean starluckCheck) {
		super();
		this.id = id;
		this.alarmTime = alarmTime;
		this.weatherCheck = weatherCheck;
		this.bbsCheck = bbsCheck;
		this.coronaCheck = coronaCheck;
		this.scheduleCheck = scheduleCheck;
		this.starluckCheck = starluckCheck;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getAlarmNo() {
		return alarmNo;
	}

	public void setAlarmNo(Integer alarmNo) {
		this.alarmNo = alarmNo;
	}

	public Time getAlarmTime() {
		return alarmTime;
	}

	public void setAlarmTime(Time alarmTime) {
		this.alarmTime = alarmTime;
	}

	public boolean isWeatherCheck() {
		return weatherCheck;
	}

	public void setWeatherCheck(boolean weatherCheck) {
		this.weatherCheck = weatherCheck;
	}

	public boolean isBbsCheck() {
		return bbsCheck;
	}

	public void setBbsCheck(boolean bbsCheck) {
		this.bbsCheck = bbsCheck;
	}

	public boolean isCoronaCheck() {
		return coronaCheck;
	}

	public void setCoronaCheck(boolean coronaCheck) {
		this.coronaCheck = coronaCheck;
	}

	public boolean isScheduleCheck() {
		return scheduleCheck;
	}

	public void setScheduleCheck(boolean scheduleCheck) {
		this.scheduleCheck = scheduleCheck;
	}

	public boolean isStarluckCheck() {
		return starluckCheck;
	}

	public void setStarluckCheck(boolean starluckCheck) {
		this.starluckCheck = starluckCheck;
	}
	
	
	
	
}
