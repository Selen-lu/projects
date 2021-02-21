<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!-- dao,서비스,컨트롤러에서 온 모델이 넘어온 데이터 출력 및 폼으로 감싸서 sendForm.js인식하게 함-->
<script src="resources/js/sendForm.js"></script>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<!--  카카오 css -> css폴더안에있음, index.jsp에 정적요소로 넣어줌-->

<!-- 카카오 api -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa552b5f271c87eedea586c83e48e153&libraries=services"></script>
<!--부트스트랩  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Collapsed Sidepanel(마크리스트) & 전체 테마의  meta-->
<meta name="viewport" content="width=device-width, initial-scale=1">


<article>

	<!--  메인테마 시작-->
	<div class="container">
		<div style="text-align: center">
			<h3>반갑습니다:)</h3>
			<div class="column">
				<button class="openbtn" onclick="openNav()">마크리스트 ☰</button>
			</div>
		</div>
		<div class="row">
			<!-- 	<div class="column"> -->
			<!-- 지도 출력 -->
			<div class="map_wrap">
				<div id="markMap"
					style="width: 100%; height: 100%; position: relative;"></div>
				<!-- kakao.css의.map_wrap  width, height 픽셀을 기준으로 퍼센트화 함 -->
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
					<input type="hidden" id="name" name="name"> <input
						type="hidden" id="lat" name="latitude"> <input
						type="hidden" id="lon" name="longitude"> <input
						type="hidden" id="rsX" name="latticeX"> <input
						type="hidden" id="rsY" name="latticeY"> 클릭한 장소는 어떤
					장소인가요?:) <input type="text" name='nickname' id='nickname' /> <input
						type="submit" id="markInsert" value="이 장소를 저장! :>" />
				</form>
			</div>
		</div>
	</div>


	<!--마크리스트 - 작대기 3개  -->
	<div id="mySidepanel" class="sidepanel">

		<!--마크리스트의  닫기버튼  -->
		<div class="navbar">
			<a class="active" href="javascript:void(0)" onclick="closeNav()">창
				닫기 X </a>
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
						</select> <input type="text" name="keyword" /> <input type="submit"
							value="Search" />
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
						<form name="update" class="updateForm" action="update"
							method="post">
							<input type="hidden" name="no" value="${m.no}" class="no" /> <input
								type="text" class="nickname" name="nickname"
								placeholder="저장한 장소이름을 변경하려면 여기를 클릭해주세요"> <input
								type="submit" class="btnUpdate" value="저장 장소변경" />
						</form>
						<!--장소 삭제 -->
						<form name="delete" class="deleteForm" action="delete"
							method="post">
							<input type="hidden" name="no" value="${ m.no }" class="no" /> <input
								type="submit" value="삭제하기" />
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
								<a href="markList?pageNum=${startPage + pageGroup }">&raquo;
								</a>
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
						<form name="update" class="updateForm" action="update"
							method="post">
							<input type="hidden" class="no" name="no" value="${m.no }" /> <input
								type="text" class="nickname" name="nickname"> <input
								type="submit" class="btnUpdate" value="장소이름변경" />
						</form>


						<!--장소 삭제 -->
						<form name="delete" class="deleteForm" action="delete"
							method="post">
							<input type="hidden" name="no" value="${ m.no }" class="no" /> <input
								type="submit" value="삭제하기" />
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
									<a>${ i } </a>
								</div>
							</c:if>




							<!-- 현재 머무르고 있는 그룹링크가 아니면 링크처리 -->
							<c:if test="${ i != nowPage }">
								<div class="pagination">
									<a href="markList?pageNum=${ i }">${i}</a>
									<!-- 태그안에 글씨 없으면 글씨는 안보이고 링크페이지 이동만 가능 -->
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
								<a href="markList?pageNum=${startPage + pageGroup }">&raquo;
								</a>
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



<script>
/*지도  */
		navigator.geolocation.getCurrentPosition(function(pos) { // v지오로케이션으로 카카오 맵 감쌈
		    var latitude = pos.coords.latitude;
		    var longitude = pos.coords.longitude;
		   // alert("현재 위치는 : " + latitude + ", "+ longitude);
		
		
		var mapContainer = document.getElementById('markMap'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(latitude, longitude), 
		        // 지도의 중심좌표, v지오로케이션 변수로 받아서 넣음,현재 본인 위치
		       
		        level: 1 // 지도의 확대 레벨
		    };  
		
		
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		
	
	
			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			});
			
			function searchAddrFromCoords(coords, callback) {
			    // 위경도 좌표로 현재 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}
			
			function searchDetailAddrFromCoords(coords, callback) {
			    // 위경도 좌표로 현재 주소의 상세 주소 정보를 요청합니다
			    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
			}
			
			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
					
			        var infoDiv = document.getElementById('centerAddr');
	
			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                infoDiv.innerHTML = "지도의 중심 장소는 "+result[i].address_name + " 입니다";		                
			                break;
			            }
			        }


			        
			    }    
			}
	
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>클릭한 도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			            detailAddr += '<div>클릭한 지번 주소 : ' + result[0].address.address_name + '</div>';
			            var content = '<div class="bAddr">' +
			                            detailAddr +'</div>';


						//클릭하면 중앙 지번이 바뀐다
			    		var centeradder = result[0].address.address_name;
			    		 var result1 = document.getElementById('centerAddr'); 
			    		 result1.innerHTML = "클릭한 장소는 : " +centeradder +"입니다.";
		
			              //폼에 넣을 클릭 지번주소
			               // db: name
			              $("#name").val(result[0].address.address_name);


			           	
					    // 클릭한 위도, 경도 정보를 가져옵니다 
					    var latlng = mouseEvent.latLng; 
					    
					    // 마커 위치를 클릭한 위치로 옮깁니다
					    marker.setPosition(latlng);
					    
					    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
					    message += '경도는 ' + latlng.getLng() + ' 입니다';
					    
					    var resultDiv = document.getElementById('clickLatlng'); 
					    resultDiv.innerHTML = message;
	
					    //###################################
						// 폼에 위경도를 출력
						$("#lat").val( latlng.getLat());
						$("#lon").val(latlng.getLng());
		                
	
			       		 }
			
				            // 마커를 클릭한 위치에 표시합니다 
				            marker.setPosition(mouseEvent.latLng);
				            marker.setMap(map);
				
						
				
				            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
				            infowindow.setContent(content);
				            infowindow.open(map, marker);
						
					        var contentDiv =  document.getElementById('clickName');
				            contentDiv.innerHTML = detailAddr;
			
					            var x = latlng.getLat();//위도
					            var y =latlng.getLng();//경도
					            var strXY="";

					            if(!x||!y||isNaN(x)||isNaN(y)) {
					                alert("숫자 값이 아니거나 데이터 형식이 맞지 않습니다.");
					                return;
					            }
					            console.log("latlng, latlng "+latlng.getLng()+" "+latlng.getLat());
					            var xy = dfs_xy_conv("toXY", x, y);
					            console.log(xy);
					            
		
								
								// 격자지도 전환
								// 위에 위경도를 격자X, 격자Y로 변환 
							    var RE = 6371.00877; // 지구 반경(km)
						  	    var GRID = 5.0; // 격자 간격(km)
						  	    var SLAT1 = 30.0; // 투영 위도1(degree)
						  	    var SLAT2 = 60.0; // 투영 위도2(degree)
						  	    var OLON = 126.0; // 기준점 경도(degree)
						  	    var OLAT = 38.0; // 기준점 위도(degree)
						  	    var XO = 43; // 기준점 X좌표(GRID)
						  	    var YO = 136; // 기1준점 Y좌표(GRID)
						  	    
	
						  									//v1 - 위도,v2 - 경도
							    function dfs_xy_conv(code, v1, v2) { 
								    				
	
								     const DEGRAD = Math.PI / 180.0; 
								     const RADDEG = 180.0 / Math.PI; 
								     const re = RE / GRID; 
								     const slat1 = SLAT1 * DEGRAD; 
								     const slat2 = SLAT2 * DEGRAD; 
								     const olon = OLON * DEGRAD;
								     const olat = OLAT * DEGRAD;
	
										let sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5); 
										sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
										let sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5); 
										sf = (Math.pow(sf, sn) * Math.cos(slat1)) / sn; 
										let ro = Math.tan(Math.PI * 0.25 + olat * 0.5); 
										ro = (re * sf) / Math.pow(ro, sn); 
	
										const rs = {}; 
	
										//위경도-> 격자로 변환
										// 생략)격자->위경도
										if (code == "toXY") { 
											
											rs["lat"] = v1; //위도
											rs["lng"] = v2; //경도
											let ra = Math.tan(Math.PI * 0.25 + v1 * DEGRAD * 0.5); 
											ra = (re * sf) / Math.pow(ra, sn); 
											let theta = v2 * DEGRAD - olon; 
											
											if (theta > Math.PI) theta -= 2.0 * Math.PI; 
											if (theta < -Math.PI) theta += 2.0 * Math.PI; theta *= sn; 
											rs["x"] = Math.floor(ra * Math.sin(theta) + XO + 0.5); 
											rs["y"] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5); 
										} 
										else { 
											rs["x"] = v1; 
											rs["y"] = v2;
										 	const xn = v1 - XO; 
										 	const yn = ro - v2 + YO; 
										 	ra = Math.sqrt(xn * xn + yn * yn); 
										 	
									 		if (sn < 0.0) -ra;
											  let alat = Math.pow((re * sf) / ra, 1.0 / sn); 
											  alat = 2.0 * Math.atan(alat) - Math.PI * 0.5; 
											  
											if (Math.abs(xn) <= 0.0) { 
												theta = 0.0; 
										}
										 else { 
											  if (Math.abs(yn) <= 0.0) { 
												  theta = Math.PI * 0.5; 
											  
											 if (xn < 0.0) -theta; 
											 
										}else 
											theta = Math.atan2(xn, yn); 
	
										}
										
											const alon = theta / sn + olon; 
											rs["lat"] = alat * RADDEG; 
											rs["lng"] = alon * RADDEG; 
								
						            	} 
						            		return rs; 
						  	    }

								
									//카카오 지도 위경도를 반대로 받아서 NaN값이 된것
									//값 입력은 여기서!!!
									//위경도 -> 격자 XY전환
									const rs = dfs_xy_conv("toXY",String(x),String(y));  //위경도 스트링으로 변경
		
									console.log("(인트값) 위경도 x , y 출력 "+latlng.getLng()+" "+latlng.getLat()); //x,y 와 같음, 직접 가져오는 방법. 인트값
									console.log("rs.x,y 격자 출력 : "+ rs.x+" "+ rs.y); //엑셀파일 격자XY확인 완료
									console.log("rs.x,y type  위경도 타입 :  "+typeof(rs.x)+typeof(rs.y));
	
	
									 var rsx = String(rs.x);
									 var rsy = String(rs.y);

									//격자 div에 보여주기
									 var rsxx = String(rs.x);
									 var rsyy = String(rs.y);
									 var message2 =rsxx;
									 var message3 =rsyy;
									 var resultDiv2 = document.getElementById('rsXText'); 
									 resultDiv2.innerHTML = "격자 x좌표는 " +message2 + "입니다";
									 var resultDiv3 = document.getElementById('rsYText'); 
									 resultDiv3.innerHTML = "격자 y좌표는 " +message3 + "입니다";
										
									// 폼에 격자 x y 데이터 입력
									$("#rsX").val(message2);
									$("#rsY").val(message3); 


									//위경도-> 격자 전환끝 


									 

	
								
	
									/* 날씨 API  시작 */
								    var today = new Date();
								    var week = ['일','월','화','수','목','금','토'];
								    var year = today.getFullYear();
								    var month = today.getMonth()+1;
								    var day = today.getDate();
								    var hours = today.getHours();
								    var minutes = today.getMinutes();


								    
								    
								     //기상청 분마다 발표
								    // 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300 (1일 8회) 
								     //API 제공 시간(~이후) : 02:10, 05:10, 08:10, 11:10, 14:10, 17:10, 20:10, 23:10
								     
								    //자정	12~2시 9분까지
								    if(hours>=0&&hours<=2 || hours==2 && minutes<10){
							            // 자정 이전은 전날23시 10분 으로 계산(새벽 2시10분까지 당일 정보를 제공 안하기때문)
							            today.setDate(today.getDate() - 1);
							            day = today.getDate();
							            month = today.getMonth()+1;
							            hours = 23;
							           
							            
								    	}
									     //2시 10분 부터 5시 9분까지
									     else if(hours>=2 && minutes>=10 || hours >=2 &&hours <=5 && minutes<10){
									    	 	
								  				hours =2;
								        }
								        //5시 10분 부터 8시 9분까지
								        else if(hours>=5 && minutes>=10 || hours >=5 &&hours <=8 && minutes<10){
								        	
							  				hours =5;
							        	}
									        //8시 10분 부터 11시 9분까지
								        else if(hours>=8 && minutes>=10 || hours >=8 &&hours <=11 && minutes<10){
								        	
							  				hours =8;
							        	}
									        //11시 10분 부터 14시 9분까지
								        else if(hours>=11 && minutes>=10 || hours >=11 &&hours <=14 && minutes<10){
								        	
							  				hours =11;
							        	}
									        //14시 10분 부터 17시 9분까지
								        else if(hours>=14 && minutes>=10 || hours >=14 &&hours <=17 && minutes<10){
								        	
							  				hours =14;
							        	}
									        //17시 10분 부터 20시 9분까지
								        else if(hours>=17 && minutes>=10 || hours >=17 &&hours <=20 && minutes<10){
								        	
							  				hours =17;
							        	}
									        //20시 10분 부터 23시 9분까지
								        else if(hours>=20 && minutes>=10 || hours >=20 &&hours <=23 && minutes<10){
								        	
							  				hours =20;
							        	}
									        //23시 10분 부터 23시 59분까지
								        else if(hours>=23 && minutes>=10 && minutes <=59){
								        	
							  				hours =20;
							        	}
								 
								    
									  //example
								 	//9시 -> 09시 변경 필요
								    if(hours < 10) {
								        hours = '0'+hours;
								        minutes = 00;
								        
								    }
								    if(month < 10) {
								        month = '0' + month;
								        minutes = 00;
								    }    
								    if(day < 10) {
								        day = '0' + day;
								        minutes = 00;
								    } 
								    console.log("year" +year);
								    console.log("month " +month);
								    console.log("day "+ day);

								   	// year2020
								  	//month 10
								    //day 02
								    // today1:203002
								    //현재 today에서 숫자 더해지는 현상 벌어짐
								    //스트링으로 변경하여 today에 넣어줌
								    today =String(year) +String(month)+String(day);
								    
								    
								    console.log("today:" + today);

	
	
								    //위에서 전환한 격자 X,Y 좌표를 스트링으로 변환하여 변수에 넣어준다
								    var _nx = String(rs.x);//격자 x
								    _ny = String(rs.y); //격자 y
								    
								    //api 키
								    apikey = "UINP0yM2CDNuiAmyi%2BYUnmeQ4giBrRltrb4OJwfTsh06NI%2FXaKtQRAWsfAyYx9kHdImj7fs1WRmkGOqrGozLuQ%3D%3D";



								    var xhr = new XMLHttpRequest();
								    var url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst'; /*URL*/
								    var queryParams = '?' + encodeURIComponent('ServiceKey') + '='+apikey; /*Service Key*/
								    queryParams += '&' + encodeURIComponent('ServiceKey') + '=' + encodeURIComponent(apikey); /*Service Key*/
								    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); 
								    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); 
									 // - XML형식으로 받아온다.(JSON으로 받지 말고)
									 // - 날씨 API와 카카오가 충돌난다.
									 // - 에러 내용)
									 // - Uncaught TypeError: Failed to execute 'appendChild' on 'Node': 
							   		 // 	parameter 1 is not of type 'Node'.
									 //- 주원인은 카카오쪽에서 나오는 문제이며 appendChild의 DOM 함수 사용이 원인이다 
									// - 아마도 날씨 API는 append 사용함 (JavaScript 함수)
									   // queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('XML');
								    queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('XML'); /**/
								    queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(today);
								    queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent(hours+"00"); 
								    queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent(_nx); 
								    queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent(_ny);
					
	
								    xhr.open('GET', url + queryParams);
								    xhr.onreadystatechange = function () {
								        if (this.readyState == 4) {
	
									        //기상청 및 국가 공공 api 사용시 ->Allow-Control-Allow-Origin(보안 문제) 뜨며 값이 넘어오지 않음
									        //브라우저 보안 정책임..이것은 개인 개발자가 해결x, 제공쪽에서 풀어주지 않으면 직접 얻기 어려움
									        // access-controll-allow-origin의 의미는 "여기에 적힌놈은 정책 무시했어도 걍 허용해 줘라"라는 의미이며...(vue.router사용시? 아니면 스트링부트 사용하면 사용하는 문법)
									        //보안 정책때문에 걸리는 문제를 무시하고 가져와야함
									        // 방법: 
									        //컨트롤러 - > 적용할 메소드 위에 @CrossOrigin(origins = "http://localhost:8080")
									        //크롬 브라우저 키고 ->크롬 웹스토어 -> Allow-Control-Allow-Origin 검색해서
									        //Moesif Origin & CORS Changer(제공업체: https://www.moesif.com) 확장 프로그램 설치
									        //off->on상태로 변경 
								            
								            // 기상청 데이터가 넘어오지 않을때 상태 보는 콘솔로그
								            //console.log('Status: '+this.status+" "+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+" "+'nBody: '+this.responseText);
								            
								            console.log(" -------------- ");
											
								            
											// 넘어온 데이터의 이름 
											//for문 안에 if문 총 13개
											//POP PTY R06 REH S06 T3H TMN  TMX WAV VEC WSD RN1 SKY
											
											var POP ;
											var PTY ;
											var R06 ;
											var REH ;
											var S06 ;
											var T3H ;
											var TMN  ;
											var TMX ;
											var WAV ;
											var VEC ;
											var WSD ;
											var RN1 ;
											var SKY;
											
											for(var i = 0; i < 10 ; i++) {
												
										
											parser=new DOMParser();
												 //  (*_*) 카카오쪽에서 파싱할 때 text라는 변수를 사용해서 변수명을 text 말고 다른걸 사용함
									            // 에러 내용 ) Uncaught ReferenceError: txt is not defined at XMLHttpRequest.xhr.onreadystatechange
												 var xmlText = this.responseText;  //XML형식의 본문 내용이 들어간다


												//console.log("실상 내용물이다. this.responseText : "+this.responseText);
											       
													
												 // (*_*)의 에러원인
												xmlDoc=parser.parseFromString(xmlText,"text/xml");
												 
												// 특정 태그를 기준으로 변수에 담는다
												var xml = xmlDoc.getElementsByTagName('items');



												
												//getElementsByTagName : 태그 호출
												//childNodes : 자식 노드
												//nodeValue : 해당 노드의 값(text)

												
												// 넘어온 값의 이름
												var WEA12 = xml[0].getElementsByTagName('item')[i].getElementsByTagName('category')[0].childNodes[0].nodeValue;

												//넘어온 값의 실제 값
												var WEATHER12 = xml[0].getElementsByTagName('item')[i].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;

												if(WEA12 =="POP" ){
													POP = WEATHER12;
													console.log("POP : " + POP+ " " +" typeof : "+typeof(POP));
											
													}
												else if (WEA12 =="PTY"){
													PTY = WEATHER12;
													console.log("PTY : " +PTY+ " " +" typeof : "+typeof(PTY));

													}
												else if (WEA12 =="R06"){
													R06 = WEATHER12;
													console.log("R06 : "+R06+ " " +" typeof : "+typeof(R06));

													}
												else if (WEA12 =="REH"){
													REH = WEATHER12;
													console.log("REH : " + REH+ " " +" typeof : "+typeof(REH));
													
													}
												else if (WEA12 =="S06"){
													S06 = WEATHER12;
													console.log("S06 : "+ S06+ " " +" typeof : "+typeof(S06));

													}
												else if (WEA12 =="T3H"){
													T3H  = WEATHER12;
													console.log("T3H : " + T3H+ " " +" typeof : "+typeof(T3H));
 
													}
												else if(WEA12 =="TMN"){
													TMN = WEATHER12;
													console.log("TMN : " +  TMN+ " " +" typeof : "+typeof(TMN));
											
													}
												else if(WEA12 =="TMX"){
													TMX = WEATHER12;
													console.log("TMX :" +TMX+ " " +" typeof : "+typeof(TMX));
													
													}
												else if (WEA12 =="WAV"){
													WAV = WEATHER12;
													console.log("WAV : " + WAV+ " " +" typeof : "+typeof(WAV));

													}
												else if (WEA12 =="VEC"){
													VEC = WEATHER12;
													console.log("VEC : " +  VEC+ " " +" typeof : "+typeof(VEC));
													}
												else if (WEA12 =="WSD"){
													WSD = WEATHER12;
													console.log("WSD : " +WSD + " " +" typeof : "+typeof(WSD));
													}
												else if (WEA12 =="RN1"){
													RN1 = WEATHER12;
													console.log("RN1 :" +RN1+ " " +" typeof : "+typeof(RN1));
													}
												else if (WEA12 =="SKY"){
													SKY = WEATHER12;
													console.log( "SKY :" + SKY + " " +" typeof : "+typeof(SKY) );

													}
								
											}

											// 시간대에 나온 변수 값만 출력 
											console.log("POP : "+ String(POP)
													+ "\n" +"PTY : "+  String(PTY)
													+ "\n" +" R06 : "+ String(R06)
													+ "\n" + "REH : "+String(REH)
													+ "\n" + "S06 : "+String(S06)
													+ "\n" + "T3H : "+ String(T3H)
													+ "\n" + "TMN : "+String(TMN)
													+  "\n"+" TMX : "+String(TMX)
													+  "\n"+"WAV : "+String(WAV)
													+ "\n" +"VEC"+ String(VEC)
													+ "\n" + "WSD : "+String(WSD)
													+ "\n" + "RN1 : "+String(RN1)
													+ "\n" + "SKY : "+String(SKY))

									//변수 따로 만들어서 미리 작성한 if문에서 값이 있는지 없는지 판단후 (if,true)값 넣어서 보낸다
									
											/* 
											
											해당 아이디로 넘김 (inner랑 함께 사용)
											 var URU1 =document.getElementById('WEATHER1'); 
											 var URU2 =document.getElementById('WEATHER2'); 
											 var URU3 =document.getElementById('WEATHER3'); 
											 var URU4 =document.getElementById('WEATHER4'); 
											 var URU5 =document.getElementById('WEATHER5'); 
											 var URU6 =document.getElementById('WEATHER6'); 
											 var URU7 =document.getElementById('WEATHER7'); 
											 var URU8 =document.getElementById('WEATHER8'); 
											 var URU9 =document.getElementById('WEATHER9'); 
											 var URU10 =document.getElementById('WEATHER10'); */

											 var URU1 =document.getElementById('WEATHER1'); 

										

			
											    //자정	12~2시 9분까지  // 자정 이전은 전날로 계산됨
											    if(hours>=0&&hours<=2 || hours==2 && minutes<10){

												 }
												 //2시 10분 부터 5시 9분까지
												else if(hours>=2 && minutes>=10 || hours >=2 &&hours <=5 && minutes<10){

											  	
											     }
											       //5시 10분 부터 8시 9분까지
											     else if(hours>=5 && minutes>=10 || hours >=5 &&hours <=8 && minutes<10){
											        
										         }
												  //8시 10분 부터 11시 9분까지
											      else if(hours>=8 && minutes>=10 || hours >=8 &&hours <=11 && minutes<10){
										
										  			
										         }
												  //11시 10분 부터 14시 9분까지
											    else if(hours>=11 && minutes>=10 || hours >=11 &&hours <=14 && minutes<10){

										         }
												//14시 10분 부터 17시 9분까지
											     else if(hours>=14 && minutes>=10 || hours >=14 &&hours <=17 && minutes<10){

											        	
										         }
												  //17시 10분 부터 20시 9분까지
											    else if(hours>=17 && minutes>=10 || hours >=17 &&hours <=20 && minutes<10){
											        
										         }
												 //20시 10분 부터 23시 9분까지
											      else if(hours>=20 && minutes>=10 || hours >=20 &&hours <=23 && minutes<10){
							
										        }
												 //23시 10분 부터 23시 59분까지(다음날 2시이전이랑 같게함)
											    else if(hours>=23 && minutes>=10 && minutes <=59){
											       
										        }


											//(언젠간 처리할것)
											// -주의) 동네예보조회 해상 마스킹 처리 (해상에서는 표시 안함 또는 다른곳 표시해달라는 표기 필요)
											//해상에는 기온군, 강수확률, 강수량/적설, 습도를 제공하지 않음 (Missing값으로 마스킹처리 함)
	

											
	
									  		}//날씨
								    };//날씨
	
								    xhr.send('');
									console.log("queryParams  넘어옴: XML 형식이 콘솔로 내용물 넘어온다");
								 
								//날씨끝


									
				    }) //격자지도 끝
				    
				});//카카오맵 끝
		  
	});//지오로케이션 끝
</script>