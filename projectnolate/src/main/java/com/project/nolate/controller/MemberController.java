package com.project.nolate.controller;

import java.security.Principal;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nolate.domain.Mapp;
import com.project.nolate.domain.Member;
import com.project.nolate.domain.MemberAuth;
import com.project.nolate.service.map.MapService;
import com.project.nolate.service.member.MemberService;



@Controller
public class MemberController {  //
	
	//로그인, 회원가입, 아이디찾기, 비밀번호찾기, 로그아웃, 회원정보수정, 비밀번호 확인
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MapService mapService; 
	
	@Autowired 
	private PasswordEncoder pwencoder; 
	 
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}

	
	public void setPwencoder(PasswordEncoder pwencoder) { 
		this.pwencoder = pwencoder; 
	}
	
	
	public void setMapService(MapService mapService) {
		this.mapService = mapService;
	}


	@RequestMapping(value = "/main", method = RequestMethod.POST) 
	public String main1(Model model) {
	 
		 return "main/index.jsp?body=mainPage"; 
	 }
	 
	@RequestMapping(value = "/main") 
	 public String main2(Model model) {
	 
		 return "main/index.jsp?body=mainPage"; 
	}
	
	
	//회원가입
	@RequestMapping(value = "/joinMember", method = RequestMethod.POST)
	public String joinMember(String id, String pass, String email, 
			String birth_year, String birth_month, String birth_day, 
			String home_Address, String company_Address) {
		
		pass = pwencoder.encode(pass);
		Date birtyday = Date.valueOf(birth_year + "-" + birth_month + "-" + birth_day);
		
		Member member = new Member(id, pass, email, birtyday, home_Address, company_Address);
		MemberAuth auth = new MemberAuth(member.getId(), "ROLE_MEMBER"); 
		memberService.insertMember(member, auth);
		
		Mapp mapp1 = new Mapp(home_Address, company_Address, id);
		Mapp mapp2 = new Mapp(company_Address, home_Address, id);
		
		mapService.insertMap(mapp1);
		mapService.insertMap(mapp2);
		
		return "redirect:signIn";
	}
	
	
	//아이디 찾기
	@RequestMapping(value = "/searchID", method = RequestMethod.POST)
	public String searchID(Model model, String email) {
		
		
		List<String> idList = memberService.getId(email);
		model.addAttribute("idList", idList);
		
		return "member/memberResultId";
	}
	
	@RequestMapping(value = "/overlapID")
	@ResponseBody
	public Map<String, Boolean> overapID(String id) {
		
		boolean isOverlapId = memberService.overlapID(id);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		
		map.put("isOverlapId", isOverlapId);
		
		return map;
	}
	
	//비밀번호 찾기
	@RequestMapping(value = "/searchPass", method = RequestMethod.POST)
	public String searchPass(Model model, String id, String email) {
		
		String pass = memberService.getPass(id, email);
		if(pass != null) {
			model.addAttribute("id", id);
			return "member/memberUpdatePass";
		}
		else {
			model.addAttribute("alertMesage", "해당하는 회원정보가 없습니다.");
			return "member/memberAlert";
		}
	}
	
	@RequestMapping(value = "/updatePass", method = RequestMethod.POST)
	public String updatePass(Model model, String id, String pass) {
		
		String encodePass = pwencoder.encode(pass);
		memberService.updatePass(id, encodePass);
		model.addAttribute("alertMesage", "비밀번호 변경이 완료됐습니다.");
		return "member/memberAlert";
	}
	
	//회원정보 수정
	//@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	@RequestMapping(value = "/main/updateMember", method = RequestMethod.POST)
	public String updateMember(Principal principal, Model model, String pass, String email, 
			String birth_year, String birth_month, String birth_day,
			String home_address, String company_address) {
		
		pass = pwencoder.encode(pass);
		String id = principal.getName();
		Date birtyday = Date.valueOf(birth_year + "-" + birth_month + "-" + birth_day);
		
		//세션에서 ID 가져와야함
		Member member = new Member(id, pass, email, birtyday, home_address, company_address); 
		
		memberService.updateMember(member);
		
		Mapp mapp1 = new Mapp(home_address, company_address, id);
		Mapp mapp2 = new Mapp(company_address, home_address, id);
		
		mapService.updateMap(mapp1);
		mapService.updateMap(mapp2);
		
		return "redirect:main";
	}
	
	//회원정보수정 전 비밀번호 확인
	//@RequestMapping(value = "/main/confirmPass", method = RequestMethod.POST)
	@RequestMapping(value = "/confirmPass", method = RequestMethod.POST)
	@ResponseBody
	//public String confirmPass(Principal principal, Model model, String pass) {
	public Map<String, Boolean> confirmPass(Principal principal, Model model, String pass) {
		
		String id = principal.getName();
		String oldPass = memberService.confirmPass(id);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		if(pwencoder.matches(pass, oldPass)) {
			map.put("isConfirm", true);
		}else {
			map.put("isConfirm", false);
		}
		
		return map;
	}
	
	//@RequestMapping(value = "/main/sucessConfirm", method = RequestMethod.POST)
	@RequestMapping(value = "/sucessConfirm", method = RequestMethod.POST)
	public String sucessConfirm(Principal principal, Model model) {
		
		String id = principal.getName();
		Member member = memberService.getMember(id);
		model.addAttribute("member", member);
		
		return "member/memberUpdate";
	}
	
	
}
