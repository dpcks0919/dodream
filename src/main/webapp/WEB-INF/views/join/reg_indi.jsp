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
                            <h4>개인회원가입</h4>
                            <p>회원가입 하시면, 주변 이웃들의 필요가 나타날 때마다<br>알림을 받으실 수 있습니다!</p>
                        </div>
                        <div class="input-card">
                            <div style="text-align:left;">
                                <form method="post" action="">
                                	<input type="hidden" id="type" value="INDIVIDUAL">
                                    <div class="input-content">
                                        <span class="input-title">아이디</span><br>
                                        <div class="flex-center">
                                            <div style="width:calc(100% - 60px);">
                                                <input class="text-input" type="text" name="userid" id="userid" placeholder="아이디 입력">
                                            </div>
                                            <div class="input-check">중복 확인</div>
                                        </div>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">비밀번호</span><br><input class="text-input" type="password" name="userpw" id="userpw" placeholder="비밀번호 입력">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">비밀번호 확인</span><br><input class="text-input" type="password" name="userpwchk" placeholder="비밀번호 입력">
                                    </div>
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div style="color:#e95378;"><h4>개인정보</h4></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">이름</span><br><input class="text-input" type="text" name="username" id="username" placeholder="이름 입력">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">성별</span><br>
                                        <div class="flex-center"style="margin-top:0.5rem;">
                                            <div class="select-sex selected" id="maleuser" onclick="selectSex(this)">남자</div>
                                            <div style="width:2%;"></div>
                                            <div class="select-sex" id="femaleuser" onclick="selectSex(this)">여자</div>
                                        </div>
                                        <input id="input_sex" type="text" name="input_sex" value="male" style="display:none;">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">생년월일</span><br>
                                        <div class="flex-center" style="margin-top:0.5rem;">
                                            <div class="select-date"><input class="input-date" type="text" name="birthyear" id="birthyear" placeholder="2020"></div>
                                            <div style="width:0.5%;"></div>
                                            <div class="select-date"><input class="input-date" type="text" name="birthmonth" id="birthmonth" placeholder="01"></div>
                                            <div style="width:0.5%;"></div>
                                            <div class="select-date"><input class="input-date" type="text" name="birthdate" id="birthdate" placeholder="19"></div>
                                        </div>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">이메일주소</span><br><input class="text-input" type="text" name="usermail" id="useremail" placeholder="이메일주소 입력">
                                        <span class="extra-info">주변 이웃들의 필요를 메일로 받으실 수 있습니다.
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
                                                <input class="text-input" type="text" name="userphone" id="userphone" placeholder="전화번호 입력">
                                            </div>
                                            <div class="input-check" style="width:50px;">인증</div>
                                        </div>
                                        <span class="extra-info">
                                        주변 이웃들의 필요를 문자로 받으실 수 있습니다.
                                        <br>SMS 수신 동의&nbsp;&nbsp;
                                        <span>
                                            <label><input type="radio" name="sms_rcv" value="1" id="sms_rcv" checked> 예</label>&nbsp;&nbsp;
                                            <label><input type="radio" name="sms_rcv" value="0" id="sms_rcv" > 아니요</label>
                                        </span></span>
                                    </div>
                                    <div class="input-content">
	                                     <div class="flex-center">
	                                        <span class="input-title">내 주소</span><br><input class="text-input" type="text" name="useraddr" id="useraddr" placeholder="도로명 주소 입력">
	                                        <div class="input-check"  id="btn-addr-search" style="width:50px;">검색</div>
	                                    </div>
                                        <span class="extra-info">반경 내의 소식들을 확인할 수 있습니다.</span>
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">소속되어 있는 단체</span><br><input class="text-input" type="text" name="orgname" id="orgname" placeholder="정확한 명칭을 적어주세요.">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">직위/역할</span><br><input class="text-input" type="text" name="userpos" id="userpos" placeholder="소속이 있다면 직위나 역할을 작성해주세요.">
                                    </div>
                                    <div style="width:100%;">
                                       <!--  <input class="sign-submit" type="submit" value="가입하기"> -->
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
              $("#input_sex").val("1");	// 1: male
            } else {
              $("#femaleuser").addClass("selected");
              $("#maleuser").removeClass("selected");
              $("#input_sex").val("2");	// 2: female
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
        <script src="js/scripts.js"></script>
        <script src="/js/modal.js"></script>
        <script type="text/javascript" src="/js/join.js"></script>
    </body>
</html>
    