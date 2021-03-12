<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<link href="/css/register.css" rel="stylesheet" />

</head>
<!-- younghwan33 -->
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
					<h4>아이디/비밀번호를 잊어버리셨습니까?</h4>
				</div>
			</div>
		</header>
		<section class="page-section-join" id="join">
			<div class="flex-center">
				<div class="find-container">
					<div class="find-input">
						<form method="post" action="">
							<h4>아이디 잊어버린 경우</h4>
							<p>가입하신 이메일을 입력해주세요.</p>
							<div "email-input" style="height: 100%;">
								<input class="find-email" type="text" name="femail" id="input1-find-id">&nbsp;@ <input class="find-address" id="input2-find-id"" type="text" name="faddr" placeholder="직접입력"> <select class="select-portal"
									id="idselect" name="portal" onchange="selectEmail(this)">
									<option value="">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
								</select>
							</div>
						</form>
						<button class="find-submit" id="btn-find-id">아이디 찾기</button>
					</div>
					<div class="find-input">
						<form method="post" action="">
							<h4>비밀번호 잊어버린 경우</h4>
							<p>가입하신 ID와 이메일을 입력해주세요.</p>
							<div "email-input" style="height: 100%;">
								<input class="find-email" type="text" style="width:100%; margin-bottom:10px;" id="input1-find-pw" placeholder="ID를 입력하세요">
								<input class="find-email" type="text" name="femail" id="input2-find-pw">&nbsp;@ <input class="find-address" id="input3-find-pw" type="text" name="faddr" placeholder="직접입력"> <select class="select-portal"
									id="pwselect" name="portal" onchange="selectEmail(this)">
									<option value="">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
								</select>
							</div>
						</form>
						<button class="find-submit" id="btn-find-password">비밀번호 찾기</button>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="../layout/sidebar_back.jsp"%>
	<%@include file="../layout/jsFile.jsp"%>
	<script src="/js/join.js"></script>
	<script>
		function selectEmail(ele) {
			var $ele = $(ele);
			var $idaddr = $('input[id=input2-find-id]');
			var $pwaddr = $('input[id=input3-find-pw]');
			if ($ele.val() == "") {
				if (ele.id == "idselect") {
					$idaddr.attr('readonly', false);
					$idaddr.val('');
				} else {
					$pwaddr.attr('readonly', false);
					$pwaddr.val('');
				}
			} else {
				if (ele.id == "idselect") {
					$idaddr.attr('readonly', true);
					$idaddr.val($ele.val());
				} else {
					$pwaddr.attr('readonly', true);
					$pwaddr.val($ele.val());
				}
			}
		}
	</script>

</body>
</html>
