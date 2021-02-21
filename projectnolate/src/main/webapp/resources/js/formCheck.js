
$(function(){
	$('.join_input_id > input, .search_input_id > input').blur(function(){
		var checkstr = $(this).val();
		var regExp = /^.*(?=^.{6,12}$)(?=.*\d)(?=.*[a-zA-Z]).*$/
 
		if(checkstr.length != 0){
			if(!regExp.test(checkstr)){
				//alert("6~12자리의 영문, 숫자만 사용 가능합니다.");
				$('.join_input_id > .error_box, .search_input_id > .error_box').text('6~12자리의 영문, 숫자만 사용 가능합니다.');
				
			}
			else{
				$('.join_input_id > .error_box, .search_input_id > .error_box').text('');
			}
		}
		else{
			$('.join_input_id > .error_box, .search_input_id > .error_box').text('아이디를 입력해주세요');
		}
		submitEnable();
	});
	
	$('.join_input_password > input, .update_input_password > input, .check_input_password > input').blur(function(){
		var checkstr = $(this).val();
		var regExp = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		if(checkstr.length != 0){
			if(!regExp.test(checkstr)){
				$('.join_input_password > .error_box, .update_input_password > .error_box, .check_input_password > .error_box').text('비밀번호는 8~16자리의 영문, 숫자, 특수문자의 조합이어야 합니다.');
			}
			else{
				$('.join_input_password > .error_box, .update_input_password > .error_box, .check_input_password > .error_box').text('');
			}
		}
		else{
			$('.join_input_password > .error_box, .update_input_password > .error_box, .check_input_password > .error_box').text('비밀번호를 입력해주세요');
		}
		submitEnable();
	});
	
	$('.join_confirm_password > input, .update_confirm_password > input').blur(function(){
		var checkstr = $(this).val();
		//if(($('.join_input_password > input, .update_confirm_password > input').val().indexOf(checkstr)) != 0){
		if(($('.join_input_password > input, .update_input_password > input').val() == checkstr)){	
			$('.join_confirm_password > .error_box, .update_confirm_password > .error_box').text('');
		}
		else{
			$('.join_confirm_password > .error_box, .update_confirm_password > .error_box').text('비밀번호가 일치하지 않습니다. 다시 입력해주세요');
		}
		submitEnable();
	});
	
	$('.join_input_email > input, .search_input_email > input, .update_input_email > input').blur(function(){
		var checkstr = $(this).val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(checkstr.length != 0){
			if(!regExp.test(checkstr)){
				$('.join_input_email > .error_box, .search_input_email > .error_box, .update_input_email > .error_box').text('이메일 양식을 정확히 입력해주세요.');
			}
			else{
				$('.join_input_email > .error_box, .search_input_email > .error_box, .update_input_email > .error_box').text('');
			}
		}
		else{
			$('.join_input_email > .error_box, .search_input_email > .error_box, .update_input_email > .error_box').text('이메일을 입력해주세요');
		}
		submitEnable();
	});
	
	$('.join_input_birthday > .year, .update_input_birthday > .year').blur(function(){
		var checkYear = $(this).val();
		var date = new Date();
		if(checkYear < date.getFullYear() - 100){
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('아직도 살아계십니까?');
		}
		else if(checkYear > date.getFullYear()){
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('미래에서 오셨습니까?');
		}
		else{
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('');
		}
		submitEnable();
	});
	
	$('.join_input_birthday > .day, .update_input_birthday > .day').blur(function(){
		var year = $('.join_input_birthday > .year, .update_input_birthday > .year').val();
		var month = $('.join_input_birthday > .month, .update_input_birthday > .month').val();
		var day = $('.join_input_birthday > .day, .join_input_birthday > .day').val();
		var inputDate = new Date(year, month, day);
		var todayDate = new Date();
		
		if(year.length == 0 && day.length == 0){
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('');
			submitEnable();
			return;
		}
		else if(!(day < 1 || day > 31)){
			if(month == 2){
				switch (parseInt(day)) {
					case 29:
					case 30:						
					case 31:
						$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('잘못된 날짜를 입력하였습니다.');
						submitEnable();
						return;
				}
				$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('');
				submitEnable();
				return;
			}
			switch (parseInt(month)) {
				case 4:
				case 6:
				case 9:
				case 11:{	
					if(day == 31){
						$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('잘못된 날짜를 입력하였습니다.');
						submitEnable();
						return;
					}
				}
			}
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('');
			submitEnable();
		}
		else{
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('잘못된 날짜를 입력하였습니다.');
			submitEnable();
			return;
		}
		
		
		if(year < todayDate.getFullYear() - 100){
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('아직도 살아계십니까?');
			submitEnable();
			return;
		}
		else if(inputDate.getTime() > todayDate.getTime()){
			$('.join_input_birthday > .error_box, .update_input_birthday > .error_box').text('미래에서 오셨습니까?');
			submitEnable();
		}
		
	});
	
});

function inputHomeAddress(){
	new daum.Postcode({
		oncomplete: function(data){
			$('.join_home_address > .address, .update_home_address > .address').val(data.roadAddress);
		}
	}).open();
}

function inputCompanyAddress(){
	new daum.Postcode({
		oncomplete: function(data){
			$('.join_company_address > .address, .update_company_address > .address').val(data.roadAddress);
		}
	}).open();
}

function submitEnable(){
	var idError = $('.join_input_id > .error_box').text();
	var passError = $('.join_input_password > .error_box').text();
	var confirmError = $('.join_confirm_password > .error_box').text();
	var emailError = $('.join_input_email > .error_box').text();
	var birthError = $('.join_input_birthday > .error_box').text();
	
	if(idError == '' && passError == '' && 
	confirmError == '' && emailError == '' && birthError == ''){
		if($('.join_input_id > input').val().length != 0 && $('.join_input_password > input').val().length != 0 &&
		$('.join_confirm_password > input').val().length != 0 && $('.join_input_email > input').val().length != 0){
			$(".join_btn_area > input[type='submit']").removeAttr('disabled');
		}
		else
			$(".join_btn_area > input[type='submit']").attr('disabled', 'disabled');
	}
	else
		$(".join_btn_area > input[type='submit']").attr('disabled', 'disabled');
}




