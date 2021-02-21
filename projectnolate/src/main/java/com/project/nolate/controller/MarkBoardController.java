package com.project.nolate.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.project.nolate.domain.MarkBoard;
import com.project.nolate.service.member.MarkBoardService;


@Controller
public class MarkBoardController {
	
	

	private MarkBoardService markBoardService;
	
	private static final String APIKEY = "K1COpft1yy6YLlfi8VzjGCQU%2B793AH2J4wy%2BQLnEYYaoW9GyhIaKmDM6a9icpdwFHAPmjotNRXOCKQkaPxT0iw%3D%3D";
	//서비스 세터 주입
	@Autowired
	public void setMarkBoardService(MarkBoardService markBoardService) {
		this.markBoardService = markBoardService;
	}
	

	//전체 글리스트 가져오기
	// - pageNum이라는 요청 파라미터 없을시 필수요구는 아니라는 의미로 required=false를 지정
	// - 대신 defaultValue를 "1"로 지정해서 없을시 대신 처리하도록 함
	// - 없어서 defaultValue값이 넘어올 경우: Spring이 숫자로 인식해서 int로 바인딩해줌

	//org.springframework.web.servlet.PageNotFound -> markBoard를 markList로 변경하니 해결 :: 매핑 잘못해서 페이징 처리 안됬음
	@CrossOrigin(origins = "http://localhost:8080")
	@RequestMapping(value = {"/markList","/mark","/MarkBoard"}, method = {RequestMethod.POST,RequestMethod.GET} ,produces="text/plain;charset=UTF-8")
	public String markList(Model model,
			@RequestParam(value = "pageNum",required = false, defaultValue = "1") int pageNum,
			@RequestParam(value = "type", required = false,defaultValue = "null") String type,
			@RequestParam(value = "keyword", required = false, defaultValue = "null") String keyword
			) {
		
		
		// - service 클래스를 이용해서 게시글 리스트 가져옴
		Map<String,Object> modelMap = markBoardService.markList(pageNum,type,keyword);
		// - 페이징 처리 없을 때
		// - List<MarkBoard> mList = markBoardService.markList(String startRow,int  num);
	
		
		// - 파라미터로 받은 모델 객체에 뷰로 보낼 모델을 저장한다
		// - *모델*에는 도메인객체나 비즈니스 로직을 처리한 결과를 저장
		model.addAllAttributes(modelMap);
		// - 페이징 처리 없을 때
		// - model.addAttribute("mList", mList);
		
		
		// - servlet-context.xml에 설정한 viewResolver에서 prefix와suffix에 지정한
		// - 정보를 제외한 뷰 이름을 문자열로 반환
		// - 포워드 되고, 제어가 뷰 페이지로 이동
		
		// - requsetMapping애노테이션을 이용해 별도로 경로 매핑 안하고
		// - markList 메서드에만 요청 매핑 설정
		
		// - 뷰단의 css 등의 정적리소스와 관련한 url맵핑은
		// - appServlet/servlet-context.xml에서 설정
		// - <mvc:resources mapping="/resources/**" location="/resources/" /> 
		// - css의 위치를 "resources/css/index.css"와 같이 지정해야 한다.
		// -> src폴더 - webapp -resources 아래 css 폴더 작성 
		
		// - return ->View페이지로 전달
		// - 반환값은 String이여야함
		return "main/index.jsp?body=markList";
	}
	
	// 글 DB에 저장하기
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	//@ResponseBody(에이작스로 하면 쓰지만 아닐 때는 삭제해야 리턴 리다이렉트 작동)
	public String insertMark(MarkBoard markBoard,HttpServletRequest request) {

		// - 서비스 클래스를 이용해서
		// - 폼에서 넘어온 게시글 정보를 게시글 테이블에 추가		
	
		markBoardService.insertMark(markBoard);
		
		return "redirect:markList";
	}
	
	
	
	//업데이트
	//폼으로 부터 전달된 파라미터를 객체로 처리 = 전송하는 폼에 name속성 지정필수
	@RequestMapping(value = "/updateMark", method = RequestMethod.POST)
	public String updateMark(HttpServletResponse response, PrintWriter out, String no, String nickname) {
		//이 애노테이션이 적용된 컨트롤러 메서드의 파라미터에 response,PrintWriter 지정, 요청 파라미터를 받을 board객체 지정
		
		markBoardService.updateMark(no, nickname);
		//markBoardService.updateMark(markboard);
		
		//클라이언트 요청 처리후 리다이렉트 해야될경우
		//httpServletResponse를 사용해서 지정한 경로로 redirect가능
		//아래처럼 하면됨
		// /로 시작하면 contextRoot를 기준으로 절대 경로 방식
		// /로 시작 안하면 현재 경로를 기준으로 상대 경로 방식
		
		//다른 사이트로 redirect 하고싶으면 redirect:http://사이트 주소
		return "redirect:markList";
	}
		
	//삭제구문
	@RequestMapping(value = "/deleteMark", method = RequestMethod.POST)
	//@responsebody사용시 리다이렉트 안됨
	public String deleteMark(HttpServletResponse response, PrintWriter out,String no) {
		markBoardService.deleteMark(no);
		
		return "redirect:markList";
	}
	
	@RequestMapping(value = "/weather", method = RequestMethod.POST)
	@ResponseBody
	public List<String> getWeatherInfo(String nx, String ny) {
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		Calendar date = Calendar.getInstance();
		String today = transFormat.format(date.getTime());
		String hour = String.valueOf(date.get(Calendar.HOUR));
		StringBuffer urlBuilder = new StringBuffer("http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtNcst"); /*URL*/
        urlBuilder.append("?" + "ServiceKey=" + APIKEY); /*Service Key*/
        urlBuilder.append("&pageNo=1"); /*페이지번호*/
        urlBuilder.append("&numOfRows=10"); /*한 페이지 결과 수*/
        urlBuilder.append("&dataType=XML"); /*요청자료형식(XML/JSON)Default: XML*/
        urlBuilder.append("&base_date=" + today); /*15년 12월 1일 발표*/
        urlBuilder.append("&base_time=" + hour); /*06시 발표(정시단위)*/
        urlBuilder.append("&nx=" + nx); /*예보지점의 X 좌표값*/
        urlBuilder.append("&ny=" + ny); /*예보지점 Y 좌표*/
		
		Document doc = null;
		
		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactoty.newDocumentBuilder();

			doc = dBuilder.parse(urlBuilder.toString());

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		doc.getDocumentElement().normalize();
	

		NodeList itemList = doc.getElementsByTagName("item");
		List<String> fsctValueList = new ArrayList<String>();
		
		for (int temp = 0; temp < itemList.getLength(); temp++) {
			Node nNode = itemList.item(temp);
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				NodeList nlList = eElement.getElementsByTagName("fcstValue").item(0).getChildNodes();
				Node nValue = (Node) nlList.item(0);
				fsctValueList.add(nValue.getNodeValue());
			}
		}
		
		return fsctValueList;
	}
}
