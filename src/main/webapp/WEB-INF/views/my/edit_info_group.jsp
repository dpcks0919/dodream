<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/kakaoMap.jsp"%>
<link href="/css/register.css" rel="stylesheet" />

</head>

<body id="page-top">
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>


	<div id="Wrapper">
		<!-- Navigation-->
		<%@include file="../layout/navbar.jsp"%>

		<!-- Masthead-->
		<header class="text-white text-center response-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>단체정보 수정</h4>
				</div>
			</div>
		</header>
		<section class="page-section text-white text-center" id="contact" style="padding-top: 0;">
			<div class="flex-center">
				<div class="input-card" style="margin-top: -4rem;">
					<div style="text-align: left;">
						<form method="post" name="regForm" action="">
							<div class="divider-custom" style="margin-top: 0">
								<div class="divider-custom-line"></div>
								<div style="color: #e95378;">
									<h4>단체정보</h4>
								</div>
								<div class="divider-custom-line"></div>
							</div>
							<input type="hidden" id="loginId">
							<div class="input-content">
								<span class="input-title">단체명</span><br> <input class="text-input" type="text" name="username" id="username" placeholder="이름 입력" disabled="disabled">
							</div>
							<div class="input-content">
								<span class="input-title">대표 이메일주소</span><span>&nbsp;<em>*</em></span><br> <input class="text-input" type="email" name="usermail" id="useremail" placeholder="이메일주소 입력"> <span
									class="extra-info">주변 이웃들의 필요를 메일로 받으실 수 있습니다. <br>메일 수신 동의&nbsp;&nbsp; <span> <label><input type="radio" name="mail_rcv" value="1" id="mail_rcv" checked> 예</label>&nbsp;&nbsp;
										<label><input type="radio" name="mail_rcv" value="0" id="mail_rcv"> 아니요</label>
								</span></span>
							</div>
							<div class="input-content">
								<span class="input-title">대표 전화번호</span><span>&nbsp;<em>*</em></span><br>
								<div class="flex-center">
									<div id="sms_confirm" style="width: calc(100%);">
										<input class="text-input" type="text" name="userphone" id="userphone" placeholder="전화번호 입력">
									</div>
								</div>
								<div style="height: 5px;"></div>

								<div class="extra-info timer-info" id="smstimer"></div>
								<span class="extra-info"> 주변 이웃들의 필요를 문자로 받으실 수 있습니다. <br>SMS 수신 동의&nbsp;&nbsp; <span> <label><input type="radio" name="sms_rcv" value="1" id="sms_rcv" checked>
											예</label>&nbsp;&nbsp; <label><input type="radio" name="sms_rcv" value="0" id="sms_rcv"> 아니요</label>
								</span></span>
							</div>
							<div class="input-content">
								<span class="input-title">도로명주소</span><span>&nbsp;<em>*</em></span><br>
								<div class="flex-center">
									<div style="width: calc(100% - 50px);">
										<input class="text-input" type="text" name="roadAddrPart1" id="roadAddrPart1" placeholder="도로명 주소 입력" disabled>
									</div>
									<div class="input-check" onclick="goPopup();" id="btn-addr-search" style="width: 50px;">변경</div>
								</div>
								<div style="height: 5px;"></div>
								<input class="text-input" type="text" style="display: none" name="addrDetail" id="addrDetail" placeholder="상세주소 입력"> <span class="extra-info">반경 내의 소식들을 확인할 수 있습니다.</span> <br> <span
									class="extra-info"> 알림 반경 : <select class="select-radius" id="selectradius"></select> <input type="hidden" name="radius" id="notification_radius">&nbsp;km
								</span>
							</div>
						</form>
						<div style="width: 100%;">
							<button id="btn-update" class="sign-submit">수정하기</button>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="../layout/sidebar_back.jsp"%>

	<script>
		$(document).ready(function() {

			
			$('#loginId').val('${user.loginId}');
			$('#username').val('${user.userName}');
		
			
			if( ${user.emailFlag} == 1 ){
				document.regForm.mail_rcv[0].checked = true;
			}else{
				document.regForm.mail_rcv[1].checked = true;
			}
			
			if( ${user.msgFlag} == 1 ){
				document.regForm.sms_rcv[0].checked = true;
			}else{
				document.regForm.sms_rcv[1].checked = true;
			}
			
			$('#useremail').val('${user.userEmail}');
			$('#userphone').val('${user.userPhone}');
			$('#roadAddrPart1').val('${user.address}');
			$('#orgname').val('${user.orgName}');
			$('#userpos').val('${user.orgUserRole}');
			$('#selectradius').val('${user.notificationRadius}');
			/* 사회복지사의 경우 */
			$('#orgphone').val('${user.orgPhone}');
			
		});

	</script>

	<%@include file="../layout/jsFile.jsp"%>

	<script src="/js/modal.js"></script>
	<script src="/js/my.js"></script>

</body>
</html>
