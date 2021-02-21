package com.project.nolate.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nolate.dao.AlarmDAO;
import com.project.nolate.domain.AlarmOption;

@Service
public class AlarmServiceImpl implements AlarmService{

	@Autowired
	private AlarmDAO alarmDao;
	
	@Override
	public void setAlarm(AlarmOption alarm) {
		// TODO Auto-generated method stub
		alarmDao.setAlarm(alarm);
	}

	@Override
	public void updateAlarm(AlarmOption alarm) {
		// TODO Auto-generated method stub
		alarmDao.updateAlarm(alarm);
	}

	@Override
	public void deleteAlarm(Integer alarmNo) {
		// TODO Auto-generated method stub
		alarmDao.deleteAlarm(alarmNo);
	}

	@Override
	public AlarmOption getAlarm(Integer alarmNo) {
		// TODO Auto-generated method stub
		return alarmDao.getAlarm(alarmNo);
	}

	@Override
	public Integer getAlarmNo() {
		// TODO Auto-generated method stub
		return alarmDao.getAlarmNo();
	}
	
	
	
	
}
