var Lat, Lng;

function goPopup(){
	
	var pop;
	
	if( $(window).width() < 600 ){
		pop = window.open("/jusoPopupMobile","pop","scrollbars=yes, resizable=yes"); 
	}else{
		pop = window.open("/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
}

// kakaomap.jsp include 해야 실행됨.
function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {

	$("#roadAddrPart1").val(roadAddrPart1);
	$("#addrDetail").val(addrDetail);
	
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
			$("#roadLongitude").val(Lng);
			$("#roadLatitude").val(Lat);
		}
	});

}

function deleteRequest() {
	let rid = $("#rq_id").val();
	if(confirm("해당 요청을 삭제하시겠습니까?\n해당 요청을 삭제하게 되면, 응답된 내역도 함께 삭제됩니다.")) {
		$.ajax({
		type : "GET",
		traditional : true,
		url : "/user/deleteRequest?id=" + rid
	}).done(function(resp) {
		if (resp.status == 500) {
			alert("에러 발생!");
		} else {
			alert("해당 요청이 삭제되었습니다.");
			location.reload();
		}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});
	} else {
		alert("취소하였습니다");
	}
}

function rowAdd() {
  var trCnt = $('#myTable tbody[id="newItem"] tr').length;
  var curCnt = trCnt+1;
  var curID = 'tr' + curCnt;
  var curItem = curID + "newItem";
  var curName = curID + "newName";
  var curCount = curID + "newCount";
  var curDiv = curID + "div";
  var innerHtml = "";
  innerHtml += "<tr id="+curID+" class='default_item'>";
  innerHtml += "<th class='item'><select class='request-item' id="+curItem+" onchange='alert_select_value(this, "+curCnt+",1);'>";
  innerHtml += "<option name='STUFF' value='STUFF' selected>물품</option>";
  innerHtml += "<option name='FINANCE' value='FINANCE'>재정</option>";
  innerHtml += "<option name='SERVICE' value='SERVICE'>봉사</option>";
  innerHtml += "<option name='ETC' value='ETC'>기타</option>";
  innerHtml += "</select></th>";                  
  innerHtml += "<th><input type='text' class='request-item-name' placeholder='이름 입력' id='"+curName+"'/></th>";
  innerHtml += "<th><div id='"+curDiv+"'>";
  innerHtml += "<i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 1, 0);'></i><input type='text' class='response-item-count' name='request' placeholder='0' value='0' id='"+curCount+"'/>";
  innerHtml += "<i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 1);'></i>";
  innerHtml += "</div></th>";
  innerHtml += "<th><div class='del-btn' id="+curID+" onclick='rowDelete(this, 1);'>X</div></th>";
  innerHtml += "</tr>";
  $('#myTable > tbody[id="newItem"]:first').append(innerHtml);
}

function rowDelete(current) {
  var target = document.getElementById(current.getAttribute('id')).getAttribute('id')
  $('#'+target).remove();
}

function minusCount(_current, flag, receivedNum) {
	var str = "";
	if(flag == 0 || flag == 2) {
		str = "count";
	} else if(flag == 1) {
		str = "newCount";
	}
  var target = _current.id + str;
  var cnt = document.getElementById(target).value;
  if(cnt>receivedNum) {
    document.getElementById(target).value=cnt*1 - 1;
	if(flag == 2) {
		var rcItemId = _current.id + "rccount";
		var rNum = document.getElementById(rcItemId).innerText * 1;
		document.getElementById(rcItemId).innerText = rNum - 1; 	
	}
  }
  else {
	if(flag == 0) {
		if(receivedNum == 0) {
			alert("0이상의 수를 입력하세요.");
		} else {
			alert("응답된 항목이 존재합니다. "+ receivedNum + " 이상의 수를 입력하세요.");			
		}
	} else if(flag == 2) {
		alert("0이상의 수를 입력하세요.");		
	} 
  }
}
 
function plusCount(_current, flag) {
	var str = "";
	if(flag == 0 || flag == 2) {
		str = "count";
	} else if(flag == 1) {
		str = "newCount";
	}
  var target = _current.id + str;
  var cnt = document.getElementById(target).value;
  // document.getElementById(target).setAttribute('value', cnt+1);
  if(flag == 2) {
	var rcItemId = _current.id + "rccount";
	var tItemId = _current.id +"tcount";
	var rNum = document.getElementById(rcItemId).innerText * 1;	
	var tNum = document.getElementById(tItemId).innerText * 1;
	
	if(rNum != tNum) {
	    document.getElementById(target).value=cnt*1 + 1;
		document.getElementById(rcItemId).innerText = rNum+1; 		
	} else {
		alert("더이상 추가할 수 없습니다.");
	}
  } else {
	  document.getElementById(target).value=cnt*1 + 1;
  }
}

function numberWithCommas(curObj) {
  var x = curObj.value;
  var curID = "#"+curObj.id;
  x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
  x = x.replace(/,/g,'');          // ,값 공백처리
  $(curID).val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가
}

function checkMoney(me, rcNum) {
	// rcNum은 내가 응답한 아이템 개수를 제외한 다른 사람들이 이미 등록한 개수
	var curValue = document.getElementById(me.id).value;

	var rItemId = me.id;
	var _temp = rItemId;
	var tItemId = _temp.replace("count", "") + "tcount";
	var _temp = rItemId;
	var rcItemId = _temp.replace("count", "") +"rccount";
	
	var rNum = document.getElementById(rcItemId).innerText * 1;	
	var tNum = document.getElementById(tItemId).innerText * 1;
	
	$("#"+rItemId).on("propertychange change keyup paste input", function() {
		if(curValue == "") {
			curValue = 0;
		} else {
			curValue = document.getElementById(rItemId).value;			
		}
		// 빈칸 아닐 때, 첫자리 0 방지
		if(curValue[0] == 0 && curValue != 0) {
			var curValue = curValue.replace(/(^0+)/, "");
			// 맨 앞 0뺀 수
			document.getElementById(rItemId).value = curValue; 
		} else if(curValue == 0) {
			// 0으로 갑 바꾸기.
			document.getElementById(rItemId).value = 0;
			document.getElementById(rcItemId).innerText = rcNum;
			return 0;
		}
		// 여기서 현재 값이 배정된 상태. 이제 rcItem, tItem 변경해야함. 
		// rcNum + 현재 값이 총값보다 크면 rcNum은 꽉 채워야함.
		if (rcNum*1 + curValue*1 > tNum*1) {
			alert('값이 초과되었습니다.');
			document.getElementById(rItemId).value = tNum*1 - rcNum*1; 
			document.getElementById(rcItemId).innerText = tNum;
		}
		 else {
			document.getElementById(rcItemId).innerText = rcNum*1 + document.getElementById(rItemId).value *1;		
		}
	});
}


// 도움 종류에 따라 수량 표기 변화시키는 함수
var alert_select_value = function (select_obj, curCnt, flag) {

	var str = "";
	if(flag == 0) {
		str = "count";
	} else if(flag == 1) {
		str = "newCount";
	}
  var selected_index = select_obj.selectedIndex;
  var selected_value = select_obj.options[selected_index].value;
  var curDiv = 'tr' + curCnt + "div";
  var curCount = 'tr' + curCnt +str;
  var newHtml = "";
  if(selected_value === 'FINANCE') {
    newHtml += "<input type='text' class='response-item-count-big' name='request' value='0' id='"+curCount+"' onkeyup='numberWithCommas(this)'/>원";
  }
  else {
    newHtml += "<i class='fas fa-minus minus-icon' id='"+"tr"+curCnt+"' onclick='minusCount(this, "+ flag +");'></i><input type='text' class='response-item-count' name='request' placeholder='0' value='0' id='"+curCount+"'/>";
    newHtml += "<i class='fas fa-plus plus-icon' id='"+"tr"+curCnt+"' onclick='plusCount(this, "+ flag +");'></i>";
  }
  document.getElementById(curDiv).innerHTML = newHtml;
}

function checkSpecial(str) { 
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi; 
	if(special_pattern.test(str) == true) { 
		return true; 
	} else {
		return false; 
	} 
}

let myInit = {
	
	init: function(){
	
		//this.dobInputSetup();
		this.selectBirth();
		this.radiusInputSetUp();
	
		$("#btn-update").on("click", () => { 
			this.update();
		});
		$("#btn-check").on("click", () => { 
			this.passwordCheck();
		});
		$("#btn-change").on("click", () => { 
			this.passwordChange();
		});
		$("#btn-addr-search").on("click", () => { 
			jQuery('#addrDetail').css("display", "block");
		});
	},
	
		selectBirth:function(){
		$('#selectyear').change(function() {
    		$('#birthyear').val($('#selectyear').val());
    	});
    	$('#selectmonth').change(function() {
    		$('#birthmonth').val($('#selectmonth').val());
    		let inputMonth =  $('#selectmonth').val();
			  $('#selectdate option').remove();
		      if(inputMonth == 1 || inputMonth == 3 || inputMonth == 5 || inputMonth == 7 || inputMonth == 8 || inputMonth == 10 || inputMonth == 12) {
				for(var i = 1; i <= 31; i++) {
			      $("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
			    }
		      } else if(inputMonth == 4 || inputMonth == 6 || inputMonth == 9 || inputMonth == 11) {
				for(var i = 1; i <= 30; i++) {
			      $("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
			    }
			  } else if(inputMonth == 2) {
				for(var i = 1; i <= 29; i++) {
			      $("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
			     }
			  }
			  $('#birthdate').val($('#selectdate').val());
    	});
    	$('#selectdate').change(function() {
    		$('#birthdate').val($('#selectdate').val());
    	});
	},
	
	selectSex:function(sex){
		let $sex = sex.id;
			if($sex == "maleuser") {
			  $("#maleuser").addClass("selected");
			  $("#femaleuser").removeClass("selected");
			  $("#input_sex").val("1");	// 1: male
			} else {
			  $("#femaleuser").addClass("selected");
			  $("#maleuser").removeClass("selected");
			  $("#input_sex").val("2");	// 2: female
		}
	},
	/*	
	dobInputSetup:function(){
              let today = new Date()
              let year = today.getFullYear();
              let limit = year - 90;
              let month = today.getMonth() + 1;
              let day = today.getDate();
              
              for(var i = year; i >= limit; i--) {
                 $("#selectyear").append("<option value='" + i + "'>" + i + "</option>");
              }
              for(var i = 1; i <= 12; i++) {
                 $("#selectmonth").append("<option value='" + i + "'>" + i + "</option>");
              }
              for(var i = 1; i <= 31; i++) {
                 $("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
              }
			$('#selectmonth').val(month).attr('selected', 'selected');
			$('#selectdate').val(day).attr('selected', 'selected');
			$('#birthyear').val($('#selectyear').val());
			$('#birthmonth').val($('#selectmonth').val());
			$('#birthdate').val($('#selectdate').val());
	},
	*/
	radiusInputSetUp:function(){
		$('#selectradius').append("<option value='3'>3</option>");
		$('#selectradius').append("<option value='5'>5</option>");
		$('#selectradius').append("<option value='7'>7</option>");
		$('#selectradius').append("<option value='10'>10</option>");
		$('#selectradius').append("<option value='15'>15</option>");
		$('#notification_radius').val($('#selectradius').val());
		$('#selectradius').change(function() {
    		$('#notification_radius').val($('#selectradius').val());
    	});	
	},
		
	update:function(){
					
		var birthyear = $("#birthyear").val();
		var birthmonth =  $("#birthmonth").val();
	 	var birthdate =  $("#birthdate").val();	
		var birthdob = new Date(birthyear+ "/" + birthmonth + "/" + birthdate);				
		var fullAddr = $("#roadAddrPart1").val()+ " " + $("#addrDetail").val();
		
		// userEmail 체크
		if($("#useremail").length){
			if(!$("#useremail").val()){
				alert("이메일을 입력해주세요.");
				return false;
			}
			var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			if(!regex.test($("#useremail").val())){
				alert("이메일 형식에 맞게 작성해주세요.");
				return false;
			}
			
			if($("#useremail").val() != $("#originalEmail").val() && !myInit.emailCheck($("#useremail").val())){
				alert("중복되는 이메일이 존재합니다. 다시 한번 확인해주세요.");
				return false;
			}
		}
		var userEmail = $("#useremail").val().trim();
		
		// userPhone 체크
		if($("#userphone").length){
			if(!$("#userphone").val()){
				alert("연락처를 입력해주세요.");
				return false;
			}
			var regex = /^\d{2,3}\d{3,4}\d{4}$/;
			if(!regex.test($("#userphone").val())){
				alert("전화번호를 정확하게 입력해주세요.(하이픈(-)은 제거해주세요)");
				return false;
			}
		}	
		var userPhone = $("#userphone").val();

		// orgPhone 체크
		if($("#orgphone").length){
			if(!$("#orgphone").val()){
				alert("기관 연락처를 입력해주세요.");
				return false;
			}
			var regex = /^\d{2,3}\d{3,4}\d{4}$/;
			if(!regex.test($("#orgphone").val())){
				alert("기관 전화번호를 정확하게 입력해주세요.(하이픈(-)은 제거해주세요)");
				return false;
			}
		}	
		
		var orgPhone = $("#orgphone").val();
				
		let data = {
			loginId : $("#loginId").val(),
			userName : $("#username").val(),
			userSex : $("#input_sex").val(),
			userDob : birthdob,
			userEmail: userEmail,
			emailFlag: $("input[name='mail_rcv']:checked").val(),
			userPhone: userPhone,
			msgFlag: $("input[name='sms_rcv']:checked").val(),
			showFlag: $("input[name='show_flag']:checked").val(),
			address : fullAddr,
			orgName: $("#orgname").val(),
			orgUserRole: $("#userpos").val(),
			orgPhone: $("#orgphone").val(),
			latitude: Lat,
			longitude: Lng,
			notificationRadius: $("#notification_radius").val(),
		};	
				
		$.ajax({
			type: "PUT",
			url: "/updateProc",
			data: JSON.stringify(data), //json으로 변경, 
			contentType: "application/json; charset = utf-8 ",  // body 데이터가 어떤 타입인지
			dataType: "json" // 요청을 서버로해서 응답이 왔을 때 기본적으로 모든 것이 문자열, (생긴게 json이라면 => javascript로 변경해줌)
		}).done(function(resp){ // 응답의 결과를 받아주는 parameter
			if(resp.status == 500){
				alert("수정에 실패하였습니다.");
			}else{
				alert("수정이 완료되었습니다.");
				location.href = "/";
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});
	},
	
	passwordCheck:function(){
		var password =  $("#password").val();
		var pwchange = $('#pwchange').val();
		var infotype = $('#info_type').val();
		$.ajax({
			type: "POST",
			data: {password: password},
			url: "/passwordCheckProc",
		}).done(function(resp){ // 응답의 결과를 받아주는 parameter
			if( resp.status == 500){ 
				alert("에러가 발생하였습니다.\n다시 한번 시도해주세요!");
			}else{
				if( resp.data ){
					if(pwchange == 1) {
						location.href = "/user/pwChange";
					} else {
						location.href = "/user/editInfo/" + infotype;	
					}
				}else{
					alert("비밀번호가 틀렸습니다.");
				}	
			}
		});
	},
	
	passwordChange:function(){
		var password = "";
		var pass = $("#userpw").val();
		var passcheck = $("#userpwchk").val() ;

		if( pass == "" ){
			alert("비밀번호를 입력하여주세요.");	// 2.pw 체크
			return false;
		}else if( !checkSpecial(pass) ){
			alert("특수문자와 조합하여 사용해주세요.");
			return false;
		}else if( pass !=  passcheck ){
			alert("비밀번호가 일치하지 않습니다.");	// 2.pw 체크
			return false;
		}else{
			password = $("#userpw").val();
		}
		
		$.ajax({
			//회원가입 수행 요청.
			type: "PUT",
			url: "/updatepwProc",
			data: {password: password}, //json으로 변경, 
		}).done(function(resp){ // 응답의 결과를 받아주는 parameter
			if(resp.status == 500){
				alert("비밀번호 변경에 실패하였습니다.");
			}else{
				alert("비밀번호가 변경되었습니다.");
				location.href = "/user/mypage";
			}
		});
	},
	
	emailCheck:function(useremail){	// email 중복 체크
		var emailCheckFlag = false;
		$.ajax({
			type: "POST",
			url: "/emailCheckProc",
			data: {useremail: useremail.trim()},
			async: false,
		}).done(function(resp){ 
			if(resp.status == 500){
				alert("emailCheck 에러");
			}else{
				emailCheckFlag = resp.data;
			}
		}).fail(function(error){
			console.log("emailCheck에러: " + JSON.stringify(error));
		}); 
		return emailCheckFlag;
	},
	
	
}

myInit.init();