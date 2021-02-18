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
        <!-- Navigation-->
        <div id="menu-back" onclick="closeNav()"></div>
        <%@include file="../layout/sidebar_front.jsp" %> 

        <div id="Wrapper">
          <%@include file="../layout/navbar.jsp" %> 
          
        <!-- Masthead-->
        <header class="bg-primary text-white text-center gradient-bgcolor">
            <div class="container d-flex flex-column title-info">
                <div class="reg-info-small">
                  <h4>비밀번호 변경</h4>
                </div>
            </div>
        </header>
        <section class="page-section-join" id="join">
          <div class="flex-center">
              <div class="find-container">
              	  <div style="height:2rem;"></div>
                  <div class="find-input">
                      <form method="post" action="">
						  <div class="input-content">
							  <span class="input-title">새 비밀번호 </span><br> <input class="text-input" type="password" name="userpw" id="userpw" placeholder="비밀번호 입력">
						  </div>
						  <div class="input-content">
							  <span class="input-title">비밀번호 확인 </span><br> <input class="text-input" type="password" name="userpwchk" id="userpwchk" placeholder="비밀번호 입력">
						  </div>
                      </form>
                      <button id="btn-change" class="sign-submit" style="margin-top:1rem;">변경하기</button>
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
		<script src="/js/my.js"></script>
    </body>
</html>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</html> --%>