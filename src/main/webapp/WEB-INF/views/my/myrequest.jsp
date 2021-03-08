<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​
<%@include file="../layout/header.jsp"%>


<link href="/css/mypage.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
table {
	table-layout: fixed;
}

table td {
	width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>

</head>

<body id="page-top">
	<div class="modal-bg" id="modal-bg" style="display: none;"></div>

	<!-- 요청 항목 세부정보 보기 -->
	<div class="modal-container" id="view-detail" style="display: none;">
		<div class="modal-content" style="height: 100%;">
			<div class="modal-title">
				<h5 id="rq_title"></h5>
				<div class="dropdown dd-down" id="change-req" onclick="requestdown(this);">
					<i class="fas fa-chevron-down"></i>
				</div>
			</div>
			<div class="content-info" id="request-info" style="display: none;">
				<table class="info-table" style="border-top: none; margin-top: 0;">
					<tr>
						<td style="width: 17.5%;"><b>등록번호</b></td>
						<td id="rq_id" style="width: 27.5%;"></td>
						<td style="width: 17.5%;"><b>등록날짜</b></td>
						<td id="rq_date" style="width: 37.5%;"></td>
					</tr>
					<tr>
						<td><b>상태</b></td>
						<td id="rq_status"></td>
						<td><b>주소</b></td>
						<td id="rq_addr"></td>
					</tr>
				</table>
				<div class="content-text" id="rq_contents"></div>
				<div class="content-needs">
					<table class="info-table">
						<tr>
							<th style="width: 17.5%;">종류</th>
							<th style="width: 27.5%;">내역</th>
							<th style="width: 55%;">현재 수량 / 목표 수량</th>
						</tr>
						<tr class="needs-category" id="rq_item0"></tr>
					</table>
				</div>
				<div class="btn-res btn-edit">수정하기</div>
			</div>
			
			
			<!-- 요청에 대한 응답 목록 부분 -->
			<div class="modal-title" style="margin-top: 1rem;">
				<h5>응답 확인하기</h5>
				<div class="dropdown dd-up" id="change-res" onclick="responsedown(this);">
					<i class="fas fa-chevron-up"></i>
				</div>
			</div>
			<!-- 
			1. request.id 에 해당하는 모든 replyList을 불러옴. (ajax로 Controller-Service-replyRepository.findById)
			2. reply.id, reply.title, reply.item, reply.status 별로 List 정렬 (
			3. reply.id에 해당하는 title, content, replyItem들을 다 불러옴.
			4. replyItem
			
			-->
			<div class="content-info" id="response-info" style="display: block;">
				<div class="content-needs" id="content-responseList"></div>
			</div>
		</div>
	</div>

	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<!-- Navigation-->

		<%@include file="../layout/navbar.jsp"%>

		<header class="text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>요청내역</h4>
					<p>
						지금까지 요청하신 내역들을<br>모두 확인할 수 있습니다.
					</p>
				</div>
			</div>
		</header>
		<!-- news Section-->
		<section class="mypage-section2" id="about" style="text-align: center;">
			<div class="container ">
				<table style="table-layout: fixed">
					<thead>
						<tr style="border-bottom: 3px solid #d3d3d3;">
							<th class="table-num">등록번호</th>
							<th class="table-title">요청 내용</th>
							<th class="table-date">등록일</th>
							<th class="table-status">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="request" items="${myrequestList}">
						<fmt:formatDate value="${request.regDate}" pattern="yyyy. MM. dd." var="regdate" />
						
							<script>
								var arr = new Array();
								<c:forEach items="${request.requestItem}" var="item">
 									if("${item.requestType}" == "STUFF") var type = "물품";
									else if("${item.requestType}" == "SERVICE") var type = "봉사";
									else if("${item.requestType}" == "FINANCE") var type = "재정";
									else var type = "기타"; 
									arr.push({
										itemId: ${item.id},
										itemName: "${item.itemName}",
										itemNum: "${item.itemNum}",
										receivedNum: "${item.receivedNum}",
										requestType: "${item.requestType}",
									});
								</c:forEach>
								const rq${request.id} = {
									id: ${request.id},
									title: '${request.title}',
									regDate: '${request.regDate}',
									dueDate: '${request.dueDate}',
									requestAddress: '${request.requestAddress}',
									urgentLevel: '${request.urgentLevel}',
									userName: '${request.user.userName}',
									description: '${request.description}',
									requestItem: arr,
								};
							</script>
													
						<c:choose>
							<c:when test="${request.status == 'APPROVED'}" >
								<c:set var="status" value="승인"/>
							</c:when>
							<c:when test="${request.status == 'NON_APPROVED'}" >
								<c:set var="status" value="미승인"/>
							</c:when>
							<c:when test="${request.status == 'WAITING'}" >
								<c:set var="status" value="대기"/>
							</c:when>
							<c:when test="${request.status == 'CLOSED'}" >
								<c:set var="status" value="마감"/>
							</c:when>
						</c:choose>
												
						<tr class="response-item" onclick="goDetail_myrequest(rq${request.id});">
							<td class="table-num">${request.id}</td>
							<td class="table-title fbold">${request.title}</td>
							<td class="table-date">${regdate}</td>
							<td class="table-status">대기</td>
						</tr>						
						</c:forEach>
						
					</tbody>
				</table>
			</div>
		</section>

		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>

		<%@include file="../layout/sidebar_back.jsp"%>

	</div>

	<%@include file="../layout/jsFile.jsp"%>
	<script>
		function response_detail(ele) {
			alert(ele);
			var id = "#" + $(ele).attr('id');
			var num = id.substr(id.length - 1, 1);
			var cl = 'rc' + num;
			var html = '';
			html += ('<tr class="' + cl + '"><td colspan="4" style="padding:0;margin:0;"><textarea rows="2" style="resize:none;width:100%;border:none;border-top:1px solid gray;border-bottom:1px solid gray;text-align:left;padding:10px;">독거어르신 주거환경개선을 위해 도와드리고 싶습니다. 블라블라 뭐라고 하면 좋을까요? 아무튼 여기는 응답자가 직접 작성한 내용이 보여지는 곳입니다!</textarea></td></tr>');
			html += ('<tr class="' + cl + '"><th style="width:15%;padding:5px;">종류</th><th style="width:30%;padding:5px;">내역</th><th style="width:55%;padding:5px;">수량</th></tr>');
			html += ('<tr class="' + cl + '" style="border-top:1px solid gray;"><td style="padding:5px;">물품</td><td style="padding:5px;">물품1</td><td colspan="2" style="padding:5px;">2개</td></tr>');
			html += ('<tr class="' + cl + '"><td style="padding:5px;"></td><td style="padding:5px;">물품2</td><td style="padding:5px;">3개</td></tr>');
			html += ('<tr class="' + cl + '" style="border-top:2px solid black;"><th style="width:15%;padding:5px;padding-top:10px;">응답 상태</th><td colspan="3" style="width:85%;padding:5px;padding-top:10px;"><select name="status" class="a-or-w"><option value="wait">대기</option><option value="approve">승인</option></select></td></tr>');
			html += ('<tr class="' + cl + '"><td colspan="4" style="padding:0;"><textarea name="content" rows="3" style="resize:none;width:100%;margin-top:0.5rem;"></textarea></td></tr>');
			html += ('<tr class="' + cl + '" style="border-bottom:2px solid black;"><td colspan="2" style="padding:0;"></td><td colspan="2" style="text-align:right;padding:0;padding-bottom:10px;"><div class="btn-com">등록하기</div></td></tr>');
			$(id).after(html);
			$(id).removeAttr("onclick");
			$(id).attr("onclick", ("close_detail(" + num + ")"));
		}
		function close_detail(num) {
			var id = "#response" + num;
			var cl = ".rc" + num;
			$('tr').remove(cl);
			$(id).removeAttr("onclick");
			$(id).attr("onclick", "response_detail(this)");
		}
		function requestdown(ele) {
			if ($("#change-req").hasClass('dd-down') === true) {
				$("#request-info").css("display", "block");
				$("#change-req").html('<i class="fas fa-chevron-up"></i>');
				$("#change-req").removeClass('dd-down');
				$("#change-req").addClass('dd-up;');
			} else {
				$("#request-info").css("display", "none");
				$("#change-req").html('<i class="fas fa-chevron-down"></i>');
				$("#change-req").removeClass('dd-up');
				$("#change-req").addClass('dd-down');
			}
		}
		function responsedown(ele) {
			if ($("#change-res").hasClass('dd-down') === true) {
				$("#response-info").css("display", "block");
				$("#change-res").html('<i class="fas fa-chevron-up"></i>');
				$("#change-res").removeClass('dd-down');
				$("#change-res").addClass('dd-up;');
			} else {
				$("#response-info").css("display", "none");
				$("#change-res").html('<i class="fas fa-chevron-down"></i>');
				$("#change-res").removeClass('dd-up');
				$("#change-res").addClass('dd-down');
			}
		}
	</script>

</body>
</html>