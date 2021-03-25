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
					<h4>정보 수정</h4>
				</div>
			</div>
		</header>
		<section class="page-section-join" id="join">
			<div class="flex-center">
				<div class="find-container">
					<div style="height: 2rem;"></div>
					<div class="find-input">
						<form method="post">
							<div class="input-content">
								<span class="input-title">현재 비밀번호 입력</span><br> 
								<input class="text-input" type="password" name="userpw" id="password" onkeydown="enterkey();" placeholder="비밀번호 입력">
							</div>
							<c:choose>
								<c:when test="${userType eq 'INDIVIDUAL'}">
									<input type="hidden" value="indi" id="info_type">
								</c:when>
								<c:when test="${userType eq 'GROUP'}">
									<input type="hidden" value="group" id="info_type">
								</c:when>
								<c:when test="${userType eq 'SOCIAL_WORKER'}">
									<input type="hidden" value="worker" id="info_type">
								</c:when>
								<c:when test="${userType eq 'INSTITUTION'}">
									<input type="hidden" value="org" id="info_type">
								</c:when>
							</c:choose>
						</form>
						<button id="btn-check" type="submit" class="sign-submit" style="margin-top: 1rem;">확인</button>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="../layout/sidebar_back.jsp"%>
	<%@include file="../layout/jsFile.jsp"%>
	<script src="/js/my.js"></script>
	<script>
		function enterkey() {
	        if (window.event.keyCode == 13) {
	        	myInit.passwordCheck();
				event.preventDefault();
	        } 
		}
	</script>
</body>
</html>