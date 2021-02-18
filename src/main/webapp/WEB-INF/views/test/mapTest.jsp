<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>다른 이미지로 마커 생성하기</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" rel="stylesheet" />
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/nav_footer.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
html, body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

.map_wrap {
	position: relative;
	overflow: hidden;
	width: 100%;
	height: 350px;
}

.radius_border {
	border: 1px solid #919191;
	border-radius: 5px;
}

.custom_typecontrol {
	position: absolute;
	top: 10px;
	right: 10px;
	overflow: hidden;
	width: 130px;
	height: 30px;
	margin: 0;
	padding: 0;
	z-index: 1;
	font-size: 12px;
	font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
}

.custom_typecontrol span {
	display: block;
	width: 65px;
	height: 30px;
	float: left;
	text-align: center;
	line-height: 30px;
	cursor: pointer;
}

.custom_typecontrol .unselected_btn {
	background: #fff;
	background: linear-gradient(#fff, #e6e6e6);
}

.custom_typecontrol .unselected_btn:hover {
	background: #f5f5f5;
	background: linear-gradient(#f5f5f5, #e3e3e3);
}

.custom_typecontrol .unselected_btn:active {
	background: #e6e6e6;
	background: linear-gradient(#e6e6e6, #fff);
}

.custom_typecontrol .selected_btn {
	color: #fff;
	background: #425470;
	background: linear-gradient(#425470, #5b6d8a);
}

.custom_typecontrol .selected_btn:hover {
	color: #fff;
}

.custom_zoomcontrol {
	position: absolute;
	top: 50px;
	right: 10px;
	width: 36px;
	height: 80px;
	overflow: hidden;
	z-index: 1;
	background-color: #f5f5f5;
}

.custom_zoomcontrol span {
	display: block;
	width: 36px;
	height: 40px;
	text-align: center;
	cursor: pointer;
}

.custom_zoomcontrol span img {
	width: 15px;
	height: 15px;
	padding: 12px 0;
	border: none;
}

.custom_zoomcontrol span:first-child {
	border-bottom: 1px solid #bfbfbf;
}
</style>

</head>
<body>

	<div class="container ">
		<div style="text-align: right;">
			<input type="text" class="tbox-center tbox-big" placeholder="위치를 검색하세요." id="input-addr">
			<div id="btn-search">
				<i class="fas fa-search search-icon"></i>
			</div>
		</div>
		<div class="sec3-middle ">
			<div class="left sec3-middle-left">
				<span class="sec3-text1">돕고 싶은 이웃</span>
				<button class="tbox-center tbox-small" id="btn-elderly">노인</button>
				<button class="tbox-center tbox-small" id="btn-child">아이</button>
				<button class="tbox-center tbox-small" id="btn-disabled">장애인</button>
				<button class="tbox-center tbox-small" id="btn-others">기타</button>
			</div>
			<div class="left sec3-middle-right">
				<span class="sec3-text1">돕고 싶은 재화</span>
				<button class="tbox-center tbox-small" id="btn-goods">물품</button>
				<button class="tbox-center tbox-small" id="btn-finance">재정</button>
				<button class="tbox-center tbox-small" id="btn-service">서비스</button>
				<button class="tbox-center tbox-small" id="btn-etc">기타</button>
			</div>
			<br>

		</div>

		<div class="map_wrap">
			<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
			<!-- 지도타입 컨트롤 div 입니다 -->
			<div class="custom_typecontrol radius_border">
				<span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span> 
				<span id="btnSkyview" class="unselected_btn" onclick="setMapType('skyview')">스카이뷰</span>
			</div> 
			<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
			<div class="custom_zoomcontrol radius_border">
				<span onclick="zoomIn()"> + </span><span onclick="zoomOut()"> - </span>
			</div>
		</div>


		<!-- Kakao Maps API -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4407e6aa270afe5752d07352835fb75f&libraries=services"></script>
		<!-- Bootstrap core JS-->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
		<!-- Third party plugin JS-->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
		<script type="text/javascript" src="/js/map.js"></script>
</body>
</html>