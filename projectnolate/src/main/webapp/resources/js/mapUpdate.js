// DOM(Document Object Model)이 준비 되었다면
$(document).ready(function() {
		
	/* 댓글 수정 버튼이 클릭되면
	 * 댓글을 쓰고 나면 동적으로 요소를 생성하기 때문에 live 방식으로 이벤트를 등록해야
	 * 한다. 만약 $(".modifyReply").click(function() {}); 형식으로 이벤트를 
	 * 등록했다면 새로운 댓글을 등록한 후에는 클릭 이벤트 처리가 되지 않는다.
	 **/
	$(document).on("click", ".modifyMap", function() {	
		
		// 현재 수정하기가 클릭된 부모 요소의 다음 형제 요소를 구한다.
		//var $next = $(this).parent().next();
		var $next = $(this).parent().prev();
		
		/* 현재 수정하기가 클릭된 부모 요소의 다음 형제 요소의 두 번째 자식은
		 * 댓글 쓰기 수정 폼이 된다. 그러므로 댓글 수정 폼이 있는 곳은 이미 폼이
		 * 존재하기 때문에 추가 작업을 할 필요가 없고 댓글 쓰기 폼이 없는 곳에만
		 * 댓글 쓰기 폼을 가져와 그 위치에 추가하는 작업을 해야 한다.
		 **/		
		if($($next.children()[1]).attr("id") == undefined) {
		
			/* 아래와 같이 jQuery의 is() 메서드를 이용해 화면에 보이는
			 * 상태인지 보이지 않는 상태인지를 체크할 수 있다. 그리고 length
			 * 속성으로 지정한 요소가 문서에 존재하는지 여부를 체크할 수 있다.
			 **/
			console.log(".modifyMap click : visible - " 
					+ $("#replyForm").is(":visible")
					+ ", hidden - " + $("#mapForm").is(":hidden")
					+ ", length - " + $("#mapForm").length);
			
			/* 부모 요소의 다음 형제 요소의 첫 번째 자식 요소의 text를 구한다.
			 * <pre> 태그로 감싼 <span> 태그에 표시한 댓글의 내용을 구한다.
			 * text() 메서드는 현재 선택된 요소의 모든 하위 요소에 표시된 텍스트를
			 * 반환하는데 <pre> 태그 안에 하나의 <span>만 존재하기 때문에
			 * 댓글 내용만 읽어 올 수 있다.
			 **/	
			
			var reply = $($next.children()[0]).first().text();			
			var reply_e =$($next.children()[1]).last().text();	
			if($("#mapForm").css("display") == 'block') {
				$("#mapForm").slideUp(300);
			}
			setTimeout(function() {				
				$(".maps_tx").val($.trim(reply));
				$(".mape_tx").val($.trim(reply_e));
				$("#mapForm").appendTo($next)
					.slideDown(300);
			}, 300);
			$("#mapForm").find("form")
				.attr({"id": "mapUpdateForm", "data-no": $(this).attr("data-no") });
			
		}	//if-끝	
		// 앵커 태그의 기본 기능인 링크로 연결되는 것을 취소한다.
		return false;
	});
		
	/* 댓글 수정 폼이 submit 될 때
	 * 최초 한 번은 완성된 html 문서가 화면에 출력되지만 댓글 쓰기를 한 번
	 * 이상하게 되면 ajax 통신을 통해 받은 데이터를 이전 화면과 동일하게
	 * 출력하기 위해 동적으로 요소를 생성하기 때문에 live 방식의 이벤트
	 * 처리가 필요하다. 댓글 쓰기와 수정하기 폼을 하나로 사용하기 때문에
	 * 댓글 수정 또는 쓰기 후에 댓글 쓰기가 제대로 동작하지 않을 수 있다.
	 **/
	$(document).on("click", ".map_update", function() {	
	//$(document).on("submit", "#replyUpdateForm", function() {	
		//$(".map_update").on("click", function() {
		
		//var no = $(this).attr("data-no");
		
		var no = $("#mapUpdateForm").attr("data-no");
		
		var map_s =$(".maps_tx").val();
		var map_e =$(".mape_tx").val();
		
		$(".noUp").val(no);
		$(".mapsUp").val(map_s);
		$(".mapeUp").val(map_e);
		
		$("#mapUpdateForm").attr("action", "mapUpdateForm");
					$("#mapUpdateForm").attr("method", "post");
					$("#mapUpdateForm").submit();
		
	});
});
