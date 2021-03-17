<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>


<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top shadow" id="mainNav">
	<div class="container">
		<img src="/image/Logo.png" class="logo" onclick="document.location.href='/'"> 
		<c:choose>
			<c:when test=  "${principal.user.userType eq 'SOCIAL_WORKER' || principal.user.userType eq 'INSTITUTION' }" >
				<a class="navbar-brand js-scroll-trigger" href="/user/request">요청하기</a>
			</c:when>
		</c:choose>
		<a class="navbar-brand js-scroll-trigger" href="/requestMap">요청 보기</a> 
		<a class="navbar-brand js-scroll-trigger" href="/news/newsList">소식 보기</a> 

		<a class="navbar-brand js-scroll-trigger" href="/dodreamtouch">두드림터치</a>
		<!-- 로그인하기 / 가입하기 -->

		<c:choose>
			<c:when test="${principal.user.loginCount == 0 || empty principal.user.loginCount}">
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item mx-0 mx-lg-1"><a class="py-2 px-0 px-lg-3 rounded js-scroll-trigger nav-link" href="/loginForm">로그인하기</a></li>
						<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-3 rounded js-scroll-trigger register" href="/joinForm">가입하기</a></li>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item mx-0 mx-lg-1"><a class="py-2 px-0 px-lg-3 rounded js-scroll-trigger nav-link" href="/logout">로그아웃</a></li>
						<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-3 rounded js-scroll-trigger register" href="/user/mypage">내 페이지</a></li>
					</ul>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="responsive-container">
		<img src="/image/hamburger.png" class="menu-bar" onclick="openMenu()" id="nav-burger"> 
		<img src="/image/Logo.png" class="responsive-logo " id="nav-logo" onclick="document.location.href='/'"> 
		<img src="/image/myinfo.png" class="profile " id="nav-profile" onclick="openProfile()">
	</div>
</nav>

