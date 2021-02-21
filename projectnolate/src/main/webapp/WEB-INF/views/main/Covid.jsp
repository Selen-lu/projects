<%@page import="org.apache.catalina.ant.SessionsTask"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<article> 
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f95fb7dddd485b4273ebad216e739c0c"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/js/Covid.js"></script>
	<div id="resultDiv"></div>

	<div style="width: 900px;">

		<div id="map" style="width: 50%; height: 600px; float: left;"></div>
		<div id="div01" >
		<div id="map" ></div>
	</div>
		<form id="selectgubun">
		<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
		<input type="hidden" name="date" id="date"/>

			<!-- <select name="gubun" id="gubun"  style="float: left;"> -->

		<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">  AJAX 사용--%>
		
		<input type="text" id=datepicker placeholder="날짜를 검색해 주세요"> 
		<select name="gubun" id="gubun" style="width: 150px;"  >
				<option>서울</option>
				<option>경남</option>
				<option>경북</option>
				<option>전남</option>
				<option>전북</option>
				<option>충남</option>
				<option>충북</option>
				<option>세종</option>
				<option>울산</option>
				<option>대전</option>
				<option>광주</option>
				<option>경기</option>
				<option>인천</option>
				<option>대구</option>
				<option>부산</option>
				<option>강원</option>
				<option>제주</option>
				<option>합계</option>
				<option>검역</option>
				<!-- 4개 -->
			</select>
			
			<input type="button" id="btn1" value="검색" >
		</form>
		
		<div id="Covidresult" >

		</div>
		<div id="totalCovid">
			<h2>${toTal.gubun }</h2>
			<p>확진자:${ toTal.defCnt}</p>
			<p>전일대비 증가:${toTal.incDec }</p>
			<p>격리 해제:${ toTal.isolClearCnt}</p>
			<p>사망자:${ toTal.deathCnt}</p>
			<p>해외유입:${toTal.overFlowCnt }</p>
			<p>지역 감염자:${toTal.localOccCnt }</p>
			<p>10만명당 감염:${ toTal.qurRate}</p>
			<p>등록 일시:${ toTal.stdDay}</p>
		</div>
	</div>
	
	<div id="ChartDiv">
		<h2 id="ChartH2">그래프</h2>
				<select name="Chartgubun" id="Chartgubun" >
						<option>서울</option>
						<option>경남</option>
						<option>경북</option>
						<option>전남</option>
						<option>전북</option>
						<option>충남</option>
						<option>충북</option>
						<option>세종</option>
						<option>울산</option>
						<option>대전</option>
						<option>광주</option>
						<option>경기</option>
						<option>인천</option>
						<option>대구</option>
						<option>부산</option>
						<option>강원</option>
						<option>제주</option>
						<option>합계</option>
						<option>검역</option>
				<!-- 4개 -->
			</select>
			
			<span> 
			<input type="radio" name="AAA" value="확진자" checked="checked">확진자 
			<input type="radio" name="AAA" value="증가">전일대비 증가
			</span>
			<input type="button" id="btn2" value="검색" >
			
		
		<div id="linechart_material" ></div>
		</div>

</article> 