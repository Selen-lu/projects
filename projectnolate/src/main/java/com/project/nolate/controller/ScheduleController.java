package com.project.nolate.controller;

import java.security.Principal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.project.nolate.domain.Schedule;
import com.project.nolate.domain.ScheduleCalender;
import com.project.nolate.service.schedule.ScheduleService;

@Controller
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;
	
	@RequestMapping(value = "/calender")
	public String loadCalender(Principal principal, Model model, Integer year, Integer month) {
		
		if(year == null && month == null) {
			year = Calendar.getInstance().get(Calendar.YEAR);
			month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		}
		String id = principal.getName();
		List<Schedule> scheduleList = scheduleService.getScheduleList(id, year, month);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		List<String> scheduleListJson = new ArrayList<String>();
		for(Schedule s : scheduleList) {
			String json = gson.toJson(s);
			json = json.replace("\"", "'");
			scheduleListJson.add(json);
		}
		model.addAttribute("scheduleList", scheduleListJson);

		
		return "main/index.jsp?body=calenderMain";
	}
	
	@RequestMapping(value = "/setSchedule", method = RequestMethod.POST)
	public String setSchedule(Principal principal, String title, String meterials, String year, String month, String day) {
		String id = principal.getName();
		Date date = Date.valueOf(year + "-" + month + "-" + day);
		ScheduleCalender scheduleBase = new ScheduleCalender(id);
		Integer scheduleNo = scheduleService.getScheduleBaseNo();
		Schedule schedule = new Schedule(scheduleNo, date, title, meterials);
		
		scheduleService.setSchedule(scheduleBase, schedule);
		
		return "redirect:calender";
	}
	
	@RequestMapping(value = "/updateSchedule", method = RequestMethod.POST)
	public String updateSchedule(Principal principal, int no, String title, String meterials, String year, String month, String day) {
		Date date = Date.valueOf(year + "-" + month + "-" + day);
		Schedule schedule = new Schedule(no, date, title, meterials);
		
		scheduleService.updateSchedule(schedule);
		
		return "redirect:calender";
	}
	
	@RequestMapping(value = "/loadSchedule", method = RequestMethod.POST)
	public String loadSchedule(Principal principal, Model model, String no) {
		String id = principal.getName();
		Schedule schedule = scheduleService.getSchedule(id, no);
		
		SimpleDateFormat trans = new SimpleDateFormat("yyyy");
		String year = trans.format(schedule.getScheduleDate());
		
		trans = new SimpleDateFormat("MM");
		String month = trans.format(schedule.getScheduleDate());
		
		trans = new SimpleDateFormat("dd");
		String day = trans.format(schedule.getScheduleDate());
		
		model.addAttribute("schedule", schedule);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("day", day);
		
		return "main/updateAndDeleteSchedule";
	}
	
	@RequestMapping(value = "/deleteSchedule", method = RequestMethod.POST)
	public String deleteSchedule(Principal principal, String no) {
		
		String id = principal.getName();
		scheduleService.deleteSchedule(id, no);
		
		return "redirect:calender";
	}
}
