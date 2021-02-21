<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>알람 설정</title>
		<script type="text/javascript" src="resources/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="resources/js/alarm.js"></script>
	</head>
	<body>
		<form class="input_alarm_form" method="post" action="inputAlarm" >
			<input type="hidden" name="alarmeNo" value="${alarmNo}">
			<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
			<div class="input_alarm">
				<div class="input_alarm_time">
					<span>알람시간<input name="hour" type="number" max="23" min="0">:<input name="minute" type="number" max="59" min="0"></span>
				</div>
				 <div class="input_alarm_option">
					<span>날씨<input type="checkbox" name="weatherCheck"></span>
					<span>교통<input type="checkbox" name="bbsCheck"></span>
					<span>코로나<input type="checkbox" name="coronaCheck"></span>
					<span>일정<input type="checkbox" name="scheduleCheck"></span>
					<span>운세<input type="checkbox" name="starluckCheck"></span>
				</div>
			</div>
			<div class="alarm_btn_area">
				<input type="submit" value="설정하기">
				<input type="button" value="취소하기" onclick="location.href='main'">
			</div>
		</form>
	</body>
</html>