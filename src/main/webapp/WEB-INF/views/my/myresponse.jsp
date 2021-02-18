<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/mypage.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body id="page-top">

	<div class="modal-bg" id="m-background" style="display: none;" onclick="closeModal();"></div>
	<div class="modal-container" id="m-container" style="display: none;">
		<div class="modal-content">
			<div class="content-title">
				<h4>응답확인</h4>
				<span style="margin-top: 10px; margin-right: 5px;">독거어르신 주거환경개선 도움 요청</span>
			</div>
			<div class="content-info">
				<table class="info-table">
					<tr>
						<td style="width: 17.5%;"><b>등록날짜</b></td>
						<td style="width: 37.5%;">2020.12.26.</td>
						<td style="width: 15%;"><b>상태</b></td>
						<td style="width: 30%;">승인</td>
					</tr>
					<tr>
						<td><b>주소</b></td>
						<td>경상북도 포항시 북구 흥해읍</td>
						<td><b>요청자</b></td>
						<td>요청을 올린 사회복지사/기관</td>
					</tr>
				</table>
				<div class="content-text">독거어르신 주거환경개선을 위해 도와드리고 싶습니다. 블라블라 뭐라고 하면 좋을까요? 아무튼 여기는 응답자가 직접 작성한 내용이 보여지는 곳입니다.</div>
				<div class="content-needs">
					<table class="info-table">
						<tr>
							<th style="width: 15%;">종류</th>
							<th style="width: 40%;">내역</th>
							<th style="width: 45%;">수량</th>
						</tr>
						<tr class="needs-category">
							<td>물품</td>
							<td>물품1</td>
							<td>2개</td>
						</tr>
						<tr>
							<td></td>
							<td>물품2</td>
							<td>3개</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="modal-ftr" style="height: 15vh; margin-top: 5vh;">
			<div class="response-wrapper">
				<div class="response-title">요청자 회신</div>
				<div class="response-content">안녕하세요. 요청올린 사회복지사 임터치입니다. 먼저 이렇게 응답해주셔서 정말 감사드립니다. 보내주신 품목은 블라블라블라 저희가 따로 문자 보내드리겠습니다:)</div>
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
					<h4>응답내역</h4>
					<p>
						지금까지 응답하신 내역들을<br>모두 확인할 수 있습니다.
					</p>
				</div>
			</div>
		</header>
		<!-- news Section-->
		<section class="mypage-section2" id="about" style="text-align: center;">
			<div class="container ">
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
						<tr class="response-item" onclick="openModal(this);">
							<td class="table-num">#10011</td>
							<td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">대기</td>
						</tr>
						<tr class="response-item" onclick="openModal(this);">
							<td class="table-num">#10011</td>
							<td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">미승인</td>
						</tr>
						<tr class="response-item" onclick="openModal(this);">
							<td class="table-num">#10011</td>
							<td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">승인</td>
						</tr>
						<tr class="response-item" onclick="openModal(this);">
							<td class="table-num">#10011</td>
							<td class="table-title fbold">독거 어르신 주거 환경 개선을 위해 도와드리고 싶습니다.</td>
							<td class="table-date">2020.12.26</td>
							<td class="table-status">대기</td>
						</tr>
						<tr class="response-item" onclick="openModal(this);">
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
	<%@include file="../layout/jsFile.jsp"%>

	<script>
		function openModal(item) {
			document.getElementById("m-background").style.display = "block";
			document.getElementById("m-container").style.display = "block";
			document.getElementById("mainNav").style.zIndex = "9";
			document.getElementById("menu-back").style.filter = "blur(5px)";
			document.getElementById("Wrapper").style.filter = "blur(5px)";
		}
		function closeModal() {
			document.getElementById("m-background").style.display = "none";
			document.getElementById("m-container").style.display = "none";
			document.getElementById("menu-back").style.filter = "none";
			document.getElementById("Wrapper").style.filter = "none";
		}
	</script>
</body>
</html>
