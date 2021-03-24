<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="layout/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<link href="/css/main.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body id="page-top">
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="layout/sidebar_front.jsp"%>

	<div id="Wrapper" style="width: 100%;">
		<!-- Navigation-->
		<%@include file="layout/navbar.jsp"%>

		<!-- Carousel header -->
		<header class="carousel-masthead text-white text-center">
			<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li class="first-link" data-target="#carouselExampleCaptions" data-slide-to="0"></li>
					<li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
					<li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img src="image/Main1.png" class="d-block w-100 mainImage-web" alt="...">
						<img src="image/Main1_mobile.png" class="d-block w-100 mainImage-mobile" alt="...">
						<div class="carousel-caption1 d-md-block mainImage-web">
							<a class=" rounded main1-register" href="/news/newsList">소식 보기</a>
						</div>
						<div class="carousel-caption1_mobile d-md-block mainImage-mobile">
							<!-- 
								<p class="main1-register-text_mobile">이번 달에는 어떤 도움의 손길들이 있었을까요?</p>
							 -->
							<a class=" rounded main1-register main1-register_mobile" href="/news/newsList">소식 보기</a>
						</div>
					</div>
					<div class="carousel-item">
						<img src="image/Main2.png" class="d-block w-100 mainImage-web" alt="...">
						<img src="image/Main2_mobile.png" class="d-block w-100 mainImage-mobile" alt="...">
						<div class="carousel-caption2 d-md-block mainImage-web">
							<a class="py-2 rounded js-scroldl-trigger main3-register " href="/dodreamtouch">자세히 보기</a>
						</div>
						<div class="carousel-caption3_mobile d-md-block mainImage-mobile">
							<a class="py-2 rounded js-scroll-trigger main3-register" href="/dodreamtouch">자세히 보기</a>
						</div>
						<iframe class="carousel-youtube" src="https://www.youtube.com/embed/9Yfaj0oTw18" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
							allowfullscreen></iframe>
					</div>
					<div class="carousel-item">
						<img src="image/Main3.png" class="d-block w-100 mainImage-web" alt="...">					
						<img src="image/Main3_mobile.png" class="d-block w-100 mainImage-mobile" alt="...">
						<div class="carousel-caption3 d-md-block mainImage-web">
							<a class="py-2 rounded js-scroll-trigger main3-register" href="/requestMap">요청 보기</a>
						</div>
						<div class="carousel-caption3_mobile d-md-block mainImage-mobile">
						<!-- 
							<h3 style="font-size:1rem; font-weight:bold; color:#ed7e95;">두드림이 있는 곳에 손길을</h3>
							<p style="font-size:0.75rem;">돕는다는 것은,<br>함께 하는 것입니다.</p>
							<p style="font-size:0.75rem;">아름다운 세상을 위한 변화,<br>당신의 손길로 시작됩니다.</p>
							<p style="font-size:0.75rem;">"네 이웃을 네 몸과 같이 사랑하라"</p>
						
						 -->
							<a class="py-2 rounded js-scroll-trigger main3-register" href="/requestMap">요청 보기</a>
						</div>
					</div>
				</div>
				<a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev"> 
				<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
				<span class="sr-only">Previous</span>
				</a> 
				<a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next"> 
				<span class="carousel-control-next-icon" aria-hidden="true"></span> 
				<span class="sr-only">Next</span>
				</a>
			</div>
		</header>
		<!-- map Section -->
		<section class="page-section3 help text-center " id="portfolio">
			<p class="text-center text-uppercase text-secondary mb-0 page-section3-title">
				내 주변에는 어떤 이웃이 도움을 필요로 할까요?<br>지금 바로 지도를 통해 확인해 보세요!
			</p>
			<div class="container">
				<div style="text-align: right;">
					<input type="text" class="tbox-center tbox-big" onkeyup="enterkey();" placeholder="위치를 검색하세요." id="input-addr">
					<div id="btn-search">
						<img class="search-icon" src="image/search-icon.png" />
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
						<button class="tbox-center tbox-small" id="btn-stuff">물품</button>
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
						<span id="btnRoadmap" class="btn" onclick="setMapType('roadmap')">지도</span> <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
					</div>
					<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
					<div class="custom_zoomcontrol radius_border">
						<span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span> <span onclick="zoomOut()"><img
							src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
					</div>
				</div>

				<div class="container-sec3">
					<div class="sec3-bottom-right-tmp left">
						<p style="color: white;" class="sec3-bottom-right-title">
							어떤 도움이든, <br>당신의 도움은 시작이 됩니다.
						</p>
						<span style="color: white; margin-bottom: 7vw; font-weight: bold;" class="sec3-bottom-right-content">나의 손길이 하나의 시작이 되다.</span> 
						<c:choose>
							<c:when test="${principal.user.loginCount == 0 || empty principal.user.loginCount}">
								<a class="py-2 rounded js-scroll-trigger main4-register" href="/loginForm">시작하기</a>
							</c:when>
							<c:otherwise>
								<a class="py-2 rounded js-scroll-trigger main4-register" href="/requestMap">시작하기</a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="sec3-bottom-left left ">
						<div class="four_box">
							<img class="fbox-image" src="image/product.png">
							<p class="fbox-title">물품</p>
							<p class="fbox-content">나에게 작은 것이 누군가에게는</p>
							<p class="fbox-content">소중한 것이 될 수 있습니다.</p>
						</div>
						<div class="four_box">
							<img class="fbox-image" src="image/money.png">
							<p class="fbox-title">재정</p>
							<p class="fbox-content">작은 금액이라도</p>
							<p class="fbox-content">누군가의 삶을 바꾸실 수 있습니다.</p>
						</div>
						<div class="four_box">
							<img class="fbox-image" src="image/service.png">
							<p class="fbox-title">서비스</p>
							<p class="fbox-content">우리 주변에는 봉사, 멘토링 등을</p>
							<p class="fbox-content">필요로 하는 곳이 많습니다.</p>
						</div>
						<div class="four_box">
							<img class="fbox-image" src="image/plus.png">
							<p class="fbox-title">기타</p>
							<p class="fbox-content">두드림 터치는 주변의 다양한 필요를</p>
							<p class="fbox-content">확인할 수 있게 해줍니다.</p>
						</div>
					</div>
					<div class="sec3-bottom-right left ">
						<p style="color: white;" class="sec3-bottom-right-title">
							어떤 도움이든, <br>당신의 도움은 시작이 됩니다.
						</p>
						<h4 style="color: white; margin-bottom: 7vw;" class="sec3-bottom-right-content">
							나의 손길이 하나의 시작이 되다.
						</h4>
						<c:choose>
							<c:when test="${principal.user.loginCount == 0 || empty principal.user.loginCount}">
								<a class="py-2 rounded js-scroll-trigger main4-register" href="/loginForm">시작하기</a>
							</c:when>
							<c:otherwise>
								<a class="py-2 rounded js-scroll-trigger main4-register" href="/requestMap">시작하기</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</section>
		<!-- news Section-->
		<section class="page-section-news" id="about" style="text-align: center;">
			<div class="container-news">
				<!-- About Section Heading-->
				<div class="news-title-div">
					<div class="news-title-line"></div>
					<div class="news-title">두드림터치 소식</div>
					<div class="news-title-line"></div>
				</div>
				<div class="news-body" style="height:auto;">
					<div class="news-body-left">
						<c:set var="topCount" value="1" />
						<c:forEach var="top" items="${recentNews}">
							<div class="image-inline">
							<c:choose>
								<c:when test="${topCount == 1 }">
									<div class="four_box-news" onclick="newsDetail('${top.id}');">
										<img class="news-image" id="topImg${topCount}" src="" >
										<div class="news-image-title">${top.title}</div>
									</div>
								</c:when>
								<c:when test="${topCount == 2 }">
									<div class="four_box-news" onclick="newsDetail('${top.id}');">
										<img class="news-image" id="topImg${topCount}" src="" >
										<div class="news-image-title">${top.title}</div>
									</div>
								</c:when>
							</c:choose>
							</div>
							
							<div class="image-inline">
							<c:choose>
								<c:when test="${topCount == 3 }">
									<div class="four_box-news" onclick="newsDetail('${top.id}');">
										<img class="news-image" id="topImg${topCount}" src="" >
										<div class="news-image-title">${top.title}</div>
									</div>
								</c:when>
								<c:when test="${topCount == 4 }">
									<div class="four_box-news" onclick="newsDetail('${top.id}');">
										<img class="news-image" id="topImg${topCount}" src="" >
										<div class="news-image-title">${top.title}</div>
									</div>
								</c:when>
							</c:choose>
								<script>
									// 첫 img 태그만 잘라서 보여주는 태그
									var realImg = "/image/news2.jpeg";
									var fullStr = '${top.content}';
									var strArray = fullStr.split('<p>');
									if(fullStr.includes('<img')){
										for(var i=0; i<strArray.length; i++) {
											if(strArray[i].includes('<img')) {
												var strDetail = strArray[i].split('src="')[1];
												var realImg = strDetail.split('"')[0];
												var imgId = "topImg"+${topCount};
												document.getElementById(imgId).src= realImg;
												break;
											}
										};
									}else{
										document.getElementById(imgId).src= realImg;
									}	
								</script>							
							
							</div>
							<c:set var="topCount" value="${topCount + 1}" />
						</c:forEach>
					</div>
					
					
					<div class="news-body-right">
						<!-- 소식에 대한 리스트 -->
						<c:set var="rightCount" value="1" />
						<c:forEach var="right" items="${recentNews}">
							<c:choose>
								<c:when test="${rightCount < 10}">
									<fmt:formatDate value="${right.regDate}" pattern="MM.dd" var="rightRegdate" />
									<p class="news-body-right-content" onclick="newsDetail('${right.id}');">[${rightRegdate} 두드림터치 소식] ${right.title}</p>	
								</c:when>
							</c:choose>
							<c:set var="rightCount" value="${rightCount + 1}" />
						</c:forEach>
					</div>
				</div>
			</div>
		</section>

		<!-- Contact Section-->
		<section class="page-section-join" id="join">
			<div class="container">
				<div class="container-join text-white">
					<h4 style="margin-bottom:2rem;">두드림터치와 함께하기</h4>
					<p style="margin-bottom:2rem;">기관/사회복지사가 도움이 필요한 이웃의 필요를 발견하고<br>두드림터치 플랫폼에 등록하면 요청사항들이 두드림터치를 통해<br>지역교회/커뮤니티로 전달됩니다.</p>
					<p style="margin-bottom:2rem;">두드림터치와 함께 이웃을 돕고 싶으신 분들을 찾습니다.</p>
					<c:choose>
						<c:when test="${principal.user.loginCount == 0 || empty principal.user.loginCount}">
							<a class=" rounded join-btn" href="/loginForm">가입하기</a>
					</c:when>
					<c:otherwise>
							<a class=" rounded join-btn" href="/requestList">요청보기</a>
					</c:otherwise>
					</c:choose>
					
				</div>
			</div>
		</section>
		<!-- Footer-->
		<%@include file="layout/footer.jsp"%>
	</div>
	<%@include file="layout/sidebar_back.jsp"%>

	<%@include file="layout/jsFile.jsp"%>
	<%@include file="layout/kakaoMap.jsp"%>
	<script type="text/javascript" src="/js/map.js"></script>
	<script>
	
	function newsDetail(newsId) {
		location.href="/news/newsDetail/"+newsId;
	}
	
	function enterkey() {
        if (window.event.keyCode == 13) {
        	var addr = $("#input-addr").val()
			mapInit.searchAndLocate(addr);
        }
	}
	
	var isIndexPage = true;	// index page인지 판별하는 변수(map.js에서 구분 위해 필요)
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

	var map = new kakao.maps.Map(mapContainer, mapOption);
	</script>

</body>
</html>
