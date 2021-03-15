<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<link href="/css/manager.css" rel="stylesheet" />
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
			<!-- 위에까지 고정. 이 밑에부터 manager1, manager2, manager3, manager3로 나뉘기. -->
			
			
			<!-- 회원관리 
			id / 이름 / userType / 등록일 / 
			-->
			
			<section class="manager1">
				
			</section>
			
			<!-- 요청 관리 -->
			<section class="manager2" >	
			
			</section>
			
			<!-- 응답 관리 -->
			<section class="manager3" >
				
			</section>
		</div>

	
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>
		<%@include file="../layout/jsFile.jsp"%>
	<%@include file="../layout/kakaoMap.jsp"%>
	<script src="/js/dodreamtouch.js"></script>
	
	<script>
	
	
	$(document).ready(function() {
		$(".manager-menu").on("click", function() {
			$(".manager-menu").removeClass('selected-menu');
			$(this).addClass('selected-menu');		 
		});
	});
	
	// 두드림터치 주소
	var lati = 36.111029;
	var longi = 129.396592;	
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(lati, longi), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};


	
	</script>
</body>
</html>
