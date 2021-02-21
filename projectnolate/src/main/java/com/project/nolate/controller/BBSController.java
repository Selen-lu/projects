package com.project.nolate.controller;

import java.io.PrintWriter;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nolate.domain.Mapp;
import com.project.nolate.service.map.MapService;

@Controller
public class BBSController {

	@Autowired
	private MapService mapService;
	
	public void setMapService(MapService mapService) {
		this.mapService = mapService;
	}
	
	@RequestMapping(value= {"/mapList", "/list"}, method=RequestMethod.GET) 
	public String mapList(Principal principal, Model model) {
		int cnt = 0;
		cnt =mapService.countMap();
		String id = principal.getName();
		List<Mapp> mList = mapService.mapList(id);
		
		model.addAttribute("mList", mList);
		model.addAttribute("cnt", cnt);
		
		return "main/index.jsp?body=mapList";
	}
	
	@RequestMapping("/mapDetail")
	public String mapDetail(Model model,int no) {
		
		Mapp map = mapService.getMap(no);
		
		model.addAttribute("m", map);
		
		return "main/mapDetail";
	}
	
	@RequestMapping(value="/saveProcess",method=RequestMethod.POST)
	public String insertMap(Mapp map) {
		
		mapService.insertMap(map);
		
		return "redirect:mapList";
	}
	@RequestMapping("/update")
	public String updateMap(Model model, int no) {
		
		Mapp map = mapService.getMap(no);
		
		model.addAttribute("m", map);
		
		return "main/updateMap";
	}
	@RequestMapping(value="/mapUpdateForm" ,method=RequestMethod.POST)
	public String updateMap(Model model, Mapp map) {
		
		mapService.updateMap(map);
		
		return "redirect:mapList";
	}
	@RequestMapping({"/delete", "deleteMap"})
	public String deleteMap(int no) {
		
		mapService.deleteMap(no);
		
		return "redirect:/main/mapList";
	}
	@RequestMapping(value="seForm" ,method=RequestMethod.POST)
	public String seForm(Mapp map,String marker_s,String marker_e) {
		
		
		map.setMap_s(marker_s);
		map.setMap_e(marker_e);
		
		mapService.insertMap(map);
			
		return "redirect:mapList";
	}
	@RequestMapping(value="sbSearchProcess" ,method=RequestMethod.POST)
	public String sbSearchProcess(Model model,int no) {
	
		 String map_s; 
		 String map_e;
		 map_s =mapService.maps_str(no); 
		 map_e =mapService.mape_str(no);
		  
		 model.addAttribute("map_s", map_s); 
		 model.addAttribute("map_e", map_e);
		 
		
		return "main/NewMap";
	}
	@RequestMapping(value="saveDelete" ,method=RequestMethod.POST)
	public String saveDelete(int no) {
		
		mapService.deleteMap(no);
		
		return "redirect:mapList";
	}
	
	@RequestMapping(value="saveUpdateProcess" ,method=RequestMethod.POST)
	public String saveUpdateProcess(Model model, Mapp map) {
		
		mapService.updateMap(map);
		
		return "redirect:mapList";
	}
	
	@RequestMapping("/saveUpdate.ajax")
	@ResponseBody 
	public Mapp saveUpdate(int no) {
		Mapp map =mapService.getMap(no);
		return map;
	}
	@RequestMapping(value="replyUpdateForm" ,method=RequestMethod.POST)
	public String saveUpdateMap(Model model, Mapp map, String map_s,
			String map_e, int no) {
		
		map = mapService.getMap(no);
		
		map.setMap_s(map_s);
		map.setMap_e(map_e);
		
		mapService.updateMap(map);
		
		return "redirect:mapList";
	}
}
