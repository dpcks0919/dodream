<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="width:100%; font-size:1rem; margin-bottom:1rem;">
	<b>* 두드림 터치에 올라온 모든 응답에 대해 확인 및 수정할 수 있습니다.</b>
</div>
<style>
@media (max-width: 768px) {
	.table-regdate {
		display:none;
	}
}


</style>
<table class="" id="info-table" style="table-layout: fixed;">
	<thead>
		<tr style="border-bottom: 3px solid #d3d3d3;">
			<th class="table-num" style="width:10%;">응답번호</th>
			<th class="table-content" style="width:15%;">응답 내용</th>
			<th class="table-status" style="width:12.5%;">승인여부</th>
			<th class="table-name" style="width:10%;">응답자</th>
			<th class="table-regdate" style="width:10%;">등록일</th>
			<th class="table-title" style="width:25%;">관련 요청</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="replyCount" value="0" />
		<c:set var="currentPage" value="${replys.pageable.pageNumber}"></c:set>
		<c:forEach var="reply" items="${replys.content}">
			<c:choose>
				<c:when test="${reply.status == 'APPROVED'}">
					<c:set var="replytype" value="승인" />
				</c:when>
				<c:when test="${reply.status == 'NON_APPROVED'}">
					<c:set var="replytype" value="미승인" />
				</c:when>
				<c:when test="${reply.status == 'WAITING'}">
					<c:set var="replytype" value="대기" />
				</c:when>
			</c:choose>
			<c:set var="rcontent" value="${reply.replyContent}"/>
			<c:if test="${reply.replyContent == ''}">
				<c:set var="rcontent" value="-"/>
			</c:if>
			<tr class="info-table-tr" >
				<td class="table-num" onclick="openModal_manager(${reply.id}, 2)">${reply.id}</td>
				<td class="table-content" onclick="openModal_manager(${reply.id}, 2)">${rcontent}</td>
				<td class="table-status" onclick="openModal_manager(${reply.id}, 2)"><b>${replytype}</b></td>
				<td class="table-name" onclick="openModal_manager(${reply.id}, 2)">${reply.user.userName}</td>
				<td class="table-regdate" onclick="openModal_manager(${reply.id}, 2)">${fn:substring(reply.regDate, 0, 10)}</td>
				<td class="table-title" onclick="openModal_manager(${reply.request.id}, 1)">[#${reply.request.id}] ${reply.request.title}</td>
			</tr>
			<c:set var="replyCount" value="${replyCount + 1}" />
		</c:forEach>
	</tbody>
</table>
<!-- 
<c:if test="${replyCount == 0}">
	<div style="width:100%; text-align:center; margin-top:1.5rem; margin-bottom:1.5rem;" class="test">응답글이 존재하지 않습니다.</div>
</c:if>
 -->

<section class="mypage-section2" id="about" style="text-align: center;">
	<div class="container">
		<!-- searech line -->
		<br>
		<!-- 페이징할때 주의할 점 : users.number는 0부터 시작하기 때부터 그걸 고려해서 밑에 다 수정했음. 
				그래서 화면에 보이는 것만 1부터 보이게 설정함. -->
		<c:set var="page" value="${replys.number}" />
		<!-- 첫번째 페이지 -->
		<c:set var="startNum" value="${page - (page) % 5}" />
		<!-- 마지막 페이지 -->
		<c:set var="lastNum" value="${replys.totalPages-1}" />
		<c:set var="isLast" value="5" />
		<c:if test="${replys.totalPages == 0}">
			<div style="margin-bottom: 2vh;">
				<br>응답이 존재하지 않습니다.
			</div>
			<c:set var="isLast" value="1" />
		</c:if>
		<div class="pagination">
			<c:if test="${startNum >= 5}">
				<a onclick="paging(${startNum - 1}, 2)" style="float: left;" class="btn btn-prev paging-left">&laquo;</a>
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
						<a class="-text- orange bold selected_page" onclick="paging(${startNum + i}, 2)"> ${startNum + i + 1}</a>
					</c:when>
					<c:otherwise>
						<a class="-text- orange bold" onclick="paging(${startNum + i}, 2)"> ${startNum + i + 1}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 마지막번호는 DB레코드 수와 연관이 있다! 우선은 lastpage 개수를 임의로 지정. -->
			<c:if test="${startNum + 4 <= lastNum }">
				<a onclick="paging(${startNum + 5}, 2)" class="btn btn-next paging-right">&raquo;</a>
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
