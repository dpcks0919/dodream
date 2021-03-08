<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<table class="info-table res-table">
	<tr>
		<th style="width: 15%;">순서</th>
		<th style="width: 30%;">응답 내용</th>
		<th style="width: 40%;">응답 종류</th>
		<th style="width: 15%;">응답 상태</th>
	</tr>
	<c:set var="replyCount" value="0" />
	<c:forEach var="reply" items="${replyList}">
		<tr class="needs-category response-row" id="response1" style="" onclick="response_detail(${reply.id});">
			<td>1</td>
			<td class="td-title">
				<c:choose>
					<c:when test="${reply.comment == null}">
						-
					</c:when>
					<c:when test="${reply.comment != null}">
						${reply.comment}					
					</c:when>
				</c:choose>
			</td>
			<c:choose>
				<c:when test="${reply.comment == null}">
					-
				</c:when>
				<c:when test="${reply.comment != null}">
					${reply.comment}					
				</c:when>
			</c:choose>
			<script>
				$.ajax({
					type : "GET",
					traditional : true,
					url : "/user/replyitemList?id="+${reply.id},
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
			<td id="rp-item${replyCount}">물품1 10개, 물품2 5개</td>
			<td>${reply.status}</td>
		</tr>
	<c:set var="replyCount" value="${replyCount + 1}" />
	</c:forEach>
</table>
<div style="width:100%; margin-top:1rem; text-align:center;">
	<c:if test="${replyCount == 0}" >
		현재 응답된 내역이 없습니다.
	</c:if>
</div>