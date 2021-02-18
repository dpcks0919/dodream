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
            <span class="input-title">비밀번호</span><span>&nbsp;<em>*</em></span><br><input class="text-input" type="password" name="userpw" id="userpw" placeholder="비밀번호 입력">
        </div>
        <div class="input-content">
            <span class="input-title">비밀번호 확인</span><span>&nbsp;<em>*</em></span><br><input class="text-input" type="password" name="userpwchk" id="userpwchk" placeholder="비밀번호 입력">
        </div>
	</form>
	<div style="width: 100%;">
		<button id="btn-change" class="sign-submit">변경</button>
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