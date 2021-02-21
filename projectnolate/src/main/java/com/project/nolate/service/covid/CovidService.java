package com.project.nolate.service.covid;

import java.util.List;


import org.w3c.dom.Element;


import com.project.nolate.domain.Covid;
public interface CovidService {

	String toDay();
	
	String dbDay();
	
	//파싱할때 잘라올 메소드
	String getTagValue(String tag, Element eElement);

	
	
	//지역 을 통해 검색할 메소드
	Covid getCovid(String gubun,String date01);
	//오늘 날짜 합계 가져올 메소드
	Covid getTotal(String date01);
	

	
	//오늘 것만 파싱해 와서 인설트 할것!
	
	void todayCovid(String date);
	
	
	//db에서 날자 가져옴
	String getDBdate(String date01);
	
	
	//어제 날짜 구하는거
	String yesterDay();
	
	//04/12 부터 인설트
	void insertCovid(String date01);
	
	//그래프용
	List<Covid> getChart(String gubun);
	
	
}
