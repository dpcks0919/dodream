<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<div id="menu-back" onclick="closeNav()"></div>
<div id="mySidebar" class="sidebar">
	<h2>두드림터치</h2>
	<div style="padding-top: 20%; padding-left: 7%; padding-right: 7%; text-align: left;">
	
		 <c:choose>
		 	<c:when test="${principal.user.userType eq 'SOCIAL_WORKER' || principal.user.userType eq 'INSTITUTION' }">
		 		<a class="menu-item-top" href="/social/request">요청하기</a>
				<a class="menu-item" href="/requestMap">요청보기</a>
		 	</c:when>
			<c:when test="${principal.user.userType eq 'ADMIN' }">
				<a href="/user/manager" class="menu-item-top">관리자 페이지</a>
				<a class="menu-item" href="/requestMap">요청보기</a>
				<a class="menu-item" href="/social/request">요청하기</a> 
			</c:when>
		 	<c:otherwise>
		 		<a class="menu-item-top" href="/requestMap">요청보기</a>
		 	</c:otherwise>
		 </c:choose>		 
		 <a class="menu-item" href="/news/newsList">소식보기</a> 
		 <a class="menu-item" href="/dodreamtouch">두드림터치</a>
	</div>
</div>
