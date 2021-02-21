<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">	
  	 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>회원가입</title>
		<script type="text/javascript" src="resources/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script type="text/javascript" src="resources/js/formCheck.js"></script>
		<script type="text/javascript" src="resources/js/ajaxCheck.js"></script>
		<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/memberJoin.css">
	</head>
	<body class="joinBody">
		<!-- 필수 입력 단 : 아이디, 비밀번호, 비밀번호 확인, email  -->
		<div class="container">
			<form class="join_form" method="post" action="joinMember"> 
				<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
				<div class="required_join_input">
					<h2 class="title">필수입력</h2>
					<div class="join_input_id">
						<label for="id">아이디</label>
						<span class="error_box"><!-- 6~12자리의 영문, 숫자만 사용 가능합니다. --></span>
						<input type="text" name="id" class="form-control">
						<button class = "btn btn-primary">중복확인</button>
					</div>
					<div class="join_input_password">
						<label for="pass">비밀번호</label>
						<span class="error_box"><!-- 8~16자리의 영문, 숫자, 특수문자를 모두 포함해서 입력하세요. --></span>
						<input type="password" name="pass" class="form-control">
					</div>
					<div class="join_confirm_password">
						<label for="confirm_pass">비밀번호 확인</label>
						<span class="error_box"><!-- 입력한 비밀번호와 일치하지 않습니다. 다시 입력해주세요 --></span>
						<input type="password" name="confirm_pass" class="form-control">
					</div>
					<div class="join_input_email">
						<label for="email">email</label>
						<span class="error_box"><!-- 이메일 주소를 정확하게 입력해주세요 --></span>
						<input type="email" name="email" class="form-control">	
					</div>				
				</div>
				<!-- 선택 입력 단 : 생년월일, 자택주소, 회사/학교주소  -->
				<div class="select_input">
					<h2 class="title">선택입력</h2>
					<div class="join_input_birthday form-group">
						<label for="birtyday">생년월일</label>
						<span class="error_box"><!-- 생년월일을 정확히 입력해주세요 --></span>
						<input type="number" name="birth_year" class="year form-control" >
						<select name="birth_month" class="month form-control">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
							<option>6</option>
							<option>7</option>
							<option>8</option>
							<option>9</option>
							<option>10</option>
							<option>11</option>
							<option>12</option>
						</select>
						<input type="number" name="birth_day" class="day form-control">
					</div>
					<div class="join_home_address">
						<label for="home_add">자택 주소</label>
						<input type="button" class = "btn btn-primary" value="주소찾기" onclick="inputHomeAddress()">
						<input type="text" name="home_Address" class="form-control address" readonly="readonly">
					</div>
					<div class="join_company_address">
						<label for="com_add">회사/학교 주소</label>
						<input type="button" class = "btn btn-primary" value="주소찾기" onclick="inputCompanyAddress()">
						<input type="text" name="company_Address" class="form-control address" readonly="readonly">
					</div>
					<div class="join_btn_area">
						<input type="submit" class = "btn btn-primary" value="가입하기" disabled="disabled">
						<input type="reset" class = "btn btn-primary" value="취소하기" onclick='location.href="signIn"'>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>