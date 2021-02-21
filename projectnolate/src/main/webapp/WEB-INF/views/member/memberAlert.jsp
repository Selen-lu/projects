<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>변경완료</title>
		<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/memberUpdatePass.css">
	</head>
	<body>
		<div class="alert_container container">
			<span class="alertMagase">${alertMesage }</span>
			<button class="btn btn-primary" onclick='location.href="main"'>확인</button>
		</div>
	</body>
</html>