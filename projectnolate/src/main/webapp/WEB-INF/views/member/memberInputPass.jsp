<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 입력</title>
		<script type="text/javascript" src="resources/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script type="text/javascript" src="resources/js/formCheck.js"></script>
		<script type="text/javascript" src="resources/js/ajaxCheck.js"></script>
		<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/memberInputPass.css">
	</head>
	<body class="inputPassBody">
		<div class="container">
			<form class="check_pass_form" action="sucessConfirm" method="post">
				<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
				<div class="check_input_password">
					<h2>비밀번호를 입력하세요</h2>
					<label for="pass">비밀번호</label>
					<span class="error_box"><!-- 8~16자리의 영문, 숫자, 특수문자를 모두 포함해서 입력하세요. --></span>
					<input type="password" name="pass" class="form-control" placeholder="비밀번호 입력">
				</div>
				<div class="check_btn_area">
					<!-- <input type="button" value="확인"> -->
					<button class="btn btn-primary">확인</button>
					<!-- <input type="reset" class="btn btn-primary" value="취소" onclick="location.href='/projectnolate/main'"> -->
					<input type="reset" class="btn btn-primary" value="취소" onclick="location.href='main'">
				</div>
			</form>
		</div>
	</body>
</html>