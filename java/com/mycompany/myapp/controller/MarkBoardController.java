package com.mycompany.myapp.controller;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.myapp.domain.MarkBoard;
import com.mycompany.myapp.service.MarkBoardService;

@Controller
public class MarkBoardController {
	
	

	private MarkBoardService markBoardService;
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
	// post 쓴 이유 -> 에이작스 데이터 받기 위함
	@CrossOrigin(origins = "http://localhost:8080")
	@RequestMapping(value = {"/markList","/mark","/MarkBoard"}, method = {RequestMethod.POST,RequestMethod.GET})
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
		return "markList";
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
	@RequestMapping(value = "/update", method = RequestMethod.POST)
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
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	//@responsebody사용시 리다이렉트 안됨
	public String deleteMark(HttpServletResponse response, PrintWriter out,String no) {
		markBoardService.deleteMark(no);
		
		return "redirect:markList";
	}
	
	

}
