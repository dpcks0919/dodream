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

      <div id="Wrapper" style="width:100%;">
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
          <div class="container d-flex flex-column">
              <div class="flex-center reg-container">
                  <div class="reg-response" style="height:55vh;">
                      <div class="reg-title response-bgcolor">
                          이웃을 돕고 싶은 경우
                      </div>
                      <div style="height:2.5%;"></div>
                      <div class="flex-center reg-content">
                          <div class="reg-card response-bgcolor">
                              <div class="card-title"><h4>개인 회원</h4></div>
                              <p class="select-info">이웃의 요청에<br>응답하고자 하는<br>개인인 경우</p>
                               <div class="reg-button" onclick="document.location.href='/joinForm/indi_s'" >가입하기</div>
                          </div>
                          <div style="width:3%;"></div>
                          <div class="reg-card response-bgcolor">
                              <div class="card-title"><h4>단체</h4></div>
                              <p class="select-info">이웃의 요청에<br>응답하고자 하는<br>단체인 경우<br>(동호회, 교회 등)</p>
                              <div class="reg-button" onclick="document.location.href='/joinForm/group_s'">가입하기</div>
                          </div>
                      </div>
                  </div>
                  <div style="width:1.25%;"></div>
                  <div class="reg-request" style="height:55vh;">
                      <div class="reg-title request-bgcolor">
                          이웃의 도움을 요청하고 싶은 경우
                      </div>
                      <div style="height:2.5%;"></div>
                      <div class="flex-center reg-content">
                      <div class="reg-card request-bgcolor">
                          <div class="card-title"><h4>사회복지사</h4></div>
                          <p class="select-info">도움 요청을<br>필요로하는<br>사회복지사인 경우</p>
                          <div class="reg-button" onclick="document.location.href='/joinForm/worker_s'">가입하기</div>
                      </div>
                      <div style="width:3%;"></div>
                      <div class="reg-card request-bgcolor">
                          <div class="card-title"><h4>사회복지기관</h4></div>
                          <p class="select-info">사회복지사들의<br>소속 기관인 경우</p>
                          <div class="reg-button" onclick="document.location.href='/joinForm/group_s'">가입하기</div>
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
        <script src="/js/join.js"></script>
    </body>
</html>
