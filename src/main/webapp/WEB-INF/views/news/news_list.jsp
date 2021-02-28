<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/news.css" rel="stylesheet" />
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
					<h4>소식 보기</h4>
					<p>두드림의 순간들과<br>두드림터치의 이야기들을 확인할 수 있습니다.
					</p>
				</div>
			</div>
		</header>
		
		<section class="news-section1">
			<div class="news-section1-wrapper">
				<div class="news-header">
				<!-- 제일 최근 3개   -->
					<div class="news-header-wrapper" style="display:inline;">
						<img class="news-header-wrapper-image" src="/image/news-test.jpeg" style="width:100%;"/>
						<div class="news-header-wrapper-text">
							<p class="news-header-wrapper-title">두드림터치, 한동대학교 10대 프로젝트 신청</p>
							<p class="news-header-wrapper-date">2020.09.30</p>
							<p class="news-header-wrapper-content">지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다.</p>						
						</div>
					</div>
					<div class="news-header-wrapper" style="display:inline;">
						<img class="news-header-wrapper-image" src="/image/news-test.jpeg" style="width:100%;"/>
						<div class="news-header-wrapper-text">
							<p class="news-header-wrapper-title">두드림터치, 한동대학교 10대 프로젝트 신청</p>
							<p class="news-header-wrapper-date">2020.09.30</p>
							<p class="news-header-wrapper-content">지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다.</p>						
						</div>
					</div>
					<div class="news-header-wrapper" style="display:inline;">
						<img class="news-header-wrapper-image" src="/image/news-test.jpeg" style="width:100%;"/>
						<div class="news-header-wrapper-text">
							<p class="news-header-wrapper-title">두드림터치, 한동대학교 10대 프로젝트 신청</p>
							<p class="news-header-wrapper-date">2020.09.30</p>
							<p class="news-header-wrapper-content">지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다. 지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다.</p>						
						</div>
					</div>		
				</div>
			
			</div>
		</section>
		
		<div class="news-section2-menu-wrapper">
			<div class="news-section2-menu">
				<a class="news-menu-title"><b>최신 콘텐츠</b></a>
				<a class="news-menu-button news-section2-menu-selected">모든 소식</a>
				<a class="news-menu-button">이웃 소식</a>
				<a class="news-menu-button">두드림 소식</a>
			</div>
		</div>
		
		<!-- news Section-->
		
		<section class="news-section2">
			<div class="news-section2-wrapper test">
				<div class="news-section2-div test">
					<img src="/image/news-test.jpeg" style="height:100%; object-fit:contain;"/>
					<div class="news-section2-div-right">
						<p class="news-section2-div-title">두드림터치, 한동대학교 10대 프로젝트 신청</p>
						<p class="news-section2-div-date">2020.09.30</p>
						<p class="news-section2-div-content">지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다.</p>					
					</div>
				</div>
				<div class="news-section2-div test">
					<img src="/image/news-test.jpeg" style="height:100%; object-fit:contain;"/>
					<div class="news-section2-div-right ">
						<p class="news-section2-div-title">두드림터치, 한동대학교 10대 프로젝트 신청</p>
						<p class="news-section2-div-date">2020.09.30</p>
						<p class="news-section2-div-content">지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다.</p>					
					</div>
				</div>
				<div class="news-section2-div test">
					<img src="/image/news-test.jpeg" style="height:100%; object-fit:contain;"/>
					<div class="news-section2-div-right ">
						<p class="news-section2-div-title">두드림터치, 한동대학교 10대 프로젝트 신청</p>
						<p class="news-section2-div-date">2020.09.30</p>
						<p class="news-section2-div-content">지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다.</p>					
					</div>
				</div>
				<div class="news-section2-div test">
					<img src="/image/news-test.jpeg" style="height:100%; object-fit:contain;"/>
					<div class="news-section2-div-right ">
						<p class="news-section2-div-title">두드림터치, 한동대학교 10대 프로젝트 신청</p>
						<p class="news-section2-div-date">2020.09.30</p>
						<p class="news-section2-div-content">지난 9월, 한동대학교 10대 프로젝트에 두드림터치가 선정되었다. 두드림터치는 ‘지역공동체 자원 활용을 통한 지역, 마을 협동 돌봄 생태계 조성’을 주제로 지역발전프로젝트에 참여하고 있다.</p>					
					</div>
				</div>								
			</div>
		</section>
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>
		<%@include file="../layout/jsFile.jsp"%>
	<script>
	$(document).ready(function() {
		$(".news-menu-button").on("click", function() {
			$(".news-menu-button").removeClass('news-section2-menu-selected');
			$(this).addClass('news-section2-menu-selected');		
		});
	});

	
	</script>
</body>
</html>
