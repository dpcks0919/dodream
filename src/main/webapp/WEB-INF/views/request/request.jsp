<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no"/>
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>도움 요청</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="/css/request.css" rel="stylesheet" />
        <link href="/css/modal-info.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <body id="page-top" >
      <div class="modal-bg" id="modal-bg" onclick="closeModal()"></div>
      <div class="modal-container" id="view-detail">
          <div class="modal-content">
              <h5 id="modal-title">독거어르신 주거환경개선 도움 요청</h5>
              <div class="content-info">
                  <table class="info-table">
                      <tr>
                          <td style="width:17.5%;"><b>등록번호</b></td>
                          <td style="width:27.5%;">#10011</td>
                          <td style="width:17.5%;"><b>등록날짜</b></td>
                          <td style="width:37.5%;">2020.10.21.</td>
                      </tr>
                      <tr>
                          <td><b>기간</b></td>
                          <td id="modal-period"></td>
                          <td></td>
                          <td></td>
                      </tr>
                  </table>
                  <div class="content-text" id="modal-contents">

                  </div>
                  <div class="content-needs">
                      <table class="info-table" id="modal-table">
                        <thead>
                          <tr style="border-bottom: 2px solid grey; cursor:none;">
                              <th style="width:15%;">종류</th>
                              <th style="width:50%;">내역</th>
                              <th style="width:35%;">수량</th>
                          </tr>
                        </thead>
                        <tbody id="modal-reset">

                        </tbody>
                      </table>
                  </div>
              </div>
          </div>

          <div class="modal-ftr" style="display:flex;flex-direction:row;justify-content:left;">
              <div class="btn-res" onclick="goResponse()" style="color:gray;border:2px solid gray;">수정하기</div>
          </div>
      </div>

      <div id="menu-back" onclick="closeNav()"></div>
      	<%@include file="../layout/sidebar_front.jsp"%>

      <div id="Wrapper">
        <!-- Navigation-->
   		<%@include file="../layout/navbar.jsp"%>

        <header class="text-white text-center request-bgcolor">
            <div class="container d-flex flex-column title-info">
                <div class="reg-info">
                    <h4>요청하기</h4>
                    <p>도움이 필요한 이웃을 위해<br>요청을 올릴 수 있습니다.</p>
                </div>
            </div>
        </header>

        <section class="request-section" id="request">
          <div class="container">
            <div class="request-form" id="requestForm">
              <div class="">
                <input type="text" class="request-title" id="requestTitle" placeholder="제목을 입력해주세요" name="title" required/>
              </div>
              <div class="">
                <span>기간 : </span>
                  <select class="request-period" name="period" id="requestPeriod">
                    <option name="p1">보통(한 달 이내)</option>
                    <option name="p2">긴급(7~14일 이내)</option>
                    <option name="p3">매우 긴급(3일 이내)</option>
                  </select>
              </div>
              <div>
                <textarea type="text" class="request-content" id="requestContents" placeholder="사연을 작성해주세요" name="content" required></textarea>
              </div>
              <div>
                <p style="font-weight:bold;">어떤 도움이 필요하신지 입력해주세요!</p>
              </div>
              <div>
                <p><b>**입력 가이드라인**</b></p>
                <p>1. 물품: 이름-물품명 <span class="res-span">ex)선풍기, 세제 등</span></p>
                <p>2. 재정: 이름-재정이 쓰이는 곳 <span class="res-span">ex) 밀린 공과금 납부</span></p>
                <p>3. 봉사: 이름-봉사 이름 <span class="res-span">ex)연탄봉사</span></p>
              </div>
              <div>
                <table id="myTable">
                  <thead class="table-title" style="cursor:initial;">
                    <th class="" width="20%">종류</th>
                    <th class="" width="40%">이름</th>
                    <th class="" width="5%">수량</th>
                    <th class="" width="5%">삭제</th>
                  </thead>
                  <tbody>
                  </tbody>
                  <tr class="add_item ">
                    <th colspan="4"><button type="button" class="add_item-button" style="width:100%" onclick="rowAdd();">+</button></th>
                  </tr>
                </table>
              </div>
            </div>
            <div class="request-ftr" style="justify-content: space-between;">
              <div class="btn-upload" onclick="upload();">올리기</div>
              <div class="btn-save" onclick="save();">저장하기</div>
            </div>
          </div>
        </section>

        <!-- Footer-->
   		<%@include file="../layout/footer.jsp"%>

		<%@include file="../layout/sidebar_back.jsp"%>
		
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
        <script>
                // 모달
                function goRequestDetail(title, period_text, contents, totalCnt, itemList) {
                  document.getElementById("modal-bg").style.display="block";
                  document.getElementById("view-detail").style.display="block";
                  document.getElementById("page-top").style.overflow="hidden";
                  document.getElementById("menu-back").style.filter = "blur(5px)";
                  document.getElementById("Wrapper").style.filter = "blur(5px)";
                  document.getElementById("modal-title").innerHTML = title;
                  document.getElementById("modal-contents").innerHTML = contents;
                  document.getElementById("modal-period").innerHTML = period_text;
                  document.getElementById("modal-reset").innerHTML = "";
                  for(var i=0; i<totalCnt; i++) {
                    var _item = itemList[i].item;
                    var _name = itemList[i].name;
                    var _count = itemList[i].count;
                    if(_item == "" || _name == "" || _count == "") {
                      alert('항목을 입력해주세요');
                      closeModal();
                      return 0;
                    }
                    var innerHtml = "";
                    innerHtml += "<tr>";
                    innerHtml += "<th class='item'><p style='margin:0; padding:0;'>"+_item;
                    innerHtml += "</p></th>";
                    innerHtml += "<th><input type='text' class='request-item-name' value='"+_name+"' style='border-style:none;' readonly/></th>";
                    innerHtml += "<th><div>";
                    innerHtml += "<input type='text' class='modal-response-item-count' name='request' value='"+_count+"' style='border-style:none;' readonly/>";
                    innerHtml += "</div></th>";
                    innerHtml += "</tr>";
                    $('#modal-reset').append(innerHtml);
                  }
                }

                function rowAdd() {
                  var trCnt = $('#myTable tbody tr').length-1;
                  var curCnt = trCnt+1;
                  var curID = 'tr' + curCnt;
                  var curItem = curID + "item";
                  var curName = curID + "name";
                  var curCount = curID + "count";
                  var curDiv = curID + "div";
                  // alert(curItem + " "+curName + " "+curCount);
                  var innerHtml = "";
                  innerHtml += "<tr id="+curID+">";
                  innerHtml += "<th class='item'><select class='request-item' id="+curItem+" onchange='alert_select_value(this, "+curCnt+");'>";
                  innerHtml += "<option name='item' selected>물품</option>";
                  innerHtml += "<option name='money'>재정</option>";
                  innerHtml += "<option name='service'>봉사</option>";
                  innerHtml += "</select></th>";                  innerHtml += "<th><input type='text' class='request-item-name' placeholder='이름 입력' id='"+curName+"'/></th>";
                  innerHtml += "<th><div id='"+curDiv+"'>";
                  innerHtml += "<i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this);'></i><input type='text' class='response-item-count' name='request' placeholder='0' value='0' id='"+curCount+"'/>";
                  innerHtml += "<i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this);'></i>";
                  innerHtml += "</div></th>";
                  innerHtml += "<th><div class='del-btn' id="+curID+" onclick='rowDelete(this);'>X</div></th>";
                  innerHtml += "</tr>";
                  $('#myTable > tbody:first').append(innerHtml);
                }

                function rowDelete(current) {
                  var target = document.getElementById(current.getAttribute('id')).getAttribute('id')
                  $('#'+target).remove();
                }

                function minusCount(_current) {
                  var target = _current.id + "count";
                  var cnt = document.getElementById(target).value;
                  if(cnt>0) {
                    document.getElementById(target).value=cnt*1 - 1;
                  }
                  else {
                    alert("0이상의 수를 입력하세요.");
                  }
                }

                function plusCount(_current) {
                  var target = _current.id + "count";
                  var cnt = document.getElementById(target).value;
                  // document.getElementById(target).setAttribute('value', cnt+1);
                  document.getElementById(target).value=cnt*1 + 1;
                }

                // 임시 저장 (db에 올리기)
                function save() {
                  // 제목
                  var title = document.getElementById('requestTitle').value;
                  var period = document.getElementById('requestPeriod').value;
                  // 기간(텍스트)
                  var period_text = period;
                  if(period_text == '보통(한 달 이내)') period = 3;
                  else if(period_text == '긴급(7~14일 이내)') period = 2;
                  else if(period_text == '매우 긴급(3일 이내)') period = 1;
                  // 내용 : 사연
                  var contents = document.getElementById('requestContents').value;
                  // 아이템 총 개수
                  var totalCnt = $('#myTable tbody tr').length-1;
                  alert(totalCnt);
                  // 세부 아이템들 itemList에 객체를 요소로 가지는 배열로 저장될거고, db에 올릴 때 itemList 사용하면 됨.
                  if(totalCnt > 0) {
                    var itemList = [];
                    for(var i = 1; i<=totalCnt; i++) {
                      var _item = 'tr'+i+'item';
                      var _name = 'tr'+i+'name';
                      var _count = 'tr'+i+'count';
                      itemList.push({
                        item : document.getElementById(_item).value,
                        name : document.getElementById(_name).value,
                        count : document.getElementById(_count).value
                      });
                    }

                    // DB에 올릴 함수 실행 (임시로 함수 만들어놓음-이름 수정하면됨)
                    // saveItem();

                  }
                }
                // 최종 제출 (db에 올리기)
                function upload() {
                  var title = document.getElementById('requestTitle').value;

                  var period = document.getElementById('requestPeriod').value;
                  var period_text = period;
                  if(period_text == '보통(한 달 이내)') period = 3;
                  else if(period_text == '긴급(7~14일 이내)') period = 2;
                  else if(period_text == '매우 긴급(3일 이내)') period = 1;
                  var contents = document.getElementById('requestContents').value;

                  if(title =='') {
                    alert("제목을 입력해주세요!");
                    return 0;
                  }
                  else if(contents == '') {
                    alert('내용을 입력해주세요!');
                    return 0;
                  }
                  var totalCnt = $('#myTable tbody tr').length-1;
                  // alert(totalCnt);
                  if(totalCnt > 0) {
                    var itemList = [];
                    for(var i = 1; i<=totalCnt; i++) {
                      var _item = 'tr'+i+'item';
                      var _name = 'tr'+i+'name';
                      var _count = 'tr'+i+'count';
                      itemList.push({
                        item : document.getElementById(_item).value,
                        name : document.getElementById(_name).value,
                        count : document.getElementById(_count).value
                      });
                    }
                    // 여기서 itemList를 넘겨주고, DB에 저장할 때 totalCnt 갯수만큼 itemList[totalCnt].item, .name, .count 이렇게 순서대로 저장시키면 됨.
                    // totalCnt 갯수만큼 추가 쿼리문 실행시키면 됨.

                    // DB에 올릴 함수 실행 (임시로 함수 만들어놓음-이름 수정하면됨)
                    // saveItem();

                    // console.log(itemList);

                    // 모달 실행 + 모달에 내용 불러오기.
                    goRequestDetail(title, period_text, contents, totalCnt, itemList);
                  }
                  else {
                    alert('물품을 입력해주세요');
                  }
                  // 갯수만큼 for문을 돌려서 배열에 저장해놓고
                }
                function numberWithCommas(curObj) {
                  var x = curObj.value;
                  var curID = "#"+curObj.id;
                  x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
                  x = x.replace(/,/g,'');          // ,값 공백처리
                  $(curID).val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가
                }

                // 도움 종류에 따라 수량 표기 변화시키는 함수
                var alert_select_value = function (select_obj, curCnt) {
                  var selected_index = select_obj.selectedIndex;
                  var selected_value = select_obj.options[selected_index].value;
                  var curDiv = 'tr' + curCnt + "div";
                  var curCount = 'tr' + curCnt +'count';
                  var newHtml = "";
                  if(selected_value === '재정') {
                    newHtml += "<input type='text' class='response-item-count-big' name='request' value='0' id='"+curCount+"' onkeyup='numberWithCommas(this)'/>원";
                  }
                  else {
                    newHtml += "<i class='fas fa-minus minus-icon' id='"+"tr"+curCnt+"' onclick='minusCount(this);'></i><input type='text' class='response-item-count' name='request' placeholder='0' value='0' id='"+curCount+"'/>";
                    newHtml += "<i class='fas fa-plus plus-icon' id='"+"tr"+curCnt+"' onclick='plusCount(this);'></i>";
                  }
                  document.getElementById(curDiv).innerHTML = newHtml;
                }

          </script>

      </div>
    </body>
</html>
