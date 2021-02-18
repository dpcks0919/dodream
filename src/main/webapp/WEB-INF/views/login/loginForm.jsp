<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/login.css" rel="stylesheet" />

</head>

<body id="page-top">
	<!-- Navigation-->
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper" style="height: auto; overflow: visible;">
		<%@include file="../layout/navbar_join.jsp"%>
		<%@include file="../layout/sidebar_back.jsp"%>

		<!-- Masthead-->
		<header class="masthead bg-primary text-white text-center" style="background: linear-gradient(to right, rgb(175, 218, 231), #ed7e95);">
			<div class="container d-flex flex-column login-all">
				<div class="login-wrapper" style="display: flex; width: 100%; margin-top: -3rem; text-align: center; flex-direction: row; justify-content: center;">
					<div class="login-container" style="position: relative; background-color: white; box-shadow: 1px 1px 6px 1px #A6A6A6; color: black; padding: 3rem; height: 100%;">
						<h4 align="left" style="color: #e95378; margin-top: 1.8vh;">로그인</h4>
						<form method="post">
							<div class="idpw-container" style="margin-top: 4vh; color: black;">
								<input class="input-id" type="text" name="userid" placeholder="아이디 입력" style="width: 100%; height: 2.5rem; border: none; border-bottom: 2px solid lightgray;" id="loginid"> <input
									class="input-pw" type="password" name="userpw" placeholder="패스워드 입력" style="width: 100%; height: 2.5rem; border: none; border-bottom: 2px solid lightgray;" id="loginpw"><br>
							</div>
							<div class="checkbox-container">
								<input type="checkbox" id="is-subscription"> <label for="is-subscription">아이디 기억하기</label>
							</div>
							<div class="find-container" style="width: 100%; text-align: right; font-size: 9pt; margin-top: 1vh;">
								<a href="" style="color: black;"><U>아이디/비밀번호 찾기</U></a>
							</div>
							<!--                           <input class="login-submit" type="submit" value="로그인" style="width:100%;padding:6px 1px 6px 1px;background-color:#ed7e95;border:none;border-radius:16px;color:white;font-size:14pt;margin-top:1.5vh;">
 -->
						</form>
						<button id="btn-login" class="login-submit" type="submit"
							style="width: 100%; padding: 6px 1px 6px 1px; background-color: #ed7e95; border: none; border-radius: 16px; color: white; font-size: 14pt; margin-top: 1.5vh;">로그인</button>
						<div class="login-sns" style="margin-top: 5.5vh;">
							<div class="divider-custom">
								<div class="divider-custom-line"></div>
								<div style="font-size: 10pt; color: #CACACA;">간편 로그인</div>
								<div class="divider-custom-line"></div>
							</div>
							<img class="snslgbtn" src="/image/kakao.png" alt="" onclick="javascript:location.href='/oauth2/authorization/kakao'" /> <img class="snslgbtn" src="/image/naver.PNG" alt=""
								onclick="javascript:location.href='/oauth2/authorization/naver'" /> <img class="snslgbtn" src="/image/facebook.png" alt="" onclick="javascript:location.href='/oauth2/authorization/facebook'" />
						</div>
					</div>
					<div class="login-explain" style="height: 100%; text-align: left; padding-left: 4.5rem; padding-top: 22.5vh;">
						<h4>
							주변 이웃의 도움을<br>확인해볼까요?
						</h4>
						<p>먼저 로그인이 필요합니다 :)</p>
						<br>
						<p>아직 가입하지 않으셨습니까?</p>
						<span style="background-color: rgba(255, 255, 255, 0.2); border: 1px solid white; border-radius: 16px; padding: 6px 49px 6px 49px; font-size: 14pt; font-weight: bold; cursor: pointer;"
							onclick="javascript:location.href='/joinForm'">회원가입</span>
					</div>
				</div>
				<!-- <img class="masthead-avatar mb-5" src="assets/img/avataaars.svg" alt="" /> -->
			</div>
		</header>
	</div>
	<%@include file="../layout/jsFile.jsp"%>
	<script type="text/javascript" src="/js/join.js"></script>
</body>
</html>
