var scheduleList;

$(function(){
	var temp = $('#schedueList').val();
	//if(temp != "[]"){
		//temp = temp.replaceAll("'", "\"");
		temp = temp.replace(/'/gi, "\"");
		scheduleList = JSON.parse(temp);
	//}
	var week = ['일', '월', '화', '수', '목', '금', '토'];
	var selectDate = new Date();
	var year = selectDate.getFullYear();
	var month = selectDate.getMonth() + 1;
		
	$('.calender_header > input[type=number]').val(year);
	$('.calender_header > select').val(month);
	
	for(var i = 0; i < 7 ; i++){
		$('.calender_head_col > tbody > tr').append(
			'<th><a class="calender_head_col_cell" href="#">' + week[i] + '</a></th>');	
	}
	
	for(var i = 0; i < 6; i++){
		$('.calender_body_col > tbody').append('<tr class = "body_col_' + i + '">');
		for(var j = 0; j < 7; j++){
			$('.body_col_' + i).append(
				'<td></td>'
			);
		}
	}
	makeCalender();
	$('.calender_header > select').click(makeCalender);
	$('.calender_header > input[type=number]').blur(makeCalender);
	//$('.calender_header > input[type=button]').click(loadSchedule);
});

function loadSchedule(selectSchedule){
	var title = $(selectSchedule).text();
	var day = $(selectSchedule).attr("day");
	
	$.each(scheduleList, function(index, value){
		var date = new Date(value.scheduleDate);
		var tempday = date.getDate();
		if(title === value.scheduleTitle && day == tempday){
			$('.loadSchedule > input[name="no"]').val(value.scheduleNo);
		}
	});
	$('.loadSchedule').submit();
}

function printScheduleList(selectDay){
	
	var year = $('.calender_header > input[type=number]').val();
	var month = $('.calender_header > select').val();
	var day = $(selectDay).text();
	var selectDate = new Date(year, month - 1, day);
	$('.calender_day_list').empty();
	
	$('.calender_day_list').append(
		'<h3>' + year + '년 ' + month + '월 ' + day + '일</h3>'
		+ '<ul>' );
	
	$.each(scheduleList, function(index, value){
		var date = new Date(value.scheduleDate);
		if(date.getFullYear() === selectDate.getFullYear() && 
		date.getMonth() === selectDate.getMonth() && 
		date.getDate() === selectDate.getDate()){
			$('.calender_day_list > ul').append(
				'<li>' + value.scheduleTitle + '</li>' + 
				'<ul><li>' + value.scheduleMaterials + '</li></ul>'
			)
		}
	});	
}

function makeCalender(){
	
	$('.calender_body_col > tbody > tr > td').empty();
	var year = $('.calender_header > input[type=number]').val();
	var month = $('.calender_header > select').val();
	var days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	if(year % 4 == 0){ //윤년 체크
		days[1] = 29;
		if(year % 100 == 0){
			days[1] = 28;
			if(year % 400 == 0){
				days[1] = 29;
			}
		}
	}
	var monthDay = days[month - 1];
	var monthDate = 1;
	
	var pyear = year - 1; //1년에 요일이 하나씩 밀리므로 직전년도만큼 요일이 밀린다.
	var yyears = parseInt(pyear / 4) - parseInt(pyear / 100) + parseInt(pyear / 400); //윤년은 요일이 두개씩 밀리므로 윤년의 횟수를 구해서 추가로 더해준다.
	var startWeek = (pyear + yyears) % 7; //총 요일이 밀린 횟수를 7로 나눈 나머지가 그해 1월 1일의 요일이다.(0이 월욜, 6이 일욜)
	var totalday = startWeek; 
	for(var i = 0; i < month - 1; i++){
		totalday += days[i]; //지난달 까지의 총 일수 합산
	}
	firstMonthWeek = (totalday + 1) % 7;  //이번달 1일의 요일. 
	
	for(var i = 0; i < 6; i++){
		for(var j = 0; j < 7; j++){
			if(i == 0 && j <= firstMonthWeek){
				for(var k = 0; k < firstMonthWeek; k++){ j++; }
			}
			else if(monthDate > monthDay)
				break;
				
			$('.body_col_' + i + ' > td:nth-child(' + (j + 1) + ')').append(
				'<div class="day_frame_' + year + '-' + month + '-' + monthDate + '">' 
				+ '<div class="day_frame_top">' 
				+ '<a class="day_number" onclick="printScheduleList(this)">'
				+ monthDate
				+ '</a>' 
				+ '</div>'
				+ '<div class="day_frame_event">'
				+ '</div>'
				+ '</div>'
			);
			
			monthDate++;
		}
	}
	$.each(scheduleList, function(index, value){
		var date = new Date(value.scheduleDate);
		$('.day_frame_' + date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate() + '> .day_frame_event').append(
			'<a onclick="loadSchedule(this)" day="' + date.getDate() + '">'
				+ value.scheduleTitle
				+ '</a><br/>'//value.scheduleTitle + '<br/>'

		)
	});
}