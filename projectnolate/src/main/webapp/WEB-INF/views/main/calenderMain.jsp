<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<article>
	<script type="text/javascript" src="resources/js/calender.js"></script>
		<div class="calender">
			<form class ="loadSchedule" method="post" action="loadSchedule" >
				<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
				<input type="hidden" name="no">
			</form>
			<div class="calender_header">
				<input id = "schedueList" type="hidden" value="${scheduleList}">
				<input type="number" name="year" class="form-control">
				<select name="month" class="form-control">
					<option value="1">1월</option>
					<option value="2">2월</option>
					<option value="3">3월</option>
					<option value="4">4월</option>
					<option value="5">5월</option>
					<option value="6">6월</option>
					<option value="7">7월</option>
					<option value="8">8월</option>
					<option value="9">9월</option>
					<option value="10">10월</option>
					<option value="11">11월</option>
					<option value="12">12월</option>
				</select>
				<input type="button" class="btn btn-primary" value="일정등록" onclick="location.href='createSchedule'">
			</div>
			<div class="calender_body calendar">
				<table>
					<thead>
						<tr><td><table class="calender_head_col"><tbody><tr>
						</tr></tbody></table></td></tr>
					</thead>
					<tbody>
						<tr><td><table class="calender_body_col"><tbody>
						</tbody></table></td></tr>
					</tbody>
				</table>
			</div>
			<div class="calender_day_list">
				
			</div>
		</div>
</article>