<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 입력</title>
		<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="js/formCheck.js"></script>
		<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/memberUpdatePass.css">
	</head>
	<body class="updatePassBody">
		<div class="container">
			<form class="update_pass_form" action="main/updatePass" method="post">
				<input type="hidden" name="id" value="${id}">
				<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
				<div class="check_input_password">
					<h2>비밀번호를 입력하세요</h2>
					<label for="pass">비밀번호</label>
					<span class="error_box"><!-- 8~16자리의 영문, 숫자, 특수문자를 모두 포함해서 입력하세요. --></span>
					<input type="password" name="pass" class="form-control">
				</div>
				<div class="check_btn_area">
					<input type="submit" class = "btn btn-primary" value="확인">
					<input type="reset" class = "btn btn-primary" value="취소">
				</div>
			</form>
		</div>
	</body>
</html>