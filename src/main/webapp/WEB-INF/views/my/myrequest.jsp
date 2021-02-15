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
        <link href="/css/modal-info.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
          table {
            table-layout: fixed;
          }
          table td {
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
          }
        </style>

    </head>

    <body id="page-top">
      <div class="modal-bg" id="modal-bg" onclick="closeModal()" style="display:none;"></div>

           <!-- 요청 항목 세부정보 보기 -->
           <div class="modal-container" id="view-detail" style="display:none;">
               <div class="modal-content" style="height:100%;">
                   <div class="modal-title">
                       <h5>독거어르신 주거환경개선 도움 요청</h5>
                       <div class="dropdown dd-down" id="change-req" onclick="requestdown(this);"><i class="fas fa-chevron-down"></i></div>
                   </div>
                   <div class="content-info" id="request-info" style="display:none;">
                       <table class="info-table" style="border-top:none;margin-top:0;">
                           <tr>
                               <td style="width:17.5%;"><b>등록번호</b></td>
                               <td style="width:27.5%;">#10011</td>
                               <td style="width:17.5%;"><b>등록날짜</b></td>
                               <td style="width:37.5%;">2020.10.21.</td>
                           </tr>
                           <tr>
                               <td><b>기간</b></td>
                               <td>보통(한 달 이내)</td>
                               <td></td>
                               <td></td>
                           </tr>
                       </table>
                       <div class="content-text">
                           여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는
                           혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선
                           도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가
                           직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로
                           주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다.
                           블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라
                           여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는
                           혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선
                           도움을 요청합니다. 블라블라 글글글글
                       </div>
                       <div class="content-needs">
                           <table class="info-table">
                               <tr>
                                   <th style="width:15%;">종류</th>
                                   <th style="width:35%;">내역</th>
                                   <th style="width:50%;">수량</th>
                               </tr>
                               <tr class="needs-category">
                                   <td>물품</td>
                                   <td>물품1</td>
                                   <td>30</td>
                               </tr>
                               <tr>
                                   <td></td>
                                   <td>물품2</td>
                                   <td>10</td>
                               </tr>
                               <tr>
                                   <td></td>
                                   <td>물품3</td>
                                   <td>20</td>
                               </tr>
                               <tr class="needs-category">
                                   <td>봉사</td>
                                   <td>옮기기</td>
                                   <td>10</td>
                               </tr>
                           </table>
                       </div>
                       <div class="btn-res btn-edit">수정하기</div>
                   </div>
                   <div class="modal-title" style="margin-top:1rem;">
                       <h5>응답 확인하기</h5>
                       <div class="dropdown dd-up" id="change-res" onclick="responsedown(this);"><i class="fas fa-chevron-up"></i></div>
                   </div>
                   <div class="content-info" id="response-info" style="display:block;">
                       <div class="content-needs">
                           <table class="info-table res-table">
                               <tr>
                                   <th style="width:15%;">순서</th>
                                   <th style="width:30%;">응답 내용</th>
                                   <th style="width:40%;">응답 종류</th>
                                   <th style="width:15%;">응답 상태</th>
                               </tr>
                               <tr class="needs-category response-row" id="response1" onclick="response_detail(this);">
                                   <td>1</td>
                                   <td class="td-title">독거어르신 주거환경개선 도움 요청</td>
                                   <td>물품1 10개, 물품2 5개</td>
                                   <td>대기</td>
                               </tr>

                               <tr class="response-row" id="response2" onclick="response_detail(this);">
                                   <td>2</td>
                                   <td class="td-title">독거어르신 주거환경개선 도움 요청</td>
                                   <td>물품1 10개, 물품2 5개</td>
                                   <td>대기</td>
                               </tr>
                               <tr class="response-row" id="response3" onclick="response_detail(this);">
                                   <td>3</td>
                                   <td class="td-title">독거어르신 주거환경개선 도움 요청</td>
                                   <td>물품1 10개, 물품2 5개</td>
                                   <td>승인</td>
                               </tr>
                           </table>
                       </div>
                   </div>
               </div>
           </div>

	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

      <div id="Wrapper">
        <!-- Navigation-->

		<%@include file="../layout/navbar.jsp"%>

        <header class="text-white text-center gradient-bgcolor">
            <div class="container d-flex flex-column title-info">
                <div class="reg-info">
                    <h4>요청내역</h4>
                    <p>지금까지 요청하신 내역들을<br>모두 확인할 수 있습니다.</p>
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
                  <th class="table-title">요청 내용</th>
                  <th class="table-date">등록일</th>
                  <th class="table-status">상태</th>
                </tr>
                </thead>
                <tbody>
                <tr class="response-item" onclick="goDetail();">
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">대기</td>
                </tr>
                <tr class="response-item" onclick="goDetail(this);">
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">미승인</td>
                </tr>
                <tr class="response-item" onclick="goDetail(this);">
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">승인</td>
                </tr>
                <tr class="response-item" onclick="goDetail(this);">
                  <td class="table-num">#10011</td>
                  <td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
                  <td class="table-date">2020.12.26</td>
                  <td class="table-status">대기</td>
                </tr>
                <tr class="response-item" onclick="goDetail(this);">
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
		<%@include file="../layout/footer.jsp"%>

		<%@include file="../layout/sidebar_back.jsp"%>

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
        
        <script>
        function response_detail(ele) {
              var id = "#" + $(ele).attr('id');
              var num = id.substr(id.length-1, 1);
              var cl = 'rc' + num;
              var html = '';
              html += ('<tr class="' + cl + '"><td colspan="4" style="padding:0;margin:0;"><textarea rows="2" style="resize:none;width:100%;border:none;border-top:1px solid gray;border-bottom:1px solid gray;text-align:left;padding:10px;">독거어르신 주거환경개선을 위해 도와드리고 싶습니다. 블라블라 뭐라고 하면 좋을까요? 아무튼 여기는 응답자가 직접 작성한 내용이 보여지는 곳입니다!</textarea></td></tr>');
              html += ('<tr class="' + cl + '"><th style="width:15%;padding:5px;">종류</th><th style="width:30%;padding:5px;">내역</th><th style="width:55%;padding:5px;">수량</th></tr>');
              html += ('<tr class="' + cl + '" style="border-top:1px solid gray;"><td style="padding:5px;">물품</td><td style="padding:5px;">물품1</td><td colspan="2" style="padding:5px;">2개</td></tr>');
              html += ('<tr class="' + cl + '"><td style="padding:5px;"></td><td style="padding:5px;">물품2</td><td style="padding:5px;">3개</td></tr>');
              html += ('<tr class="' + cl + '" style="border-top:2px solid black;"><th style="width:15%;padding:5px;padding-top:10px;">응답 상태</th><td colspan="3" style="width:85%;padding:5px;padding-top:10px;"><select name="status" class="a-or-w"><option value="wait">대기</option><option value="approve">승인</option></select></td></tr>');
              html += ('<tr class="' + cl + '"><td colspan="4" style="padding:0;"><textarea name="content" rows="3" style="resize:none;width:100%;margin-top:0.5rem;"></textarea></td></tr>');
              html += ('<tr class="' + cl + '" style="border-bottom:2px solid black;"><td colspan="2" style="padding:0;"></td><td colspan="2" style="text-align:right;padding:0;padding-bottom:10px;"><div class="btn-com">등록하기</div></td></tr>');
              $(id).after(html);
              $(id).removeAttr("onclick");
              $(id).attr("onclick", ("close_detail(" + num + ")"));
            }
            function close_detail(num) {
              var id = "#response" + num;
              var cl = ".rc" + num;
              $('tr').remove(cl);
              $(id).removeAttr("onclick");
              $(id).attr("onclick", "response_detail(this)");
            }

            function requestdown(ele) {
              if($("#change-req").hasClass('dd-down') === true) {
                $("#request-info").css("display", "block");
                $("#change-req").html('<i class="fas fa-chevron-up"></i>');
                $("#change-req").removeClass('dd-down');
                $("#change-req").addClass('dd-up;');
              } else {
                $("#request-info").css("display", "none");
                $("#change-req").html('<i class="fas fa-chevron-down"></i>');
                $("#change-req").removeClass('dd-up');
                $("#change-req").addClass('dd-down');
              }
            }
            function responsedown(ele) {
              if($("#change-res").hasClass('dd-down') === true) {
                $("#response-info").css("display", "block");
                $("#change-res").html('<i class="fas fa-chevron-up"></i>');
                $("#change-res").removeClass('dd-down');
                $("#change-res").addClass('dd-up;');
              } else {
                $("#response-info").css("display", "none");
                $("#change-res").html('<i class="fas fa-chevron-down"></i>');
                $("#change-res").removeClass('dd-up');
                $("#change-res").addClass('dd-down');
              }
            }


        </script>

    </body>
</html>
