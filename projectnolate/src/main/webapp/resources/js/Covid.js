
$(function() {

	var csrfHeader = $('.token').data("token-name");
	var csrfToken = $('.token').val();

	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeader, csrfToken);
		}
	})

	var get= $("#getGubun option:selected").val();

	
	var checkRun=false;

	$("#btn1").on("click",function(){
	

	var date=$("#datepicker").val();
		
	var Hdate=$("#date").val(date);
			
	if(date==""){
		alert("날짜를 선택해 주세요");
		$("#datepicker").focus();
		return false;
	}
			
	
	var formData = $("#selectgubun").serialize();
					

	$.ajax({
		type:"POST",
		url:"Covidday",
		data:formData,
		dataType: "json",
		success:function(resData){		
			$("#Covidresult").empty();
			$("#Covidresult").append("<h2>" + $("#gubun").val() + "</h2>");
			$("#Covidresult").append("<p>확진자 : " + resData.defCnt + "</p>");
			$("#Covidresult").append("<p>전일대비 증가 : " + resData.incDec + "</p>");
			$("#Covidresult").append("<p>격리 해제 : " + resData.isolClearCnt + "</p>");
			$("#Covidresult").append("<p>10만명당 감염자 : " + resData.qurRate + "</p>");
			$("#Covidresult").append("<p>사망자 : " + resData.deathCnt + "</p>");
			$("#Covidresult").append("<p>해외 유입 : " + resData.overFlowCnt + "</p>");
			$("#Covidresult").append("<p>지역 감염자 : " + resData.localOccCnt + "</p>");
			$("#Covidresult").append("<p>기준일시 : " + resData.stdDay + "</p>");
							
		},
		error:function(e){
			alert("업데이트 않됨");
		}
	});
		
});
	

	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	
	mapOption = { 
    center: new kakao.maps.LatLng(35.337339, 128.284646), // 지도의 중심좌표
    level: 13 };
    
    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    var x = 37.564214;
    

    
    var positions = [

{
	
    title: '서울', 
    content: '<div id="MapResult">'+'지역:서울'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(37.523537, 127.004577)
},
{
    title: '경남', 
    content: '<div id="MapResult">'+'지역:경남'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(35.437339, 128.284646)
},
{
    title: '경북', 
    content: '<div id="MapResult">'+'지역:경북'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(36.478483, 128.706994)
},
{
    title: '제주',
    content: '<div id="MapResult">'+'지역:제주'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(33.451393, 126.570738)
},
{
    title: '세종',
    content: '<div id="MapResult">'+'지역:세종'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(36.559994, 127.261430)
},
{
    title: '울산',
    content: '<div id="MapResult">'+'지역:울산'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(35.547785, 129.256569)
},
{
    title: '대전',
    content: '<div id="MapResult">'+'지역:대전'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(36.347505, 127.380043)
},
{
    title: '광주',
    content: '<div id="MapResult">'+'지역:광주'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(35.155069, 126.831267)
},
{
    title: '전남',
    content: '<div id="MapResult">'+'지역:전남'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(34.841375, 126.940049)
},
{
    title: '전북',
    content:  '<div id="MapResult">'+'지역:전북'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(35.663368, 127.165892)
},
{
    title: '충남',
    content:'<div id="MapResult">'+'지역:충남'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(36.634371, 126.799267)
} ,  
{
    title: '충북',
    content:  '<div id="MapResult">'+'지역:충북'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(36.947667, 127.683830)
},    
{
    title: '경기',
    content: '<div id="MapResult">'+'지역:경기'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(37.354699, 127.517851)
},
{
    title: '인천',
    content: '<div id="MapResult">'+'지역:인천'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(37.442077, 126.711277)
},
 {
    title: '대구',
    content: '<div id="MapResult">'+'지역:대구'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(35.818109, 128.588395)
},    
{
    title: '부산',
    content: '<div id="MapResult">'+'지역:부산'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(35.185362, 129.079673)
},
{
	title: '강원',
	content: '<div id="MapResult">'+'지역:강원'+'<br>'+'</div>',
    latlng: new kakao.maps.LatLng(37.611063, 128.365740)
}

   
];

for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커의 위치
        title:positions[i].title
    });
    
     // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    }); 
  
	
	
	kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));

    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

    kakao.maps.event.addListener(marker, 'click', mouse(map,marker,event));
}

function mouse(map,marker,event){
	
 return function(){
			
			
		var gubun = marker.getTitle();
		
		var latlng=marker.getPosition();
	
		// 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(latlng.Ha,latlng.Ga);
    
    
    
    // 지도 중심을 이동 시킵니다
    map.setCenter(moveLatLon);
    map.setLevel(10);
		
 
   		
   	  	 
    	
   			 $.ajax({
			type:"post",
			url:"MapCovidAjax?gubun="+gubun,
			data:gubun,
			dataType:"json",
			success:function(resData){
				
				var day= resData.stdDay.substring(0,12)+"일";
				
							
				$("#MapResult").empty();
				$("#MapResult").append("<h4>" +resData.gubun + "</h4>");
				$("#MapResult").append("<div>확진자 : " + resData.defCnt + "</div>");
				$("#MapResult").append("<div>전일대비 증가 : " + resData.incDec + "</div>");
				$("#MapResult").append("<div>격리 해제 : " + resData.isolClearCnt + "</div>");
				$("#MapResult").append("<div>10만명당 감염자 : " + resData.qurRate + "</div>");
				$("#MapResult").append("<div>지역 총 사망자 : " + resData.deathCnt + "</div>");
				$("#MapResult").append("<div>" +day+"</div>");
				$("#MapResult").append("<br/>");
				
				
				
		
				
			},
			error:function(e){
				alert("않됨");
			}
		});//ajax끝
		
		}//function 끝
	}




   
   
   // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
       
       
    };
} 
// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
    	
        infowindow.close();
        
    };
}
		
		var option = {
		// datepicker 애니메이션 타입
		// option 종류 : "show" , "slideDown", "fadeIn", "blind", "bounce", "clip", "drop", "fold", "slide"
		showAnim : "slideDown",
		// 해당 월의 다른 월의 날짜가 보이는 여부, 예를 들면 10월이면 전후에 9월 마지막과 11월의 시작 일이 보이는 여부입니다. 즉, 달력이 꽉 차 보이게 하는 것
		showOtherMonths: true,
	
	
		// 년 월이 셀렉트 박스로 표현 되어서 선택할 수 있다.
		changeMonth: true,
		changeYear: true,
		
		// 데이터 포멧
		dateFormat: "yy-mm-dd",
		// 텍스트 박스 옆의 달력 포시
		showOn: "focus",
		//이미지 타입인지 버튼 타입인지 설정
		//buttonImageOnly: true,
		// 이미지 경로
		//buttonImage: "https://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
		// 버튼 타입이면 버튼 값
		//buttonText: "날짜 선택",
	
		
		minDate: new Date(2020,03,12),
		// 선택 가능한 최대 날짜(문자 형식) - 현재 기준 +1월 +20일
		maxDate: "0D",
		// 주 표시
		showWeek: true
		};




 		//달력 을 만듬 위의 옵션을 가지고
    $( "#datepicker" ).datepicker(option);

 		//그래프 추가
		 $("#btn2").on("click",function(){
			ajaxData();
			
		});
	
	
	function ajaxData(){
			var Chart = $("#Chartgubun").serialize();
		
			var Check = $("input[name=AAA]:checked").val();
			
			
		var requset = $.ajax({
		type:"post",
		url:"Chart",
		data:Chart,
		dataType:"json"
		
		});
	
	requset.done(function(resData){

	google.charts.load('current', {'packages':['line']}); //차트 스타일
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
	var data = new google.visualization.DataTable();
	
	data.addColumn('string', '등록일[day]');
	if(Check=="확진자"){
	data.addColumn('number', '확진자');
	
	resData.forEach(function(val,index){
		data.addRow([val.stdDay.substring(0,13),parseInt(val.defCnt)])
	
	});//forEach 끝
	}else if(Check=="증가"){
	data.addColumn('number', '전일대비 증가');
	
	resData.forEach(function(val,index){
		data.addRow([val.stdDay.substring(0,13),parseInt(val.incDec)])
	
	});//forEach 끝
	
	}
	var options = {
        chart: {
          title: '지역별  그래프'
        },
        width: 785,
        height: 500
      };
      
      var chart = new google.charts.Line(document.getElementById('linechart_material'));

      chart.draw(data, google.charts.Line.convertOptions(options));
	
   }//requset 끝
  });
	
}





    
    
});


