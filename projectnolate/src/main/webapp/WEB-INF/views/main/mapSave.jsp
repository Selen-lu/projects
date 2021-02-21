<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>
	<form name="writeForm" action="saveProcess" id="writeForm"
			 method="post">
		<table class="readTable">
			<tr>
				<td colspan="4" class="boardTitle"><h2>길찾기 등록 </h2></td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td class="readTh">출발지</td>
				<td class="readTd">
					<input type="text" name="map_s" size="30" id="map_s"/>
				</td>
				<td class="readTh">도착지</td>
				<td class="readTd">
					<input type="text" name="map_e" size="30" id="map_e"/>
				</td>
			</tr>		
			<tr>
				<td colspan="4" class="tdSpan"><input type="reset" value="다시쓰기"/>
					&nbsp;&nbsp;<input type="submit" value="등록하기" />
					&nbsp;&nbsp;<input type="button" value="목록보기" 
						onclick="javascript:window.location.href='mapList.bbs'"/></td>
			</tr>
		</table>
	</form>
</article>