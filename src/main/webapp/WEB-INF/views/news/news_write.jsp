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
					<h4>글쓰기 (임시)</h4>
					<p>소식을 작성할 수 있습니다.</p>
					<a style="border:1px solid white; color:white; cursor:pointer; padding:0.5rem;" href="/user/news/newsList">뒤로가기</a>
				</div>
			</div>
		</header>
		
		<section class="news-section1" style="height:7rem;">
			<div class="news-section1-wrapper">
					<div><b>테스트</b></div>
				<div class=" " style="display:flex; justify-content:flex-start; ">
					<div style="margin-right:4rem;">소식 제목 : <input type="text" placeholder="제목을 입력하세요" id="news-title"/></div>
					<div style="margin-right:4rem;">소식 내용 : <input type="text" placeholder="내용을 입력하세요" id="news-content"/></div>
					<button style="outline:none; border-style:none; border:1px solid black;" onclick="news_upload();">등록</button>
				</div>
			</div>
		</section>
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
	</div>
		<%@include file="../layout/sidebar_back.jsp"%>
		<%@include file="../layout/jsFile.jsp"%>
		<script src="/js/news.js"></script>
	<script>

	</script>
</body>
</html>
