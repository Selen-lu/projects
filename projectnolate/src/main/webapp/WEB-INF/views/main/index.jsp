<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Insert title here</title>
	<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	 
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	
	
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="resources/bootCSS/bootstrap.min.css">
	
	
	<link type="text/css" href="resources/css/headMenu.css" rel="stylesheet">
	<link type="text/css" href= "resources/css/kakao.css" rel= "stylesheet" />
	<link type="text/css" href= "resources/css/mark.css" rel= "stylesheet"/>
	<link type="text/css" href="resources/css/global.css" rel="stylesheet" />
	<link type="text/css" href="resources/css/board.css" rel="stylesheet" /> 
	<link type="text/css" href="resources/css/mapp.css" rel="stylesheet" />	
	<link type="text/css" href="resources/css/starluck.css" rel="stylesheet" />
	<link type="text/css" href="resources/css/CovidCss.css" rel="stylesheet"/>
	<link type="text/css" href="resources/css/starluck.css" rel="stylesheet"/>
	<link type="text/css" href="resources/css/calender.css" rel="stylesheet"/>
	<link type="text/css" href="resources/css/index.css" rel="stylesheet"/>
	
</head>

<!-- <body onload="initTmap()"> -->

<body class="indexBody">
	<%@ include file="headMenu.jsp" %>
	
	<jsp:include page="${ param.body }"/>
</body>
</html>