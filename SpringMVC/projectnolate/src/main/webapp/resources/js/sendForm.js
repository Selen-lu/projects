$(function() {

		$("#insert").on("submit", function() {

				if($("#nickname").val().length <= 0) {
					alert("장소명을 입력해 주세요");
					return false;
				}

				//한번 물어봄
				if(!confirm("현재 위치를 저장하시겠습니까?")){ 
					return false;					
				}
	
	});// 저장구문끝


		
	//삭제구문
	$(".deleteForm").on("submit", function() {	
		//한번 물어봄
		if(!confirm("삭제하시겠습니까?")){ // 아니오를 선택하면
			return false;				// 폼이 전송되면 않되고
		}
		// 그냥 놔두면 return true; 이므로 폼은 전송된다.
	});
		
		//수정구문
	$(".updateForm").submit(function() {
	
		var newName = $(this).find(".nickname").val();// .updateForm에 nickname 클래스의 값을 넣고
		
		// 입력이 안되었을 때 체크해서 처리하는 코드 필요		// 한번 체크
		if(newName.length < 2) {	
			alert("변경할 장소 이름을 2자이상 입력해 주세요");
			return false;
		}
		
		var oldName = $(this).prev().find(".listNickName").text().split(" : ")[1]//돔제어 하는법, 
		//c:if 안에 형제 요소인 listUl 의 텍스트 내용(인덱스 1)을 달라고 함.
		// value가 없으므로 , 보통 카카오에서 div로 보내는 값을 이런식으로 받을 수 있다.
		
		if(!confirm(oldName + "를 " + newName + "으로 수정하시겠습니까?")){ // 아니오를 선택하면
			return false;				// 폼이 전송되면 않되고
		}				
		//console.log($(this).prev().find(".listNickName").text().split(" : ")[1]);		
		
	});
		

	// 게시 글 리스트, 검색 결과 페이지에서 검색 요청 처리
	$("#searchForm").on("submit", function() {
		var keyword = $("#keyword").val();
		if(keyword.length <= 0) {
			alert("검색어를 입력하세요");
			return false;
		}		
			$(this).attr("method", "post");
			$(this).attr("action", "markList");	
		});	
	});