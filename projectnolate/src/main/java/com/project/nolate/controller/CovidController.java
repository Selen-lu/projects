package com.project.nolate.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nolate.domain.Covid;
import com.project.nolate.service.covid.CovidService;

@Controller
public class CovidController {
	
	
	private CovidService CovidService;
	@Autowired
	public void setDao(CovidService service) {
		this.CovidService=service;
	}
	

	@RequestMapping("/covid")
	public String MainIndex(Model model) {
		String date01 = CovidService.dbDay();
		String date = CovidService.toDay()
				;
		String getDate=CovidService.getDBdate(date01);
		//어제
		String yesterDay = CovidService.yesterDay();
		
		if(getDate == null) {
			CovidService.todayCovid(date);
		}
		
		if(getDate ==null) {
		Covid total = CovidService.getTotal(yesterDay);
		model.addAttribute("toTal", total);
			
		}else {
		Covid toTal = CovidService.getTotal(date01);
		
		model.addAttribute("toTal",toTal);
		}
		
		return "main/index.jsp?body=Covid";
	}
	
	
	@RequestMapping(value = "/MapCovidAjax",method = RequestMethod.POST)
	@ResponseBody
	public Covid MapCovid(@RequestParam(value = "gubun",required = false,
			defaultValue = "null")String gubun
			) {
		Covid a =null; 
		String date01 = CovidService.dbDay();
		String getDate=CovidService.getDBdate(date01);
		String yesterDay = CovidService.yesterDay();
		if(getDate==null) {
			
			a=CovidService.getCovid(gubun, yesterDay);
		}else {
		
		a=CovidService.getCovid(gubun, date01);
		}
		return a;
	}
	
	@RequestMapping(value = "/Covidday",method = RequestMethod.POST)
	@ResponseBody
	public Covid DAY(@RequestParam(value = "gubun",required = false,
						defaultValue = "null")String gubun,
						@RequestParam(value = "date",required = false,
						defaultValue = "null")String date01) {
		
	
		Covid C2 = null;
		
		C2=CovidService.getCovid(gubun, date01);
		
		
		return C2;
		
	}
	
	//차트용 ajax
	@RequestMapping(value = "/Chart",method = RequestMethod.POST)
	@ResponseBody
	public List<Covid>Chart(
			@RequestParam(value = "Chartgubun",required = false,defaultValue = "합계")String Chartgubun){
	
		List<Covid> ChartList = CovidService.getChart(Chartgubun);
		
		return ChartList;
	}
	
	
	/*
	//04/12 부터 오늘 날짜 까지 인설트 db 드랍시 사용
	@RequestMapping("/insert")
	public String insertAll() {
		String date = CovidService.toDay();
		int count = 0;
		if(count==0) {
		CovidService.insertCovid(date);
		}
		
		return "main";
	}
	*/
	

}
