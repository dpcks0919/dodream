<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="layout/header.jsp"%>

<link href="/css/main.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body id="page-top">
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="layout/sidebar_front.jsp"%>

	<div id="Wrapper" style="width: 100%;">
		<!-- Navigation-->
		<%@include file="layout/navbar.jsp"%>

		<!-- map Section -->
		<section class="page-section3 page-section-join text-center " id="portfolio" style="margin-top: 100px;">
			<p class="text-center text-uppercase text-secondary mb-0 page-section3-title">
				권한이 필요한 페이지 입니다!  <br>
				관리자에게 액세스를 요청하거나 권한이 있는 계정으로 전환해주시기 바랍니다! <br>
				자세한 사항은 관리자에게 문의해주세요. <br><br>
				전화: 054-262-1070 <br>
				이메일: dodream.touch@gmail.com
			</p>	
		</section>

		<!-- Footer-->
		<%@include file="layout/footer.jsp"%>
	</div>
	<%@include file="layout/sidebar_back.jsp"%>

	<%@include file="layout/jsFile.jsp"%>

</body>
</html>
