<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!-- dao,서비스,컨트롤러에서 온 모델이 넘어온 데이터 출력 및 폼으로 감싸서 sendForm.js인식하게 함-->
<!-- <script src="resources/js/sendForm.js"></script> -->
<!-- <script src="resources/js/jquery-3.2.1.min.js"></script> -->
<!--  카카오 css -> css폴더안에있음, index.jsp에 정적요소로 넣어줌-->

<!-- 카카오 api -->
<!-- <script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=23e1182870260b654342add02459ac61&libraries=services"></script> -->
 
<!-- <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 -->
<!-- Collapsed Sidepanel(마크리스트) & 전체 테마의  meta-->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->


<article>
<!-- 	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f95fb7dddd485b4273ebad216e739c0c"></script> -->
	<!-- <script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=23e1182870260b654342add02459ac61&libraries=services"></script> -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa552b5f271c87eedea586c83e48e153&libraries=services"></script>
	<script type="text/javascript" src="resources/js/markList.js"></script>
	<!--  메인테마 시작-->
	<div class="container">
		<div style="text-align: center">
			<h3>반갑습니다:) 마크리스트입니다^^</h3>
			<div class="column">
				<button class="openbtn" onclick="openNav()" >마크리스트 ☰</button>
			</div>
		</div>
		<div class="row">
		<!-- 	<div class="column"> -->
				<!-- 지도 출력 -->
			<div class="map_wrap">
				<div id="map"
					style="width: 100%; height: 100%; position:relative;"></div><!-- kakao.css의.map_wrap  width, height 픽셀을 기준으로 퍼센트화 함 -->
			</div>
		</div>
		<div class="column">
			<p>지도를 클릭해보세요! 오늘의 날씨를 알 수 있습니다~:)</p>
			<div class="hAddr" id="hereAddr">
				<div id="centerAddr"></div>
				<div id="clickLatlng"></div>
				<div id="clickName"></div>
				<div id="rsXText"></div>
				<div id="rsYText"></div>
				<!-- 날씨 출력 -->
				<div id="WEATHER1"></div>
				<div id="WEATHER2"></div>
				<div id="WEATHER3"></div>
				<div id="WEATHER4"></div>
				<div id="WEATHER5"></div>
				<div id="WEATHER6"></div>
				<div id="WEATHER7"></div>
				<div id="WEATHER8"></div>
				<div id="WEATHER9"></div>
				<div id="WEATHER10"></div>
			</div>
		</div>
		<div class="column">
				<!--장소이름 저장  -->
			<div class="topnav">
				<form name="insert" id="insert" method="POST" action="insert">
					<input type="hidden" id="name" name="name"> 
					<input type="hidden" id="lat" name="latitude"> 
					<input type="hidden" id="lon" name="longitude"> 
					<input type="hidden" id="rsX" name="latticeX"> 
					<input type="hidden" id="rsY" name="latticeY"> 클릭한 장소는 어떤 장소인가요?:)  
					<input type="text" name='nickname' id='nickname' /> 
					<input type="submit" id="markInsert" value="이 장소를 저장! :>" />
				</form>
			</div>
		</div>
	</div>


	<!--마크리스트 - 작대기 3개  -->
	<div id="mySidepanel" class="sidepanel">

			<!--마크리스트의  닫기버튼  -->
		<div class="navbar">
			<a class="active" href="javascript:void(0)" onclick="closeNav()">창 닫기 X </a>
		</div>

		<!-- 네비바 아래 스크롤되는 내용물 -->
		<div class="main">
			<!-- 내가 저장한 장소 검색 - 아코디언 -->
			<button class="accordion">저장한 장소를 검색해보세요~</button>
			<div class="panel">
				<div class="topnav">
					<form name="searchForm" id="searchForm">
						<h4>저장한 장소 검색</h4>
						<select name="type">
							<!-- 옵션 value값은 mapper랑 이름같게 -->
							<option value="name">장소 지명</option>
							<option value="nickname">장소 별칭</option>
						</select> 
						<input type="text" name="keyword" /> 
						<input type="submit" value="Search" />
					</form>
				</div>
				<!-- 검색 요청일 경우에 이전 일반 리스트로 돌아갈 수 있는 링크 표시-->
				<c:if test="${searchOption }">
					<ul>
						<li id="searchOutcome">"${keyword}" 검색결과</li>
					</ul>
				</c:if>
			</div>
			<div>
		
				<!-- 검색요청이 아닐 경우에는 일반 게시글 리스트 이므로 표시 하지 않음(나의 경우) -->
				<c:if test="${not searchOption }">
				</c:if>
		
		
					<!-- !!검색게시글 리스트!!
				markBoardList(서비스에서 지정) & 검색 요청이 잘 넘어왔으면  -->
				<c:if test="${not empty markBoardList and searchOption}">
		
					<div>
						<h2>마크리스트</h2>
					</div>
					<c:forEach var="m" items="${markBoardList}" varStatus="status">
						<ul class="listUl">
							<li class="listNo">번호 : ${m.no}</li>
							<li class="listName">장소지번 : ${m.name}</li>
							<li class="listNickName">저장한 장소 : ${m.nickname}</li>
							<li class="listLatitude">위도 : ${m.latitude }</li>
							<li class="listLatticeY">경도 : ${m.longitude}</li>
							<li class="listLongitude">격자 x : ${m.latticeX}</li>
							<li class="listLatticeX">격자 y : ${ m.latticeY}</li>
						</ul>
		
		
						<!--장소 업데이트 -->
						<form name="update" class="updateForm" action="update" method="post">
							<input type="hidden" name="no" value="${m.no}" class="no" /> 
							<input type="text" class="nickname" name="nickname" placeholder="저장한 장소이름을 변경하려면 여기를 클릭해주세요"> 
							<input type="submit" class="btnUpdate" value="저장 장소변경" />
						</form>
						<!--장소 삭제 -->
						<form name="delete" class="deleteForm" action="delete" method="post">
							<input type="hidden" name="no" value="${ m.no }" class="no" /> 
							<input type="submit" value="삭제하기" />
						</form>
					</c:forEach>
		
					<ul class="listPage">
		
						<!-- 페이징 처리 - 이전 처리 
					  - 예를 들면 : 
						 시작페이지(현재 : 6페이지)가 페이지그룹(5개씩 보여짐)보다 크다는 것은 
							 이전 글이 있다는 뜻 -->
								<!--  service에서 컨트롤러로 넘길 때 지정한 
								PAGE_GROUP이 pageGroup으로 변경되서 온걸 확인 가능함 -->
						<c:if test="${startPage > pageGroup }">
							<div class="pagination">
								<a href="markList?pageNum=${startPage - pageGroup}">&laquo;</a>
							</div>
						</c:if>
		
						<!-- 현재 머무르고 있는 그룹링크가 맞다면 숫자만 표기 -->
						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:if test="${ i == nowPage }">
								<div class="pagination">
									<a href="${ i } ">${ i } </a>
								</div>
							</c:if>
		
		
		
							<!-- 현재 머무르고 있는 그룹링크가 아니면 링크처리 -->
							<c:if test="${ i != nowPage }">
								<div class="pagination">
									<a href="markList?pageNum=${ i }"></a>
								</div>
							</c:if>
						</c:forEach>
		
								<!-- 다음 페이지 표기 하는 if문
							(전체 게시글 갯수가 끝페이지 수보다 클 때)
							
							끝 페이지가 카운트한 전체 페이지 수 보다  작다면 [ 다음 ] 표시가 보이게 함 
							 - service단에서 endPage 계산 끝내고 넘어옴 
							 - 내가 머무르는 페이지 = 13페이지 , 그룹링크의 갯수 = 5
							 - endPage = 시작페이지(11) + pageGroup(5) - 1 // 15
							 - pageCount(전체 페이지 수) = 22 페이지
							 - 내가 머무르는13페이지의 끝페이지는 15이고 전체 페이지수가 22개라 [다음] 표기가 됨
							 - 전체 페이지 수가 끝 페이지 수보다 적으면 표기 안됨 
							
							 - 현재 페이지 그룹의 시작페이지(startPage, 11 )에 pageGroup(5)을 더함
							 - 그리고  링크 설정한다. => 다음 페이지 그룹의 startPage(16페이지)로 이동 할 수 있음 
							 - pageNum = nowPage (서비스에서 변경했지만 dao에서 markList 파라미터로 인트가 들어오면 이라는 조건 때문에? 가능한듯)
							 -->
		
						<c:if test="${endPage < pageCount}">
							<div class="pagination">
								<a href="markList?pageNum=${startPage + pageGroup }">&raquo; </a>
							</div>
						</c:if>
					</ul>
				</c:if>
		
					<!--  검색 게시글 요청-->
		
		
					<!-- !!일반 게시글 리스트!!
				markBoardList(서비스에서 지정)만 !!  잘 넘어왔으면  -->
				<c:if test="${not empty markBoardList and not searchOption}">
					<div>
						<h2>마크리스트</h2>
					</div>
					<c:forEach var="m" items="${markBoardList}" varStatus="status">
						<ul class="listUl">
							<li class="listNo" id="listNo">번호 : ${m.no}</li>
							<li class="listName">장소지번 : ${m.name}</li>
							<li class="listNickName">저장한 장소 : ${m.nickname}</li>
							<li class="listLatitude">위도 : ${m.latitude }</li>
							<li class="listLatticeY">경도 : ${m.longitude}</li>
							<li class="listLongitude">격자 x : ${m.latticeX}</li>
							<li class="listLatticeX">격자 y : ${ m.latticeY}</li>
						</ul>
						<!--장소 업데이트 버튼 -->
						<form name="update" class="updateForm" action="update" method="post">
							<input type="hidden" class="no" name="no" value="${m.no }" /> 
							<input type="text" class="nickname" name="nickname"> 
							<input type="submit" class="btnUpdate" value="장소이름변경" />
						</form>
		
		
								<!--장소 삭제 -->
						<form name="delete" class="deleteForm" action="delete" method="post">
							<input type="hidden" name="no" value="${ m.no }" class="no" /> 
							<input type="submit" value="삭제하기" />
						</form>
					</c:forEach>
							<!--  일반게시글 요청-->
		
					<ul class="listPage">
		
								<!-- 페이징 처리 - 이전 처리 
							  - 예를 들면 : 
							 시작페이지(현재 : 6페이지)가 페이지그룹(5개씩 보여짐)보다 크다는 것은 
							 이전 글이 있다는 뜻 -->
								<!--  service에서 컨트롤러로 넘길 때 지정한 
								PAGE_GROUP이 pageGroup으로 변경되서 온걸 확인 가능함 -->
						<c:if test="${startPage > pageGroup }">
							<div class="pagination">
								<a href="markList?pageNum=${startPage - pageGroup}">&laquo;</a>
							</div>
						</c:if>
		
								<!-- 현재 머무르고 있는 그룹링크가 맞다면 숫자만 표기 -->
						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:if test="${ i == nowPage }">
								<div class="pagination">
									<a >${ i } </a>
								</div>
							</c:if>
									
		
		
		
									<!-- 현재 머무르고 있는 그룹링크가 아니면 링크처리 -->
							<c:if test="${ i != nowPage }">
								<div class="pagination">
									<a href="markList?pageNum=${ i }">${i}</a><!-- 태그안에 글씨 없으면 글씨는 안보이고 링크페이지 이동만 가능 -->
								</div>
		
							</c:if>
						</c:forEach>
		
								<!-- 다음 페이지 표기 하는 if문
							(전체 게시글 갯수가 끝페이지 수보다 클 때)
							
							끝 페이지가 카운트한 전체 페이지 수 보다  작다면 [ 다음 ] 표시가 보이게 함 
							 - service단에서 endPage 계산 끝내고 넘어옴 
							 - 내가 머무르는 페이지 = 13페이지 , 그룹링크의 갯수 = 5
							 - endPage = 시작페이지(11) + pageGroup(5) - 1 // 15
							 - pageCount(전체 페이지 수) = 22 페이지
							 - 내가 머무르는13페이지의 끝페이지는 15이고 전체 페이지수가 22개라 [다음] 표기가 됨
							 - 전체 페이지 수가 끝 페이지 수보다 적으면 표기 안됨 
							
							 - 현재 페이지 그룹의 시작페이지(startPage, 11 )에 pageGroup(5)을 더함
							 - 그리고  링크 설정한다. => 다음 페이지 그룹의 startPage(16페이지)로 이동 할 수 있음 
							 - pageNum = nowPage (서비스에서 변경했지만 dao에서 markList 파라미터로 인트가 들어오면 이라는 조건 때문에? 가능한듯)
							 -->
		
						<c:if test="${endPage < pageCount}">
							<div class="pagination">
								<a href="markList?pageNum=${startPage + pageGroup }">&raquo; </a>
							</div>
						</c:if>
					</ul>
				</c:if>
		
		
						<!-- 검색요청이지만 검색에 해당되는 리스트가(내용물이) 없는 경우 -->
				<c:if test="${empty markBoardList and searchOption }">
					<ul>
						<li>" ${keyword}"에 대한 검색결과가 없습니다</li>
						<li>&nbsp;&nbsp;<input type="button" value="목록보기"
								onclick="javascript:window.location.href=
										'markList?pageNum=${ pageNum }'" /></li>
					</ul>
				</c:if>
		
					<!-- 검색 요청과 markBoardList(서비스단에서 넘김)가 넘어오지 않았으면(없으면) -->
				<c:if test="${empty markBoardList and not searchOption }">
					<ul>
						<li>새로운 장소를 추가해보세요!</li>
					</ul>
						<!-- 목록으로 돌아가기 -->
					<ul class="BackToList">
						<c:if test="${ not searchOption }">		
							&nbsp;&nbsp;<input type="button" value="목록보기"
								onclick="javascript:window.location.href=
									'markList?pageNum=${ pageNum }'" />
						</c:if>
					</ul>
				</c:if>
			</div>
		<!-- 마크리스트 끝 -->
		</div>
	<!--마크리스트 부트스트랩 끝 -->
	</div>
		<!-- 마크리스트의 삭제 네비바를 위한 컨텐츠 디브(스크롤할 때 네비바 고정, 컨텐츠 스크롤 가능) -->
</article>



<script>
/* 마크리스트 부트스트랩 스크립트 */
 function openNav() {
  document.getElementById("mySidepanel").style.width = "40%";
  document.getElementById("mySidepanel").style.height = "800px;";
}


function closeNav() {
  document.getElementById("mySidepanel").style.width = "0";
  } 
  /* 마크리스트 부트스트랩 스크립트 끝 */

/* 검색 아코디언 부트스트랩 스크립트 */
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
}
/* 검색 아코디언 부트스트랩 스크립트 끝 */


</script>



