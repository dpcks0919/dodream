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
        <link href="/css/mypage.css" rel="stylesheet" />
        <link href="/css/nav_footer.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <style>
      .complete_event {
        color:#d5d5d5;
      }

    </style>

    <body id="page-top" >
      <div id="menu-back" onclick="closeNav()"></div>
      <%@include file="../layout/sidebar_front.jsp" %> 

      <div id="Wrapper">
        <!-- Navigation-->
        <%@include file="../layout/navbar.jsp" %> 


        <header class="bg-primary text-white text-center gradient-bgcolor">
            <div class="container d-flex flex-column title-info">
                <div class="reg-info">
                  <h4>나의 두드림</h4>
                  <p>지금까지 찜하신 목록들을 확인할 수 있습니다.<br></p>
                </div>
            </div>
        </header>
        <!-- news Section-->
        <section class="mypage-section2" id="about" style="text-align:center;">
            <div class="container ">
              <table style="table-layout:fixed">
                <thead>
                <tr style="border-bottom:3px solid #d3d3d3;">
                  <th class="table-num"> 등록번호</th>
                  <th class="table-title">응답 명</th>
                  <th class="table-date">등록일</th>
                  <th class="table-status">상태</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">대기</td>
                </tr>
                <tr>
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">미승인</td>
                </tr>
                <tr class="complete_event">
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">승인</td>
                </tr>
                <tr class="complete_event">
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">대기</td>
                </tr>
                <tr class="complete_event">
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">대기</td>
                </tr>
                </tbody>
              </table>
            </div>
        </section>

        <!-- Footer-->
        <%@include file="../layout/footer.jsp" %> 
        <%@include file="../layout/sidebar_back.jsp" %> 


      </div> <!-- Wrapper -->

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
