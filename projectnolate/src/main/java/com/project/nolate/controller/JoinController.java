package com.project.nolate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JoinController {
	
	@RequestMapping(value = "/login")
	public String login() {
		
		return "/login";
	}  
}
