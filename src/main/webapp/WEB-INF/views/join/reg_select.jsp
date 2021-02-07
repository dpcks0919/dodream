<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no"/>
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Freelancer - Start Bootstrap Theme</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="/css/register.css" rel="stylesheet" />
        <link href="/css/nav_footer.css" rel="stylesheet" />

    </head>

    <body id="page-top">
        <div id="menu-back" onclick="closeNav()"></div>
        <%@include file="../layout/sidebar_front.jsp" %> 


        <div id="Wrapper">
        <!-- Navigation-->
		<%@include file="../layout/navbar.jsp" %> 

        <!-- Masthead-->
        <header class="bg-primary text-white text-center gradient-bgcolor">
            <div class="container d-flex flex-column title-info">
                <div class="reg-info">
                  <h4>회원가입</h4>
                  <p>회원가입 하시면, 주변 이웃들의 필요가 나타날 때마다<br>
                  알림을 받으실 수 있습니다!</p>
                </div>
            </div>
        </header>
        <section class="page-section-join" id="join">
          <div class="flex-center">
              <div class="flex-column" style="width:400px;padding:30px;">
                  <div class="sns-card" onclick="document.location.href='/joinFormMain'">
                      <div class="sns-logo" style="background-image:url('/image/Logo2.png');">로고</div>
                      <div class="sns-title">이메일로 회원가입</div>
                  </div>
                  <div class="sns-card" onclick="document.location.href='/oauth2/authorization/kakao'">
                      <div class="sns-logo" style="background-image:url('/image/kakaologo.png');">로고</div>
                      <div class="sns-title">카카오톡으로 회원가입</div>
                  </div>
                  <div class="sns-card" onclick="document.location.href='/oauth2/authorization/naver'">
                      <div class="sns-logo" style="background-image:url('/image/naverlogo.png');">로고</div>
                      <div class="sns-title">네이버로 회원가입</div>
                  </div>
                  <div class="sns-card" onclick="document.location.href='/oauth2/authorization/facebook'">
                      <div class="sns-logo" style="background-image:url('/image/facelogo.png');">로고</div>
                      <div class="sns-title">페이스북으로 회원가입</div>
                  </div>
              </div>
          </div>
        </section>
        </div>
        <%@include file="../layout/sidebar_back.jsp" %> 

        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="assets/mail/jqBootstrapValidation.js"></script>
        <script src="assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="/js/scripts.js"></script>
        <script src="/js/modal.js"></script>
    </body>
</html>
