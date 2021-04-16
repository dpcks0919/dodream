<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="width:100%; font-size:1rem; margin-bottom:1rem;">
	<b>* 두드림 터치에 올라온 모든 요청에 대해 확인 및 수정할 수 있습니다.</b>
</div>
<style>
@media (max-width: 768px) {
	.table-regdate, .table-duedate {
		display:none;
	}
}

</style>
<table class="" id="info-table" style="table-layout: fixed;">
	<thead>
		<tr style="border-bottom: 3px solid #d3d3d3;">
			<th class="table-num" style="width:10%;">등록 번호</th>
			<th class="table-title" style="width:25%;">요청 제목</th>
			<th class="table-status" style="width:12.5%;">상태</th>
			<th class="table-name" style="width:10%;">요청자</th>
			<th class="table-regdate" style="width:10%;">등록일</th>
			<th class="table-duedate" style="width:10%;">마감일</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="requestCount" value="0" />
		<c:set var="currentPage" value="${requests.pageable.pageNumber}"></c:set>
		<c:forEach var="request" items="${requests.content}">
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
				clientType : '${request.clientType}',
				urgentLevel: '${request.urgentLevel}',
				userName: '${request.user.userName}',
				description: '${request.description}',
				longitude: '${request.longitude}',
				latitude: '${request.latitude}',
				requestItem: arr,
			};
		</script>
		
			<tr class="info-table-tr" onclick="openModal_manager(${request.id}, 1)">
				<td class="table-num">${request.id}</td>
				<td class="table-title">${request.title}</td>
				<c:choose>
					<c:when test="${request.status == 'APPROVED'}">
						<c:set var="requesttype" value="승인" />
						<td class="table-status">${requesttype}</td>
					</c:when>
					<c:when test="${request.status == 'NON_APPROVED'}">
						<c:set var="requesttype" value="미승인" />
						<td class="table-status" style="color:red;">${requesttype}</td>
					</c:when>
					<c:when test="${request.status == 'WAITING'}">
						<c:set var="requesttype" value="대기" />
						<td class="table-status">${requesttype}</td>
					</c:when>
					<c:when test="${request.status == 'CLOSED'}">
						<c:set var="requesttype" value="마감" />
						<td class="table-status">${requesttype}</td>
					</c:when>
					<c:when test="${request.status == 'DELETED'}">
						<c:set var="requesttype" value="삭제" />
						<td class="table-status">${requesttype}</td>
					</c:when>
				</c:choose>					
				<td class="table-name">${request.user.userName}</td>
				<td class="table-regdate">${fn:substring(request.regDate, 0, 10)}</td>
				<td class="table-duedate">${fn:substring(request.dueDate, 0, 10)}</td>
			</tr>
			<c:set var="requestCount" value="${requestCount + 1}" />
		</c:forEach>
	</tbody>
</table>

<section class="mypage-section2" id="about" style="text-align: center;">
	<div class="container">
		<!-- searech line -->
		<br>
		<!-- 페이징할때 주의할 점 : users.number는 0부터 시작하기 때부터 그걸 고려해서 밑에 다 수정했음. 
				그래서 화면에 보이는 것만 1부터 보이게 설정함. -->
		<c:set var="page" value="${requests.number}" />
		<!-- 첫번째 페이지 -->
		<c:set var="startNum" value="${page - (page) % 5}" />
		<!-- 마지막 페이지 -->
		<c:set var="lastNum" value="${requests.totalPages-1}" />
		<c:set var="isLast" value="5" />
		<c:if test="${requests.totalPages == 0}">
			<div style="margin-bottom: 2vh;">
				<br>요청 목록이 존재하지 않습니다.
			</div>
			<c:set var="isLast" value="1" />
		</c:if>
		<div class="pagination">
			<c:if test="${startNum >= 5}">
				<a onclick="paging(${startNum - 1}, 1)" style="float: left;" class="btn btn-prev paging-left">&laquo;</a>
			</c:if>

			<c:if test="${startNum == 0}">
				<span class="btn btn-prev" style="color: #e3e3e3; float: left; cursor: initial;" disabled>&laquo;</span>
			</c:if>
			<c:if test="${requests.totalPages ne 0}">
				<!-- 마지막수 - 첫번째수 -->
				<c:if test="${startNum + 5 >= lastNum }">
					<c:set var="isLast" value="${lastNum - startNum + 1}" />
				</c:if>
			</c:if>
			<c:forEach var="i" begin="0" end="${isLast-1}">
				<c:choose>
					<c:when test="${i eq page%5}">
						<a class="-text- orange bold selected_page" onclick="paging(${startNum + i}, 1)"> ${startNum + i + 1}</a>
					</c:when>
					<c:otherwise>
						<a class="-text- orange bold" onclick="paging(${startNum + i}, 1)"> ${startNum + i + 1}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 마지막번호는 DB레코드 수와 연관이 있다! 우선은 lastpage 개수를 임의로 지정. -->
			<c:if test="${startNum + 4 <= lastNum }">
				<a onclick="paging(${startNum + 5}, 1)" class="btn btn-next paging-right">&raquo;</a>
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
