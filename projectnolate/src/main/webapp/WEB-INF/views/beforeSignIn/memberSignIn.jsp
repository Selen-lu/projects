<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">	
  	 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>로그인</title>

		<script type="text/javascript" src="resources/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="resources/js/formCheck.js"></script>
		<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/memberSignIn.css">
	</head>
	<body class="loginBody">
		<div class="container">
	      <form class="signin_form" method="post" action="login">
	     	<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
	        <h2 class="form-signin-heading">지각 하지 말아줘</h2>
	        <label for="inputID" class="sr-only">ID입력</label>
	        <input type="text" name = "id" id="inputEmail" class="form-control" placeholder="id 입력" required autofocus>
	        <label for="inputPassword" class="sr-only">Password</label>
	        <input type="password" name = "pass" id="inputPassword" class="form-control" placeholder="비밀번호 입력" required >
	        <div class="checkbox">
	          <label>
	            <input type="checkbox" value="remember-me"> 아이디 저장
	          </label>
	          <label>
	            <input type="checkbox" value="remember-me"> 비밀번호 저장
	          </label>
	        </div>
	        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	        
	      </form>
	      <div class="search_and_join_area">
	      	<a href="search">아이디/비밀번호찾기</a>
	      	<a href="join">회원가입</a>
	      </div>
	   	</div> <!-- /container -->
	</body>
</html>