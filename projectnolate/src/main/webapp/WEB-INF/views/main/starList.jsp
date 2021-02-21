<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<article>
<form name="lucks" id="lucks">
<input type="hidden" id="rTitle" name="title" value="${Star.title }"/>
<input type="hidden" class = "token" name="${_csrf.parameterName }" data-token-name="${_csrf.headerName}" value="${_csrf.token }">
</form>
	<script type="text/javascript" src="resources/js/starformcheck.js"></script>
	<ul class="table">
		<li class="table_row">			
			<div class="table_cell th"><img class="starImage" src="./resources/images/Aquarius.JPG" ></div>
			<div class="table_cell th"><img class="starImage" src="./resources/images/Pisces.JPG" ></div>
			<div class="table_cell th"><img class="starImage" src="./resources/images/Aries.JPG" ></div>
			<div class="table_cell th"><img class="starImage" src="./resources/images/Taurus.JPG"></div>
			<div class="table_cell th"><img class="starImage" src="./resources/images/Gemini.JPG" ></div>
			<div class="table_cell th"><img class="starImage" src="./resources/images/Cancer.JPG" ></div>
		</li>
		<li class="table_row">			
			<div class="table_cell"><input type="button" value="[물병자리 1.20 ~ 2.18]" id="Aquarius" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[물고기자리 2.19 ~ 3.20]" id="Pisces" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[양자리 3.21 ~ 4.19]" id="Aries" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[황소자리 4.20 ~ 5.20]" id="Taurus" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[쌍둥이자리 5.21 ~ 6.21]" id="Gemini" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[게자리 6.22 ~ 7.22]" id="Cancer" class="starbtn"/></div>
		</li>
		<li class="table_row">			
			<div class="table_cell th"><img src="./resources/images/Leo.JPG" class="starImage"></div>
			<div class="table_cell th"><img src="./resources/images/Virgo.JPG"class="starImage"></div>
			<div class="table_cell th"><img src="./resources/images/Libra.JPG" class="starImage"></div>
			<div class="table_cell th"><img src="./resources/images/Scorpio.JPG" class="starImage"></div>
			<div class="table_cell th"><img src="./resources/images/Sagittarius.JPG" class="starImage"></div>
			<div class="table_cell th"><img src="./resources/images/Capricorn.JPG" class="starImage"></div>
			
		</li>
		<li class="table_row">			
			<div class="table_cell"><input type="button" value="[사자자리 7.23 ~ 8.22]" id="Leo" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[처녀자리 8.23 ~ 9.22]" id="Virgo" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[천칭자리 9.23 ~ 10.23]" id="Libra" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[전갈자리 10.24 ~ 11.22]" id="Scorpio" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[사수자리 11.23 ~ 12.21]" id="Sagittarius" class="starbtn"/></div>
			<div class="table_cell"><input type="button" value="[염소자리 12.22 ~ 1.19]" id="Capricorn" class="starbtn"/></div>
		</li>
	</ul>
	<ul class="table">
		<li class="table_row">
			<div class="table_cell th" id="readContent">
			
			</div>
		</li>
	</ul>
</article>
