<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<p style="font-weight:bold;">* 요청 내역을 수정한 후 [저장하기]를 누르시면 수정된 내역이 바로 저장됩니다.</p>

<div class="modal-title">
	<input id ="rq_title" type="text" style="font-size:1.25rem; font-weight:bold;" />
</div>
<div class="content-info" id="request-info">
	<div class="div-table" style="border-top:none;">	
		<div class="div-table-wrapper">
			<div class="div-table-left">
				<div class="div-table-title"><b>요청번호</b></div><input id="rq_id"  type="text" style="border-style:none;" disabled/>
			</div>
			<div class="div-table-right">
				<div class="div-table-title"><b>등록날짜</b></div><input id="rq_date" type="text" style="border-style:none;" disabled/>
			</div>
		</div>
		<div class="div-table-wrapper">
			<div class="div-table-left">
				<div class="div-table-title"><b>상태<span style="visibility:hidden;">상태</span></b></div>
				<select class="request-period" name="type" id="rq_status" style="outline:none;">
					<option value="WAITING">대기</option>
					<option value="APPROVED">승인</option>
					<option value="NON_APPROVED">미승인</option>
					<option value="CLOSED">마감</option>
				</select>
			</div>
			<div class="div-table-right">
				<div class="div-table-title"><b>요청대상</b></div>
				<select class="request-period" name="type" id="rq_clientType" style="outline:none;">
					<option value="ELDERLY">노인</option>
					<option value="CHILD">아이</option>
					<option value="DISABLED">장애인</option>
					<option value="OTHERS">기타</option>
				</select>
			</div>
		</div>
		
		<div class="div-table-wrapper">
			<div class="div-table-left">
				<div class="div-table-title"><b>요청자<span style="visibility:hidden;">요</span></span></b></div>
				<input type="text" name="userName" id="rq_userName" style="border-style:none" disabled />
			</div>
			<div class="div-table-right">
				<div class="div-table-title"><b>기간설정</b></div>
				<select class="request-period" name="period" id="rq_urgentLevel" style="outline:none;">
					<option value="3">보통(한 달 이내)</option>
					<option value="2">긴급(7~14일 이내)</option>
					<option value="1">매우 긴급(3일 이내)</option>
				</select>
				
			</div>			
		</div>
		<div class="div-table-wrapper">
			<div class="div-table-left">
				<div class="div-table-title"><b>주소<span style="visibility:hidden;">주소</span></b></div>
				<input class="text-input" type="text" name="roadAddrPart1" style="width:50%;" id="roadAddrPart1" disabled>			
				<input type="text" name="roadLongitude" id="roadLongitude" hidden />
				<input type="text" name="roadLatitude" id="roadLatitude" hidden />
				<button id="rq_search" style="background-color:white; border:1px solid black; outline:none; width:3rem;" onclick="goPopup();">검색</button>			
			</div>
		</div>				
	</div>
<!-- 
	<table class="info-table" style="border-top: none; margin-top: 0;">
		<tr>
			<td style="width: 17.5%;"><b>요청번호</b></td>
			<td style="width: 27.5%;"><input id="rq_id"  type="text" style="border-style:none;" disabled/></td>
			<td style="width: 17.5%;"><b>등록날짜</b></td>
			<td id="" style="width: 37.5%;"><input id="rq_date" type="text" style="border-style:none;" disabled/></td>
		</tr>
		<tr>
			<td><b>승인여부</b></td>
			<td id="">
				<select class="request-period" name="type" id="rq_status" style="outline:none;">
					<option value="WAITING">대기</option>
					<option value="APPROVED">승인</option>
					<option value="NON_APPROVED">미승인</option>
					<option value="CLOSED">마감</option>
				</select>
			</td>
			<td><b>주소</b></td>
			<td id="">
				<input class="text-input" type="text" name="roadAddrPart1" style="width:50%;" id="roadAddrPart1" disabled>			
				<input type="text" name="roadLongitude" id="roadLongitude" hidden />
				<input type="text" name="roadLatitude" id="roadLatitude" hidden />
				<button id="rq_search" style="background-color:white; border:1px solid black; outline:none;" onclick="goPopup();">검색</button>
			</td>
		</tr>
		<tr>
			<td style="width: 17.5%;"><b>요청대상</b></td>
			<td style="width: 27.5%;">
				<select class="request-period" name="type" id="rq_clientType" style="outline:none;">
					<option value="ELDERLY">노인</option>
					<option value="CHILD">아이</option>
					<option value="DISABLED">장애인</option>
					<option value="OTHERS">기타</option>
				</select>
			</td>
			<td style="width: 17.5%;"><b>기간 설정</b></td>
			<td id="" style="width: 37.5%;">
				<select class="request-period" name="period" id="rq_urgentLevel" style="outline:none;">
					<option value="3">보통(한 달 이내)</option>
					<option value="2">긴급(7~14일 이내)</option>
					<option value="1">매우 긴급(3일 이내)</option>
				</select>
			</td>
		</tr>
		<tr>
			<td style="width: 17.5%"><b>요청자</b></td>
			<td style="width:27.5%">
				<input type="text" name="userName" id="rq_userName" style="border-style:none" disabled />
			</td>
			<td style="width: 17.5%"><b></b></td>
			<td style="width:27.5%">
			</td>
		</tr>
	</table>

 -->
	<div class="summernoteDiv" id="rq_contents_summernotes">
		<textarea type="text" class="request-content summernote" id="rq_contents1" name="content" required></textarea>
	</div>
	<p style="margin-top:0.5rem; font-weight:bold;">* 기존 아이템의 삭제를 원할 경우 목표 수량을 0으로 지정해주시기 바랍니다.</p>
	
	<div class="content-needs">
		<table id="myTable" class="info-table">
			<tr>
				<th style="width: 17.5%;">종류</th>
				<th style="width: 25.5%;">내역</th>
				<th style="width: 15%;" id="current_td">응답된 수</th>
				<th style="width: 25%;" id="edit_td">목표 수량</th>
				<th style="width: 5%;" id="delete_td">삭제</th>
				
			</tr>
			<tr class="needs-category" id="rq_item0"></tr>
			<tbody id="preItem">
			</tbody>
			<tbody id="newItem">
			</tbody>
			<tr class="add_item" id="add_item">
				<th colspan="5"><button type="button" class="add_item-button" style="width: 100%" onclick="rowAdd();">+</button></th>
			</tr>					
		</table>
	</div>
	<div style="width:100%; display:flex; justify-content:space-between;" class="">
		<div class="btn-res btn-edit" id="rq_back" onclick="closeModal_manager();">뒤로가기</div>
		<div class="btn-res" id="rq_save" onclick="">저장하기</div>
	</div>
</div>