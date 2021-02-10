<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
        <link href="/css/login.css" rel="stylesheet" />
        <link href="/css/nav_footer.css" rel="stylesheet" />
        <style>
          .checkbox-container {
            width: 100%;
            font-size: 8pt;
            font-weight: 500;
            text-align: left;
            margin-top: 1.5vh;
          }
          .checkbox-container input[type="checkbox"] {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip:rect(0,0,0,0);
            border: 0
          }
          .checkbox-container input[type="checkbox"] + label {
            display: inline-block;
            position: relative;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
          }
          .checkbox-container input[type="checkbox"] + label:before {
            content: ' ';
            display: inline-block;
            width: 12px;
            height: 12px;
            line-height: 12px;
            margin: -2px 8px 0 0;
            text-align: center;
            vertical-align: middle;
            background: #fafafa;
            border: 1px solid #e95378;;
            border-radius: 3px;
          }
          .checkbox-container input[type="checkbox"] + label:active:before,
          .checkbox-container input[type="checkbox"]:checked + label:active:before {
              box-shadow: 0px 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
          }
          .checkbox-container input[type="checkbox"]:checked + label:before {
            content: '\2713';
            color: white;
            background: #e95378;;
            border-color: #e95378;;
          }
          .input-id::placeholder, .input-pw::placeholder {
            color: #CACACA;
          }
          *:focus {outline:none;}
          .input-id:focus, .input-pw:focus {
            outline:none;
            background-color: white;
          }
          .snslgbtn {
            width:100%;
            height: 3rem;
            margin-top: 1.2vh;
          }
          .divider-custom {
            margin: 0;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
          }
          .divider-custom .divider-custom-line {
            width: 30%;
            height: 0.1rem;
            background-color: #CACACA;
            border-radius: 1rem;
            border-color: #CACACA !important;
          }
          .login-container {
            width: 22.5rem;
          }
          .login-explain {
            display: block;
            width:32.5%;
          }
          .login-all {
            height:calc(40vh - 2rem);
          }

          /*@media (max-width: 992px) {
            .login-container {
              margin-top: 1rem;
            }
            .login-explain {
              width: 50%;
            }
          }*/
          @media (max-width: 992px) {
            .login-explain {
              display: none;
            }
            .login-all {
              position: relative;
            }
            .login-wrapper {
              position: absolute;
              top: 100%;
              left: 50%;
              transform: translate(-50%, -45%);
            }
            .masthead {
              height: 100vh;
            }
            body {
              /*background: linear-gradient(to right, rgb(175, 218, 231), #ed7e95);*/
              background-color: inherit;
            }
          }

        </style>
    </head>

    <body id="page-top">
        <!-- Navigation-->
        <div id="menu-back" onclick="closeNav()"></div>
          <%@include file="../layout/sidebar_front.jsp" %>
 
        <div id="Wrapper" style="height:auto;overflow:visible;">
           <%@include file="../layout/navbar_join.jsp" %>
           <%@include file="../layout/sidebar_back.jsp" %> 

        <!-- Masthead-->
        <header class="masthead bg-primary text-white text-center" style="background: linear-gradient(to right, rgb(175, 218, 231), #ed7e95);">
            <div class="container d-flex flex-column login-all">
                <div class="login-wrapper" style="display:flex;width:100%;margin-top:-3rem;text-align:center;flex-direction:row;justify-content:center;">
                    <div class="login-container" style="position:relative;background-color:white;box-shadow: 1px 1px 6px 1px #A6A6A6;color:black;padding:3rem;height:100%;">
                        <h4 align="left" style="color:#e95378;margin-top:1.8vh;">로그인</h4>
                        <form method="post">
                          <div class="idpw-container" style="margin-top: 4vh;color:black;">
                              <input class="input-id" type="text" name="userid" placeholder="아이디 입력" style="width:100%;height:2.5rem;border:none;border-bottom:2px solid lightgray;" id="loginid">
                              <input class="input-pw" type="password" name="userpw" placeholder="패스워드 입력" style="width:100%;height:2.5rem;border:none;border-bottom:2px solid lightgray;" id="loginpw"><br>
                          </div>
                          <div class="checkbox-container">
                              <input type="checkbox" id="is-subscription">
                              <label for="is-subscription">아이디 기억하기</label>
                          </div>
                          <div class="find-container" style="width:100%;text-align:right;font-size:9pt;margin-top:1vh;"><a href="" style="color:black;"><U>아이디/비밀번호 찾기</U></a></div>
<!--                           <input class="login-submit" type="submit" value="로그인" style="width:100%;padding:6px 1px 6px 1px;background-color:#ed7e95;border:none;border-radius:16px;color:white;font-size:14pt;margin-top:1.5vh;">
 -->                        </form>
                           <button id="btn-login" class="login-submit" type="submit" style="width:100%;padding:6px 1px 6px 1px;background-color:#ed7e95;border:none;border-radius:16px;color:white;font-size:14pt;margin-top:1.5vh;">로그인</button>
                        <div class="login-sns" style="margin-top:5.5vh;">
                            <div class="divider-custom">
                                <div class="divider-custom-line"></div>
                                <div style="font-size:10pt;color:#CACACA;">간편 로그인</div>
                                <div class="divider-custom-line"></div>
                            </div>
                            <img class="snslgbtn" src="/image/kakao.png" alt="" onclick="javascript:location.href='/oauth2/authorization/kakao'" />
                            <img class="snslgbtn" src="/image/naver.PNG" alt="" onclick="javascript:location.href='/oauth2/authorization/naver'"/>
                            <img class="snslgbtn" src="/image/facebook.png" alt="" onclick="javascript:location.href='/oauth2/authorization/facebook'"/>
                        </div>
                    </div>
                    <div class="login-explain" style="height:100%;text-align:left;padding-left:4.5rem;padding-top:22.5vh;">
                        <h4>주변 이웃의 도움을<br>확인해볼까요?</h4>
                        <p>먼저 로그인이 필요합니다 :)</p><br>
                        <p>아직 가입하지 않으셨습니까?</p>
                        <span style="background-color: rgba(255, 255, 255, 0.2);border:1px solid white;border-radius:16px;padding:6px 49px 6px 49px;font-size:14pt;font-weight:bold;cursor:pointer;" onclick="javascript:location.href='/joinForm'">회원가입</span>
                    </div>
                </div>
                <!-- <img class="masthead-avatar mb-5" src="assets/img/avataaars.svg" alt="" /> -->
            </div>
        </header>
        </div>
        
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
        <script type="text/javascript" src="/js/join.js"></script>
    </body>
</html>
