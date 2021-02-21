<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header>
	<!-- <div class="alarm_btn">
		<input type="button" value="알람설정" onclick="location.href='setAlarm'">
	</div> -->
	<div class="member_btn_area" >
		<form action="logout" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="submit" class="btn btn-primary" value="로그아웃">
			<!-- <input type="button" class="btn btn-primary" value="회원정보변경" onclick="location.href='main/memberUpdate'"> -->
			<input type="button" class="btn btn-primary" value="회원정보변경" onclick="location.href='memberUpdate'">
			<input type="button" class="btn btn-primary" value="홈으로" onclick="location.href='main'">
		</form>
	</div>
	<div class="menu_bar masthead">
		<nav>
			<ul class="nav nav-justified">
				<li><a href="markList">날씨</a></li>
				<li><a href="mapList">교통</a></li>
				<li><a href="calender">캘린더</a></li>
				<li><a href="star">운세</a></li>
				<li><a href="covid">코로나</a></li>
			</ul>
		</nav>
	</div>
</header>