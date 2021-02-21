<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일정 등록하기</title>
		<script type="text/javascript" src="resources/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/createSchedule.css">
	</head>
	<body class="createScheduleBody">
		<div class="container">
			<form class="input_schedule_form" method="post" action="setSchedule">
				<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
				<div class="input_schedule">
					<div class="input_schedule_date">
						<label for="scheduleDay">날짜</label>
						<input type="number" name="year" class="year form-control" min="1" >
						<select name="month" class="month form-control">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
							<option>6</option>
							<option>7</option>
							<option>8</option>
							<option>9</option>
							<option>10</option>
							<option>11</option>
							<option>12</option>
						</select>
						<input type="number" name="day" class="day form-control" min="1" max="31">
					</div>
					<div class="input_schedule_title">
						<label for="scheduleTitle">일정명</label>
						<input type="text" name="title" class="form-control">
					</div>
					<div class="input_schedule_meterials">
						<label for="scheduleMeterials">준비물</label>
						<textarea rows="20" cols="20" name="meterials" class="form-control"></textarea>
					</div>
				</div>		
				<div class="schedule_btn_area">
					<input type="submit" value="등록하기" class="btn btn-primary">
					<input type="button" value="취소하기" class="btn btn-primary" onclick='location.href="calender"'>
				</div>
			</form>
		</div>
		<div>
		
		</div>
	</body>
</html>