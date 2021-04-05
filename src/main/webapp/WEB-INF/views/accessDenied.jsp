<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="layout/header.jsp"%>
<link href="/css/accessDenied.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body id="page-top" >
	<div class="modal-bg" id="modal-bg" onclick="closeModal();"></div>

	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="layout/sidebar_front.jsp"%>

	<div id="Wrapper" style="height: 100%;">
		<!-- Navigation-->
		<%@include file="layout/navbar.jsp"%>

		<header class="bg-primary text-white text-center gradient-bgcolor">
			<div class="d-flex flex-column title-info">
				<div class="reg-info-small">
					<h4>도움 요청은 승인된 사회복지사만 사용하실 수 있습니다.</h4>
				</div>
			</div>
		</header>

		<section style="height: 31%; margin:2rem 2rem 0 0; display: flex" >
			<div class="container text-left" > 
				<p><i class="fa fa-arrow-right" aria-hidden="true"></i> 
					남용과 불필요한 요청을 최소화하고 이웃의 개인정보 및 권리를 보호하기 위한 최소한의 조치이니 양해바랍니다 </p>
				<p><i class="fa fa-arrow-right" aria-hidden="true"></i> 
					부적절한 요청은 두드림터치에서 반려됩니다 </p>
				<p><i class="fa fa-arrow-right" aria-hidden="true"></i> 
					긴급한 필요의 경우 두드림터치 대표전화(054-262-1070)로 연락바랍니다 </p>
			</div>
		</section>

		<!-- Footer-->
		<%@include file="layout/footer.jsp"%>
		<%@include file="layout/sidebar_back.jsp"%>

	</div>

	<%@include file="layout/jsFile.jsp"%>

</body>
</html>