<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/mypage.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<style>
.complete_event {
	color: #d5d5d5;
}
</style>

<body id="page-top">
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper" style="width: 100%;">
		<!-- Navigation-->
		<%@include file="../layout/navbar.jsp"%>


		<header class="bg-primary text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>나의 두드림</h4>
					<p>
						지금까지 찜하신 목록들을 확인할 수 있습니다.<br>
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
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>
	<%@include file="../layout/jsFile.jsp"%>
</body>
</html>
