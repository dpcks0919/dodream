<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<link href="/css/manager.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<style>
.complete_event {
	color: #d5d5d5;
}
</style>

<body id="page-top">
	<div class="modal-bg" id="modal-bg" onclick="closeModal();"></div>
	<!-- 세부정보 살펴보기 -->
	<div class="modal-container" id="view-detail">
		<div class="modal-content" id="detail-content"></div>
	</div>

	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper" style="width: 100%;">
		<!-- Navigation-->
		<%@include file="../layout/navbar.jsp"%>		
		<header class="bg-primary text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info" style="height:auto;">
				<div class="reg-info" style="margin-bottom:2rem;">
					<h4>관리자 페이지</h4>
					<p>회원, 요청, 응답에 대해 관리하실 수 있습니다.</p>
				</div>
			</div>
		</header>
		<div class="container ">
			<div class="manager-menubar">
				<div class="manager-menu selected-menu" onclick="menuToggle(1);">회원 관리</div>
				<div class="manager-menu" onclick="menuToggle(2);">요청 관리</div>
				<div class="manager-menu" onclick="menuToggle(3);">응답 관리</div>
			</div>
			<div class="" id="table-wrapper"></div>
		</div>
		
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>
		<%@include file="../layout/jsFile.jsp"%>
	<%@include file="../layout/kakaoMap.jsp"%>
	<script src="/js/manager.js"></script>
	
	<script>

	$(document).ready(function() {
		// 처음 회원관리 로드
		menuToggle(1);
		
		// menu 선택 시 효과
		$(".manager-menu").on("click", function() {
			$(".manager-menu").removeClass('selected-menu');
			$(this).addClass('selected-menu');
			
		});
	});



	
	</script>
</body>
</html>
