<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="">
		<div class="input-content">
			<span class="input-title">현재 비밀번호 입력</span><br> <input class="text-input" type="password" name="userpw" id="password" placeholder="비밀번호 입력">
		</div>
		<input type="hidden" value="1" id="pwchange">
	</form>
	<div style="width: 100%;">
		<button id="btn-check" class="sign-submit">확인</button>
	</div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Third party plugin JS-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<!-- Contact form JS-->
	<script src="assets/mail/jqBootstrapValidation.js"></script>
	<script src="assets/mail/contact_me.js"></script>
<script src="/js/my.js"></script>
</html>