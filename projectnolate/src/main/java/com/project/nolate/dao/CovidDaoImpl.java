package com.project.nolate.dao;

import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


import com.project.nolate.domain.Covid;

@Repository
public class CovidDaoImpl implements CovidDao{

	
	
	private SqlSessionTemplate sqlSession;
	
	private static  final String NAMESPACE="com.project.nolate.mapper.CovidMapper";
	
	@Autowired
	public void setDao(SqlSessionTemplate sqlSession) {
		this.sqlSession=sqlSession;
	}


	//04/12 일까지 인설트
	@Override
	public void insertCovid(String date01) {
		String first = "20200412";
		Document doc = null;
		String url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=gUg34UITOr1HqZ54K4CLWB6PDUfzjNIw3fwJBKzqT0q%2B8j348elAoU3tMYEVel16jPu4a6sl5yjZcBDJZKyAWw%3D%3D&pageNo=1&numOfRows=10&startCreateDt="
				+ first + "&endCreateDt="+date01;

		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactoty.newDocumentBuilder();

			doc = dBuilder.parse(url);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String, String> params = new HashMap<String, String>();
		doc.getDocumentElement().normalize();
	

		NodeList nList = doc.getElementsByTagName("item");
		
		for (int temp = 0; temp < nList.getLength(); temp++) {
			Node nNode = nList.item(temp);
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				params.put("gubun", getTagValue("gubun", eElement));
				params.put("defCnt", getTagValue("defCnt", eElement));
				params.put("incDec", getTagValue("incDec", eElement));
				params.put("isolClearCnt", getTagValue("isolClearCnt", eElement));
				params.put("deathCnt", getTagValue("deathCnt", eElement));
				params.put("qurRate", getTagValue("qurRate", eElement));
				params.put("stdDay", getTagValue("stdDay", eElement));
				params.put("overFlowCnt", getTagValue("overFlowCnt", eElement));
				params.put("localOccCnt", getTagValue("localOccCnt", eElement));
				params.put("createDt", getTagValue("createDt", eElement));
			
				sqlSession.insert(NAMESPACE + ".insertAll", params);
			}

		}
	
		
	}

	//파싱할때사용할 날짜
	@Override
	public String toDay() {
		String date = "";
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Date time = new Date();
		date = format.format(time);

		return date;
	}
	
	//db검색시 쓸거
	@Override
	public String dbDay() {
		String date = "";
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date time = new Date();
		date = format.format(time);

		return date;
	}
	
	
	@Override
	public String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}



		//맵 마커용 메소드
	@Override
	public List<Covid> getCovid(String gubun,String date01) {
		// TODO Auto-generated method stub
		Map<String, String> params = new HashMap<String, String>();
		params.put("gubun",gubun);
		params.put("date01",date01);
		
		return sqlSession.selectList(NAMESPACE+".getCovid", params);
	}
	
	//합계표시에 사용할것
	@Override
	public List<Covid> getTotal(String date01) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".getTotal",date01);
	}

	//인설트용 오늘 날짜
	@Override
	public void todayCovid(String date) {
		String url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson"
				+ "?serviceKey=gUg34UITOr1HqZ54K4CLWB6PDUfzjNIw3fwJBKzqT0q%2B8j348elAoU3tMYEVel16jPu4a6sl5yjZcBDJZKyAWw%3D%3D&pageNo=1&numOfRows=10&startCreateDt="
				+ date + "&endCreateDt=" + date;
		Document doc = null;
		
		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactoty.newDocumentBuilder();

			doc = dBuilder.parse(url);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String, String> params = new HashMap<String, String>();
		doc.getDocumentElement().normalize();
	

		NodeList nList = doc.getElementsByTagName("item");
		
		for (int temp = 0; temp < nList.getLength(); temp++) {
			Node nNode = nList.item(temp);
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				params.put("gubun", getTagValue("gubun", eElement));
				params.put("defCnt", getTagValue("defCnt", eElement));
				params.put("incDec", getTagValue("incDec", eElement));
				params.put("isolClearCnt", getTagValue("isolClearCnt", eElement));
				params.put("deathCnt", getTagValue("deathCnt", eElement));
				params.put("qurRate", getTagValue("qurRate", eElement));
				params.put("stdDay", getTagValue("stdDay", eElement));
				params.put("overFlowCnt", getTagValue("overFlowCnt", eElement));
				params.put("localOccCnt", getTagValue("localOccCnt", eElement));
				params.put("createDt", getTagValue("createDt", eElement));
			
				sqlSession.insert(NAMESPACE + ".insertCovid", params);
			}

		}
			
	}
	
	
	//DB에서 오늘 날짜 가져와서 있는지 없는지 확인한후 인설트 메서드를 실행하기 위해 만듬
	@Override
	public String getDBdate(String date01) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE+".DBdate", date01);
	}
	
	@Override
	public List<Covid> getChart(String gubun) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".getChart", gubun);
	}
	


	
	
}
