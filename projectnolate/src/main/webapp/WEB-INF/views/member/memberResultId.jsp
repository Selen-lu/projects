<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>아이디 찾기</title>
	</head>
	<body>
		<c:if test="${not empty idList }">
			<span class="printIdList">
				등록된 ID는 
				<c:forEach var="id" items="${idList }">
					${id}, 
				</c:forEach>
				입니다.
			</span>
		</c:if>
	</body>
</html>