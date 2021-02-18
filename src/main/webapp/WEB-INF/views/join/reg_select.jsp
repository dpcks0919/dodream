<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<link href="/css/register.css" rel="stylesheet" />

</head>

<body id="page-top">
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>


	<div id="Wrapper">
		<!-- Navigation-->
		<%@include file="../layout/navbar_join.jsp"%>

		<!-- Masthead-->
		<header class="bg-primary text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>회원가입</h4>
					<p>
						회원가입 하시면, 주변 이웃들의 필요가 나타날 때마다<br> 알림을 받으실 수 있습니다!
					</p>
				</div>
			</div>
		</header>
		<section class="page-section-join" id="join">
			<div class="flex-center">
				<div class="flex-column" style="width: 400px; padding: 30px;">
					<div class="sns-card" onclick="document.location.href='/joinFormMain'">
						<div class="sns-logo" style="background-image: url('/image/Logo2.png');">로고</div>
						<div class="sns-title">이메일로 회원가입</div>
					</div>
					<div class="sns-card" onclick="document.location.href='/oauth2/authorization/kakao'">
						<div class="sns-logo" style="background-image: url('/image/kakaologo.png');">로고</div>
						<div class="sns-title">카카오톡으로 회원가입</div>
					</div>
					<div class="sns-card" onclick="document.location.href='/oauth2/authorization/naver'">
						<div class="sns-logo" style="background-image: url('/image/naverlogo.png');">로고</div>
						<div class="sns-title">네이버로 회원가입</div>
					</div>
					<div class="sns-card" onclick="document.location.href='/oauth2/authorization/facebook'">
						<div class="sns-logo" style="background-image: url('/image/facelogo.png');">로고</div>
						<div class="sns-title">페이스북으로 회원가입</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="../layout/sidebar_back.jsp"%>
	<%@include file="../layout/jsFile.jsp"%>
</body>
</html>
