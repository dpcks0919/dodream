<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/main.css" rel="stylesheet" />
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 -->
<title>MapTest</title>
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
			<div class="map_wrap">
				<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
				<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
				<div class="custom_zoomcontrol radius_border">
					<span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span> <span onclick="zoomOut()"><img
						src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
				</div>
			</div>

		</div>

		<%@include file="../layout/jsFile.jsp"%>
		<%@include file="../layout/kakaoMap.jsp"%>
		<script src="/js/map.js"></script>
</body>
</html>