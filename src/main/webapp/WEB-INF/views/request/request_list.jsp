<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>요청 보기</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" rel="stylesheet" />
<link href="/css/view-reg.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4407e6aa270afe5752d07352835fb75f"></script>
</head>

<body id="page-top">
	<div class="modal-bg" id="modal-bg" onclick="closeModal()"></div>

	<!-- 요청 항목 세부정보 보기 -->
	<div class="modal-container" id="view-detail">
		<div class="modal-content">
			<h5>독거어르신 주거환경개선 도움 요청</h5>
			<div class="content-info">
				<table class="info-table">
					<tr>
						<td style="width: 17.5%;"><b>등록번호</b></td>
						<td style="width: 27.5%;">#10011</td>
						<td style="width: 17.5%;"><b>등록날짜</b></td>
						<td style="width: 37.5%;">2020.10.21.</td>
					</tr>
					<tr>
						<td><b>상태</b></td>
						<td>응답 대기중</td>
						<td><b>주소</b></td>
						<td>경상북도 포항시 북구 흥해읍</td>
					</tr>
					<tr>
						<td><b>기간</b></td>
						<td>보통(한 달 이내)</td>
						<td><b>요청자</b></td>
						<td>요청을 올린 사회복지사/기관</td>
					</tr>
				</table>
				<div class="content-text">여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는
					어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이
					노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는
					사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한
					글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다.
					주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라 여기는 사회복지사가 직접 작성한 글이 나타나는 곳이다. 주거환경개선 도움을 요청합니다. 블라블라 글글글글 대상자는 혼자 사시는 어르신으로 주택이 노후되어 블라블라</div>
				<div class="content-needs">
					<table class="info-table">
						<tr>
							<th style="width: 15%;">종류</th>
							<th style="width: 35%;">내역</th>
							<th style="width: 50%;">필요 수량 / 목표 수량</th>
						</tr>
						<tr class="needs-category">
							<td>물품</td>
							<td>물품1</td>
							<td>10 / 30</td>
						</tr>
						<tr>
							<td></td>
							<td>물품2</td>
							<td>5 / 10</td>
						</tr>
						<tr>
							<td></td>
							<td>물품3</td>
							<td>10 / 20</td>
						</tr>
						<tr class="needs-category">
							<td>봉사</td>
							<td>옮기기</td>
							<td>7 / 10</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="modal-ftr">
			<div class="btn-res" onclick="goResponse()">응답하기</div>
			<div class="btn-icon">
				<i class="far fa-heart"></i>
			</div>
		</div>
	</div>
	<!-- 응답하기 -->
	<div class="modal-container" id="view-responseForm">
		<div class="modal-content">
			<div class="" style="vertical-align: text-bottom !important;">
				<h5 style="float: left">응답하기</h5>
				<span class="request-name"><br>독거어르신 주거환경개선 도움 요청</span>
			</div>
			<div class="content-info" style="text-align: center;">
				<div style="border-top: 3px solid black; padding-top: 1vh; padding-bottom: 1vh;">
					<button class="info-btn">내 정보 가져오기</button>
					<button class="new-btn click_event">새로 작성하기</button>
				</div>
				<div class="div-inline">
					<div class="response-info ">
						<div class="info-title">
							이름<span style="color: white;">이름</span>
						</div>
						<input class="info-text" name="response-name" type="text" placeholder="이름 입력"></input>
					</div>
					<div class="response-info">
						<div class="info-title">소속단체</div>
						<input class="info-text" name="response-org" type="text" placeholder="소속단체 입력"></input>
					</div>
				</div>
				<div class="response-info">
					<div class="info-title">전화번호</div>
					<input class="info-text" name="response-phone" type="text" placeholder="전화번호 입력"></input>
				</div>
				<!-- 공간 맞추기 여백 -->
				<div class="response-info" style="visibility: hidden !important;">
					<div class="info-title">전화번호</div>
					<input class="info-text" type="text" placeholder="전화번호 입력"></input>
				</div>
				<br>
				<textarea class="response-info-content" name="response-content"></textarea>
				<p style="float: left; margin-bottom: 0.5vh; font-weight: bold;">도움을 드리고 싶은 품목의 수량을 입력해주세요!</p>
				<div class="content-needs">
					<table class="info-table">
						<tr>
							<th style="width: 5%;">종류</th>
							<th style="width: 20%;">내역</th>
							<th style="width: 13%;">수량 설정</th>
							<th style="width: 20%;">필요 수량 / 목표 수량</th>
						</tr>
						<tr class="needs-category">
							<td>물품</td>
							<td style="width: 20%;" class="reponse-item">물품1</td>
							<td>
								<div>
									<i class="fas fa-minus minus-icon" onclick="alert('minus');"></i><input type="text" class="response-item-count" name="response-item" placeholder="0" readonly> <i
										class="fas fa-plus plus-icon" onclick="alert('plus');"></i>
								</div>
							</td>
							<td>10 / 30</td>

						</tr>
						<tr>
							<td></td>
							<td>물품2</td>
							<td>
								<div>
									<i class="fas fa-minus minus-icon"></i><input type="text" class="response-item-count" name="response-item" placeholder="0" readonly> <i class="fas fa-plus plus-icon"></i>
								</div>
							</td>
							<td>5 / 10</td>
						</tr>
						<tr>
							<td></td>
							<td>물품3</td>
							<td>
								<div>
									<i class="fas fa-minus minus-icon"></i><input type="text" class="response-item-count" name="response-item" placeholder="0" readonly> <i class="fas fa-plus plus-icon"></i>
								</div>
							</td>
							<td>10 / 20</td>
						</tr>
						<tr class="needs-category">
							<td>봉사</td>
							<td>옮기기</td>
							<td>
								<div>
									<i class="fas fa-minus minus-icon"></i><input type="text" class="response-item-count" name="response-item" placeholder="0" readonly> <i class="fas fa-plus plus-icon"></i>
								</div>
							</td>
							<td>7 / 10</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="modal-ftr" style="justify-content: space-between;">
			<div class="btn-com">완료하기</div>
			<div class="btn-back" onclick="goBack()">
				<span style="color: #e5e5e5; visibility: hidden;">뒤</span>뒤로<span style="color: #e5e5e5; visibility: hidden;">뒤</span>
			</div>
		</div>
	</div>

	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<!-- Navigation-->
		<%@include file="../layout/navbar.jsp"%>

		<header class="bg-primary text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info-small">
					<h4>도움이 필요한 주변 이웃을 확인하세요!</h4>
				</div>
			</div>
		</header>

		<section class="page-section-map text-center " id="portfolio">
			<div class="container ">
				<div style="text-align: right;">
					<input type="text" class="tbox-center tbox-big" placeholder="위치를 검색하세요."> <i class="fas fa-search search-icon"></i>
				</div>
				<div class="sec3-middle">
					<div class="left sec3-middle-left">
						<span class="sec3-text1">돕고 싶은 이웃</span>
						<button class="tbox-center tbox-small">노인</button>
						<button class="tbox-center tbox-small">아이</button>
						<button class="tbox-center tbox-small">장애인</button>
						<button class="tbox-center tbox-small">기타</button>
					</div>
					<div class="left sec3-middle-right">
						<span class="sec3-text1">돕고 싶은 재화</span>
						<button class="tbox-center tbox-small">물품</button>
						<button class="tbox-center tbox-small">재정</button>
						<button class="tbox-center tbox-small">서비스</button>
						<button class="tbox-center tbox-small">기타</button>
					</div>
				</div>
			</div>
			<div class="text-center main-map" id="map"> </div>
			<div class="container ">
				<div class="map-content ">
					<div class="map-left">
						<p class="help-content">주거환경개선 도움</p>
						<p class="help-date">등록일 2020/12/25</p>
					</div>
					<div class="map-mid ">
						<p class="wrapper-status">
							상태 <span class="help-status">응답 대기중</span>
						</p>
						<p>
							기간 <span class="help-term">보통(한 달 이내)</span>
						</p>
					</div>
					<div class="map-mid ">
						<p class="wrapper-status">
							주소 <span class="help-status">포항시 북구 흥해읍</span>
						</p>
						<p>
							문의 <span class="help-term">010-1234-5678</span>
						</p>
					</div>
					<div class="map-right ">
						<span class="help-code">검색코드<input type="text" class="help-code-box"></input><i class="fa fa-clone copy-btn" aria-hidden="true"></i></span> <input type="button" class="help-detail"
							value="자세히 보기"></input>
					</div>
				</div>
			</div>
		</section>
		<!-- news Section-->
		<section class="mypage-section2" id="about" style="text-align: center;">
			<form class="search-div">
				<span class="search-text ">검색코드<input type="text" name="code" class="search-box-mid"></input></span> <span class="search-text">재화종류<select name="search-type" class="search-box-small">
						<option name="all">모두</option>
						<option name="product">물품</option>
						<option name="money">금전</option>
						<option name="service">서비스</option>
				</select>
				</span>
				<div class="temp"></div>
				<span class="search-text">기간<select name="search-period" class="search-box-small">
						<option name="all">보통(한 달 이내)</option>
						<option name="product">긴급(7~14일 이내)</option>
						<option name="money">매우 긴급(3일 이내)</option>
				</select>
				</span> <span class="search-text">주소<input type="text" class="search-box-big"></input>
				</span> <input type="submit" class="search-btn" value="검색"></input>
			</form>
			<div class="container">
				<!-- searech line -->
				<table style="table-layout: fixed">
					<thead>
						<tr style="border-bottom: 3px solid #d3d3d3;">
							<th class="table-num">등록번호</th>
							<th class="table-title">응답 내용</th>
							<th class="table-date">등록일</th>
							<th class="table-status">상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="table-num">#10011</td>
							<td onclick="goDetail();" class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">대기</td>
						</tr>
						<tr>
							<td class="table-num">#10011</td>
							<td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">미승인</td>
						</tr>
						<tr>
							<td class="table-num">#10011</td>
							<td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">승인</td>
						</tr>
						<tr>
							<td class="table-num">#10011</td>
							<td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">대기</td>
						</tr>
						<tr>
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

	</div>
	<!-- Wrapper -->
	<script>
	var lati, longi;
	
	<c:choose>
		<c:when test="${principal.user.loginCount == 0 || empty principal.user.loginCount}">
			lati = 36.1023014256562;
			longi = 129.389266058166;
		</c:when>
		<c:otherwise>
			lati = ${principal.user.latitude};
		  	longi = ${principal.user.longitude};
		</c:otherwise>
	</c:choose>
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(lati, longi), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);
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
