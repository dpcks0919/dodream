<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/login.css" rel="stylesheet" />
<style>
@media (max-width: 992px) {
  .login-explain {
    display: none;
  }
  .login-all {
    position: relative;
  }
  .login-wrapper {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -45%);
  }
  .login-background {
    height:50rem;
  }
}
</style>
</head>

<body id="page-top">
	<!-- Navigation-->
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper" style="height: auto; overflow: visible;">
		<%@include file="../layout/navbar.jsp"%>
		<%@include file="../layout/sidebar_back.jsp"%>

		<!-- Masthead-->
		<div class="login-background" style="position:absolute;width:100%;height:35rem;background: linear-gradient(to right, rgb(175, 218, 231), #ed7e95);">
          <div class="container" style="display:flex;flex-direction:row;justify-content:center;">
            <div class="login-wrapper" style="background-color:white;width:22.5rem;box-shadow: 1px 1px 6px 1px #A6A6A6;margin-top:13.5%;padding:3rem;">
              <h4 align="left" style="color:#e95378;margin-top:0.25rem;">로그인</h4>
              <form method="post">
                <div class="idpw-container" style="margin-top:2vh;color:black;">
                    <input class="input-id" type="text" name="userid" placeholder="아이디 입력" style="width:100%;height:2.5rem;border:none;border-bottom:1px solid lightgray;" id="loginid">
                    <input class="input-pw" type="password" name="userpw" placeholder="패스워드 입력" onkeydown="enterkey();" style="width:100%;height:2.5rem;border:none;border-bottom:1px solid lightgray;" id="loginpw"><br>
                </div>
                <div class="find-container" style="width:100%;text-align:right;font-size:9pt;margin-top:1vh;">
                  <a class="sign-up" href="joinForm" style="color: black;"><U>회원가입  <br></U></a>
                  <a href="findInfoForm" style="color:black;"><U>아이디/비밀번호 찾기</U></a>
                </div>
              </form>
              <button id="btn-login" class="login-submit" type="submit"
                							style="width: 100%; padding: 6px 1px 6px 1px; background-color: #ed7e95; border: none; border-radius: 16px; color: white; font-size: 14pt; margin-top: 2.5vh;">로그인</button>              </form>
              <div class="login-sns" style="margin-top:2vw;">
                  <div class="divider-custom">
                      <div class="divider-custom-line"></div>
                      <div class="login-subtitle">간편 로그인</div>
                      <div class="divider-custom-line"></div>
                  </div>
                  <img class="snslgbtn" src="/image/kakao.png" alt="" onclick="javascript:location.href='/oauth2/authorization/kakao'"/>
                  <img class="snslgbtn" src="/image/naver.png" alt="" onclick="javascript:location.href='/oauth2/authorization/naver'"/>
                  <img class="snslgbtn" src="/image/google.png" alt="" onclick="javascript:location.href='/oauth2/authorization/google'"/>
              </div>
            </div>
            <div style="width:10%;"></div>
            <div class="login-explain" style="margin-top: 18%;color:white;">
              <h4>주변 이웃의 도움을<br>확인해볼까요?</h4>
              <p>먼저 로그인이 필요합니다 :)</p><br>
              <p>아직 가입하지 않으셨습니까?</p>
              <span style="background-color: rgba(255, 255, 255, 0.2);border:1px solid white;border-radius:16px;padding:6px 49px 6px 49px;font-size:14pt;font-weight:bold;cursor:pointer;" onclick="javascript:location.href='/joinForm'">회원가입</span>
            </div>
          </div>
        </div>
	</div>
	<%@include file="../layout/jsFile.jsp"%>
	<script type="text/javascript" src="/js/join.js"></script>
	<script>
		function enterkey() {
	        if (window.event.keyCode == 13) {
	 	    	joinInit.login();
	 	    	event.preventDefault();
	        }
		}
	</script>
</body>
</html>
