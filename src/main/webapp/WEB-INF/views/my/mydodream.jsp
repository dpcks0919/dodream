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
				<div class="div-table">	
					<div class="div-table-wrapper">
						<div class="div-table-left">
							<div class="div-table-title"><b>등록번호</b></div><span class="input-span" id="rq_id"></span>
						</div>
						<div class="div-table-right">
							<div class="div-table-title"><b>등록날짜</b></div><span class="input-span" id="rq_date"></span>
						</div>
					</div>
					<div class="div-table-wrapper">
						<div class="div-table-left">
							<div class="div-table-title"><b>상태<span style="visibility:hidden;">상태</span></span></b></div><span class="input-span" id="rq_status"></span>
						</div>
						<div class="div-table-left">
							<div class="div-table-title"><b>요청기관</b></div><span class="input-span" id="rq_user"></span>
						</div>
					</div>					
					<div class="div-table-wrapper">
						<div class="div-table-title"><b>기간<span style="visibility:hidden;">기간</span></span></b></div><span class="input-span" id="rq_level"></span>
					</div>								
					<div class="div-table-wrapper">
						<div class="div-table-title"><b>주소<span style="visibility:hidden;">주소</span></b></div><span class="input-span" id="rq_addr"></span>
					</div>				
				</div>
				<div class="content-text" id="rq_contents"></div>
				<div class="content-needs">
					<table class="info-table">
						<tr>
							<th style="width: 17.5%;">종류</th>
							<th style="width: 27.5%;">내역</th>
							<th style="width: 55%;">현재 수량 / 목표 수량</th>
						</tr>
						<tr class="needs-category" id="rq_item0"></tr>
					</table>
				</div>
			</div>
		</div>

		<div class="modal-ftr">
			<div class="btn-res" onclick="goResponse()">응답하기</div>
			<div class="btn-icon" onclick="heartClick();">
				<i class="far fa-heart" id="btn-heart"></i>
				<i class="fas fa-heart" id="btn-heart2" style="display:none"></i>
			</div>
			<div class="btn-close " onclick="closeModal();">창 닫기</div>			
		</div>
	</div>
	<!-- 응답하기 -->
	<div class="modal-container" id="view-responseForm">
		<div class="modal-content">
			<div class="" style="vertical-align: text-bottom !important;">
				<h5 style="float: left">응답하기</h5>
				<span class="request-name" id="rq_title2"><br></span>
			</div>
			<div class="content-info" style="text-align: center;">
				<div class="" style="border-top: 3px solid black; height: 4rem !important; padding-top: 1vh; padding-bottom: 1vh;">
					<button class="info-btn" id="myInfo" onclick="bringInfo('myInfo', '${user.userName}', '${user.userPhone}', '${user.orgName}')">내 정보 가져오기</button>
					<button class="new-btn click_event" id="newInfo" onclick="bringInfo('newInfo', '${user.userName}', '${user.userPhone}', '${user.orgName}')">새로 작성하기</button>
				</div>
				<div class="div-inline">
					<div class="response-info ">
						<div class="info-title">
							이름<span style="color: white;">이름</span>
						</div>
						<input class="info-name info-text" name="response-name" id="reply_user" type="text" value="${user.userName}" placeholder="이름 입력"></input>
					</div>
					<div class="response-info">
						<div class="info-title">소속단체</div>
						<input class="info-group info-text" name="response-org" id="reply_org" type="text" value="${user.orgName}" placeholder="소속단체 입력"></input>
					</div>
				</div>
				<div class="response-info">
					<div class="info-title">전화번호</div>
					<input class="info-phone info-text" name="response-phone" id="reply_phone" type="text" value="${user.userPhone}" placeholder="전화번호 입력"></input>
				</div>
				<!-- 공간 맞추기 여백 -->
				<div class="response-info margin-info" style="visibility: hidden !important;">
					<div class="info-title">전화번호</div>
					<input class="info-text" type="text" placeholder="전화번호 입력"></input>
				</div>
				<br>
				<textarea class="response-info-content" name="response-content" id="reply_content"></textarea>
				<p style="float: left; margin-bottom: 0.5vh; font-weight: bold;">도움을 드리고 싶은 품목의 수량을 입력해주세요!</p>
				<div class="content-needs">
					<table class="info-table">
						<tr>
							<th style="width: 10%;">종류</th>
							<th style="width: 30%;">내역</th>
							<th style="width: 30%;">수량 설정</th>
							<th style="width: 30%;">필요 수량</th>
						</tr>
						<tr class="needs-category" id="rp_item0"></tr>
					</table>
				</div>
			</div>
		</div>
		<!-- modal.js에 click event 생성 -->
		<div class="modal-ftr" style="justify-content: space-between;">
			<div class="btn-com" id="btn-com">완료하기</div>
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
				<div class="reg-info">
					<h4>나의 두드림</h4>
					<p>
						지금까지 찜하신 요청들을 확인할 수 있습니다.<br>
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
				url : "/user/interestedRequestTable",
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
				url : "/user/interestedRequestTable?page=" + page
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