<!-- myrequest에서 응답 내역 리스트를 보여주는 화면. -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<table class="info-table res-table">
	<tr>
		<th style="width: 15%;">응답코드</th>
		<th style="width: 30%;">응답자</th>
		<th style="width: 40%;">응답 종류</th>
		<th style="width: 15%;">응답 상태</th>
	</tr>
	<c:set var="replyCount" value="0" />
	<c:forEach var="reply" items="${replyList}">
	<c:choose>
		<c:when test="${reply.status == 'WAITING'}">
			<c:set var="replyStatus" value="대기"/>
		</c:when>
		<c:when test="${reply.status == 'APPROVED'}">
			<c:set var="replyStatus" value="승인"/>
		</c:when>
	</c:choose>
	<!-- id, num,  -->
		<tr class="needs-category response-row" id="response${replyCount}" style="" onclick="response_detail(this, ${reply.id})">

		<script>
			
		</script>
			<td>${reply.id}</td>
			<td class="td-title">${reply.replyUser}</td>
			<script>
				$.ajax({
					type : "GET",
					traditional : true,
					url : "/user/replyitemString?id="+${reply.id},
				}).done(function(resp) {
					if (resp.status == 500) {
						alert("에러발생");
					} else {
						$("#rp-item"+${replyCount}).html(resp);
					}
				}).fail(function(error) {
					console.log(JSON.stringify(error));
				});
			
			</script>
			<td id="rp-item${replyCount}"></td>
			<td>${replyStatus}</td>
		</tr>
	<c:set var="replyCount" value="${replyCount + 1}" />
	</c:forEach>
</table>
<div style="width:100%; margin-top:1rem; text-align:center;">
	<c:if test="${replyCount == 0}" >
		현재 응답된 내역이 없습니다.
	</c:if>
</div>