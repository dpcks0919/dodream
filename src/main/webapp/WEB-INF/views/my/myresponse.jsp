<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/view-reg.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<style>
</style>

<body id="page-top">
	<div class="modal-bg" id="modal-bg" onclick="closeModal();"></div>

	<!-- 요청 항목 세부정보 보기 -->
	<div class="modal-container" id="view-detail">
		<div class="modal-content">
			<div id="rq_title"></div>
			<div class="content-info">
				<table class="info-table">
					<tr>
						<td style="width: 17.5%;"><b>등록번호</b></td>
						<td id="rq_id" style="width: 27.5%;"></td>
						<td style="width: 17.5%;"><b>등록날짜</b></td>
						<td id="rq_date" style="width: 37.5%;"></td>
					</tr>
					<tr>
						<td><b>상태</b></td>
						<td id="rq_status"></td>
						<td><b>주소</b></td>
						<td id="rq_addr"></td>
					</tr>
					<tr>
						<td><b>기간</b></td>
						<td id="rq_level"></td>
						<td><b>요청기관</b></td>
						<td id="rq_user"></td>
					</tr>
				</table>
				<div class="content-text" id="rq_contents"></div>
				<div class="content-needs">
					<table class="info-table">
						<tr>
							<th style="width: 17.5%;">종류</th>
							<th style="width: 27.5%;">내역</th>
							<th style="width: 55%;">내 수량 / 현재 수량 / 목표 수량</th>
						</tr>
						<tr class="needs-category" id="rq_item0"></tr>
					</table>
				</div>
			</div>
			<div class="response-wrapper" id="response-wrapper"  style="display:none">
				<div class="response-title">요청자 회신</div>
				<div class="response-content" id="response-content"></div>
			</div>
		</div>
		<div class="modal-container" id="view-responseForm"></div>
		<!-- modal.js에 click event 생성 -->
		<div class="modal-ftr" style="justify-content: space-between;">
			<div class="btn-com" id="btn-com">수정하기</div>
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
				<div class="reg-info">
					<h4>나의 두드림</h4>
					<p>
						지금까지 찜하신 목록들을 확인할 수 있습니다.<br>
					</p>
				</div>
			</div>
		</header>
		<section class="page-section-map text-center " id="portfolio">
			<div class="container">
				<div class="request-table"></div>
			</div>
		</section>
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
		<%@include file="../layout/sidebar_back.jsp"%>
	</div>

	<%@include file="../layout/jsFile.jsp"%>
	<script src="/js/request.js"></script>

	<script>
		function initPage() {
			$.ajax({
				type : "GET",
				traditional : true,
				url : "/user/myResposeTable",
			}).done(function(resp) {
				if (resp.status == 500) {
					alert("에러발생");
				} else {
					$(".request-table").html(resp);
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
		}

		function paging(page) {

			$.ajax({
				type : "GET",
				traditional : true,
				url : "/user/myResposeTable?page=" + page
			}).done(function(resp) {
				if (resp.status == 500) {
					alert("에러발생");
				} else {
					$(".request-table").html(resp);
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
		}

		$(document).ready(function() {
			initPage();
		});
	</script>

</body>
</html>