<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top shadow" id="mainNav">
	<div class="container">
		<img src="/image/Logo.png" class="logo" onclick="document.location.href='/'"> 
		<!-- <a class="navbar-brand js-scroll-trigger" href="/user/request">요청 보기</a> <a
			class="navbar-brand js-scroll-trigger" href="#page-top">소식 보기</a> <a class="navbar-brand js-scroll-trigger" href="#page-top">두드림 터치</a> -->
		<!-- 로그인하기 / 가입하기 -->


		<div class="collapse navbar-collapse" id="navbarResponsive">
			<!-- <ul class="navbar-nav ml-auto">
				<li class="nav-item mx-0 mx-lg-1"><a class="py-2 px-0 px-lg-3 rounded js-scroll-trigger nav-link" href="/logout">로그아웃</a></li>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-3 rounded js-scroll-trigger register" href="/user/mypage">내 페이지</a></li>
			</ul> -->
		</div>
	</div>
	<div class="responsive-container">
		<a class="menu-bar" onclick="openMenu()" id="nav-burger"><i class="fa fa-bars" aria-hidden="true"></i></a> <img src="/image/Logo.png" class="logo" id="nav-logo"
			onclick="document.location.href='/'"> <a class="profile" id="nav-profile" onclick="openProfile()"><i class="fa fa-user" aria-hidden="true"></i></a>
	</div>
</nav>
