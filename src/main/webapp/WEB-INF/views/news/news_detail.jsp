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
					<h4>자세히 보기</h4>
					<p>소식을 작성할 수 있습니다.</p>
					<a style="border:1px solid white; color:white; cursor:pointer; padding:0.5rem;" href="/user/news/newsList">뒤로가기</a>
				</div>
			</div>
		</header>
		<c:set var="newsType" value="이웃 소식" />
		<c:if test="${newsDetail.newsType == 'DODREAM'}">
			<c:set var="newsType" value="두드림 소식" />
		</c:if>
		<section class="newsWrite-section" style="">
			<div class="newsWrite-section-wrapper">
				<fmt:formatDate value="${newsDetail.regDate}" pattern="yyyy. MM. dd." var="regdate" />
				<div class=" " style="display:flex; flex-direction:column; ">
					<input type="text" value="${newsDetail.title}" id="news-title" readonly/>
					<div class="" style="width:100%; margin-bottom:1rem; border-bottom:1px solid #e3e3e3;  display:flex; justify-content:space-between;">
					<span>${regdate}</span><span class="" style="padding-bottom:0.5rem;"><b>소식 분류 : </b><span>${newsType }</span></span>
												 
					</div>
					<div class="" style="overflow-y:scroll;">${newsDetail.content}</div>						
					<div class="news-ftr" style="justify-content: space-between;">
						<div class="btn-upload" onclick="alert('수정하기');" style="margin-right:0.5rem;">수정하기</div>
						<a class="btn-upload" onclick="location.href='/user/news/newsList'">뒤로 가기</a>
					</div>		
				</div>
			</div>
		</section>
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>	
		<%@include file="../layout/jsFile.jsp"%>
		<%@include file="../layout/summernote.jsp"%>
		<script src="/js/news.js"></script>
	<script>

	</script>
</body>
</html>
