<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<link href="/css/request.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
</head>

<body id="page-top">
	<div class="modal-bg" id="modal-bg" onclick="closeModal_request()"></div>
	<div class="modal-container" id="view-detail">
		<div class="modal-content">
			<h5 id="modal-title">독거어르신 주거환경개선 도움 요청</h5>
			<div class="content-info">
				<table class="info-table">
					<tr>
						<td style="width: 17.5%;"><b>등록번호</b></td>
						<td style="width: 27.5%;">#10011</td>
						<td style="width: 17.5%;"><b>등록날짜</b></td>
						<td style="width: 37.5%;">2020.10.21.</td>
					</tr>
					<tr>
						<td><b>기간</b></td>
						<td id="modal-period"></td>
						<td></td>
						<td></td>
					</tr>
				</table>
				<div class="content-text" id="modal-contents"></div>
				<div class="content-needs">
					<table class="info-table" id="modal-table">
						<thead>
							<tr style="border-bottom: 2px solid grey; cursor: none;">
								<th style="width: 15%;">종류</th>
								<th style="width: 50%;">내역</th>
								<th style="width: 35%;">수량</th>
							</tr>
						</thead>
						<tbody id="modal-reset">

						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="modal-ftr" style="display: flex; flex-direction: row; justify-content: space-between;">
			<div class="btn-res" onclick="closeModal_request();" style="color: gray; border: 2px solid gray;">취소</div>
			<div class="btn-res" onclick="upload(2);" style="color: gray; border: 2px solid gray;">올리기</div>
		</div>
	</div>

	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<!-- Navigation-->
		<%@include file="../layout/navbar.jsp"%>

		<header class="text-white text-center request-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>요청하기</h4>
					<p>
						도움이 필요한 이웃을 위해<br>요청을 올릴 수 있습니다.
					</p>
				</div>
			</div>
		</header>

		<section class="request-section" id="request">
			<div class="container">
				<div class="request-form" id="requestForm">
					<div class="" style="margin-bottom: 1rem;">
						<input type="text" class="request-title" id="requestTitle" placeholder="제목을 입력해주세요" name="title" required />
					</div>
					<div style="">
						<div class="" style="width:100%; display:inline-block;">
							<div class="" style="margin-bottom:1rem;">
								<span>기간 설정 : </span> <select class="request-period" name="period" id="requestPeriod" style="outline:none;">
									<option name="p1">보통(한 달 이내)</option>
									<option name="p2">긴급(7~14일 이내)</option>
									<option name="p3">매우 긴급(3일 이내)</option>
								</select>
							</div>
							<div class="" style="margin-bottom:0.5rem;">
								<span>요청 대상 : </span> <select class="request-period" name="type" id="requestType" style="outline:none;">
									<option name="t1">노인</option>
									<option name="t2">아이</option>
									<option name="t3">장애인</option>
									<option name="t4">기타</option>
								</select>
							</div>
							<span class="" style="font-size:0.76rem; color:blue;">* 대략적인 위치 파악을 위한 주소이므로, 상세 정보는 적으시지 않아도 됩니다.</span>
							<div class="" style="margin-bottom:0.5rem;">
								<span>요청 장소 : </span> <input class="text-input" type="text" name="roadAddrPart1" style="width:50%; margin-right:0.5rem; font-size:0.75rem;" id="roadAddrPart1" placeholder="예시 : 포항시 북구 흥해읍 한동로 558" disabled>
								<button style="background-color:white; border:1px solid black; outline:none;" onclick="goPopup();">검색</button>
								  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
								    지도에서 보기
								  </button>
							</div>
						</div>
						
						  <!-- The Modal -->
						  <div class="modal" id="myModal" style="">
						    <div class="modal-dialog" style="width:80%!important; height:80%!important;">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div class="modal-header">
						          <h4 class="modal-title">Modal Heading</h4>
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						        </div>
						        
						        <!-- Modal body -->
						        <div class="modal-body" style="padding:0; margin:0;">
	        						<!-- 지도에서 보기를 클릭하면 모달로 나오도록? -->
									<div class="map_wrap " style="height:100%!important; display:none; padding:0!important; margin:0!important;">
										<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
										<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
										<div class="custom_zoomcontrol radius_border" >
											<span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span> <span onclick="zoomOut()"><img
												src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
										</div>
									</div>
						        </div>
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
						
						
						
					</div>

					<div class="summernoteDiv">
						<textarea type="text" class="request-content summernote" id="requestContents" name="content" required></textarea>
					</div>
					<div>
						<p style="font-weight: bold;">어떤 도움이 필요하신지 입력해주세요!</p>
					</div>
					<div>
						<p>
							<b>**입력 가이드라인**</b>
						</p>
						<p>
							1. 물품: 이름-물품명 <span class="res-span">ex)선풍기, 세제 등</span>
						</p>
						<p>
							2. 재정: 이름-재정이 쓰이는 곳 <span class="res-span">ex) 밀린 공과금 납부</span>
						</p>
						<p>
							3. 봉사: 이름-봉사 이름 <span class="res-span">ex)연탄봉사</span>
						</p>
					</div>
					<div>
						<table id="myTable">
							<thead class="table-title" style="cursor: initial;">
								<th class="" width="20%">종류</th>
								<th class="" width="40%">이름</th>
								<th class="" width="5%">수량</th>
								<th class="" width="5%">삭제</th>
							</thead>
							<tbody>
							</tbody>
							<tr class="add_item ">
								<th colspan="4"><button type="button" class="add_item-button" style="width: 100%" onclick="rowAdd();">+</button></th>
							</tr>
						</table>
					</div>
				</div>
				<div class="request-ftr" style="justify-content: space-between;">
					<div class="btn-upload" onclick="upload(1);">미리보기</div>
					<!-- <div class="btn-save" onclick="save();">임시저장</div> -->
				</div>
			</div>
		</section>

		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
		<%@include file="../layout/sidebar_back.jsp"%>

	</div>
	<%@include file="../layout/jsFile.jsp"%>
	<%@include file="../layout/summernote.jsp"%>
	<%@include file="../layout/kakaoMap.jsp"%>
	<script src="/js/request.js"></script>

	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(0, 0), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomIn() {
			map.setLevel(map.getLevel() - 1);
		}

		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomOut() {
			map.setLevel(map.getLevel() + 1);
		}
		
		$(".map_wrap").hide();
	</script>
</body>
</html>
