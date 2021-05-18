<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="width:100%; font-size:1rem; margin-bottom:1rem;">
	<b>* 두드림 터치의 회원들에 대해 가입 승인 및 회원정보 수정이 가능합니다.</b>
</div>
<table class="" id="info-table" style="table-layout: fixed;">
	<thead>
		<tr style="border-bottom: 3px solid #d3d3d3;">
			<th class="table-num" style="width:10%;">등록 번호</th>
			<th class="table-name" style="width:12.5%;">이름</th>
			<th class="table-userPhone" style="width:12.5%;">연락처</th>
			<th class="table-userType" style="width:12.5%;">회원유형</th>
			<th class="table-state" style="width:12.5%;">승인여부</th>
			<th class="table-date" style="width:12.5%;">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="userCount" value="0" />
		<c:set var="currentPage" value="${users.pageable.pageNumber}"></c:set>
		<c:forEach var="user" items="${users.content}">
			<c:if test="${user.userType != 'DELETED'}">
				<c:choose>
					<c:when test="${user.userType == 'INDIVIDUAL'}">
						<c:set var="usertype" value="개인" />
					</c:when>
					<c:when test="${user.userType == 'GROUP'}">
						<c:set var="usertype" value="단체" />
					</c:when>
					<c:when test="${user.userType == 'SOCIAL_WORKER'}">
						<c:set var="usertype" value="사회복지사" />
					</c:when>
					<c:when test="${user.userType == 'INSTITUTION'}">
						<c:set var="usertype" value="기관" />
					</c:when>
					<c:when test="${user.userType == 'ADMIN'}">
						<c:set var="usertype" value="관리자" /> 
					</c:when>
				</c:choose>
				<script>
					var usr${user.id} = {
						id: ${user.id},
						uaddr: '${user.address}',
						uemail_flag: ${user.emailFlag},
						umsg_flag: ${user.msgFlag},
						uradius: ${user.notificationRadius},
						uid: '${user.loginId}',
						usex: ${user.userSex},
						utype: '${user.userType}',
						udob: '${user.userDob}',
						uemail: '${user.userEmail}',
						uname: '${user.userName}',
						uphone: '${user.userPhone}',
						uorg: '${user.orgName}',
						uorg_role: '${user.orgUserRole}',
						uorg_phone: '${user.orgPhone}',
						ushow_flag: ${user.showFlag},
						ustate_flag: '${user.stateFlag}',
						is_social: ${user.isSocial},
					};
				</script>
				<!-- 여기서 tr 클릭하면 -->
				<tr onclick="openModal_manager(usr${user.id}, 0)" style="cursor:pointer;">
					<td class="table-num">${user.id}</td>
					<td class="table-name">${user.userName}</td>
					<td class="table-userPhone">${user.userPhone}</td>
					<td class="table-userType">${usertype}</td>
					<c:choose>
						<c:when test="${user.stateFlag == 'APPROVED'}">
							<c:set var="state" value="승인" />
							<td class="table-state">${state}</td>
						</c:when>
						<c:when test="${user.stateFlag == 'NON_APPROVED' or user.stateFlag == 'WAITING'}">
							<c:set var="state" value="미승인" />
							<td class="table-state" style="color:red;">${state}</td>
						</c:when>
					</c:choose>
					<td class="table-date">${fn:substring(user.regDate, 0, 10)}</td>
				</tr>
				<c:set var="userCount" value="${userCount + 1}" />
			</c:if>
		</c:forEach>
	</tbody>
</table>

<section class="mypage-section2" id="about" style="text-align: center;">
	<div class="container">
		<!-- searech line -->
		<br>

		<c:set var="page" value="${users.number}" />
		<!-- 첫번째 페이지 -->
		<c:set var="startNum" value="${page - (page) % 5}" />
		<!-- 마지막 페이지 -->
		<c:set var="lastNum" value="${users.totalPages-1}" />
		<c:set var="isLast" value="5" />
		<c:if test="${users.totalPages == 0}">
			<div style="margin-bottom: 2vh;">
				<br>유저 정보가 존재하지 않습니다.
			</div>
			<c:set var="isLast" value="1" />
		</c:if>
		<div class="pagination">
			<c:if test="${startNum >= 5}">
				<a onclick="paging(${startNum - 1}, 0)" style="float: left;" class="btn btn-prev paging-left">&laquo;</a>
			</c:if>

			<c:if test="${startNum == 0}">
				<span class="btn btn-prev" style="color: #e3e3e3; float: left; cursor: initial;" disabled>&laquo;</span>
			</c:if>
			<c:if test="${users.totalPages ne 0}">
				<!-- 마지막수 - 첫번째수 -->
				<c:if test="${startNum + 5 >= lastNum }">
					<c:set var="isLast" value="${lastNum - startNum + 1}" />
				</c:if>
			</c:if>
			<c:forEach var="i" begin="0" end="${isLast-1}">
				<c:choose>
					<c:when test="${i eq page%5}">
						<a class="-text- orange bold selected_page" onclick="paging(${startNum + i}, 0)"> ${startNum + i + 1}</a>
					</c:when>
					<c:otherwise>
						<a class="-text- orange bold" onclick="paging(${startNum + i}, 0)"> ${startNum + i + 1}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 마지막번호는 DB레코드 수와 연관이 있다! 우선은 lastpage 개수를 임의로 지정. -->
			<c:if test="${startNum + 4 <= lastNum }">
				<a onclick="paging(${startNum + 5}, 0)" class="btn btn-next paging-right">&raquo;</a>
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
