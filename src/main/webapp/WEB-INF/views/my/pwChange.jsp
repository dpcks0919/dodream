<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<link href="/css/register.css" rel="stylesheet" />

</head>

<body id="page-top">
	<!-- Navigation-->
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<%@include file="../layout/navbar.jsp"%>

		<!-- Masthead-->
		<header class="bg-primary text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info-small">
					<h4>비밀번호 변경</h4>
				</div>
			</div>
		</header>
		<section class="page-section-join" id="join">
			<div class="flex-center">
				<div class="find-container">
					<div style="height: 2rem;"></div>
					<div class="find-input">
						<form method="post" action="">
							<div class="input-content">
								<span class="input-title">새 비밀번호 </span><br> <input class="text-input" type="password" name="userpw" id="userpw" placeholder="비밀번호 입력">
							</div>
							<div class="input-content">
								<span class="input-title">비밀번호 확인 </span><br> <input class="text-input" type="password" name="userpwchk" id="userpwchk" placeholder="비밀번호 입력">
							</div>
						</form>
						<button id="btn-change" class="sign-submit" style="margin-top: 1rem;">변경하기</button>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="../layout/sidebar_back.jsp"%>
	<%@include file="../layout/jsFile.jsp"%>
	<script src="/js/my.js"></script>
</body>
</html>