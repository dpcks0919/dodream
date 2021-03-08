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
					<h4>수정하기</h4>
					<p>소식을 수정할 수 있습니다.</p>
					<a style="border:1px solid white; color:white; cursor:pointer; padding:0.5rem;" href="/news/newsList">뒤로가기</a>
				</div>
			</div>
		</header>
		
		<section class="newsWrite-section" style="">
			<div class="newsWrite-section-wrapper">
				<div class=" " style="display:flex; flex-direction:column; ">
					<input type="text" placeholder="소식 제목을 입력하세요" id="news-title" value="${newsDetail.title}"/>
					<div class="" style="width:100%; margin-bottom:1rem;">
						<span>소식 타입 : </span> 
						<select class="news-type" name="newsType" id="news-type" style="outline:none;">
							<option name="n1">이웃 소식</option>
							<option name="n2">두드림 소식</option>
						</select>
					</div>
					<!-- 
					 <div style="width:100%; margin-right:4rem;">소식 내용 : <input type="text" placeholder="내용을 입력하세요" id="news-content"/></div>					
					 -->
					<div class="news-tip">* 소식내용에는 그림 첨부를 이용하여 <span style="color:red;">반드시 하나 이상의 사진이 첨부</span>되어야 합니다.</div>
					<div class="news-tip" style="margin-bottom:1rem;">순서상 첫번째 사진이 <span style="color:red;">대표사진</span>으로 등록되며, 아래 작성한 폼으로 게시글이 등록됩니다.</div>
					<div class="summernoteDiv">
						<textarea type="text" class="request-content summernote" id="news-content" name="content" required>${newsDetail.content}</textarea>
					</div>
					<div class="news-ftr" style="justify-content: space-between;">
						<div class="btn-upload" onclick="news_upload(2, '${newsDetail.id}');">수정하기</div>						
						<a class="btn-upload" onclick="location.href='/news/newsDetail/${newsDetail.id}'">뒤로 가기</a>
						
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
		$(document).ready(function() {
			if('${newsDetail.newsType}' == "NEIGHBOR") {
				$("#news-type").val("이웃 소식").prop("selected", true);
			} else if('${newsDetail.newsType}' == "DODREAM") {
				$("#news-type").val("두드림 소식").prop("selected", true);
			}
		});
		
	</script>
</body>
</html>
