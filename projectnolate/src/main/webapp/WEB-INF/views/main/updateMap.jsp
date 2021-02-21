<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<article>
	<form name="updateForm" id="updateForm" action="update" 
	method="post">
	
	<input type="hidden" name="no" value="${ m.no }"/>

<table class="contentTable">
	<tr>
		<td colspan="4" class="boardTitle"><h2>지도 길찾기 수정</h2></td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td class="contentTh">출발지</td>
		<td class="contentTd">
		<input type= "text" name= "map_s" id= "map_s" size= "30" 
			 value= "${ m.map_s }" /> </td>
			
	</tr>
	<tr>		
		<td class="contentTh">도착지</td>
		<td class="contentTd">
		<input type= "text" name= "map_e" id= "map_e" size= "30" 
			 value= "${ m.map_e }" /></td>
	</tr>	
	
	<tr>
		<td colspan="4" class="tdSpan">
			<input type= "reset" value= "다시쓰기 " />
			 &nbsp;&nbsp;<input type= "submit" value="수정하기 " /> 		
			&nbsp;&nbsp;<input type="button" value="목록보기" 
				onclick="javascript:window.location.href='mapList'"/></td>
	</tr>
	</table>
	</form>
</article>