package com.project.nolate.service.covid;

import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Element;
import com.project.nolate.domain.Covid;
import com.project.nolate.dao.CovidDao;
@Service
public class CovidServiceImpl implements CovidService{

	
	private CovidDao covidDao;
	
	@Autowired
	public void setDao(CovidDao dao) {
		this.covidDao=dao;
	}
	
	@Override
	public String toDay() {
		// TODO Auto-generated method stub
		return covidDao.toDay();
	}

	@Override
	public String dbDay() {
		// TODO Auto-generated method stub
		return covidDao.dbDay();
	}

	@Override
	public String getTagValue(String tag, Element eElement) {
		// TODO Auto-generated method stub
		return covidDao.getTagValue(tag, eElement);
	}

	@Override
	public Covid getCovid(String gubun, String date01) {
		// TODO Auto-generated method stub
		List<Covid> covid = covidDao.getCovid(gubun, date01);
		
		return covid.get(0);
	}

	@Override
	public Covid getTotal(String date01) {
		// TODO Auto-generated method stub
		
		List<Covid> totalCovid = covidDao.getTotal(date01); 
		return totalCovid.get(0);
	}

	@Override
	public void todayCovid(String date) {
		covidDao.todayCovid(date);
		
	}

	@Override
	public String getDBdate(String date01) {
		// TODO Auto-generated method stub
		return covidDao.getDBdate(date01);
	}

		//어제 날짜
	@Override
	public String yesterDay() {
		Calendar c1 = new GregorianCalendar();
		c1.add(Calendar.DATE, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(c1.getTime());
		return date;
	}
	
	
	@Override
	public void insertCovid(String date01) {
		covidDao.insertCovid(date01);
		
	}
	
	@Override
	public List<Covid> getChart(String gubun) {
		// TODO Auto-generated method stub
		return covidDao.getChart(gubun);
	}

		
}
