<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<link href="/css/dodreamtouch.css" rel="stylesheet" />
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
				<div class="reg-info ">
					<h4>두드림터치는 기독교 정신을 기반으로 지역공동체를 통해</h4>
					<h4>소외된 이웃이 없는 세상을 만들어갑니다.</h4>
					<div class="reg-bottom ">
						<div class="">
							<p><b>교회 기업소개서</b></p>
							<a class="donwload-btn" target="_blank" href="/download/download-church.pdf"><b>다운로드</b></a>
						</div>
						<div style="width:2rem;"></div>
						<div class="">
							<p><b>기관 기업소개서</b></p>
							<a class="donwload-btn" target="_blank" href="/download/download-organization.pdf"><b>다운로드</b></a>
						</div>
					</div>
				</div>
			</div>
		</header>
		<div class="container ">
			<div class="intro-menubar">
				<div class="intro-menu selected-menu" onclick="menuToggle(1);">미션</div>
				<div class="intro-menu" onclick="menuToggle(2);">성장</div>
				<div class="intro-menu" onclick="menuToggle(3);">조직도</div>
				<div class="intro-menu" onclick="menuToggle(4);">오시는 길</div>
			</div>
			<!-- 위에까지 고정. 이 밑에부터 intro1, intro2, intro3, intro3로 나뉘기. -->
			
			<!-- 미션 -->
			<section class="intro1">
				<section class="intro1-section1">
					<div class="intro1-section1-content">
					<h4 class="intro1-section1-title">두드림이 있는 곳에 손길을</h4>
						<p class="intro-section1-title1 text-dodream"><b>두드림터치는 기독교 정신을 바탕으로 공동체가 이웃에게 손을 내밀 수 있도록 하는 단체입니다.</b></p>
						<p>모든 사람들에게는 공동체가 필요합니다. 개인으로서 할 수 있는 일들은 제한되어 있지만,</p>
						<p>우리 사회에 있는 수많은 공동체들의 도움을 받는다면 우리는 보다 나은 세상을 만들 수 있을 것입니다.</p>
						<p>코로나19로 인해 사회의 각종 교류가 단절되면서 소외된 이웃이 늘어나고 있습니다. 여러 기관과 사회복지사들이</p>
						<p>최전선에서 이들을 돌보고 있지만, 자원과 서비스가 제한되어 있는 상태입니다. 반면 우리 사회에는 오랜 시간 사회를</p>
						<p>지켜왔던 공동체들이 있습니다.</p>
						<p class="intro-section1-title2 text-dodream"><b>어두운 현실 속에서 두드림터치가 부디 모두에게 새로운 다리가 될 수 있기를 소망합니다.</b></p>
					</div>
					<div class="responsive-intro1-section1-content">
						<h4 class="intro1-section1-title">두드림이 있는 곳에 손길을</h4>
						<p class="intro-section1-title1 text-dodream"><b>두드림터치는 기독교 정신을 바탕으로 공동체가 이웃에게 손을 내밀 수 있도록 하는 단체입니다.</b></p>
						<p>모든 사람들에게는 공동체가 필요합니다. 개인으로서 할 수 있는 일들은 제한되어 있지만,</p>
						<p>우리 사회에 있는 수많은 공동체들의 도움을 받는다면 우리는 보다 나은 세상을 만들 수 있을 것입니다.</p>
						<p>코로나19로 인해 사회의 각종 교류가 단절되면서 소외된 이웃이 늘어나고 있습니다.</p> 
						<p>여러 기관과 사회복지사들이 최전선에서 이들을 돌보고 있지만, 자원과 서비스가 제한되어 있는 상태입니다. 반면 우리 사회에는 오랜 시간 사회를 지켜왔던 공동체들이 있습니다.</p>
						<p class="intro-section1-title2 text-dodream"><b>어두운 현실 속에서 두드림터치가 부디 모두에게 새로운 다리가 될 수 있기를 소망합니다.</b></p>
					</div>
					<div class="intro1-section1-wrap "> 
						<div class="wrap-content"> 
							<iframe class="intro1-section1-youtube" src="https://www.youtube.com/embed/9Yfaj0oTw18" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe> 
						</div>
					</div>
				</section>			
				<section class="intro1-section2">
					<div class="mission-top"><img src="/image/mission-top.png" /></div>
					<p class="text-dodream" style="width:100%; text-align:center; margin-bottom:0.5rem;"><b>두드림터치는 이웃과 공동체를 연결합니다.</b></p>
					<p style="width:100%; text-align:center; margin-bottom:2rem;">사회복지사/기관이 이웃의 필요성을 발견하면 지역 커뮤니티로 사연을 전달하는 사회복지 기술 플랫폼입니다.</p>
					<div class="mission-mid-wrapper">
						<div class="mission-mid">
							<img class="" src="/image/mission-mid-text.png" />
						</div>
						<div class="mission-mid-text" hidden>
							<div class="">
								<p>도움이 필요한<br>가정발생</p>
								<p>사회복지사<br>방문</p>
								<p>사회복지사/기관이<br>요청을 입력</p>
								<p>지역 커뮤니티<br>응답</p>
								<p>도움을 받음</p>
							</div>
						</div>
						<div class="mission-mid-three">
							<div>
								<p class="text-dodream" style="margin-bottom:0.5rem;"><b>네트워크</b></p>
								<p>두드림터치는 지역 타게팅 기술과 풍부한 네트워크를 활성화시켜 필요한 만남이 신속히 이루어지도록 합니다.</p>
							</div>
							<div>
								<p class="text-dodream" style="margin-bottom:0.5rem;"><b>투명성</b></p>
								<p>자원을 효율적으로 사용하고, 투명하게 관리 및 보고합니다.</p>
							</div>
							<div>
								<p class="text-dodream" style="margin-bottom:0.5rem;"><b>IT기술</b></p>
								<p>IT기술을 바탕으로 개인과 지역사회를 연결하며 복지사각지대를 없애고 건강한 사회를 만들어 나갑니다.</p>							
							
							</div>
						</div>
					</div>
				</section>
				<section class="intro1-section3 ">
					<div class="intro1-section3-wrapper">
						<div class="intro1-section3-top ">
							<div class="intro1-section3-div">
								<h4 class="intro1-section3-title text-dodream">구세군 포항사랑교회</h4>
								<img class="responsive-intro1-section3-image" src="/image/intro-right.jpeg"/>
								<p>실질적으로 어려운 이웃을 돕고 싶다는 마음이 간절했는데, 쉽지 않더라고요. 그러던 중 우연히 팸플릿을 통해 두드림터치를 알게 되었고, 나의 생각과 딱 맞는 일을 하고 있다는 생각을 하게 되었어요. 복지 사각지대에 계신 분들이 정말 많아요. 제 주변에도 수급자 선정이 되지 못했지만 자녀가 있으셔서 힘들어하시는 분이 계시거든요. 이렇게 사각지대에 계신 분들을 잘 찾아주셔서, 감사하고 저희도 정말 조그마한 것이지만 저희의 손길을 통해서 그분들이 힘을 얻을 수 있으면 좋겠습니다.</p>
							</div>
							<div class="intro1-section3-image">
								<p class="text-white-hidden">something</p>
								<img src="/image/intro-right.jpeg"/>
							</div>
						</div>
						<div class="intro1-section3-bottom ">
							<div class="intro1-section3-image">
								<p class="text-white-hidden">something</p>
								<img src="/image/intro-left.jpeg" />
							</div>
							<div class="intro1-section3-div">
								<h4 class="intro1-section3-title text-dodream">좋은 이웃 노인복지센터</h4>
								<img class="responsive-intro1-section3-image" src="/image/intro-left.jpeg" />
								<p>저희는 요청을 올리고 후원을 받는 입장이라, 늘 감사한 마음을 가지고 있습니다. 정말 힘들 어르신들을 보면 저희가 할 수 있는 일이 ‘두드리는 일’ 밖에 없거든요. 그런데 이렇게 저희의 두드림을 또 다른 곳에 연결해 주시고, 어려운 분들을 도울 수 있어 너무 감사하죠. 저희도 또 도움을 줄 수 있는 부분이 있다면 말씀해 주시면 언제든 돕고 싶습니다. 정말 감사합니다. 그리고 얼마 후에 두드림터치를 통해 에어컨을 후원이 들어왔는데, 어르신들이 정말 좋아하시더라고요. 덕분에 그 경로당이 다시 활기를 찾아서 저도 너무 뿌듯했었습니다.</p>
							</div>
						</div>
					</div>			
				</section>			
			</section>
			
			<!-- 성장 -->
			<section class="intro2" >	
				<section class="intro2-section1">
					<h4 class="intro2-section1-title">두드림터치는 꾸준히 성장하고 있습니다!</h4>
					<p class="intro2-section1-content">현재 포항시 전역을 목표로 하고 있으며, 앞으로 전국으로 확대될 계획입니다.</p>
					<div class="resposive-intro2-section1-content">
						<p>현재 포항시 전역을 목표로 하고 있으며,</p>
						<p>앞으로 전국으로 확대될 계획입니다.</p>					
					</div>
					<div class="text-dodream intro2-section2">
						<div class="intro2-section2-wrapper">
							<div class="intro2-image-wrapper"><img class="intro2-image" src="/image/growth1.png" /></div>
							<p>신규배포</p>
							<h4>+ 120 건</h4>
						</div>
						<div class="intro2-section2-wrapper">
							<div class="intro2-image-wrapper"><img class="intro2-image" src="/image/growth2.png" /></div>
							<p>경제적효과</p>
							<h4>+ 1,032,910 원</h4>						
						</div>
						<div class="intro2-section2-wrapper">
							<div class="intro2-image-wrapper"><img class="intro2-image" src="/image/growth3.png" /></div>
							<p>응답률</p>
							<h4>85%</h4>
						</div>
					</div>
					<div class="intro2-section3">
						<div class="intro2-section3-inner">
							<div class=" text-dodream intro2-section3-inner-left">
								<div class="year-div">2020</div>
							</div>
							<div class=" intro2-section3-inner-right">
								<table class="intro2-section3-table">
									<tr class="table-section-top">
										<td class="intro2-section3-year" style="padding-top:0.75rem;">2020.02</td>
										<td style="padding-top:0.75rem;">두드림터치 설립</td>
									</tr>
									<tr class="table-section">
										<td class="intro2-section3-year" style="padding-top:0.75rem;">2020.03</td>
										<td style="padding-top:0.75rem;">포항연탄은행 MOU 체결</td>
									</tr>
									<tr>
										<td class="text-white-hidden">2020.03</td>
										<td>두드림터치 플랫폼 출범</td>
									</tr>
									<tr class="table-section">
										<td class="intro2-section3-year" style="padding-top:0.75rem;">2020.04</td>
										<td style="padding-top:0.75rem;">포항 CBS 라디오 집중 인터뷰</td>
									</tr>
									<tr>
										<td class="text-white-hidden">2020.04</td>
										<td>우리기초푸드뱅크 MOU 체결</td>
									</tr>
									<tr>
										<td class="text-white-hidden">2020.04</td>
										<td>좋은이웃노인복지센터 MOU 체결</td>
									</tr>
									<tr class="table-section">
										<td class="intro2-section3-year" style="padding-top:0.75rem;">2020.05</td>
										<td style="padding-top:0.75rem;">두드림터치를 통한 첫 요청과 응답</td>
									</tr>
									<tr>
										<td class="text-white-hidden">2020.05</td>
										<td>창포종합사회복지관 MOU 체결</td>
									</tr>
									<tr>
										<td class="text-white-hidden">2020.05</td>
										<td>한동대학교 장순흥 총장 자문위원으로 위촉</td>
									</tr>
									<tr class="table-section">
										<td class="intro2-section3-year" style="padding-top:0.75rem;">2020.07</td>
										<td style="padding-top:0.75rem;">한동대학교 MOU 체결</td>
									</tr>
									<tr class="table-section">
										<td class="intro2-section3-year" style="padding-top:0.75rem;">2020.09</td>
										<td style="padding-top:0.75rem;">경북포항지역자활센터 MOU 체결</td>
									</tr>
									<tr>
										<td class="text-white-hidden" style="padding-bottom:1.5rem;">2020.09</td>
										<td>한동대학교 10대 프로젝트 선정</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</section>
			
			</section>
			
			<!-- 조직도 -->
			<section class="intro3" >
				<div class="intro3-image ">
					<img class="" src="/image/organization-chart.png" />
				</div>
				<div class="intro3-wrapper ">
					<div class="intro3-wrapper-div">
						<div class="intro3-wrapper-left ">
							<div class="text-dodream name-div ">대표</div>
						</div>
						<div class="intro3-wrapper-right ">
							<table class="intro3-section-table ">
								<tr class="table-section-top">
									<td class="intro3-table-name " style="padding-top:0.75rem;">이종민</td>
									<td style="padding-top:0.75rem;">한동대학교 전산전자공학부 학사</td>
								</tr>
								<tr>
									<td class="text-white-hidden ">이종민</td>
									<td style="padding-top:0.75rem;">한동대학교 정보통신대학원 석사</td>
								</tr>
								<tr>
									<td class="text-white-hidden">이종민</td>
									<td style="padding-top:0.75rem;">(현) 흥해교회 전도사</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="intro3-wrapper-div">
						<div class="intro3-wrapper-left">
							<div class="text-dodream name-div">자문위원회</div>
						</div>
						<div class="intro3-wrapper-right">
							<table class="intro3-section-table">
								<tr class="table-section-top">
									<td class="intro3-table-name " style="padding-top:0.75rem;">장순흥</td>
									<td style="padding-top:0.75rem;">(현) 한동대학교 총장</td>
								</tr>
								<tr class="table-section">
									<td class="intro3-table-name" style="padding-top:0.75rem;">유호범</td>
									<td style="padding-top:0.75rem;">(현) 포항연탄은행 대표</td>
								</tr>
								<tr>
									<td class="text-white-hidden">유호범</td>
									<td><span class="text-white-hidden">(현) </span>그루터기교회 담임목사</td>
								</tr>
								<tr class="table-section">
									<td class="intro3-table-name" style="padding-top:0.75rem;">강병덕</td>
									<td style="padding-top:0.75rem;">(현) 한동대학교 상담심리복지학부 교수</td>
								</tr>
								<tr class="table-section">
									<td class="intro3-table-name" style="padding-top:0.75rem;">유장춘</td>
									<td style="padding-top:0.75rem;">(현) 한동대학교 상담심리복지학부 교수</td>
								</tr>
								<tr class="table-section">
									<td class="intro3-table-name" style="padding-top:0.75rem;">김완진</td>
									<td style="padding-top:0.75rem;">(현) 한동대학교 교목실 목사</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				
			</section>
			
			<!-- 찾아오시는 길 -->
			<section class="intro4">
				<div style="width:100%; height:2rem; visibility:hidden;">space</div>
				<div class="map_wrap ">
					<div class="" id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
					<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
					<div class="custom_zoomcontrol radius_border">
						<span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span> <span onclick="zoomOut()"><img
							src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
					</div>
				</div>
				<div class="intro4-content">
					<div class="intro4-div table-section">
						<div><span class="intro4-content-title">대표전화 </span><span class="text-dodream"><b>054-262-1070</b></span></div>
						<div><span class="intro4-content-title">E-Mail </span><span>dodream.touch@gmail.com</span></div>
					</div>
					<div class="intro4-div table-section">
						<div><span class="intro4-content-title">도로명 주소</span></div>
						<div><span>경상북도 포항시 흥해읍 한동로 513번길 43-1 202호</span></div>
					</div>
					<div class="intro4-div table-section" style="border-bottom:2px solid #e3e3e3;">
						<div><span class="intro4-content-title">승용차 이용시</span></div>
						<div><span>한동대학교 '한동로'방면으로 좌회전 -> 513번길 방면으로 우회전513번길 방면으로 우회전513번길 방면으로 우회전</span></div>
						<div><span class="intro4-content-title">버스 이용시</span></div>
						<div><span>흥해지선 탑승 -> (봉림)곡강1리에서 하차</span></div>
					</div>
				</div>			
			</section>
			
			
			
			
			
		</div>
		<section class="intro1 intro1-section4" >
			<img class="intro1-section4-support" src="/image/support.png" />
			<div class="text-white intro1-section4-div ">
				<h4 class="intro1-section4-text1 ">두드림터치와 함께할 후원회원을 찾고 있습니다.</h4>
				<div class="intro1-section4-text2 ">
					<p>현재 포항시 전역을 목표로 하고 있으며, 앞으로 전국으로 확대될 계획입니다.</p>
					<p>두드림터치 플랫폼 정착과 운영, 확대과정에 함께해 주세요.</p>				
				</div>
				<p class="intro1-section4-text3 "><b>두드림터치<br>농협은행 301-0267-4835</b></p>
				<p class="intro1-section4-text4 ">전화번호 : 054-262-1070<br>E-mail : dodreamtouch@gmail.com</p>
			</div>
		</section>
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>
		<%@include file="../layout/jsFile.jsp"%>
	<%@include file="../layout/kakaoMap.jsp"%>
	<script src="/js/dodreamtouch.js"></script>
	
	<script>
	
	
	$(document).ready(function() {
		$(".intro-menu").on("click", function() {
			$(".intro-menu").removeClass('selected-menu');
			$(this).addClass('selected-menu');		
		});
	});
	
	// 두드림터치 주소
	var lati = 36.111029;
	var longi = 129.396592;	
	var map;
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(lati, longi), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomIn() {
		map.setLevel(map.getLevel() - 1);
	}

	// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomOut() {
		map.setLevel(map.getLevel() + 1);
	}
	
	</script>
</body>
</html>
