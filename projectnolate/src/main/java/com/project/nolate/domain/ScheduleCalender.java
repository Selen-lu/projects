package com.project.nolate.domain;



public class ScheduleCalender {
	private String id;
	private int scheduleNo;
	
	public ScheduleCalender() {}
	
	public ScheduleCalender(String id, int scheduleNo) {
		super();
		this.id = id;
		this.scheduleNo = scheduleNo;
	}
	
	public ScheduleCalender(String id) {
		super();
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getScheduleNo() {
		return scheduleNo;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	
	
	
	
	
}
