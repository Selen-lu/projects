package com.project.nolate.domain;

import java.sql.Date;

public class Schedule {
	private int scheduleNo;
	private Date scheduleDate;
	private String scheduleTitle;
	private String scheduleMaterials;
	
	
	public Schedule() {}
	
	public Schedule(int scheduleNo, Date scheduleDate, String scheduleTitle, String scheduleMaterials) {
		this.scheduleNo = scheduleNo;
		this.scheduleDate = scheduleDate;
		this.scheduleTitle = scheduleTitle;
		this.scheduleMaterials = scheduleMaterials;
	}
	
	public Schedule(Date scheduleDate, String scheduleTitle, String scheduleMaterials) {
		this.scheduleDate = scheduleDate;
		this.scheduleTitle = scheduleTitle;
		this.scheduleMaterials = scheduleMaterials;
	}

	public int getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public Date getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getScheduleTitle() {
		return scheduleTitle;
	}
	public void setScheduleTitle(String scheduleTitle) {
		this.scheduleTitle = scheduleTitle;
	}
	public String getScheduleMaterials() {
		return scheduleMaterials;
	}
	public void setScheduleMaterials(String scheduleMaterials) {
		this.scheduleMaterials = scheduleMaterials;
	}
	
	
}
