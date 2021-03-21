<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<p style="font-weight:bold;">* 응답 내역을 수정한 후 [저장하기]를 누르시면 수정된 내역이 바로 저장됩니다.</p>

			<div class="" style="display:flex; justify-content:space-between;">
				<h5>응답 내역 확인</h5>
				<span id="rq_title" style="font-size:0.75rem;"></span>
			</div>
			<div class="content-info">
				<table class="info-table">
					<tr>
						<td style="width: 17.5%;"><b>등록번호</b></td>
						<td id="rp_id" style="width: 27.5%;"></td>
						<td style="width: 17.5%;"><b>등록날짜</b></td>
						<td id="rp_date" style="width: 37.5%;"></td>
					</tr>
					<tr>
						<td><b>승인여부</b></td>
						<td>
							<select class="request-period" name="type" id="rp_status" style="outline:none;">
								<option value="WAITING">대기</option>
								<option value="APPROVED">승인</option>
							</select>
						</td>
						<td><b>소속</b></td>
						<td><input id="rp_org" style="outline:none;"/></td>
					</tr>
					<tr>
						<td><b>등록자 명</b></td>
						<td><input id="rp_name" style="outline:none;" /></td>
						<td><b>연락처</b></td>
						<td><input id="rp_phone" style="outline:none;" /></td>
					</tr>
				</table>
				<div class="content-text">
					<textarea style="width:100%; padding:0.5rem; resize: none; outline:none;" id="rp_content" placeholder="응답에 대한 설명입니다."></textarea>
				
				</div>
				<div class="content-needs ">
					<table class="info-table ">
						<tr>
							<th style="width: 17.5%;">종류</th>
							<th style="width: 15.5%;">내역</th>
							<th style="width: 35%;">내 응답량</th>
							<th style="width: 10%;">현재량</th>
							<th style="width: 10%;">목표량</th>
						</tr>
						<tr class="needs-category" id="rp_item0"></tr>
					</table>
				</div>
			</div>
			<div class="response-wrapper " id="response-wrapper" style="margin-bottom:1rem;">
				<div class="response-title ">요청자 회신</div>
				<textarea style="width:100%; height:7.5rem; padding:0.5rem; resize: none; outline:none;" id="response-content" placeholder="요청자가 응답자에게 보내는 메시지입니다."></textarea>
			</div>
			
			<div class="modal-container" id="view-responseForm"></div>
			<!-- modal.js에 click event 생성 -->
			<div class=" " style="width:100%; display:flex; justify-content: space-between; margin-bottom:1rem;">
				<div class="btn-com btn-edit" id="rp-back">뒤로가기</div>
				<div class="btn-res" id="rp-save">저장하기</div>
			</div>