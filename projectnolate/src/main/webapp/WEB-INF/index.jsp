<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 게시판 인덱스</title>

<!--	//뷰단의 css 등의 정적리소스와 관련한 url맵핑은
		//appServlet/servlet-context.xml에서 설정
		//<mvc:resources mapping="/resources/**" location="/resources/" /> 
		//css의 위치를 "resources/css/index.css"와 같이 지정해야 한다.
		// src폴더 - webapp -resources 아래 css 폴더 작성   -->


<link rel= "stylesheet" type= "text/css" href= "resources/css/kakao.css" />
<link rel= "stylesheet" type= "text/css" href= "resources/css/mark.css" />
<script src= "resources/js/jquery-3.2.1.min.js"></script>

</head>
<body>

	<%-- <%@ include file ="아마 로그인 창이 될듯한.jsp" %> --%>
	<jsp:include page="${param.body}"/>
	<%-- <%@ include file ="footer 파일.jsp" %> --%>
</body>
</html>