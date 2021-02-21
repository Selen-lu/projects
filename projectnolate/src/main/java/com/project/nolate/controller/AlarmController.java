package com.project.nolate.controller;

import java.security.Principal;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.project.nolate.domain.AlarmOption;
import com.project.nolate.domain.Schedule;
import com.project.nolate.service.AlarmService;
import com.project.nolate.service.covid.CovidService;
import com.project.nolate.service.map.MapService;
import com.project.nolate.service.member.MarkBoardService;
import com.project.nolate.service.schedule.ScheduleService;
import com.project.nolate.service.starluck.StarService;

@Controller
public class AlarmController {	
	@Autowired
	private AlarmService alarmService;
	@Autowired
	private MapService mapService;
	@Autowired
	private CovidService covidService;
	@Autowired
	private StarService starService;
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private MarkBoardService markBoardService;
	
	public void setAlarmService(AlarmService alarmService) {
		this.alarmService = alarmService;
	}
	
	@RequestMapping(value = "/openAlarmSet")
	public String openAlarmSet(Model model) {
		
		Integer alarmNo = alarmService.getAlarmNo();
		model.addAttribute("alarmNo", alarmNo);
		
		return "main/setAlarm";
	}

	@RequestMapping(value = "/inputAlarm", method = RequestMethod.POST)
	public String setAlarmOption(Principal principal, String hour, String minute, boolean weatherCheck, 
			boolean bbsCheck, boolean coronaCheck, 
			boolean scheduleCheck, boolean starluckCheck) {
		
		String id = principal.getName();
		Time alarmTime = Time.valueOf(hour + ":" + minute + ":" + "00");
		AlarmOption alarm = new AlarmOption(id, alarmTime, weatherCheck, bbsCheck, coronaCheck, scheduleCheck, starluckCheck);
		
		alarmService.setAlarm(alarm);
		
		return "redirect:main";
		//return null;
	}
	
	@RequestMapping(value="/callAlarm", method = RequestMethod.GET)
	@ResponseBody
	public List<String> callAlarm(Principal principal, Integer alarmNo){
		String id = principal.getName();
		AlarmOption alarmOption = alarmService.getAlarm(alarmNo);
		Gson gson = new Gson();
		List<String> json = new ArrayList<String>();
		
		if(alarmOption.isScheduleCheck()) {
			Calendar today = Calendar.getInstance();
			Integer year = today.get(Calendar.YEAR);
			Integer month = today.get(Calendar.MONTH) + 1;
			Integer day = today.get(Calendar.DAY_OF_MONTH);
			
			List<Schedule> todayScheduleList = scheduleService.getTodayScheduleList(id, year, month, day);
			for(Schedule s : todayScheduleList) {
				json.add(gson.toJson(s));
			}
		}
		return json;
	}
	
	
	
	@RequestMapping(value = "/updateAlarm", method = RequestMethod.POST)
	public String updateAlarm(Principal principal, Time alarmTime, boolean weatherCheck, 
			boolean bbsCheck, boolean coronaCheck, 
			boolean scheduleCheck, boolean starluckCheck) {
		String id = principal.getName();
		//AlarmOption alarm = new AlarmOption(id, 321321, alarmTime, weatherCheck, bbsCheck, coronaCheck, scheduleCheck, starluckCheck);
		
		//alarmService.updateAlarm(alarm);
		return "redirect:main";
	}
	
	@RequestMapping(value = "/deleteAlarm", method = RequestMethod.POST)
	public String deleteAlarm(Integer alarmNo) {
		
		alarmService.deleteAlarm(alarmNo);
		
		return "redirect:main";
	}
}
