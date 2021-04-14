<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="/js/manager.js"></script>
<link href="/css/modal-info.css" rel="stylesheet" />
<div class="content-title userModal">
	<div id="title_id"></div>
	<input type="hidden" id="input_id">
	<div class="input-container content-title" id="input_upw_container">
		<div style="height:1.75rem;"><input type="checkbox" name="pwCheck" id="isPwChange" style="margin-top:0.3rem;"></div>
		<div class="userInfoTitle userPwChange" id="input_upw_title">비밀번호 변경: </div>
		<div class="userInfoContent" style="padding-right:1rem;"><input type="password" class="userPwInput" id="input_upw" disabled></div>
		<div class="btn-cng" id="pw_change_btn" onclick="pwChange();">변경</div>
	</div>
</div>
<div class="user-modal" style="display: flex; flex-direction: row; justify-content: space-around;padding-top:1.5rem;border-bottom:2px solid black;overflow:auto;height:75%;">
<div class="user_flex_left">
	<div class="input-container" id="input_ustate_flag_container">
		<div class="userInfoTitle">승인 여부: </div>
		<div class="userInfoContent">
			<input type="radio" name="apinfo" id="input_ustate_flag_y" value="APPROVED">&nbsp;승인 
			<input type="radio" name="apinfo" id="input_ustate_flag_n" value="WAITING">&nbsp;미승인
		</div>
	</div>
	<div class="input-container" id="input_utype_container">
		<div class="userInfoTitle">사용자 유형: </div>
		<select class="userInfoInput" id="input_utype" name="utype">
			<option value="INDIVIDUAL">개인</option>
			<option value="GROUP">단체</option>
			<option value="SOCIAL_WORKER">사회복지사</option>
			<option value="INSTITUTION">사회복지기관</option>
			<option value="ADMIN">관리자</option>
		</select>
	</div>
	<div class="input-container" id="input_uid_container">
		<span class="userInfoTitle">사용자 아이디: </span>
		<input class="userInfoInput" type="text" id="input_uid">
	</div>
	<div class="input-container" id="input_uname_container">
		<span class="userInfoTitle">사용자 이름: </span>
		<input class="userInfoInput" type="text" id="input_uname">
	</div>
	<div class="input-container" id="input_uphone_container">
		<span class="userInfoTitle">사용자 전화번호: </span>
		<input class="userInfoInput" type="text" id="input_uphone">
	</div>
	<div class="input-container" id="input_umsg_flag_container">
		<span class="userInfoTitle">SMS 수신 동의: </span>
		<input type="radio" name="smsinfo" id="input_umsg_flag_y" value="1">&nbsp;예
		<input type="radio" name="smsinfo" id="input_umsg_flag_n" value="0">&nbsp;아니오
	</div>
	<div class="input-container" id="input_uemail_container">
		<span class="userInfoTitle">사용자 이메일: </span>
		<input class="userInfoInput" type="text" id="input_uemail">
	</div>
	<div class="input-container" id="input_uemail_flag_container">
		<span class="userInfoTitle">이메일 수신 동의: </span>
		<input type="radio" name="eminfo" id="input_uemail_flag_y" value="1">&nbsp;예
		<input type="radio" name="eminfo" id="input_uemail_flag_n" value="0">&nbsp;아니오
	</div>
</div>
<div class="user_flex_right">
	<div class="input-container" id="input_uaddr_container">
		<span class="userInfoTitle">사용자 주소: </span>
		<input class="userInfoInput" type="text" id="input_uaddr">
	</div>	
	<div class="input-container" id="input_ushow_flag_container">
		<span class="userInfoTitle">지도 표시 여부: </span>
		<input type="radio" name="showinfo" id="input_ushow_flag_y" value="1">&nbsp;예
		<input type="radio" name="showinfo" id="input_ushow_flag_n" value="0">&nbsp;아니오
	</div>

	<div class="input-container" id="input_uradius_container">
		<span class="userInfoTitle">알림 반경</span>
		<select id="input_uradius" name="uradius">
			<option value="3">3</option>
			<option value="5">5</option>
			<option value="7">7</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="0" id="noradius">0</option>
		</select>
		<span>km</span>
	</div>
	<div class="input-container" id="input_udob_container">
		<span class="userInfoTitle">생년월일</span>
		<select class="select-date" id="selectyear"></select> <input type="hidden" id="dob_year">
		<select class="select-date" id="selectmonth"></select> <input type="hidden" id="dob_month">
		<select class="select-date" id="selectdate"></select> <input type="hidden" id="dob_date">
	</div>
	<div class="input-container" id="input_usex_container">
		<span class="userInfoTitle">성별: </span>
		<select class="userInfoInput" id="input_usex" name="usex">
			<option value="1">남자</option>
			<option value="2">여자</option>
		</select>
	</div>
	<div class="input-container" id="input_uorg_container">
		<span class="userInfoTitle">기관명: </span>
		<input class="userInfoInput" type="text" id="input_uorg">
	</div>
	<div class="input-container" id="input_uorg_role_container">
		<span class="userInfoTitle" id="role_type"></span>
		<input class="userInfoInput" type="text" id="input_uorg_role">
	</div>
	<div class="input-container" id="input_uorg_phone_container">
		<span class="userInfoTitle">기관 전화번호: </span>
		<input class="userInfoInput" type="text" id="input_uorg_phone">
	</div>
</div>
</div>
<div style="margin-top:3rem;">
	<div style="width:100%; display:flex; justify-content:space-between;" class="">	
		<div class="btn-res" onclick="withdraw();">삭제하기</div>
		<div class="btn-res" onclick="update();">수정하기</div>
	</div>
</div>
<!-- <div class="modal-ftr" style="float:bottom;width:100%;display:flex;flex-direction:row;justify-content:space-between;height:2rem!important;margin-top:2.5rem;border:1px solid red;">
	<div class="btn-res" onclick="withdraw();">삭제하기</div>
	<div class="btn-res" onclick="update();">수정하기</div>
</div> -->
