<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<link href="/css/mypage.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body id="page-top">
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<!-- Navigation-->
		<%@include file="../layout/navbar.jsp"%>


		<header class="text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>마이페이지</h4>
					<p>
						개인 정보를 수정하고<br>응답 내역을 확인할 수 있습니다.
					</p>
				</div>
			</div>
		</header>

		<!-- news Section-->
		<section class="mypage-section2" id="about" style="text-align: center;">
			<div class="container">
				<c:choose>
					<c:when test="${user.userType eq 'INDIVIDUAL' }">
						<div class="section2-box">
							<div class="section2-box-left">
								<span class="section2-text1">내 정보 (개인)</span>
							</div>
							<c:choose>
								<c:when test="${user.isSocial eq 0 }">
									<div class="section2-box-right box-right-two">
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/infoCheck/indi">정보 수정 <i class="fas fa-chevron-right"></i></a></p>
										<div style="height:0.5rem;"></div>
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/pwCheck">비밀번호 변경 <i class="fas fa-chevron-right"></i></a></p>
									</div>
								</c:when>
								<c:when test="${user.isSocial eq 1 }">
									<div class="section2-box-right">
										<a class="section2-text2" href="/user/infoCheck/indi">정보 수정 <i class="fas fa-chevron-right"></i></a>
									</div>
								</c:when>
							</c:choose>
						</div>
					</c:when>
					<c:when test="${user.userType eq 'GROUP' }">
						<div class="section2-box">
							<div class="section2-box-left">
								<span class="section2-text1">내 정보 (단체)</span>
							</div>
							<c:choose>
								<c:when test="${user.isSocial eq 0 }">
									<div class="section2-box-right box-right-two">
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/infoCheck/group">정보 수정 <i class="fas fa-chevron-right"></i></a></p>
										<div style="height:0.5rem;"></div>
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/pwCheck">비밀번호 변경 <i class="fas fa-chevron-right"></i></a></p>
									</div>
								</c:when>
								<c:when test="${user.isSocial eq 1 }">
									<div class="section2-box-right">
										<a class="section2-text2" href="/user/infoCheck/group">정보 수정 <i class="fas fa-chevron-right"></i></a>
									</div>
								</c:when>
							</c:choose>
						</div>
					</c:when>
					<c:when test="${user.userType eq 'SOCIAL_WORKER' }">
						<div class="section2-box">
							<div class="section2-box-left">
								<span class="section2-text1">내 정보 (사회복지사)</span>
							</div>
							<c:choose>
								<c:when test="${user.isSocial eq 0 }">
									<div class="section2-box-right box-right-two">
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/infoCheck/worker">정보 수정 <i class="fas fa-chevron-right"></i></a></p>
										<div style="height:0.5rem;"></div>
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/pwCheck">비밀번호 변경 <i class="fas fa-chevron-right"></i></a></p>
									</div>
								</c:when>
								<c:when test="${user.isSocial eq 1 }">
									<div class="section2-box-right">
										<a class="section2-text2" href="/user/infoCheck/worker">정보 수정 <i class="fas fa-chevron-right"></i></a>
									</div>
								</c:when>
							</c:choose>
						</div>
					</c:when>
					<c:when test="${user.userType eq 'INSTITUTION' }">
						<div class="section2-box">
							<div class="section2-box-left">
								<span class="section2-text1">내 정보 (기관)</span>
							</div>
							<c:choose>
								<c:when test="${user.isSocial eq 0 }">
									<div class="section2-box-right box-right-two">
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/infoCheck/org">정보 수정 <i class="fas fa-chevron-right"></i></a></p>
										<div style="height:0.5rem;"></div>
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/pwCheck">비밀번호 변경 <i class="fas fa-chevron-right"></i></a></p>
									</div>
								</c:when>
								<c:when test="${user.isSocial eq 1 }">
									<div class="section2-box-right">
										<a class="section2-text2" href="/user/infoCheck/org">정보 수정 <i class="fas fa-chevron-right"></i></a>
									</div>
								</c:when>
							</c:choose>
						</div>
					</c:when>
					<c:when test="${user.userType eq 'ADMIN' }">
						<div class="section2-box">
							<div class="section2-box-left">
								<span class="section2-text1">내 정보 (관리자)</span>
							</div>
							<c:choose>
								<c:when test="${user.isSocial eq 0 }">
									<div class="section2-box-right box-right-two">
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/infoCheck/org">정보 수정 <i class="fas fa-chevron-right"></i></a></p>
										<div style="height:0.5rem;"></div>
										<p class="section2-text2" style="margin-bottom:0;"><a class="section2-text2" href="/user/pwCheck">비밀번호 변경 <i class="fas fa-chevron-right"></i></a></p>
									</div>
								</c:when>
								<c:when test="${user.isSocial eq 1 }">
									<div class="section2-box-right">
										<a class="section2-text2" href="/user/infoCheck/org">정보 수정 <i class="fas fa-chevron-right"></i></a>
									</div>
								</c:when>
							</c:choose>
						</div>
					</c:when>
				</c:choose>
				
				<!-- 사회복지사가 자기가 요청한 내역을 확인함 -->
				<c:choose>
					<c:when test="${user.userType eq 'SOCIAL_WORKER' || user.userType eq 'INSTITUTION'  }">
						<div class="section2-box">
							<div class="section2-box-left">
								<span class="section2-text1">내 요청 내역</span>
							</div>
							<div class="section2-box-right">
								<a class="section2-text2" href="/user/myrequest">더 보기 <i class="fas fa-chevron-right"></i></a>
							</div>
						</div>
					</c:when>
				</c:choose>
				
				<div class="section2-box">
					<div class="section2-box-left">
						<span class="section2-text1">나의 두드림</span>
					</div>
					<div class="section2-box-right">
						<a class="section2-text2" href="/user/mydodream">더 보기 <i class="fas fa-chevron-right"></i></a>
					</div>
				</div>
				<div class="section2-box">
					<!-- <div class="section2-box-left" style="line-height: initial; margin-top: 1.25rem;">
						<p class="section2-text1">응답 내역</p>
						<p class="section2-text2" style="margin-bottom: 0;">새로운 응답 1</p>
						<p class="section2-text2" style="margin-bottom: 0;">지난 응답 10</p>
					</div> -->
					<div class="section2-box-left" >
						<p class="section2-text1">내 응답 내역</p>
					</div>
					<div class="section2-box-right">
						<a class="section2-text2" href="/user/myreply">더 보기 <i class="fas fa-chevron-right"></i></a>
					</div>
				</div>
				
				<c:choose>
					<c:when test="${user.userType eq 'ADMIN' }">
						<div class="section2-box">
							<div class="section2-box-left" >
								<p class="section2-text1">관리자 페이지</p>
							</div>
							<div class="section2-box-right">
								<a class="section2-text2" href="/user/manager">더 보기 <i class="fas fa-chevron-right"></i></a>
							</div>
						</div>
					</c:when>
				</c:choose>
			</div>
		</section>

		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
		<%@include file="../layout/sidebar_back.jsp"%>
		<%@include file="../layout/jsFile.jsp"%>

	</div>
</body>
</html>
