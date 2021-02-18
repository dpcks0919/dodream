<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<link href="/css/register.css" rel="stylesheet" /> 

<style>
body {
	background-color: rgb(175, 218, 231);
}
</style>
</head>

<body id="page-top">
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>


	<div id="Wrapper">
		<!-- Navigation-->
		<%@include file="../layout/navbar_join.jsp"%>


		<section class="page-section text-white text-center" id="contact">
			<div class="container d-flex flex-column">
				<div class="flex-center">
					<div class="input-column">
						<div class="input-info">
							<h4>단체가입</h4>
							<p>
								회원가입 하시면, 주변 이웃들의 필요가 나타날 때마다<br>알림을 받으실 수 있습니다!
							</p>
						</div>
						<div class="input-card">
							<div style="text-align: left;">
								<form method="post" name="regForm" action="">
									<input type="hidden" id="type" value="GROUP">
									<div class="input-content">
										<span class="input-title">아이디</span><span>&nbsp;<em>*</em></span><br>
										<div class="flex-center">
											<div style="width: calc(100% - 60px);">
												<input class="text-input" type="text" name="userid" placeholder="아이디 입력" id="userid">
											</div>
											<div class="input-check" id="btn-id-check">중복 확인</div>
										</div>
									</div>
									<div class="input-content">
										<span class="input-title">비밀번호</span><span>&nbsp;<em>*</em></span><br> <input class="text-input" type="password" name="userpw" placeholder="비밀번호 입력" id="userpw">
									</div>
									<div class="input-content">
										<span class="input-title">비밀번호 확인</span><span>&nbsp;<em>*</em></span><br> <input class="text-input" type="password" name="userpwchk" placeholder="비밀번호 입력" id="userpwchk">
									</div>
									<div class="divider-custom">
										<div class="divider-custom-line"></div>
										<div style="color: #e95378;">
											<h4>단체정보</h4>
										</div>
										<div class="divider-custom-line"></div>
									</div>
									<div class="input-content">
										<span class="input-title">단체명</span><span>&nbsp;<em>*</em></span><br> <input class="text-input" type="text" name="username" id="username" placeholder="이름 입력">
									</div>
									<div class="input-content">
										<span class="input-title">대표 이메일주소</span><span>&nbsp;<em>*</em></span><br> <input class="text-input" type="email" name="usermail" id="useremail" placeholder="이메일주소 입력"> <span
											class="extra-info">주변 이웃들의 필요를 메일로 받으실 수 있습니다. <br>메일 수신 동의&nbsp;&nbsp; <span> <label><input type="radio" name="mail_rcv" value="1" id="mail_rcv" checked>
													예</label>&nbsp;&nbsp; <label><input type="radio" name="mail_rcv" value="0" id="mail_rcv"> 아니요</label>
										</span></span>
									</div>
									<div class="input-content">
										<span class="input-title">대표 전화번호</span><span>&nbsp;<em>*</em></span><br>
										<div class="flex-center">
											<div id="sms_confirm" style="width: calc(100% - 50px);">
												<input class="text-input" type="text" name="userphone" id="userphone" placeholder="전화번호 입력">
											</div>
											<div class="input-check" id="btn-send-text" style="width: 50px;">인증</div>
										</div>
										<div style="height: 5px;"></div>
										<div class="flex-center">
											<div id="sms_check" style="width: calc(100% - 50px);">
												<input class="text-input" type="text" name="verify-input" id="verify-input" placeholder="코드입력(30초)">
											</div>
											<div class="input-check" id="btn-code-verify" style="width: 50px;">확인</div>
										</div>
										<div class="extra-info timer-info" id="smstimer"></div>
										<span class="extra-info"> 주변 이웃들의 필요를 문자로 받으실 수 있습니다. <br>SMS 수신 동의&nbsp;&nbsp; <span> <label><input type="radio" name="sms_rcv" value="1" id="sms_rcv" checked>
													예</label>&nbsp;&nbsp; <label><input type="radio" name="sms_rcv" value="0" id="sms_rcv"> 아니요</label>
										</span></span>
									</div>
									<div class="input-content">
										<span class="input-title">단체 도로명주소</span><span>&nbsp;<em>*</em></span><br>
										<div class="flex-center">
											<div style="width: calc(100% - 50px);">
												<input class="text-input" type="text" name="roadAddrPart1" id="roadAddrPart1" placeholder="도로명 주소 입력" disabled>
											</div>
											<div class="input-check" onclick="goPopup();" id="btn-addr-search" style="width: 50px;">검색</div>
										</div>
										<div style="height: 5px;"></div>
										<input class="text-input" type="text" name="addrDetail" id="addrDetail" placeholder="상세주소 입력"> <span class="extra-info">반경 내의 소식들을 확인할 수 있습니다.</span> <br>
										<span class="extra-info"> 알림 반경 : <select class="select-radius" id="selectradius"></select> <input type="hidden" name="radius" id="notification_radius">&nbsp;km
										</span>
									</div>
								</form>
								<button id="btn-save" class="sign-submit">가입하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="../layout/sidebar_back.jsp"%>
	<%@include file="../layout/jsFile.jsp"%>
	<%@include file="../layout/kakaoMap.jsp"%>
	<script type="text/javascript" src="/js/join.js"></script>
</body>
</html>
