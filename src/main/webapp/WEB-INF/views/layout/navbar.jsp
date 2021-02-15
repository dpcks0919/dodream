<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>


<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top shadow" id="mainNav">
	<div class="container">
		<img src="/image/Logo.png" class="logo" onclick="document.location.href='/'"> <a class="navbar-brand js-scroll-trigger" href="/user/request">요청 보기</a> <a
			class="navbar-brand js-scroll-trigger" href="#page-top">소식 보기</a> <a class="navbar-brand js-scroll-trigger" href="/">두드림 터치</a>
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
		<a class="menu-bar" onclick="openMenu()" id="nav-burger"><i class="fa fa-bars" aria-hidden="true"></i></a> <img src="/image/Logo.png" class="logo" id="nav-logo"
			onclick="document.location.href='main.html'"> <a class="profile" id="nav-profile" onclick="openProfile()"><i class="fa fa-user" aria-hidden="true"></i></a>
	</div>
</nav>

<!-- Bootstrap core JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<!-- Contact form JS-->
<script src="assets/mail/jqBootstrapValidation.js"></script>
<script src="assets/mail/contact_me.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>

