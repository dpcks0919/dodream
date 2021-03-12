<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​
<%@include file="../layout/header.jsp"%>


<link href="/css/mypage.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
table {
	table-layout: fixed;
}

table td {
	width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>

</head>

<body id="page-top">
	<div class="modal-bg" id="modal-bg" style="display: none;"></div>

	<!-- 요청 항목 세부정보 보기 -->
	<div class="modal-container" id="view-detail" style="display: none;">
		<div class="modal-content" style="height: 100%;">
			<div class="modal-title">
				<input id ="rq_title" type="text" style="border-style:none; font-size:1.25rem; font-weight:bold;" readonly/>
				<div class="dropdown dd-down" id="change-req" onclick="requestdown(this);">
					<i class="fas fa-chevron-down"></i>
				</div>
			</div>
			<div class="content-info" id="request-info" style="display: none;">
				<table class="info-table" style="border-top: none; margin-top: 0;">
					<tr>
						<td style="width: 17.5%;"><b>등록번호</b></td>
						<td style="width: 27.5%;"><input id="rq_id"  type="text" style="border-style:none;" disabled/></td>
						<td style="width: 17.5%;"><b>등록날짜</b></td>
						<td id="" style="width: 37.5%;"><input id="rq_date" type="text" style="border-style:none;" disabled/></td>
					</tr>
					<tr>
						<td><b>상태</b></td>
						<td id=""><input id="rq_status" type="text" style="border-style:none;" disabled/></td>
						<td><b>주소</b></td>
						<td id="">
							<input class="text-input" type="text" name="roadAddrPart1" style="width:50%;" id="roadAddrPart1" disabled>			
							<input type="text" name="roadLongitude" id="roadLongitude" hidden />
							<input type="text" name="roadLatitude" id="roadLatitude" hidden />
							<button id="rq_search" style="background-color:white; border:1px solid black; outline:none; display:none;" onclick="goPopup();">검색</button>
						</td>
					</tr>
					<tr>
						<td style="width: 17.5%;"><b>요청대상</b></td>
						<td style="width: 27.5%;">
							<select class="request-period" name="type" id="rq_clientType" style="outline:none;" disabled>
								<option value="ELDERLY">노인</option>
								<option value="CHILD">아이</option>
								<option value="DISABLED">장애인</option>
								<option value="OTHERS">기타</option>
							</select>
						</td>
						<td style="width: 17.5%;"><b>기간 설정</b></td>
						<td id="" style="width: 37.5%;">
							<select class="request-period" name="period" id="rq_urgentLevel" style="outline:none;" disabled>
								<option value="3">보통(한 달 이내)</option>
								<option value="2">긴급(7~14일 이내)</option>
								<option value="1">매우 긴급(3일 이내)</option>
							</select>
						</td>
					</tr>
				</table>
				<div class="content-text" id="rq_contents"></div>
				<div class="summernoteDiv" id="rq_contents_summernotes" style="display:none;">
					<textarea type="text" class="request-content summernote" id="rq_contents1" name="content" required></textarea>
				</div>
				<div class="content-needs">
					<table id="myTable" class="info-table">
						<tr>
							<th style="width: 17.5%;">종류</th>
							<th style="width: 25.5%;">내역</th>
							<th style="width: 55%;" id="default_td">현재 수량 / 목표 수량</th>
							<th style="width: 15%;" id="edit_td" hidden>목표 수량</th>
							<th style="width: 5%;" id="delete_td" hidden>삭제</th>
							
						</tr>
						<tr class="needs-category" id="rq_item0"></tr>
						<tbody id="preItem">
						</tbody>
						<tbody id="newItem">
						</tbody>
						<tr class="add_item" id="add_item">
							<th colspan="4"><button type="button" class="add_item-button" style="width: 100%" onclick="rowAdd();">+</button></th>
						</tr>					
					</table>
				</div>
				<div style="width:100%; display:flex; justify-content:space-between;" class="">
					<div class="btn-res btn-edit" id="rq_back" style="visibility:hidden;" onclick="request_back();">뒤로가기</div>
					<div class="btn-res btn-edit" id="rq_edit">수정하기</div>
					<div class="btn-res btn-edit" style="display:none;" id="rq_save" onclick="request_edit_save();">저장하기</div>				
				</div>
			</div>
			
			
			<!-- 요청에 대한 응답 목록 부분 -->
			<div class="modal-title" style="margin-top: 1rem;">
				<h5>응답 확인하기</h5>
				<div class="dropdown dd-up" id="change-res" onclick="responsedown(this);">
					<i class="fas fa-chevron-up"></i>
				</div>
			</div>
			<!-- 
			1. request.id 에 해당하는 모든 replyList을 불러옴. (ajax로 Controller-Service-replyRepository.findById)
			2. reply.id, reply.title, reply.item, reply.status 별로 List 정렬 (
			3. reply.id에 해당하는 title, content, replyItem들을 다 불러옴.
			4. replyItem
			
			-->
			<div class="content-info" id="response-info" style="display: block;">
				<div class="content-needs" id="content-responseList"></div>
			</div>
		</div>
	</div>

	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<!-- Navigation-->

		<%@include file="../layout/navbar.jsp"%>

		<header class="text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>요청내역</h4>
					<p>
						지금까지 요청하신 내역들을<br>모두 확인할 수 있습니다.
					</p>
				</div>
			</div>
		</header>
		<!-- news Section-->
		<section class="myrequest-section" id="about" style="text-align: center;">
			<div class="container ">
				<table style="table-layout: fixed">
					<thead>
						<tr style="border-bottom: 3px solid #d3d3d3;">
							<th class="table-num">등록번호</th>
							<th class="table-title">요청 내용</th>
							<th class="table-date">등록일</th>
							<th class="table-status">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="request" items="${myrequestList.content}">
						<fmt:formatDate value="${request.regDate}" pattern="yyyy. MM. dd." var="regdate" />
						
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
													
						<c:choose>
							<c:when test="${request.status == 'APPROVED'}" >
								<c:set var="status" value="승인"/>
							</c:when>
							<c:when test="${request.status == 'NON_APPROVED'}" >
								<c:set var="status" value="미승인"/>
							</c:when>
							<c:when test="${request.status == 'WAITING'}" >
								<c:set var="status" value="대기"/>
							</c:when>
							<c:when test="${request.status == 'CLOSED'}" >
								<c:set var="status" value="마감"/>
							</c:when>
						</c:choose>
												
						<tr class="response-item" onclick="goDetail_myrequest(rq${request.id});">
							<td class="table-num">${request.id}</td>
							<td class="table-title fbold">${request.title}</td>
							<td class="table-date">${regdate}</td>
							<td class="table-status">대기</td>
						</tr>						
						</c:forEach>
						
					</tbody>
				</table>
			</div>
		</section>
		
		<!-- paging-wrapper css는 news.css에 있음. -->
		<div class="paging-wrapper">
			<c:set var="page" value="${myrequestList.number}" />
			<!-- 첫번째 페이지 -->
			<c:set var="startNum" value="${page - (page) % 5}" />
			<!-- 마지막 페이지 -->
			<c:set var="lastNum" value="${myrequestList.totalPages-1}" />
			<c:set var="isLast" value="5" />
			<c:choose>
				<c:when test="${myrequestList.totalPages == 0}">
					<div style="margin-bottom: 1rem; text-align:center;">
						두드림 소식이 존재하지 않습니다.
					</div>
					<c:set var="isLast" value="1" />
				</c:when>
				<c:otherwise>
					<div class="pagination">
						<c:if test="${startNum >= 5}">
							<a href="?page=${startNum - 1}" style="float: left;" class="btn btn-prev paging-left">&laquo;</a>
						</c:if>
			
						<c:if test="${startNum == 0}">
							<span class="btn btn-prev" style="color: #e3e3e3; float: left; cursor: initial;" disabled>&laquo;</span>
						</c:if>
						<c:if test="${myrequestList.totalPages ne 0}">
							<!-- 마지막수 - 첫번째수 -->
							<c:if test="${startNum + 5 >= lastNum }">
								<c:set var="isLast" value="${lastNum - startNum + 1}" />
							</c:if>
						</c:if>
						<c:forEach var="i" begin="0" end="${isLast-1}">
							<c:choose>
								<c:when test="${i eq page%5}">
									<a class="-text- orange bold selected_page" href="?page=${startNum + i}">${startNum + i + 1}</a>
								</c:when>
								<c:otherwise>
									<a class="-text- orange bold" href="?page=${startNum + i}">${startNum + i + 1}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
			
						<!-- 마지막번호는 DB레코드 수와 연관이 있다! 우선은 lastpage 개수를 임의로 지정. -->
						<c:if test="${startNum + 4 <= lastNum }">
							<a href="?page=${startNum + 5}" class="btn btn-next paging-right">&raquo;</a>
						</c:if>
						<c:if test="${startNum + 4 > lastNum }">
							<span class="btn btn-next" style="color: #e3e3e3; cursor: initial;" disabled>&raquo;</span>
						</c:if>
					</div>	
				</c:otherwise>
			</c:choose>
		</div>

		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
		<%@include file="../layout/sidebar_back.jsp"%>

	</div>

	<%@include file="../layout/jsFile.jsp"%>
	<%@include file="../layout/summernote.jsp"%>
	<%@include file="../layout/kakaoMap.jsp"%>
	<script src="/js/my.js"></script>
	
	<script>
	// 응답 
		function response_detail(ele, reply_id) {
			$.ajax({
				type : "GET",
				traditional : true,
				url : "/user/replyInfo?id="+reply_id,
			}).done(function(resp) {
				if (resp.status == 500) {
					alert("에러발생");
				} else {
					// 응답 아이템 불러오기.
					$.ajax({
						type : "GET",
						traditional : true,
						url : "/user/replyItemObj?id="+reply_id,
					}).done(function(resp1) {
						if (resp1.status == 500) {
							alert("에러발생");
						} else {
							if(resp.replyPhone == "") {
								var phone = "미등록";
							} else {
								var phone = resp.replyPhone;						
							}
								var content = resp.replyContent;
								var regdate = resp.regDate;
								var message = resp.comment;
								
								var id = "#" + $(ele).attr('id');
								var num = id.substr(9, id.length);
								var cl = 'rc' + num;
								var html = "";
							
								var itemHtml = "";
								for(var i=0; i<resp1.length; i++) {
									var replyItem = resp1[i].split("^!@#^");
									itemHtml += '<tr class="' + cl + '" style="border-top:1px solid gray;"><td style="padding:5px;">'+replyItem[0]+'</td><td style="padding:5px;">'+replyItem[1]+'</td><td colspan="2" style="padding:5px;">'+replyItem[2]+'개</td></tr>';
								}
								
								html += ('<tr class="' + cl + '" style="border-top:1px solid black; padding-top:0.5rem;"><td colspan="2" style="padding-bottom:0.5rem; margin:0;"><b>연락처 : </b><span id="'+cl+'phone"></span></td>');
								html += ('<td colspan="2" style="padding:0;margin:0;"><b>등록일 : </b><span id="' + cl + 'regdate"></span></td></tr>' );
								html += ('<tr class="' + cl + '"><td colspan="4" style="padding:0;margin:0;"><textarea id="' + cl + 'content"  rows="2" style="resize:none;width:100%;border:none;border-top:1px solid gray;border-bottom:1px solid gray;text-align:left; padding:10px; border:1px solid black;" readonly></textarea></td></tr>' );
								html += ('<tr class="' + cl + '"><th style="width:15%;padding:5px;">종류</th><th style="width:30%;padding:5px;">내역</th><th style="width:55%;padding:5px;">수량</th></tr>');
								// 아이템
								html += itemHtml;
								html += ('<tr class="' + cl + '" style="border-top:2px solid black;"><th colspan="1" style="width:15%;padding:5px;padding-top:10px;">응답 상태</th><td colspan="2" style="width:85%;padding:5px;padding-top:10px;"><select name="status" class="a-or-w" id="'+cl+'status"><option value="WAITING">대기</option><option value="APPROVED">승인</option></select></td></tr>');
								html += ('<tr class="' + cl + '"><td colspan="4" style="padding:5px;padding-top:10px; font-weight:bold;">응답자에게 전하는 메시지</td></tr>');
								html += ('<tr class="' + cl + '"><td colspan="4" style="padding:0;"><textarea name="content" rows="3" id="' + cl + 'message"style="resize:none;width:100%;margin-top:0.5rem; padding:0.5rem;"></textarea></td></tr>');
								html += ('<tr class="' + cl + '" style="border-bottom:2px solid black;"><td colspan="2" style="padding:0;"></td><td colspan="2" style="text-align:right;padding:0;padding-bottom:10px;"><div class="btn-com" id="'+ cl +'upload" onclick="">등록하기</div></td></tr>');
								$(id).after(html);
								var phone_id = "#"+cl+"phone";
								var regdate_id = "#"+cl+"regdate";
								var content_id = "#"+cl+"content";
								var status_id = "#"+cl+"status";
								var uploadBtn_id = "#"+cl+"upload";
								var message_id = "#"+cl+"message";
								
								$(phone_id).text(phone);
								$(regdate_id).text(regdate.substr(0,10));
								$(content_id).text(content);
								$(message_id).text(message);
								
								// 상태 선택
								$(status_id).val(resp.status).prop("selected", true);
								
								$(id).removeAttr("onclick");
								$(id).attr("onclick", ("close_detail(" + num + "," + reply_id + ")"));
								$(uploadBtn_id).attr("onclick", ("reply_upload('"+ reply_id +"', '"+ cl +"')"));
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
			
		}
	
		function close_detail(num, reply_id) {
			var id = "#response" + num;
			var cl = ".rc" + num;
			$('tr').remove(cl);
			$(id).removeAttr("onclick");
			$(id).attr("onclick", "response_detail(this, "+reply_id+")");
		}

		
		function reply_upload(id, cl) {
			var status_id = "#"+cl+"status";
			var message_id = "#"+cl+"message";
			var status = $(status_id+ " option:selected").val();
			var message = $(message_id).val();
			$.ajax({
				type : "GET",
				traditional : true,
				url : "/user/replyUpload?id="+id+"&status="+status+"&message="+message,
			}).done(function(resp) {
				if (resp.status == 500) {
					alert("에러발생");
				} else {
					alert("등록되었습니다!");
					
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
			
		}
		
		
		function request_edit_save() {
			var preItems = $('#myTable tbody[id="preItem"] tr').length;
		    var newItems = $('#myTable tbody[id="newItem"] tr').length;

			  
			  // 먼저 기존 아이템들 업데이트 시킨다. 여기서는 해당 id로 update시킴.
			  // 완료
			  var tr = $('#myTable tbody[id="preItem"] tr');
			  for(var i=0; i<preItems; i++) {
	   			    var me = tr.eq(i).attr('id'); 
					var id = parseInt(me.substr(2, me.length)); 
					var curCnt = id;
					var curID = 'tr' + curCnt;
					var curItem = $("#"+curID + "item").val();
					var curName = $("#"+curID + "name").val();
					var curCount = $("#"+curID + "count").val();
					
					var data = {
						id : id,
						itemNum : parseInt(curCount.replace(",","")),
						itemName : curName,
						requestType : curItem.toUpperCase(),
					};
					$.ajax({
						type:"POST",
						url: "/requestItemUpdateProc",
						data: JSON.stringify(data),
						contentType: "application/json; charset = utf-8 ",
						dataType: "json"
					}).done(function(resp) {
						if(resp.status == 500) {
							alert("업로드 실패");
						} else {
							//alert("기존 아이템 업데이트 되었습니다!");
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});		
			  }
					
			  // 그다음 새로운 아이템들 업데이트 시킨다. 여기서는 id 신경 안쓰고 그냥 save 시키면 됨.
			  // 완료
			  var tr2 = $('#myTable tbody[id="newItem"] tr');
			  for(var i=0; i<newItems; i++) {
				 	var me = tr2.eq(i).attr('id'); 
					var id = me.substr(2, me.length); 
					var curCnt = id;
					var curID = 'tr' + curCnt;
				  	var rqID = parseInt($("#rq_id").val());
					var newItem = $("#"+curID + "newItem").val();
					var newName = $("#"+curID + "newName").val();
					var newCount = $("#"+curID + "newCount").val();
					newCount = parseInt(newCount.replace(",",""));
					let data2 = {
					// request id를 받아와서, requestItem.request에 입력해야하기때문에 임시로 ReceivedNum에 값을 입력받아와서
					// setRequest를 설정하고, ReceivedNum은 다시 0으로 초기화시켜주었다.
						receivedNum : rqID,
						itemNum : newCount,
						itemName : newName,
						requestType : newItem.toUpperCase()
					};
					$.ajax({
						type : "POST",
						url : "/requestItemSaveProc_myrequest",
						data: JSON.stringify(data2),
						contentType: "application/json; charset = utf-8 ",
						dataType: "json"
					}).done(function(resp) {
						if (resp.status == 500) {
							alert("에러발생");
						} else {
							//alert("새로운 아이템이 추가되었습니다!");
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});
			  }
			  
			// request 내용 수정하기.
			  	var rqID = $("#rq_id").val();
				var rqTitle = $("#rq_title").val();
				var rqAddress = $("#roadAddrPart1").val();
				var rqContents = $('.summernote').summernote('code');
				// 위도 경도가 잘 안잡힘. 
				var rqLong = $("#roadLongitude").val();
				var rqLat = $("#roadLatitude").val();

				var client_type = $("#rq_clientType").val();
				var urgent_level = $("#rq_urgentLevel").val();
				
				let data3 = {
					id : rqID,
					title : rqTitle,
					requestAddress : rqAddress,
					longitude : rqLong,
					latitude : rqLat,
					clientType : client_type,
					urgentLevel : urgent_level,
					description : rqContents
				};
				
				$.ajax({
					type : "POST",
					url : "/requestUpdateProc",
					data: JSON.stringify(data3),
					contentType: "application/json; charset = utf-8 ",
					dataType: "json"
				}).done(function(resp) {
					if (resp.status == 500) {
						alert("에러발생");
					} else {
						//alert("요청이 업데이트 되었습니다!");
						alert("요청 내역이 수정되었습니다.");
						location.href = "/user/myrequest";
					}
				}).fail(function(error) {
					console.log(JSON.stringify(error));
				});
				
					
				
			  	
				
			}
		
		// 1. rq_title, rq_status, rq_addr readonly 없애기
		// 2. rq-contents 숨기고 rq_contents_summernotes display block 시키고 val 안에 rq.description 넣기.
		// 3. rq_back visibility visible로 만들기, rq_search hidden 없애기
		// 4. rq_save hidden 없애기, rq_edit hidden으로 만들기.
		function request_edit(rq) {
			alert("수정 후 저장하시면 됩니다.");
			$('#rq_title').prop('readonly', false);
			$("#rq_clientType").prop('disabled', false);
			$("#rq_urgentLevel").prop('disabled', false);
			
			$('#rq_title').css('border-style', 'double');
			$('#roadAddrPart1').css('border-style', 'double');
			var content = $('#rq_contents').html();
			$('#rq_contents').css('display', 'none');
			$('#rq_contents_summernotes').css('display', 'block');
			$('.summernote').summernote('code', content);
			
			$('#rq_back').css('visibility', 'visible');
			$('#rq_save').css('display', 'block');
			$('#rq_edit').css('display', 'none');
			$('#rq_search').css('display', 'inline');
		    $('#rq_item0').hide();
		    $('.rq_item').hide();
		    $('#add_item').show();
		    //$('#default_td').prop("visibility", "hidden");
		    $('#default_td').prop("hidden", "hidden");
		    $('#edit_td').removeAttr("hidden");
		    $('#delete_td').removeAttr("hidden");
		    
		    
		    var firstHtml = ("<td colspan='4' id='default_item' style='text-align:center; font-weight:bold; background-color:#e3e3e3; '>기존</td>");
			$('#myTable > tbody[id="preItem"]:first').append(firstHtml);
		    var secondHtml = ("<td colspan='4' id='default_item' style='text-align:center; font-weight:bold; background-color:#e3e3e3; '>추가</td>");
	    	$('#myTable > tbody[id="newItem"]:first').append(secondHtml);
		    
		    // 기존 아이템 목록 불러오기.
		var itemString = rq.split(",");
		$("#rq_save").attr("onclick", ("request_edit_save(" + itemString.length + ")"));
		
		//rq.requestItem[i].itemId+"^^"+rq.requestItem[i].itemName+"^^"+rq.requestItem[i].itemNum+"^^"+rq.requestItem[i].receivedNum+"^^"+ type;
		for(var i = 0;  i<itemString.length; i++) {
			var items = itemString[i].split("^!@#^");
			// 진짜 item의 id
			var trCnt = items[0];
			var curCnt = trCnt;
			var curID = 'tr' + curCnt;
			var curItem = curID + "item";
			var curName = curID + "name";
			var curCount = curID + "count";
			var curDiv = curID + "div";
			let needs = items[2] - items[3];

			// 기존 아이템은 curItem('tr'+id+'item'), curName('tr'+id+'name'), curCount('tr'+id+'count') 
			// 신규 아이템은 curItem('tr'+id+'newItem'), curName('tr'+id+'newName'), curCount('tr'+id+'newCount') 
			// 기존 아이템은 
			var innerHtml = "";
			innerHtml += "<tr id="+curID+" class='default_item'>";
			innerHtml += "<th class='item' style='width:17.5%'><select class='request-item' id="+curItem+" onchange='alert_select_value(this, "+curCnt+",0);'>";
			innerHtml += "<option name='STUFF' value='STUFF' selected>물품</option>";
			innerHtml += "<option name='FINANCE' value='FINANCE'>재정</option>";
			innerHtml += "<option name='SERVICE' value='SERVICE'>봉사</option>";
			innerHtml += "<option name='ETC' value='ETC'>기타</option>";
			innerHtml += "</select></th>";                  
			innerHtml += "<th style='width:27.5%'><input type='text' class='request-item-name' placeholder='이름 입력' id='"+curName+"'/></th>";
			innerHtml += "<th style='width:30%'><div id='"+curDiv+"'>";
			innerHtml += "<i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 0);'></i><input type='text' class='response-item-count' name='request' placeholder='0' value='0' id='"+curCount+"'/>";
			innerHtml += "<i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 0);'></i>";
			innerHtml += "</div></th>";
			innerHtml += "<th style='width:10%'><div class='del-btn' id="+curID+" >-</div></th>";
			innerHtml += "</tr>";
			$('#myTable > tbody[id="preItem"]:last').append(innerHtml);
			if(items[4] == "물품" || items[4] == "STUFF") {
				items[4] = "STUFF";
			} else if(items[4] == "재정"  || items[4] == "FINANCE") {
				items[4] = "FINANCE"; 
			} else if(items[4] == "봉사"  || items[4] == "SERVICE") {
				items[4] = "SERVICE";
			} else {
				items[4] = "ETC";
			}
			$("#"+curItem).val(items[4]).prop("selected", true);
			
			$("#"+curName).val(items[1]);
			$("#"+curCount).val(items[2]);
			if(items[4] == "재정" || items[4] == "FINANCE") {
			    var newHtml = "";
				newHtml += "<input type='text' class='response-item-count-big' name='request' value='0' id='"+curCount+"' onkeyup='numberWithCommas(this)'/>원";
				document.getElementById('tr'+curCnt+'div').innerHTML = newHtml;
				$("#"+curCount).val(items[2]);
			}
		}
		
		}
		// request 수정 취소하고 뒤로가기.
		function request_back() {
			$('#rq_title').prop('readonly', true);
			$("#rq_clientType").prop('disabled', true);
			$("#rq_urgentLevel").prop('disabled', true);
			
			
			$('#rq_title').css('border-style', 'none');
			$('#roadAddrPart1').css('border-style', 'none');

			$('#rq_contents').css('display', 'block');
			$('.summernote').summernote('code', '');
			$('#rq_contents_summernotes').css('display', 'none');
			$('#rq_back').css('visibility', 'hidden');
			$('#rq_save').css('display', 'none');
			$('#rq_edit').css('display', 'block');
			$('#rq_search').css('display', 'none');
		    $('#rq_item0').show();
		    $('.rq_item').show();
		    $('#add_item').hide();
		    $('.default_item').remove();
		    $('#default_item').remove();
		    $("#newItem").empty();
		    
		    $('#default_td').removeAttr("hidden");
		    $('#edit_td').prop("hidden", "hidden");
		    $('#delete_td').prop("hidden", "hidden");

		}
		
		function requestdown(ele) {
			if ($("#change-req").hasClass('dd-down') === true) {
				$("#request-info").css("display", "block");
				$("#change-req").html('<i class="fas fa-chevron-up"></i>');
				$("#change-req").removeClass('dd-down');
				$("#change-req").addClass('dd-up;');
			} else {
				$("#request-info").css("display", "none");
				$("#change-req").html('<i class="fas fa-chevron-down"></i>');
				$("#change-req").removeClass('dd-up');
				$("#change-req").addClass('dd-down');
			}
		}
		function responsedown(ele) {
			if ($("#change-res").hasClass('dd-down') === true) {
				$("#response-info").css("display", "block");
				$("#change-res").html('<i class="fas fa-chevron-up"></i>');
				$("#change-res").removeClass('dd-down');
				$("#change-res").addClass('dd-up;');
			} else {
				$("#response-info").css("display", "none");
				$("#change-res").html('<i class="fas fa-chevron-down"></i>');
				$("#change-res").removeClass('dd-up');
				$("#change-res").addClass('dd-down');
			}
		}
	</script>

</body>
</html>