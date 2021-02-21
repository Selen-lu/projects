		var csrfHeader = $('.token').data("token-name");
		var csrfToken = $('.token').val();
	
		$.ajaxSetup({
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeader, csrfToken);
			}
		})

/*지도  */
		navigator.geolocation.getCurrentPosition(function(pos) { // v지오로케이션으로 카카오 맵 감쌈
		    var latitude = pos.coords.latitude;
		    var longitude = pos.coords.longitude;
		   // alert("현재 위치는 : " + latitude + ", "+ longitude);
		
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
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
					            
		
								
								//격자지도 전환
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
									//값 입력은 여기서
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
							            year = today.getFullYear();
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
								    }
								    if(month < 10) {
								        month = '0' + month;
								    }    
								    if(day < 10) {
								        day = '0' + day;
								    } 
								 
								    today = year+month+day;

	
	
								    //위에서 전환한 격자 X,Y 좌표를 스트링으로 변환하여 변수에 넣어준다
								    var _nx = String(rs.x);//격자 x
								    _ny = String(rs.y); //격자 y
									
									var formData = 
									$.ajax({
										type:"POST",
										url:"whether",
										data:formData,
										dataType: "json",
										success:function(resData){		

										}
									});

									//api 키
									
								    apikey = "K1COpft1yy6YLlfi8VzjGCQU%2B793AH2J4wy%2BQLnEYYaoW9GyhIaKmDM6a9icpdwFHAPmjotNRXOCKQkaPxT0iw%3D%3D";
									
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
					
									
									
									/*var formData = 'nx=' + _nx + '&ny=' + _ny;
									var we = new Array();
									$.ajax({
										type:"POST",
										url:"weather",
										data:formData,
										dataType: "json",
										success:function(resData){		
											$.each(resData, function(index, value){
												we[index] = value;
											});
										}
									});*/
									
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
								           // console.log('Status: '+this.status+" "+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+" "+'nBody: '+this.responseText);
								            
								            console.log(" -------------- ");
											
								            //console.log("실상 내용물이다. this.responseText : "+this.responseText);
								            
								            //  (*_*) 카카오쪽에서 파싱할 때 text라는 변수를 사용해서 변수명을 text 말고 다른걸 사용함
								            // 에러 내용 ) Uncaught ReferenceError: txt is not defined at XMLHttpRequest.xhr.onreadystatechange
											 var xmlText = this.responseText;  //XML형식의 본문 내용이 들어간다
	
	
											parser=new DOMParser();
	
											 // (*_*)의 에러원인
											xmlDoc=parser.parseFromString(xmlText,"text/xml");
											 
											// 특정 태그를 기준으로 변수에 담는다
											var xml = xmlDoc.getElementsByTagName('items');

											//getElementsByTagName : 태그 호출
											//childNodes : 자식 노드
											//nodeValue : 해당 노드의 값(text)
											var WE1 = xml[0].getElementsByTagName('item')[0].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE2 = xml[0].getElementsByTagName('item')[1].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE3 = xml[0].getElementsByTagName('item')[2].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE4 = xml[0].getElementsByTagName('item')[3].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE5 = xml[0].getElementsByTagName('item')[4].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE6 = xml[0].getElementsByTagName('item')[5].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE7 = xml[0].getElementsByTagName('item')[6].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE8 =xml[0].getElementsByTagName('item')[7].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE9 = xml[0].getElementsByTagName('item')[8].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;
											var WE10 =xml[0].getElementsByTagName('item')[9].getElementsByTagName('fcstValue')[0].childNodes[0].nodeValue;

										
											 var URU1 =document.getElementById('WEATHER1'); 
											 var URU2 =document.getElementById('WEATHER2'); 
											 var URU3 =document.getElementById('WEATHER3'); 
											 var URU4 =document.getElementById('WEATHER4'); 
											 var URU5 =document.getElementById('WEATHER5'); 
											 var URU6 =document.getElementById('WEATHER6'); 
											 var URU7 =document.getElementById('WEATHER7'); 
											 var URU8 =document.getElementById('WEATHER8'); 
											 var URU9 =document.getElementById('WEATHER9'); 
											 var URU10 =document.getElementById('WEATHER10'); 


											    //자정	12~2시 9분까지  // 자정 이전은 전날로 계산됨
											    if(hours>=0&&hours<=2 || hours==2 && minutes<10){
												    //hours>=0&&hours<=2&& minutes<10
												    
											    	//POP
											    	//PTY
											    	//REH
											    	//SKY
											    	//T3H
											    
											    	//UUU //
											    	//VEC
											    	//vvv//
											    	//vsd
											    	


											    	URU1.innerHTML = "강수확률 : "+WE1 +"%";

											    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
											    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
											    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
											    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
											    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
											    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
											    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
											    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
											    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

													var WE03 = parseFloat(WE3);
											    	if(WE03<0.1) URU3.innerHTML = "강수량 : "+WE3 +"! 비 소식이 매우매우 적어요~";	 
											    	if(WE03>0.1 && WE03<1) URU3.innerHTML = "강수량 : "+WE3+"mm";
											    	if(WE03>=5 && WE03<10) URU3.innerHTML = "강수량 : "+WE3+"mm";
											    	if(WE03>=10 && WE03<20) URU3.innerHTML = "강수량 : "+WE3+"mm";
											    	if(WE03>=20 && WE03<40) URU3.innerHTML = "강수량 : "+WE3+"mm";
											    	if(WE03>=40 && WE03<70) URU3.innerHTML = "강수량 : "+WE3+"mm";
											    	if(WE03>=70) URU3.innerHTML = "강수량 : "+WE3+"많은 비가 예상되니 우산은 필수입니다~";
										            
											    	URU4.innerHTML = "습도 : "+WE4+"%";

											    	 var sky = parseInt(WE5);
											    	 if(sky>=0 && sky<=5) URU5.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
											    	 if(sky>=6 && sky<=8) URU5.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
											    	 if(sky>=9 && sky<=10) URU5.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";
											    												    	
											    	 URU6.innerHTML = "(3시간 로테이션)기온 : "+WE6+"℃ ";
											    	 URU7.innerHTML = "아침 최저 기온 : "+WE7+"℃ ";

													//9는 UUU(동서 풍향,풍량 ) 이라 생략
											    
											    	 var veca = parseInt(WE10);
											    	 if(veca >=0 && veca <45){
											    	 	URU10.innerHTML = "북~북동쪽에서 바람이 부네요~";
											    	 }
											    	 else if(veca >=45 && veca <90){
											    		 URU10.innerHTML = "북동~동쪽에서 바람이 부네요~";
											    	 }
											    	 else if(veca >=90 && veca <135){
											    		 URU10.innerHTML = "동~남동쪽에서 바람이 부네요~";
											    	 }
											    	 else if(veca >=135 && veca <180) {
											    		 URU10.innerHTML = "남동~-남쪽에서 바람이 부네요~";
											    	 }	
											    	 else if(veca >=180 && veca <225) {
											    		 URU10.innerHTML = "남~남서쪽에서 바람이 부네요~";
											    	 }	
											    	 else if(veca >=225 && veca <270) {
											    		 URU10.innerHTML = "남서~서쪽에서 바람이 부네요~";
											    	 }	
											    	 else if(veca >=270 && veca <315) {
											    		 URU10.innerHTML = "서~북서쪽에서 바람이 부네요~";
											    	 }	
											    	 else if(veca >=315 && veca <360) {
											    	 	URU10.innerHTML = "북서~북쪽에서 바람이 부네요~";
											    	 }
										    	
												    
											
							

												 }
												 //2시 10분 부터 5시 9분까지
												 else if(hours>=2 && minutes>=10 || hours >=2 &&hours <=5 && minutes<10){




													    //POP,PTY,R06,REH,S06,SKY,T3H,TMN,UUU//생략,VEC


												    	URU1.innerHTML = "강수확률 : "+WE1 +"%";

												    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
												    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
												    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
												    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
												    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
												    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
												    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
												    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
												    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

														var WE03 = parseFloat(WE3);
												    	if(WE03<0.1) URU3.innerHTML = "강수량 : "+WE3 +"! 비 소식이 매우매우 적어요~";	 
												    	if(WE03>0.1 && WE03<1) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=5 && WE03<10) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=10 && WE03<20) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=20 && WE03<40) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=40 && WE03<70) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=70) URU3.innerHTML = "강수량 : "+WE3+"많은 비가 예상되니 우산은 필수입니다~";
											            
												    	URU4.innerHTML = "습도 : "+WE4+"%";

												    	var WE05 = parseFloat(WE5);
												    	if(WE05<0.1) URU5.innerHTML = "적설량 : "+WE5 +"! 눈 소식이 매우매우 적어요~";	 
												    	if(WE05>0.1 && WE05<1) URU5.innerHTML = "적설량 : "+WE5 +"cm";
												    	if(WE05>=1 && WE05<5) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=5 && WE05<10) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=10 && WE05<20) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=20) URU5.innerHTML = "적설량 : "+WE5+"cm";

												    	 var sky = parseInt(WE6);
												    	 if(sky>=0 && sky<=5) URU6.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
												    	 if(sky>=6 && sky<=8) URU6.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
												    	 if(sky>=9 && sky<=10) URU6.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";
												    												    	
												    	 URU7.innerHTML = "(3시간 로테이션)기온 : "+WE7+"℃ ";
												    	 URU8.innerHTML = "아침 최저 기온 : "+WE8+"℃ ";

														//9는 UUU(동서 풍향,풍량 ) 이라 생략
												    
												    	 var veca = parseInt(WE10);
												    	 if(veca >=0 && veca <45){
												    	 	URU10.innerHTML = "북~북동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=45 && veca <90){
												    		 URU10.innerHTML = "북동~동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=90 && veca <135){
												    		 URU10.innerHTML = "동~남동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=135 && veca <180) {
												    		 URU10.innerHTML = "남동~-남쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=180 && veca <225) {
												    		 URU10.innerHTML = "남~남서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=225 && veca <270) {
												    		 URU10.innerHTML = "남서~서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=270 && veca <315) {
												    		 URU10.innerHTML = "서~북서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=315 && veca <360) {
												    	 	URU10.innerHTML = "북서~북쪽에서 바람이 부네요~";
												    	 }

											  	
											      }
											        //5시 10분 부터 8시 9분까지
											        else if(hours>=5 && minutes>=10 || hours >=5 &&hours <=8 && minutes<10){
											        	//POP(측정시간 전날 9시),PTY,REH,SKY,T3H,UUU(생략),VEC,VVV(생략),WSD,POP(측정시간 전날 12시)
														//6,8,10 생략	
															URU1.innerHTML = "강수확률 : "+WE1 +"%";

													    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
													    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
													    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
													    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
													    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
													    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
													    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
													    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
													    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

													    	URU3.innerHTML = "습도 : "+WE3+"%";
													    	
													    	var sky = parseInt(WE4);
													    	if(sky>=0 && sky<=5) URU4.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
													    	if(sky>=6 && sky<=8) URU4.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
													    	if(sky>=9 && sky<=10) URU4.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";

													    	URU5.innerHTML = "(3시간 로테이션)기온 : "+WE5+"℃ ";
													    	
													    	//6생략		
													    		    	
													    	 var veca = parseInt(WE7);
													    	 if(veca >=0 && veca <45){
													    	 	URU7.innerHTML = "북~북동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=45 && veca <90){
													    		 URU7.innerHTML = "북동~동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=90 && veca <135){
													    		 URU7.innerHTML = "동~남동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=135 && veca <180) {
													    		 URU7.innerHTML = "남동~-남쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=180 && veca <225) {
													    		 URU7.innerHTML = "남~남서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=225 && veca <270) {
													    		 URU7.innerHTML = "남서~서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=270 && veca <315) {
													    		 URU7.innerHTML = "서~북서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=315 && veca <360) {
													    	 	URU7.innerHTML = "북서~북쪽에서 바람이 부네요~";
													    	 }
															//8생략
													    	 
													    	 var wind = parseInt(WE9);
													    	 if(wind  <=4){
													    	 URU9.innerHTML = "바람세기 : 약함";
													    	 }
													    	 else if(wind >=4 && wind <9){
													    	 URU9.innerHTML = "바람세기 : 약간 강함";
													    	 }
													    	 else if(wind >=9 && wind <14){
													    	 URU9.innerHTML = "바람세기 : 강함";
													    	 }
													    	 else if( wind  >14) {
													    	 URU9.innerHTML = "바람세기 : 매우 강함";
													    	 }	

													    	URU10.innerHTML = "강수확률 : "+WE10 +"%";

										        	}
												        //8시 10분 부터 11시 9분까지
											         else if(hours>=8 && minutes>=10 || hours >=8 &&hours <=11 && minutes<10){
											       		 //POP
											        	 //PTY
											        	 //REH
											        	 //SKY
											        	// T3H
											        	 ///TMX
											        	 //UUU
											        	 //VEC
											        	// VVV
											        	 //WSD
											        	 	URU1.innerHTML = "강수확률 : "+WE1 +"%";
													    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
													    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
													    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
													    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
													    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
													    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
													    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
													    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
													    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

													    	URU3.innerHTML = "습도 : "+WE3+"%";
													    	var sky = parseInt(WE4);
													    	if(sky>=0 && sky<=5) URU4.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
													    	if(sky>=6 && sky<=8) URU4.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
													    	if(sky>=9 && sky<=10) URU4.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";

													    	URU5.innerHTML = "(3시간 로테이션)기온 : "+WE5+"℃ ";
													    	URU6.innerHTML = "아침 최저 기온 : "+WE6+"℃ ";


													    	//7 생략
													    	
													    	 var veca = parseInt(WE8);
													    	 if(veca >=0 && veca <45){
													    	 	URU8.innerHTML = "북~북동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=45 && veca <90){
													    		 URU8.innerHTML = "북동~동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=90 && veca <135){
													    		 URU8.innerHTML = "동~남동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=135 && veca <180) {
													    		 URU8.innerHTML = "남동~-남쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=180 && veca <225) {
													    		 URU8.innerHTML = "남~남서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=225 && veca <270) {
													    		 URU8.innerHTML = "남서~서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=270 && veca <315) {
													    		 URU8.innerHTML = "서~북서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=315 && veca <360) {
													    	 	URU8.innerHTML = "북서~북쪽에서 바람이 부네요~";
													    	 }
													    	 //9생략
													    	 var wind = parseInt(WE10);
													    	 if(wind  <=4){
													    	 URU10.innerHTML = "바람세기 : 약함";
													    	 }
													    	 else if(wind >=4 && wind <9){
													    	 URU10.innerHTML = "바람세기 : 약간 강함";
													    	 }
													    	 else if(wind >=9 && wind <14){
													    	 URU10.innerHTML = "바람세기 : 강함";
													    	 }
													    	 else if( wind  >14) {
													    	 URU10.innerHTML = "바람세기 : 매우 강함";
													    	 }	
		
										  			
										        	}
												        //11시 10분 부터 14시 9분까지
											        else if(hours>=11 && minutes>=10 || hours >=11 &&hours <=14 && minutes<10){

											        	//POP 1
											        	//PTY 2 
											        	//R06 3
											        	//REH 4
											        	//S06 5
											        	//SKY 6
											        	//T3H 7
											        	//UUU -8
											        	//VEC 9 
											        	//VVV -10

											        	URU1.innerHTML = "강수확률 : "+WE1 +"%";
												    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
												    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
												    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
												    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
												    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
												    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
												    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
												    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
												    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

														var WE03 = parseFloat(WE3);
												    	if(WE03<0.1) URU3.innerHTML = "강수량 : "+WE3 +"! 비 소식이 매우매우 적어요~";	 
												    	if(WE03>0.1 && WE03<1) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=5 && WE03<10) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=10 && WE03<20) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=20 && WE03<40) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=40 && WE03<70) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=70) URU3.innerHTML = "강수량 : "+WE3+"많은 비가 예상되니 우산은 필수입니다~";

												    	URU4.innerHTML = "습도 : "+WE4+"%";

												    	var WE05 = parseFloat(WE5);
												    	if(WE05<0.1) URU5.innerHTML = "적설량 : "+WE5 +"! 눈 소식이 매우매우 적어요~";	 
												    	if(WE05>0.1 && WE05<1) URU5.innerHTML = "적설량 : "+WE5 +"cm";
												    	if(WE05>=1 && WE05<5) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=5 && WE05<10) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=10 && WE05<20) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=20) URU5.innerHTML = "적설량 : "+WE5+"cm";

												    	 var sky = parseInt(WE6);
												    	 if(sky>=0 && sky<=5) URU6.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
												    	 if(sky>=6 && sky<=8) URU6.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
												    	 if(sky>=9 && sky<=10) URU6.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";
												    												    	
												    	 URU7.innerHTML = "(3시간 로테이션)기온 : "+WE7+"℃ ";
												    	 
												    	

														//8는 UUU(동서 풍향,풍량 ) 이라 생략
												    
												    	 var veca = parseInt(WE9);
												    	 if(veca >=0 && veca <45){
												    	 	URU9.innerHTML = "북~북동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=45 && veca <90){
												    		 URU9.innerHTML = "북동~동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=90 && veca <135){
												    		 URU9.innerHTML = "동~남동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=135 && veca <180) {
												    		 URU9.innerHTML = "남동~-남쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=180 && veca <225) {
												    		 URU9.innerHTML = "남~남서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=225 && veca <270) {
												    		 URU9.innerHTML = "남서~서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=270 && veca <315) {
												    		 URU9.innerHTML = "서~북서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=315 && veca <360) {
												    	 	URU9.innerHTML = "북서~북쪽에서 바람이 부네요~";
												    	 }

												    	 //10 생략
												    	 
										        	}
												        //14시 10분 부터 17시 9분까지
											        else if(hours>=14 && minutes>=10 || hours >=14 &&hours <=17 && minutes<10){

											        	//POP(측정시간  전날 21시)
											        	//PTY
											        	//REH
											        	//SKY
											        	//T3H
											        	//UUU-6
											        	//VEC
											        	//VVV  -8
											        	//WSD
											        	//POP(측정시간  당일 00시) -10
											         	URU1.innerHTML = "강수확률 : "+WE1 +"%";
												    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
												    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
												    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
												    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
												    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
												    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
												    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
												    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
												    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

												    	URU3.innerHTML = "습도 : "+WE3+"%";

												    	 var sky = parseInt(WE4);
												    	 if(sky>=0 && sky<=5) URU6.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
												    	 if(sky>=6 && sky<=8) URU6.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
												    	 if(sky>=9 && sky<=10) URU6.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";
												    												    	
												    	 URU5.innerHTML = "(3시간 로테이션)기온 : "+WE5+"℃ ";

												    	 //6 생략
												    	 var veca = parseInt(WE7);
												    	 if(veca >=0 && veca <45){
												    	 	URU7.innerHTML = "북~북동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=45 && veca <90){
												    		 URU7.innerHTML = "북동~동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=90 && veca <135){
												    		 URU7.innerHTML = "동~남동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=135 && veca <180) {
												    		 URU7.innerHTML = "남동~-남쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=180 && veca <225) {
												    		 URU7.innerHTML = "남~남서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=225 && veca <270) {
												    		 URU7.innerHTML = "남서~서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=270 && veca <315) {
												    		 URU7.innerHTML = "서~북서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=315 && veca <360) {
												    	 	URU7.innerHTML = "북서~북쪽에서 바람이 부네요~";
												    	 }
												    	 //8생략
												    	 var wind = parseInt(WE9);
												    	 if(wind  <=4){
												    	 URU9.innerHTML = "바람세기 : 약함";
												    	 }
												    	 else if(wind >=4 && wind <9){
												    	 URU9.innerHTML = "바람세기 : 약간 강함";
												    	 }
												    	 else if(wind >=9 && wind <14){
												    	 URU9.innerHTML = "바람세기 : 강함";
												    	 }
												    	 else if( wind  >14) {
												    	 URU9.innerHTML = "바람세기 : 매우 강함";
												    	 }	
												    	 //10 생략
											        	
										        	}
												        //17시 10분 부터 20시 9분까지
											        else if(hours>=17 && minutes>=10 || hours >=17 &&hours <=20 && minutes<10){
											        	//POP
											        	//PTY
											        	//REH
											        	//SKY
											        	//T3H
											        	//UUU//6
											        	//VEC
											        	//VVV//8
											        	//wsd
											        	//wav
															URU1.innerHTML = "강수확률 : "+WE1 +"%";

													    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
													    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
													    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
													    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
													    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
													    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
													    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
													    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
													    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

													    	URU3.innerHTML = "습도 : "+WE3+"%";
													    	
													    	var sky = parseInt(WE4);
													    	if(sky>=0 && sky<=5) URU4.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
													    	if(sky>=6 && sky<=8) URU4.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
													    	if(sky>=9 && sky<=10) URU4.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";

													    	URU5.innerHTML = "(3시간 로테이션)기온 : "+WE5+"℃ ";
													    	
													    	//6생략		
													    		    	
													    	 var veca = parseInt(WE7);
													    	 if(veca >=0 && veca <45){
													    	 	URU7.innerHTML = "북~북동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=45 && veca <90){
													    		 URU7.innerHTML = "북동~동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=90 && veca <135){
													    		 URU7.innerHTML = "동~남동쪽에서 바람이 부네요~";
													    	 }
													    	 else if(veca >=135 && veca <180) {
													    		 URU7.innerHTML = "남동~-남쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=180 && veca <225) {
													    		 URU7.innerHTML = "남~남서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=225 && veca <270) {
													    		 URU7.innerHTML = "남서~서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=270 && veca <315) {
													    		 URU7.innerHTML = "서~북서쪽에서 바람이 부네요~";
													    	 }	
													    	 else if(veca >=315 && veca <360) {
													    	 	URU7.innerHTML = "북서~북쪽에서 바람이 부네요~";
													    	 }
															//8생략
													    	 
													    	 var wind = parseInt(WE9);
													    	 if(wind  <=4){
													    	 URU9.innerHTML = "바람세기 : 약함";
													    	 }
													    	 else if(wind >=4 && wind <9){
													    	 URU9.innerHTML = "바람세기 : 약간 강함";
													    	 }
													    	 else if(wind >=9 && wind <14){
													    	 URU9.innerHTML = "바람세기 : 강함";
													    	 }
													    	 else if( wind  >14) {
													    	 URU9.innerHTML = "바람세기 : 매우 강함";
													    	 }	

													    	URU10.innerHTML = "파고 : "+WE10 +"M";
										  			
										        	}
												        //20시 10분 부터 23시 9분까지
											        else if(hours>=20 && minutes>=10 || hours >=20 &&hours <=23 && minutes<10){
											        	//POP(측정시간 당일 03시)
											        	//PTY
											      		 //REH
											        	//SKY
											        	//T3H
											        	//UUU -
											        	//VEC
											        	//VVV  -
											        	//WSD
											        	//POP(측정시간 당일 06시)
										        	}
												        //23시 10분 부터 23시 59분까지(다음날 2시이전이랑 같게함)
											        else if(hours>=23 && minutes>=10 && minutes <=59){
											        //POP
											        //PTY
											        //	R06
											        //	REH
											        //	S06
											        //	SKY
											        //	T3H
											        //	TMN
											        //	UUU
											        //	VEC
											        	//POP,PTY,R06,REH,S06,SKY,T3H,TMN,UUU//생략,VEC


												    	URU1.innerHTML = "강수확률 : "+WE1 +"%";

												    	if(WE2=="0") URU2.innerHTML = "강수형태 : 맑음";
												    	if(WE2=="1") URU2.innerHTML = "강수형태 : 비가 내리니 우산들고가세요~";
												    	if(WE2=="2") URU2.innerHTML = "강수형태 : 비와눈이 같이 내려요~우산 필수";
												    	if(WE2=="3") URU2.innerHTML = "강수형태 : 눈이 내려요~따뜻하게 준비하고 가세요~";
												    	if(WE2=="4") URU2.innerHTML = "강수형태 : 소나기 올 가능성이 높아요~우산 챙기세요~";
												    	if(WE2=="5") URU2.innerHTML = "강수형태 : 빗방울이 떨어지겠네요~우산을 준비하시길 바래요~";
												    	if(WE2=="6") URU2.innerHTML = "강수형태 : 빗방울과 눈날림이 있네요~따뜻한 옷차림과 우산을 준비하시길 바래요~";
												    	if(WE2=="7") URU2.innerHTML = "강수형태 : 진눈개비가 날리네요~따뜻한 옷과 우산은 필수~";
												    	if(WE2=="8") URU2.innerHTML = "강수형태 : 눈이 많이 날리네요~따뜻하게 입고 가세요~";

														var WE03 = parseFloat(WE3);
												    	if(WE03<0.1) URU3.innerHTML = "강수량 : "+WE3 +"! 비 소식이 매우매우 적어요~";	 
												    	if(WE03>0.1 && WE03<1) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=5 && WE03<10) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=10 && WE03<20) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=20 && WE03<40) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=40 && WE03<70) URU3.innerHTML = "강수량 : "+WE3+"mm";
												    	if(WE03>=70) URU3.innerHTML = "강수량 : "+WE3+"많은 비가 예상되니 우산은 필수입니다~";
											            
												    	URU4.innerHTML = "습도 : "+WE4+"%";

												    	var WE05 = parseFloat(WE5);
												    	if(WE05<0.1) URU5.innerHTML = "적설량 : "+WE5 +"! 눈 소식이 매우매우 적어요~";	 
												    	if(WE05>0.1 && WE05<1) URU5.innerHTML = "적설량 : "+WE5 +"cm";
												    	if(WE05>=1 && WE05<5) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=5 && WE05<10) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=10 && WE05<20) URU5.innerHTML = "적설량 : "+WE5+"cm";
												    	if(WE05>=20) URU5.innerHTML = "적설량 : "+WE5+"cm";

												    	 var sky = parseInt(WE6);
												    	 if(sky>=0 && sky<=5) URU6.innerHTML = "맑은 날씨~가벼운 야외활동을 추천합니다:)";
												    	 if(sky>=6 && sky<=8) URU6.innerHTML = "구름이 많아요~가벼운 우산을 챙기는건 어떨까요? :>";
												    	 if(sky>=9 && sky<=10) URU6.innerHTML = "흐린 날씨~혹시 모르니 튼튼한 우산을 챙기세요! :]";
												    												    	
												    	 URU7.innerHTML = "(3시간 로테이션)기온 : "+WE7+"℃ ";
												    	 URU8.innerHTML = "아침 최저 기온 : "+WE8+"℃ ";

														//9는 UUU(동서 풍향,풍량 ) 이라 생략
												    
												    	 var veca = parseInt(WE10);
												    	 if(veca >=0 && veca <45){
												    	 	URU10.innerHTML = "북~북동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=45 && veca <90){
												    		 URU10.innerHTML = "북동~동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=90 && veca <135){
												    		 URU10.innerHTML = "동~남동쪽에서 바람이 부네요~";
												    	 }
												    	 else if(veca >=135 && veca <180) {
												    		 URU10.innerHTML = "남동~-남쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=180 && veca <225) {
												    		 URU10.innerHTML = "남~남서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=225 && veca <270) {
												    		 URU10.innerHTML = "남서~서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=270 && veca <315) {
												    		 URU10.innerHTML = "서~북서쪽에서 바람이 부네요~";
												    	 }	
												    	 else if(veca >=315 && veca <360) {
												    	 	URU10.innerHTML = "북서~북쪽에서 바람이 부네요~";
												    	 }
										  			
										        	}
												
											 
								console.log(" "+WE1+" "+WE2+" "+WE3+" "+WE4+" "+WE5+" "+WE6+" "+WE7+" "+WE8+" "+WE9+" "+WE10+" ");


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