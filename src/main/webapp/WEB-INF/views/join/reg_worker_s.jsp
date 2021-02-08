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
            background-color: #ed7e95;
          }
        </style>
    </head>

    <body id="page-top">
        <div id="menu-back" onclick="closeNav()"></div>
        <%@include file="../layout/sidebar_front.jsp" %> 

        <div id="Wrapper">
        <!-- Navigation-->
        <%@include file="../layout/navbar.jsp" %> 



        <section class="page-section text-white text-center" id="contact">
            <div class="container d-flex flex-column">
                <div class="flex-center">
                    <div class="input-column">
                        <div class="input-info">
                            <h4>사회복지사 가입</h4>
                            <p>회원가입 하시면, 보살피고 계신 이웃들의 필요를<br>요청하실 수 있습니다!</p>
                        </div>
                        <div class="input-card">
                            <div style="text-align:left;">
                                <form method="post" action="">
                                	<input type="hidden" id="type" value="SOCIAL_WORKER"><!--  UserType hidden으로 건네줌 -->
                                    <div class="divider-custom" style="margin-top:0;">
                                        <div class="divider-custom-line" style="background-color: rgb(175, 218, 231);border-color: rgb(175, 218, 231) !important;"></div>
                                        <div style="color:rgb(175, 218, 231)"><h4>추가정보</h4></div>
                                        <div class="divider-custom-line" style="background-color: rgb(175, 218, 231);border-color: rgb(175, 218, 231) !important;"></div>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">이메일주소</span><br><input class="text-input" type="text" name="usermail" id="useremail" "placeholder="이메일주소 입력" id="useremail">
                                        <span class="extra-info">응답이 왔을 때 메일로 받으실 수 있습니다.
                                        <br>메일 수신 동의&nbsp;&nbsp;
                                        <span>
                                            <label><input type="radio" name="mail_rcv" value="1" id="mail_rcv" checked> 예</label>&nbsp;&nbsp;
                                            <label><input type="radio" name="mail_rcv" value="0" id="mail_rcv"> 아니요</label>
                                        </span></span>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">전화번호</span><br>
                                        <div class="flex-center">
                                            <div style="width:calc(100% - 50px);">
                                                <input class="text-input" type="text" name="userphone" placeholder="전화번호 입력" id="userphone" >
                                            </div>
                                            <div class="input-check" style="width:50px;">인증</div>
                                        </div>
                                        <span class="extra-info">
                                        응답이 왔을 때 문자로 받으실 수 있습니다.
                                        <br>SMS 수신 동의&nbsp;&nbsp;
                                        <span>
                                            <label><input type="radio" name="sms_rcv" value="1" id="sms_rcv" checked> 예</label>&nbsp;&nbsp;
                                            <label><input type="radio" name="sms_rcv" value="0" id="sms_rcv" > 아니요</label>
                                        </span></span>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">기관명</span><br><input class="text-input" type="text" name="orgname" id="orgname" placeholder="기관명 입력">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">기관전화번호</span><br><input class="text-input" type="text" name="orgphone" id="orgphone" placeholder="기관전화번호 입력">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">기관주소</span><br><input class="text-input" type="text" name="useraddr" id="useraddr" placeholder="도로명 주소 입력"><!-- 기관주소이지만 useraddr로 들어간다 -->
                                    </div>
                                    <div style="width:100%;">
                                    	<!-- <input class="sign-submit-s" type="submit" value="가입하기"> -->
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
        <%@include file="../layout/sidebar_back.jsp" %> 

        <script>
         
          function selectSex(sex){
            var $sex = sex.id;
            if($sex == "maleuser") {
              $("#maleuser").addClass("selected");
              $("#femaleuser").removeClass("selected");
              $("#input_sex").val("male");
            } else {
              $("#femaleuser").addClass("selected");
              $("#maleuser").removeClass("selected");
              $("#input_sex").val("female");
            }
          }
        </script>
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
