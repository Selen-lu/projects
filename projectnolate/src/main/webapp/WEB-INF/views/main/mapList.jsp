<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<%! int cntt= 1; %>
<%! int cnttt= 1; %>
<%! int del= 1; %>
<%! int update= 1; %>

<input type="hidden"  value="<%= cntt= 1 %>"/>
<input type="hidden"  value="<%= cnttt= 1 %>"/>
<input type="hidden"  value="<%= del= 1 %>"/>
<input type="hidden"  value="<%= update= 1 %>"/>
<%-- <%= cnttt= 1 %>
<%= del= 1 %>
<%= update= 1 %> --%>

 <article>
	<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx9326574f725f4433b7ee386a0b07c3e3"></script>
	<script type="text/javascript" src="resources/js/mapUpdate.js"></script>
	<script type="text/javascript" src="resources/js/map.js"></script>
	<input type="hidden" id="map_cnt" value="${ cnt }"/>
<div class="Aside">	
	<div id="map_search">
    				<!-- 밑에서부터 검색찾기 -->
    			<input type="text" class="text_custom" id="fullAddr"
					name="fullAddr" placeholder="장소를 입력하세요">
				<button id="btn_select_0" class="button green" >검색</button>
				<br/>
				<br/><!-- 밑에서부터 길찾기 -->
			<div class="ft_area">
				<div class="ft_select_wrap">
					<div class="ft_select">
						 <select id="selectLevel">
							<option value="0" selected="selected">교통최적+추천</option>
							<option value="1">교통최적+무료우선</option>
							<option value="2">교통최적+최소시간</option>
							<option value="3">교통최적+초보</option>
							<option value="4">교통최적+고속도로우선</option>
							<option value="10">최단거리+유/무료</option>
							<option value="12">이륜차도로우선</option>
							<option value="19">교통최적+어린이보호구역 회피</option>
						</select> <select id="year">
							<option value="N" selected="selected">교통정보 표출 옵션</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select> 				
					</div>
				</div>
				<div class="map_act_btn_wrap clear_box"></div>
				<div class="clear"></div>
			</div>
			<br/>
			<form id="seForm" name="seForm">
			<div id="roadSearch">
				출 발 : <input name="marker_s" id="marker_s" type="text" placeholder="출발지 입력 후 엔터(Enter)를 해야 합니다">&nbsp;<input type="button"id="btn_select" class="button green" value="길찾기"><br/> 
				도 착 : <input name="marker_e" id="marker_e" type="text" placeholder="도착지 입력 후 엔터(Enter)를 해야 합니다"> <br/>	
			</div>
			</form>
			<br/>
			<p id="result"></p>
			<br/>
		<button id="btn_reset" class="button green">리셋</button>	
		<button id="btn_save" type="submit" class="button green">저장</button>
		<br/>
		<br/>
		</div>
		<!-- 길찾기 버튼생성 -->
		<form id="sbSearch" name="sbSearch">
			<input type="hidden" name="no" id="no">
			<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
		</form>
		<div class="bookmark">
			<c:if test="${ not empty mList }">
				<table class="bookmarkTable">
					<c:forEach var="m" items="${ mList }" varStatus="status">	
							
					<tr class="listTr mapTr">
						<td class="listSaveMap_bt">
							<button type="submit" id="<%= cnttt++ %>bt" value="${ m.no }" class="green order_bt" >
							<%= cntt++ %> <%-- 버튼 출발:${ m.map_s } 도착:${ m.map_e }  --%>
							</button>
						</td>
						 <td class="listSaveMap">
							<%--<button id="<%= update++ %>up" value="${ m.no }">수정 </button>--%>
							
							<div class="mapContent" id="div_${ m.no }">
								<pre class="sss"><span>${ m.map_s }</span></pre>
								<pre class="eee"><span>${ m.map_e }</span></pre>
							</div>
							<div class="mapModify">	 
								<a href="#" class="modifyMap" data-no="${ m.no }">
									<img src="resources/images/reply_btn_modify.gif" alt="수정하기"/></a>
								<%-- <button  type="submit" id="<%= del++ %>del" value="${ m.no }">
								 	<img src="resources/images/reply_btn_delete.gif" alt="댓글 삭제하기"/> 
								</button> --%>
								<a  type="submit" id="<%= del++ %>del" data-no="${ m.no }">
								 	<img src="resources/images/reply_btn_delete.gif" alt="삭제하기"/> 
								</a>
							</div>	
						</td>			
					</tr>
					</c:forEach>
				</table>
			</c:if>
		</div>
<br/>
	<div id="mapForm" style="display: none;" data-no="${ m.no }">
		<form id="mapUpdateForm">
			<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
			<input type="hidden" class="noUp" name="no" />
			<input type="hidden" class="mapsUp" name="map_s" />
			<input type="hidden" class="mapeUp" name="map_e"/>
		
			<table id="mapWriteTable" class="greenbk">
				<tr>
					<td class="white_td">출발지 : &nbsp;</td>
					<td><input type="text" class="maps_tx"></td>
					<td rowspan="2">
						<!-- <button type="submit" value="수정하기" class="map_update">수정하기</button> -->
						<input type="button" value="수정하기" class="map_update">
					</td>
				</tr>
				<tr>
					<td class="white_td">도착지 :&nbsp;</td>
					<td><input type="text" class="mape_tx"></td>
				</tr>
			</table>
		</form>
	</div>	
<br/>
</div> 

	<br/>
	
	<div  class="map_wrap">
		<div id="map_wrap">
			<div id="map_div"></div>
		</div>
		<div class="map_act_btn_wrap clear_box"></div>
	</div>	
		<br/>

	
	<table class="listTable">
		<tr><td class="boardTitle" colspan="4"><h2> 지도 길찾기 리스트</h2></td></tr>
		
		<tr>
			<td colspan="4" class="listWrite"><a href="mapSave">길찾기 등록하기</a></td>
		</tr>
		<tr>
			<th class="listThNo">NO</th>
			<th class="listThNo">예시N</th>
			<th class="listThTitle">출발지</th>
			<th class="listThWriter">도착지</th>
		</tr>	
	
<c:if test="${ not empty mList }">
	<c:forEach var="m" items="${ mList }" varStatus="status">		
		<tr class="listTr">
			<td class="listTdNo">${ m.no  }</td>
			<td class="listTdTitle">
				<a href="mapDetail?no=${ m.no }">자세히${ m.no }</a></td>
			<td class="listTdWriter">${ m.map_s }</td>
			<td class="listTdWriter">${ m.map_e }</td>			
		</tr>
	</c:forEach>
	</c:if>	
	<%-- 게시 글 리스트가 존재하지 않으면 --%>
	<c:if test="${ empty mList }">
		<tr>
			<td colspan="5" class="listTdSpan">게시 글이 존재하지 않습니다.</td>
		</tr>
	</c:if>
	</table>
</article>