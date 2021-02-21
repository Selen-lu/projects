package com.project.nolate.controller;

import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.project.nolate.domain.Star;
import com.project.nolate.service.starluck.StarService;

@Controller
public class StarLuckController {
	
	
	private StarService starService;
	
	@Autowired
	public void setStarService(StarService starService) {	
		this.starService = starService;
	}
	
	
	@RequestMapping(value= {"/starList","/star"},method=RequestMethod.GET)
	public String starList(Model model) {
		List<Star>starList = starService.starList();
		model.addAttribute("sList",starList);
		
		return "main/index.jsp?body=starList";
	}

	@ResponseBody
	@RequestMapping(value="/starAjax",method=RequestMethod.POST)
	public Star getStar(String title){
				
		return starService.getStarLuck(title);
			
	}
}
