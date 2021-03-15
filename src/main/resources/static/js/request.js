var Lat, Lng;
var prevMarker;

// user_Interest에 추가하는 함수
function addUserInterest(requestId){
	console.log(requestId);
	$.ajax({
		type: "POST",
		url: "/addUserInterestProc",
		data: {requestId: requestId},
	}).done(function(resp){
		if(resp.status == 500) {
			alert("addUserInterest 실패하였습니다. ");
		}else {		
			alert("관심목록 추가 성공");
		} 
	}).fail(function(error){
		console.log(JSON.stringify(error));
	});
}

// user_Interest 삭제하는 함수
function deleteUserInterest(requestId){
	console.log(requestId);
	$.ajax({
		type: "POST",
		url: "/deleteUserInterestProc",
		data: {requestId: requestId},
	}).done(function(resp){
		if(resp.status == 500) {
			alert("deleteUserInterest 실패하였습니다. ");
		}else {		
			alert("관심목록 삭제 성공");
		} 
	}).fail(function(error){
		console.log(JSON.stringify(error));
	});
}

// 도로명주소 검색
function goPopup(){
	var pop = window.open("/jusoPopup_request","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes");
	
	$(".map-div0").css("margin-bottom","2rem");
	$(".map-div1").css("margin-bottom","2rem");
	$(".map-div2").css("margin-bottom","1.5rem"); 
	$(".map-div3").css("margin-bottom","2rem");
}

function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {

	$("#roadAddrPart1").val(roadAddrPart1);

	var geocoder = new daum.maps.services.Geocoder();
	var x, y = "";
	var gap = roadAddrPart1;

	// 주소로 좌표를 검색
	geocoder.addressSearch(gap, function (result, status) {

		// 정상적으로 검색이 완료됐으면,
		if (status == daum.maps.services.Status.OK) {

			var coords = new daum.maps.LatLng(result[0].y, result[0].x);
			Lng = result[0].x;
			Lat = result[0].y;
			var moveLatLon = new kakao.maps.LatLng(Lat, Lng);
			// 지도 중심을 이동 시킵니다
			map.setCenter(moveLatLon);
			
			var marker = new kakao.maps.Marker({
				position: moveLatLon
			});
			
			// 처음인 경우
			if( prevMarker == null){
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
				prevMarker = marker;
			}else{
				prevMarker.setMap(null);
				marker.setMap(map);
				prevMarker = marker;
			}
		}
		$(".map_wrap").show();
	});
}

// 모달
function goRequestDetail(title, period_text, contents, totalCnt, itemList) {
  document.getElementById("modal-bg").style.display="block";
  document.getElementById("view-detail").style.display="block";
  document.getElementById("page-top").style.overflow="hidden";
  document.getElementById("menu-back").style.filter = "blur(5px)";
  document.getElementById("Wrapper").style.filter = "blur(5px)";
  document.getElementById("modal-title").innerHTML = title;
  document.getElementById("modal-contents").innerHTML = contents;
  document.getElementById("modal-period").innerHTML = period_text;
  document.getElementById("modal-reset").innerHTML = "";
  for(var i=0; i<totalCnt; i++) {
    var _item = itemList[i].requestType;
	if(_item == "STUFF") _item = "물품";
	else if(_item == "FINANCE") _item = "재정";
	else if(_item == "SERVICE") _item = "서비스";
	else if(_item == "ETC") _item = "기타";
    var _name = itemList[i].itemName;
    var _count = itemList[i].itemNum;
    if(_item == "" || _name == "" || _count == "") {
      alert('항목을 입력해주세요');
      closeModal_request();
      return 0;
    }
    var innerHtml = "";
    innerHtml += "<tr>";
    innerHtml += "<th class='item'><p style='margin:0; padding:0;'>"+_item;
    innerHtml += "</p></th>";
    innerHtml += "<th><input type='text' class='request-item-name' value='"+_name+"' style='border-style:none;' readonly/></th>";
    innerHtml += "<th><div>";
    innerHtml += "<input type='text' class='modal-response-item-count' name='request' value='"+_count+"' style='border-style:none;' readonly/>";
    innerHtml += "</div></th>";
    innerHtml += "</tr>";
    $('#modal-reset').append(innerHtml);
  }
}

function rowAdd() {
  var trCnt = $('#myTable tbody tr').length-1;
  var curCnt = trCnt+1;
  var curID = 'tr' + curCnt;
  var curItem = curID + "item";
  var curName = curID + "name";
  var curCount = curID + "count";
  var curDiv = curID + "div";
  // alert(curItem + " "+curName + " "+curCount);
  var innerHtml = "";
  innerHtml += "<tr id="+curID+">";
  innerHtml += "<th class='item'><select class='request-item' id="+curItem+" onchange='alert_select_value(this, "+curCnt+");'>";
  innerHtml += "<option name='STUFF' value='STUFF' selected>물품</option>";
  innerHtml += "<option name='FINANCE' value='FINANCE'>재정</option>";
  innerHtml += "<option name='SERVICE' value='SERVICE'>봉사</option>";
  innerHtml += "<option name='ETC' value='ETC'>기타</option>";
  innerHtml += "</select></th>";                  innerHtml += "<th><input type='text' class='request-item-name' placeholder='이름 입력' id='"+curName+"'/></th>";
  innerHtml += "<th><div id='"+curDiv+"'>";
  innerHtml += "<i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this);'></i><input type='text' class='response-item-count' name='request' placeholder='0' value='0' id='"+curCount+"'/>";
  innerHtml += "<i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this);'></i>";
  innerHtml += "</div></th>";
  innerHtml += "<th><div class='del-btn' id="+curID+" onclick='rowDelete(this);'>X</div></th>";
  innerHtml += "</tr>";
  $('#myTable > tbody:first').append(innerHtml);
}

function rowDelete(current) {
  var target = document.getElementById(current.getAttribute('id')).getAttribute('id')
  $('#'+target).remove();
}

function minusCount(_current) {
  var target = _current.id + "count";
  var cnt = document.getElementById(target).value;
  if(cnt>0) {
    document.getElementById(target).value=cnt*1 - 1;
  }
  else {
    alert("0이상의 수를 입력하세요.");
  }
}
 
function plusCount(_current) {
  var target = _current.id + "count";
  var cnt = document.getElementById(target).value;
  // document.getElementById(target).setAttribute('value', cnt+1);
  document.getElementById(target).value=cnt*1 + 1;
}

// 임시 저장 (db에 올리기)
function save() {
  // 제목
  var title = document.getElementById('requestTitle').value;
  var period = document.getElementById('requestPeriod').value;
  // 기간(텍스트)
  var period_text = period;
  if(period_text == '보통(한 달 이내)') period = 3;
  else if(period_text == '긴급(7~14일 이내)') period = 2;
  else if(period_text == '매우 긴급(3일 이내)') period = 1;
  // 내용 : 사연
  var contents = document.getElementById('requestContents').value;
  // 아이템 총 개수
  var totalCnt = $('#myTable tbody tr').length-1;
  // 세부 아이템들 itemList에 객체를 요소로 가지는 배열로 저장될거고, db에 올릴 때 itemList 사용하면 됨.
  if(totalCnt > 0) {
    var itemList = [];
    for(var i = 1; i<=totalCnt; i++) {
      var _item = 'tr'+i+'item';
      var _name = 'tr'+i+'name';
      var _count = 'tr'+i+'count';
      itemList.push({
        //item : document.getElementById(_item).value,
        //name : document.getElementById(_name).value,
        //count : document.getElementById(_count).value
        requestType : document.getElementById(_item).value,
        itemName : document.getElementById(_name).value,
        itemNum : document.getElementById(_count).value
      });
    }

    // DB에 올릴 함수 실행 (임시로 함수 만들어놓음-이름 수정하면됨)
    // saveItem();

  }
}
// 최종 제출 (db에 올리기)
function upload(step) {
  var title = document.getElementById('requestTitle').value;
  var period = document.getElementById('requestPeriod').value;
  var period_text = period;
  var contents = document.getElementById('requestContents').value;

  if(title =='') {
    alert("제목을 입력해주세요!");
    return 0;
  }
  else if(contents == '') {
    alert('내용을 입력해주세요!');
    return 0;
  }
  var totalCnt = $('#myTable tbody tr').length-1;
  // alert(totalCnt);
  if(totalCnt > 0) {
    var itemList = [];
    for(var i = 1; i<=totalCnt; i++) {
      var _item = 'tr'+i+'item';
      var _name = 'tr'+i+'name';
      var _count = 'tr'+i+'count';
      itemList.push({
        //item : document.getElementById(_item).value,
        //name : document.getElementById(_name).value,
        //count : document.getElementById(_count).value
        requestType : document.getElementById(_item).value,
        itemName : document.getElementById(_name).value,
        itemNum : document.getElementById(_count).value,
      });
    }
	// Modal 창 켜짐 
	if(step == 1) {
    	goRequestDetail(title, period_text, contents, totalCnt, itemList);
	}
	// 바로 upload
	else if(step == 2) {
    	requestInit.saveRequest(totalCnt, itemList);
	}
  }
  else {
    alert('물품을 입력해주세요');
  }


  // 갯수만큼 for문을 돌려서 배열에 저장해놓고
}

function numberWithCommas(curObj) {
  var x = curObj.value;
  var curID = "#"+curObj.id;
  x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
  x = x.replace(/,/g,'');          // ,값 공백처리
  $(curID).val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가
}

// 도움 종류에 따라 수량 표기 변화시키는 함수
var alert_select_value = function (select_obj, curCnt) {
  var selected_index = select_obj.selectedIndex;
  var selected_value = select_obj.options[selected_index].value;
  var curDiv = 'tr' + curCnt + "div";
  var curCount = 'tr' + curCnt +'count';
  var newHtml = "";
  if(selected_value === 'FINANCE') {
    newHtml += "<input type='text' class='response-item-count-big' name='request' value='0' id='"+curCount+"' onkeyup='numberWithCommas(this)'/>원";
  }
  else {
    newHtml += "<i class='fas fa-minus minus-icon' id='"+"tr"+curCnt+"' onclick='minusCount(this);'></i><input type='text' class='response-item-count' name='request' placeholder='0' value='0' id='"+curCount+"'/>";
    newHtml += "<i class='fas fa-plus plus-icon' id='"+"tr"+curCnt+"' onclick='plusCount(this);'></i>";
  }
  document.getElementById(curDiv).innerHTML = newHtml;
}

function bringInfo(type, userName, userPhone, orgName) {
	if(type == "myInfo") {
		$("#myInfo").removeClass("click_event");
		$("#newInfo").addClass("click_event");
		
		$(".info-name").val(userName);
		$(".info-phone").val(userPhone);
		$(".info-group").val(orgName);
	}
	else if(type == "newInfo" && $("#newInfo").hasClass("click_event")) {
		$("#newInfo").removeClass("click_event");
		$("#myInfo").addClass("click_event");
		
		$(".info-text").val('');
		$(".response-info-content").val('');
	}
}

var polyline=new daum.maps.Polyline();
// 두 좌표 사이의 거리를 구하는 함수
function getDistance(firstLongi, firstLati, secondLongi, secondLati){
	var path = [
		new kakao.maps.LatLng(firstLati, firstLongi),
		new kakao.maps.LatLng(secondLati, secondLongi)
	];
	polyline.setPath(path);
	
	return polyline.getLength();
}

function saveReply(items) {
    	
		let requestId = {
			id: $("#rq_id").text(),
		};

		let reply = {
			replyContent: $("#reply_content").val(),
			replyUser: $("#reply_user").val(),
			replyOrg: $("#reply_org").val(),
			replyPhone: $("#reply_phone").val(),
			request: requestId
		};
	
		for(var i=0; i<items.length; i++) {
			var rid = "#response_num" + i;
			var reply_num = parseInt($(rid).val());
			items[i].replyNum = reply_num;
		}
					
		var allData = {
			reply : reply,
			replyItems: items,
		}
	
		$.ajax({
			type: "POST",
			url: "/replySaveProc",
			data: JSON.stringify(allData),
			contentType: "application/json; charset = utf-8 ",
			dataType: "json"
		}).done(function(resp){
			if(resp.status == 500) {
				alert("아이템 업로드 실패하였습니다. ");
			}else{
				if(resp.data != null){
					alert("누군가 중간에 아이템 넣음");
					closeModal();
					paging(curPage);
					goDetail_request(resp.data);
				}else{
					//콜백
					notifySocialWorkerByEmail(reply);
					alert("업로드되었습니다.\n응답하신 내용은 [마이페이지]에서 확인하실 수 있습니다.");
					$(".request-table").empty();
					paging(curPage);
					closeModal();
					location.reload();
				}
			}		
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});		
	};
	
	//(기부자가) 요청보기 모달창에서 '완료하기' 버튼 누를때 해당 사회복지사에게 email 알림 보내기
	function notifySocialWorkerByEmail(reply){
		alert("사회복지사에게 이메일 전송");
		$.ajax({
			type: "POST",
			url: "/notifySocialWorkerByEmailProc",
			data: JSON.stringify(reply),
			contentType: "application/json; charset = utf-8 ",
			dataType: "json"
		}).done(function(resp){ 
			if(resp.status == 500) {
				alert("notifySocialWorkerByEmail 실패하였습니다. ");
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});
	};

let requestInit = {

	// 범위 안의 유저들에게 문자, 이메일을 보내는 함수
	notifyUser: function(requestLat, requestLng, request){		
		$.ajax({
			type: "POST",
			url: "/getValidUserListProc",
		}).done(function(resp){
			if(resp.status == 500) {
				alert("getValidUserListProc 문제 발생!");
			}
			else{
				// 1. validUserList 받기
				var validUserList = resp.data;	
				var notifyTextUserList = [];	// notify text할 유저들 리스트
				var notifyEmailUserList = [];	// notify email할 유저들 리스트
				
				// 2. for문 돌면서 user의 notification_radius 안에 있는지 확인
				validUserList.forEach(function(list, index) { 
					if(list.notificationRadius >= getDistance(list.latitude, list.longitude, requestLat, requestLng) / 1000){
						// 2-1. emailFlag == 1 이면 emailList에 넣음 
						if(list.emailFlag == 1) {
							notifyEmailUserList.push(list);
						}
						
						// 2-2. msgFlag == 1 이면 msgList에 넣음 
						if(list.msgFlag == 1){
							notifyTextUserList.push(list);
						}
					}
				});				
				// 3. 각각 msg, email 보내기
				requestInit.notifyByEmail(notifyEmailUserList, request);
				requestInit.notifyByText(notifyTextUserList, request);
				//끝나면 화면 전환
				location.href = "/user/requestMap";
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});		
	},
	
	notifyByEmail: function(userList, request){
		alert("이메일 전송");
		$.ajax({
			type: "POST",
			data: {
				stringUserList: JSON.stringify(userList),
				stringRequest: JSON.stringify(request)
			},
			dataType : 'json',
			traditional: true,
			url: "/notifyByEmailProc",
		}).done(function(resp){
			if(resp.status == 500) {
				alert("notifyByEmailProc 문제 발생!");
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});			
	},
	
	notifyByText: function(userList, request){	
		alert("문자 전송");
		$.ajax({
			type: "POST",
			data: {
				stringUserList: JSON.stringify(userList),
				stringRequest: JSON.stringify(request)
			},
			dataType : 'json',
			traditional: true,
			url: "/notifyByTextProc",
		}).done(function(resp){
			if(resp.status == 500) {
				alert("notifyByTextProc 문제 발생!");
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});			
	},
	
	saveRequest:function(totalCnt, itemList) {
		  var period = document.getElementById('requestPeriod').value;
		  var period_text = period;
		  if(period_text == '보통(한 달 이내)') period = 3;
		  else if(period_text == '긴급(7~14일 이내)') period = 2;
		  else if(period_text == '매우 긴급(3일 이내)') period = 1;
		  var contents = document.getElementById('requestContents').value;
		 
		  var type = document.getElementById('requestType').value; 
		  var type_text = type;
		  if(type_text == '노인') type = "ELDERLY";
		  else if(type_text == '아이') type = "CHILD";
		  else if(type_text == '장애인') type = "DISABLED";
		  else if(type_text == '기타') type = "OTHERS";

		//주소 입력했는지 체크
		if(document.getElementById('roadAddrPart1').value == "") alert("주소를 검색해주세요.");
		else{
			let data = {
				title: document.getElementById('requestTitle').value,
				clientType: type,
				requestAddress : document.getElementById('roadAddrPart1').value,
				latitude : Lat,
				longitude : Lng,
				urgentLevel : period,
				description : document.getElementById('requestContents').value,
				status : "NON_APPROVED",			
				showFlag : 1
			};
			
			console.log(data);
			$.ajax({
				type: "POST",
				url: "/requestSaveProc",
				data: JSON.stringify(data),
				contentType: "application/json; charset = utf-8 ",
				dataType: "json"
			}).done(function(resp){
				console.log(data);
				console.log(resp);
				if(resp.status == 500) {
					alert("업로드 실패하였습니다. ");
				}else {
					alert("업로드되었습니다.\n요청하신 내용은 [마이페이지]에서 확인하실 수 있습니다.");
					
					for(var i=0; i<itemList.length; i++) {
						requestInit.saveRequestItem(itemList[i], resp.data);
					}
					closeModal_request();
					// 해당 request 정보 user에게 notify하기 (JS 미리 실행 방지용)

					requestInit.notifyUser(Lat, Lng, data);
				} 
			}).fail(function(error){
				console.log(JSON.stringify(error));
			});
			// input값 초기화하기.
		}
	},
	
	saveRequestItem:function(item, newRequest) {
		var temp_itemNum = item.itemNum;
		item.itemNum.replace(',','');
		item.itemNum = parseInt(temp_itemNum.replace(',',''));
		
		// 어떠한 request인지 object type으로 assign
		item.request = newRequest;
		$.ajax({
			type: "POST",
			url: "/requestItemSaveProc",
			data: JSON.stringify(item),
			contentType: "application/json; charset = utf-8 ",
			dataType: "json"
		}).done(function(resp){
			if(resp.status == 500) {
				alert("아이템 업로드 실패하였습니다. ");
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});		
	},
	
}
