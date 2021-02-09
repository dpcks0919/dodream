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
	<!-- younghwan -->
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
                          <div "email-input" style="height:100%;">
                              <input class="find-email" type="text" name="femail">&nbsp;@
                              <input class="find-address" id="idaddr" type="text" name="faddr" placeholder="직접입력">
                              <select class="select-portal" id="idselect" name="portal" onchange="selectEmail(this)">
                                  <option value="">직접입력</option>
                                  <option value="naver.com">naver.com</option>
                                  <option value="daum.net">daum.net</option>
                                  <option value="gmail.com">gmail.com</option>
                              </select>
                          </div>
                          <input class="find-submit" type="submit" value="아이디 찾기">
                      </form>
                  </div>
                  <div class="find-input">
                      <form method="post" action="">
                          <h4>비밀번호 잊어버린 경우</h4>
                          <p>가입하신 이메일을 입력해주세요.</p>
                          <div "email-input" style="height:100%;">
                              <input class="find-email" type="text" name="femail">&nbsp;@
                              <input class="find-address" id="pwaddr" type="text" name="faddr" placeholder="직접입력">
                              <select class="select-portal" id="pwselect" name="portal" onchange="selectEmail(this)">
                                  <option value="">직접입력</option>
                                  <option value="naver.com">naver.com</option>
                                  <option value="daum.net">daum.net</option>
                                  <option value="gmail.com">gmail.com</option>
                              </select>
                          </div>
                          <input class="find-submit" type="submit" value="비밀번호 찾기">
                      </form>
                  </div>
              </div>
          </div>
        </section>
        </div>
        <%@include file="../layout/sidebar_back.jsp" %> 

        <script>
        function selectEmail(ele){
          var $ele = $(ele);
          var $idaddr = $('input[id=idaddr]');
          var $pwaddr = $('input[id=pwaddr]');
          if($ele.val() == ""){
            if(ele.id == "idselect") {
              $idaddr.attr('readonly', false);
              $idaddr.val('');
            } else {
              $pwaddr.attr('readonly', false);
              $pwaddr.val('');
            }
          } else {
            if(ele.id == "idselect") {
              $idaddr.attr('readonly', true);
              $idaddr.val($ele.val());
            } else {
              $pwaddr.attr('readonly', true);
              $pwaddr.val($ele.val());
            }
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
    </body>
</html>
