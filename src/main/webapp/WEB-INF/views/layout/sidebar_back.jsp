<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<div id="mySidebar2" class="sidebar2">
	<h1 style="font-size: 8rem !important; position: relative; left: 50%; transform: translateX(-50%);">
		<i class="fa fa-user" aria-hidden="true"></i>
	</h1>
	<!-- <span class="login"><a style="font-size:1rem!important; display:inline; padding-right:4vh;">로그인</a>|<a style="font-size:1rem!important; display:inline; padding-left:4vh;">회원가입</a></span> -->


	<c:choose>
		<c:when test="${principal.user.loginCount == 0 || empty principal.user.loginCount}">

			<!-- 로그인안된 버전-->
			<span class="login"> 
			<a href="/loginForm" style="font-size: 1rem !important; display: inline; position: relative; padding: 0; padding-right: 3vh; border-right: 1px solid white;"> 로그인</a> 
			<a href="/joinForm" style="font-size: 1rem !important; display: inline; position: relative; padding: 0; padding-left: 3vh;">회원가입</a>
			</span>

			<div class="logout" style="padding-top: 4%; padding-left: 7%; padding-right: 7%; text-align: left;">
				<a href="mypage/edit_info.html" class="menu-item-top"></a>
			</div>

		</c:when>
		<c:otherwise>
			<!-- 로그인된 버전 -->
			<span class="logout"><a style="font-size: 1rem !important; display: inline; position: relative; left: -1.5%;" href="/logout">로그아웃</a></span>
			<div class="logout" style="padding-top: 4%; padding-left: 7%; padding-right: 7%; text-align: left;">
				<a href="mypage/edit_info.html" class="menu-item-top">개인정보 수정</a> <a href="#" class="menu-item">나의 두드림</a> <a href="#" class="menu-item">응답 내역</a>
			</div>

		</c:otherwise>
	</c:choose>
</div>
