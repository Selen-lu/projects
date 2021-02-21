<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>아이디/비밀번호 찾기</title>
		<script type="text/javascript" src="resources/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="resources/js/formCheck.js"></script>
		<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/memberSearch.css">
	</head>
	<body class="searchBody">
		<div class="container">
			<form class="search_id_form"name="search_id_form" method="post" action="searchID">
				<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
				<h2>아이디 찾기</h2>
				<div class="search_input_email">
					<label for="input_email">이메일 입력</label>
					<span class="error_box"><!-- 이메일 주소를 정확히 입력해주세요 --></span>
					<input type="text" name="email" class="form-control">
				</div>
				<input type="submit" class = "btn btn-primary" value="확인">
			</form>
		</div>
		<div class="container">
			<form class="search_pass_form" name="search_pass_form" method="post" action="searchPass">
				<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
				<h2>비밀번호 찾기</h2>
				<div class="search_input_id">
					<label for="input_id">아이디 입력</label>
					<span class="error_box"><!-- 6~12자리의 영문, 숫자만 사용 가능합니다. --></span>
					<input type="text" name="id" class="form-control">
				</div>
				<div class="search_input_email">
					<label for="input_email">이메일 입력</label>
					<span class="error_box"><!-- 이메일 주소를 정확히 입력해주세요 --></span>
					<input type="text" name="email" class="form-control">
				</div>
				<input type="submit" value="확인" class = "btn btn-primary">
				<input type="button" class = "btn btn-primary" value="취소" onclick='location.href="signIn"'>
			</form>
		</div>
	</body>
</html>