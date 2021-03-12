<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<table style="table-layout: fixed">
	<thead>
		<tr style="border-bottom: 3px solid #d3d3d3;">
			<th class="table-num">등록번호</th>
			<th class="table-title">요청 내용</th>
			<th class="table-date">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="currentPage" value="${replys.pageable.pageNumber}"></c:set>
		<c:forEach var="reply" items="${replys.content}">
			<fmt:formatDate value="${reply.request.regDate}" pattern="yyyy. MM. dd." var="regdate" />
			<script>
				var arr = new Array();
				<c:forEach items="${reply.request.requestItem}" var="item">
					if("${item.requestType}" == "STUFF") var type = "물품";
					else if("${item.requestType}" == "SERVICE") var type = "봉사";
					else if("${item.requestType}" == "FINANCE") var type = "재정";
					else var type = "기타"; 
					arr.push({
						id: ${item.id},
						itemName: "${item.itemName}",
						itemNum: "${item.itemNum}",
						receivedNum: "${item.receivedNum}",
						requestType: "${item.requestType}",
					});
				</c:forEach>
				var rq${reply.request.id} = {
					id: ${reply.request.id},
					title: '${reply.request.title}',
					regDate: '${reply.request.regDate}',
					dueDate: '${reply.request.dueDate}',
					requestAddress: '${reply.request.requestAddress}',
					urgentLevel: '${reply.request.urgentLevel}',
					user: '${reply.request.user.orgName}', //기관 이름
					description: '${reply.request.description}',
					requestItem: arr,
				};
				var arr2 = new Array();
				<c:forEach items="${reply.replyItem}" var="item">
					arr2.push({
						id: ${item.id},
						replyNum: "${item.replyNum}",
						replyId: "${item.reply.id}",
						requestItemId: "${item.requestItem.id}",
					});
				</c:forEach>
				var rp${reply.id} = {
					id: ${reply.id},
					comment: '${reply.comment}',
					regDate: '${reply.regDate}',
					replyContent: '${reply.replyContent}',
					replyOrg: '${reply.replyOrg}',
					replyPhone: '${reply.replyPhone}',
					replyUser: '${reply.replyUser}',
					status: '${reply.status}',
					updateDate: '${reply.updateDate}',
					requestId: '${reply.request.id}',
					userId: '${reply.user.id}',
					replyItem: arr2,
				};
			</script>
			<tr>
				<td class="table-num">${reply.request.id}</td>
				<td onclick="goDetail_myResponse(rq${reply.request.id}, rp${reply.id});" href="/user/" class="table-title fbold">${reply.request.title}</td>
				<td class="table-date">${fn:substring(reply.request.regDate, 0, 10)}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<section class="mypage-section2" id="about" style="text-align: center;">
	<div class="container">
		<!-- searech line -->
		<br>
		<!-- 페이징할때 주의할 점 : replys.number는 0부터 시작하기 때부터 그걸 고려해서 밑에 다 수정했음. 
				그래서 화면에 보이는 것만 1부터 보이게 설정함. -->
		<c:set var="page" value="${replys.number}" />
		<!-- 첫번째 페이지 -->
		<c:set var="startNum" value="${page - (page) % 5}" />
		<!-- 마지막 페이지 -->
		<c:set var="lastNum" value="${replys.totalPages-1}" />
		<c:set var="isLast" value="5" />
		<c:if test="${replys.totalPages == 0}">
			<div style="margin-bottom: 2vh;">
				<br>요청 내용이 존재하지 않습니다.
			</div>
			<c:set var="isLast" value="1" />
		</c:if>
		<div class="pagination">
			<c:if test="${startNum >= 5}">
				<a onclick="paging(${startNum - 1})" style="float: left;" class="btn btn-prev paging-left">&laquo;</a>
			</c:if>

			<c:if test="${startNum == 0}">
				<span class="btn btn-prev" style="color: #e3e3e3; float: left; cursor: initial;" disabled>&laquo;</span>
			</c:if>
			<c:if test="${replys.totalPages ne 0}">
				<!-- 마지막수 - 첫번째수 -->
				<c:if test="${startNum + 5 >= lastNum }">
					<c:set var="isLast" value="${lastNum - startNum + 1}" />
				</c:if>
			</c:if>
			<c:forEach var="i" begin="0" end="${isLast-1}">
				<c:choose>
					<c:when test="${i eq page%5}">
						<a class="-text- orange bold selected_page" onclick="paging(${startNum + i})"> ${startNum + i + 1}</a>
					</c:when>
					<c:otherwise>
						<a class="-text- orange bold" onclick="paging(${startNum + i})"> ${startNum + i + 1}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 마지막번호는 DB레코드 수와 연관이 있다! 우선은 lastpage 개수를 임의로 지정. -->
			<c:if test="${startNum + 4 <= lastNum }">
				<a onclick="paging(${startNum + 5})" class="btn btn-next paging-right">&raquo;</a>
			</c:if>
			<c:if test="${startNum + 4 > lastNum }">
				<span class="btn btn-next" style="color: #e3e3e3; cursor: initial;" disabled>&raquo;</span>
			</c:if>
		</div>
	</div>
</section>

<script>
var curPage = "${currentPage}";
</script>
