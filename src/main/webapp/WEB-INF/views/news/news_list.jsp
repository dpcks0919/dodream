<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>​

<link href="/css/news.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<style>
.complete_event {
	color: #d5d5d5;
}
</style>

<form id="newsForm" method="post" action="/news/newsList" hidden>
	<input type="hidden" name="type" id="newsType" value="">
</form>

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
			<div class="news-section1-wrapper ">
				<div class="news-header ">
				<!-- 제일 최근 3개   -->
				<c:set var="topCount" value="0" />
				<c:forEach var="top" items="${recentNews}">
					<c:choose>
						<c:when test="${topCount < 3}">
							<c:set var="strNewsType" value="[이웃 소식]" />
							<c:if test="${top.newsType == 'DODREAM'}">
								<c:set var="strNewsType" value="[두드림 소식]" />
							</c:if>
							<fmt:formatDate value="${top.regDate}" pattern="yyyy. MM. dd." var="topRegdate" />
							<div class="news-header-wrapper " style="display:inline;">
								<img class="news-header-wrapper-image" onclick="newDetail('${top.id}');" id="topImg${topCount}" src="" style="width:100%;"/>
								<script>
									// 첫 img 태그만 잘라서 보여주는 태그
									var fullStr = '${top.content}';
									var strArray = fullStr.split('<p>');
									for(var i=0; i<strArray.length; i++) {
										if(strArray[i].includes('img src=')) {
											var strDetail = strArray[i].split('<img src=');
											if(strDetail.includes('<img src=')) {
												var imgAddress = strDetail[0].split('style');													
											} else {
												var imgAddress = strDetail[1].split('style');
											}
											var realImg = imgAddress[0];
											// 맨 앞 문자 자르기(" 하나)
											realImg = realImg.substr(1);
											// 맨 뒷 두문자 자르기(공백과 " 하나)
											realImg = realImg.substr(0, realImg.length -2);
											var imgId = "topImg"+${topCount};
											document.getElementById(imgId).src= realImg;
											break;
										}
									};
									
									
								</script>
								<div class="news-header-wrapper-text">
									<p class="news-header-wrapper-title"><a style="color:black; cursor:pointer;" onclick="newDetail('${top.id}');">${top.title}</a></p>
									<div style="width:100%; display:flex; justify-content:space-between;">
										<span class="news-header-wrapper-date">${topRegdate}</span>
										<span class="news-header-wrapper-date">${strNewsType}</span>									
									</div>
								</div>
							</div>			
						</c:when>
					</c:choose>
					<c:set var="topCount" value="${topCount + 1}" />
				</c:forEach>

				</div>
			
			</div>
		</section>
		
		<div class="news-section2-menu-wrapper">
			<div class="news-section2-menu">
				<a class="news-menu-title"><b>최신 콘텐츠</b></a>
				<c:if test="${ntype}">		
				</c:if>
				<c:choose>
					<c:when test="${ntype == 'ALL'}">
						<a class="news-menu-button news-section2-menu-selected" onclick="goNews('ALL');">모든 소식</a>
						<a class="news-menu-button" onclick="goNews('NEIGHBOR');">이웃 소식</a>
						<a class="news-menu-button" onclick="goNews('DODREAM');">두드림 소식</a>					
					</c:when>
					<c:when test="${ntype == 'NEIGHBOR'}">
						<a class="news-menu-button" onclick="goNews('ALL');">모든 소식</a>
						<a class="news-menu-button news-section2-menu-selected" onclick="goNews('NEIGHBOR');">이웃 소식</a>
						<a class="news-menu-button" onclick="goNews('DODREAM');">두드림 소식</a>								</c:when>
					<c:when test="${ntype == 'DODREAM'}">
						<a class="news-menu-button" onclick="goNews('ALL');">모든 소식</a>
						<a class="news-menu-button" onclick="goNews('NEIGHBOR');">이웃 소식</a>
						<a class="news-menu-button news-section2-menu-selected" onclick="goNews('DODREAM');">두드림 소식</a>								</c:when>
				</c:choose>
			</div>
		</div>
		
		<!-- news Section-->		
		<section class="news-section2 ">
			<div class="news-section2-wrapper">
				<c:set var="bottomCount" value="0" />
				<c:forEach var="news" items="${newsList.content}">
					<c:set var="strNewsType" value="[이웃 소식]" />
					<c:if test="${news.newsType == 'DODREAM'}">
						<c:set var="strNewsType" value="[두드림 소식]" />
					</c:if>
				<fmt:formatDate value="${news.regDate}" pattern="yyyy. MM. dd." var="regdate" />
					<div class="news-section2-div">
						<div class="image-container2" onclick="newDetail('${news.id}');">						
						<img class="news-section2-image" id="bottomImg${bottomCount}" src="" style="width:10rem; height:100%; object-fit:contain;"/>
							<script>
								// default image
								var realImg = "/image/news2.jpeg";
								// 첫 img 태그만 잘라서 보여주는 태그
								var fullStr = '${news.content}';
								// img 태그 id
								var imgId2 = "bottomImg"+${bottomCount};
								if(fullStr.includes('<img src=')) {
									var strArray = fullStr.split('<p>');
									for(var i=0; i<strArray.length; i++) {
										if(strArray[i].includes('img src=')) {
											var strDetail = strArray[i].split('<img src=');
											if(strDetail.includes('<img src=')) {
												var imgAddress = strDetail[0].split('style');													
											} else {
												var imgAddress = strDetail[1].split('style');
											}
											realImg = imgAddress[0];
											// 맨 앞 문자 자르기(" 하나)
											realImg = realImg.substr(1);
											// 맨 뒷 두문자 자르기(공백과 " 하나)
											realImg = realImg.substr(0, realImg.length -2);
											document.getElementById(imgId2).src= realImg;
											break;
										}
									}
								} else {
									document.getElementById(imgId2).src= realImg;									
								}
								
							</script>
						
						
						</div>
						<div class="news-section2-div-right" >
							<p class="news-section2-div-title"><a style="color:black; text-decoration:none; cursor:pointer;" onclick="newDetail('${news.id}');">${news.title}</a></p>
							<div style="width:100%; display:flex; justify-content:space-between;">
								<p class="news-section2-div-date">조회수 ${news.count}회 · ${regdate}</p>
								<span class="news-header-wrapper-date">${strNewsType}</span>									
							</div>
						</div>
					</div>
					<c:set var="bottomCount" value="${bottomCount + 1}" />
				</c:forEach>
			</div>
		</section>
		
		<!-- paging-wrapper css는 news.css에 있음. -->
		<div class="paging-wrapper">
			<c:set var="page" value="${newsList.number}" />
			<!-- 첫번째 페이지 -->
			<c:set var="startNum" value="${page - (page) % 5}" />
			<!-- 마지막 페이지 -->
			<c:set var="lastNum" value="${newsList.totalPages-1}" />
			<c:set var="isLast" value="5" />
			<c:choose>
				<c:when test="${newsList.totalPages == 0}">
					<div style="margin-bottom: 1rem; text-align:center;">
						두드림 소식이 존재하지 않습니다.
					</div>
					<c:set var="isLast" value="1" />
				</c:when>
				<c:otherwise>
					<div class="pagination">
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
				</c:otherwise>
			</c:choose>
		</div>
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>
		<%@include file="../layout/jsFile.jsp"%>
		<script src="/js/news.js"></script>
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
