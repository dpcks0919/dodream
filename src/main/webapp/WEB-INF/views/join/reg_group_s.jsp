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
        
        <style>
          body {
            background-color: rgb(175, 218, 231);
          }
        </style>
    </head>

    <body id="page-top">
        <!-- Navigation-->
        <div id="menu-back" onclick="closeNav()"></div>
        <%@include file="../layout/sidebar_front.jsp" %> 

        <div id="Wrapper">
          <%@include file="../layout/navbar.jsp" %> 
          
        <section class="page-section text-white text-center" id="contact">
            <div class="container d-flex flex-column">
                <div class="flex-center">
                    <div class="input-column">
                        <div class="input-info">
                            <h4>단체가입</h4>
                            <p>회원가입 하시면, 주변 이웃들의 필요가 나타날 때마다<br>알림을 받으실 수 있습니다!</p>
                        </div>
                        <div class="input-card">
                            <div style="text-align:left;">
                                <form method="post" action="">
                                    <div class="divider-custom" style="margin-top:0;">
                                        <div class="divider-custom-line"></div>
                                        <div style="color:#e95378;"><h4>추가정보</h4></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">단체명</span><br><input class="text-input" type="text" name="username" placeholder="이름 입력">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">대표 이메일주소</span><br><input class="text-input" type="text" name="usermail" placeholder="이메일주소 입력">
                                        <span class="extra-info">주변 이웃들의 필요를 메일로 받으실 수 있습니다.
                                        <br>메일 수신 동의&nbsp;&nbsp;
                                        <span>
                                            <label><input type="radio" name="mail_rcv" value="agr" checked> 예</label>&nbsp;&nbsp;
                                            <label><input type="radio" name="mail_rcv" value="dis"> 아니요</label>
                                        </span></span>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">대표 전화번호</span><br>
                                        <div class="flex-center">
                                            <div style="width:calc(100% - 50px);">
                                                <input class="text-input" type="text" name="userphone" placeholder="전화번호 입력">
                                            </div>
                                            <div class="input-check" style="width:50px;">인증</div>
                                        </div>
                                        <span class="extra-info">
                                        주변 이웃들의 필요를 문자로 받으실 수 있습니다.
                                        <br>SMS 수신 동의&nbsp;&nbsp;
                                        <span>
                                            <label><input type="radio" name="sms_rcv" value="agr" checked> 예</label>&nbsp;&nbsp;
                                            <label><input type="radio" name="sms_rcv" value="dis"> 아니요</label>
                                        </span></span>
                                    </div>
                                    <div class="input-content">
                                        <div id="input-addr"><span class="input-title">단체 주소</span><br><input class="text-input" type="text" name="useraddr" placeholder="도로명 주소 입력"></div>
                                        <span class="extra-info" id="extra-addr">
                                            반경 내의 소식들을 확인할 수 있습니다.<br>
                                            두드림터치 홈페이지에는 이웃의 필요의 손길들을<br>
                                            지도에 시각적으로 나타내고 있습니다.<br>
                                            단체도 지도에 표시하시길 원하십니까?&nbsp;&nbsp;
                                            <span>
                                                <label><input type="radio" name="onmap" value="agr" checked> 예</label>&nbsp;&nbsp;
                                                <label><input type="radio" name="onmap" value="dis"> 아니요</label>
                                            </span>
                                        </span>
                                    </div>
                                    <div style="width:100%;">
                                        <input class="sign-submit" type="submit" value="가입하기">
                                    </div>
                                </form>
                            </div>
                        </div>
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
