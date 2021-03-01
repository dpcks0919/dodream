<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

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
					<p>두드림의 순간들과<br>두드림터치의 이야기들을 확인할 수 있습니다.</p>
					<a style="border:1px solid white; color: white; cursor:pointer; padding:0.5rem;" href="/user/news/newsWrite">글 쓰기(임시)</a>
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
		<fmt:formatDate value="${news.count}" pattern="yyyy.MM.dd" />
		
		<section class="news-section2 ">
			<div class="news-section2-wrapper">
				<c:forEach var="news" items="${newsList.content}">
				<fmt:formatDate value="${news.regDate}" pattern="yyyy. MM. dd." var="today" />
					<div class="news-section2-div">
						<div class="image-container2"><img class="news-section2-image" src="/image/news-test.jpeg" style="height:100%; object-fit:contain;"/></div>
						<div class="news-section2-div-right">
							<p class="news-section2-div-title">${news.title}</p>
							<p class="news-section2-div-date">조회수 ${news.count}회 · ${today}</p>
							<p class="news-section2-div-content">${news.content}</p>					
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
		
		<!-- paging-wrapper css는 news.css에 있음. -->
		<div class="paging-wrapper ">
			<c:set var="page" value="${newsList.number}" />
			<!-- 첫번째 페이지 -->
			<c:set var="startNum" value="${page - (page) % 5}" />
			<!-- 마지막 페이지 -->
			<c:set var="lastNum" value="${newsList.totalPages-1}" />
			<c:set var="isLast" value="5" />
			<c:if test="${newsList.totalPages == 0}">
				<div style="margin-bottom: 2vh;">
					<br>요청 내용이 존재하지 않습니다.
				</div>
				<c:set var="isLast" value="1" />
			</c:if>
			<div class="pagination ">
				<c:if test="${startNum >= 5}">
					<a href="?page=${startNum - 1}" style="float: left;" class="btn btn-prev paging-left">&laquo;</a>
				</c:if>
	
				<c:if test="${startNum == 0}">
					<span class="btn btn-prev" style="color: #e3e3e3; float: left; cursor: initial;" disabled>&laquo;</span>
				</c:if>
				<c:if test="${newsList.totalPages ne 0}">
					<!-- 마지막수 - 첫번째수 -->
					<c:if test="${startNum + 5 >= lastNum }">
						<c:set var="isLast" value="${lastNum - startNum + 1}" />
					</c:if>
				</c:if>
				<c:forEach var="i" begin="0" end="${isLast-1}">
					<c:choose>
						<c:when test="${i eq page%5}">
							<a class="-text- orange bold selected_page" href="?page=${startNum + i}">${startNum + i + 1}</a>
						</c:when>
						<c:otherwise>
							<a class="-text- orange bold" href="?page=${startNum + i}">${startNum + i + 1}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
	
				<!-- 마지막번호는 DB레코드 수와 연관이 있다! 우선은 lastpage 개수를 임의로 지정. -->
				<c:if test="${startNum + 4 <= lastNum }">
					<a href="?page=${startNum + 5}" class="btn btn-next paging-right">&raquo;</a>
				</c:if>
				<c:if test="${startNum + 4 > lastNum }">
					<span class="btn btn-next" style="color: #e3e3e3; cursor: initial;" disabled>&raquo;</span>
				</c:if>
			</div>	
		
		</div>
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
