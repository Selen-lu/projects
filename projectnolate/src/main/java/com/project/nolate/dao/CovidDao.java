package com.project.nolate.dao;

import java.util.List;


import org.w3c.dom.Element;


import com.project.nolate.domain.Covid;
public interface CovidDao {


	
	String toDay();
	
	String dbDay();
	
	//파싱할때 잘라올 메소드
	String getTagValue(String tag, Element eElement);

	
	//04/12일 부터 인설트 해온다 오늘 날짜까지
	void insertCovid(String date01);
	
	//지역 을 통해 검색할 메소드
	//가끔 같은 날짜에 값이 2번들어가는 일이 있길래 selectOne으로 가져오지 못하는 경우가 발생 수정하기 위해 리스트로 받아 한개만 가져옴
	List<Covid> getCovid(String gubun,String date01);
	//오늘 날짜 합계 가져올 메소드
	List<Covid> getTotal(String date01);
	
	
	
	
	
	//오늘 것만 파싱해 와서 인설트 할것!
	
	void todayCovid(String date);
	
	
	//db에서 날자 가져옴
	String getDBdate(String date01);
	
	//그래프용
		List<Covid> getChart(String gubun);
	

	
}
