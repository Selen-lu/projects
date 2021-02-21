<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
 <!DOCTYPE html>
<article>
	<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="rNo" value="${ m.no }"/>
	<!-- <input type="hidden" name="map_s" id="map_s"  />
	<input type="hidden" name="map_e" id="map_e" /> -->
</form>
<table class="contentTable">
	<tr>
		<td colspan="4" class="boardTitle"><h2>지도 길찾기 목록</h2></td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td class="contentTh">넘&nbsp;&nbsp;&nbsp;버</td>
		<td class="contentTd" colspan="3">${ m.no }</td>		
	</tr>
	<tr>
		<td class="contentTh">출발지</td>
		<td class="contentTd" id="up_s">${ m.map_s }</td>
			
	</tr>
	<tr>		
		<td class="contentTh">도착지</td>
		<td class="contentTd" id="up_e">${ m.map_e }</td>
	</tr>	
	<tr>
		<td colspan="4" class="tdSpan">
			<input type="button" id="detailUpdate" value="수정하기"/>
			&nbsp;&nbsp;
			<input type="button" id="detailDelete" value="삭제하기" />			
			&nbsp;&nbsp;
			<input type="button" value="목록보기" 
				onclick="javascript:window.location.href='mapList'"/></td>
	</tr>
	</table>
</article>