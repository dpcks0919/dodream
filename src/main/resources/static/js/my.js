var raw, Lat, Lng;

function goPopup(){

	var pop = window.open("/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}

 function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){

		document.regForm.roadAddrPart1.value = roadAddrPart1;
		document.regForm.addrDetail.value = addrDetail;
		
		var geocoder = new daum.maps.services.Geocoder();
		 var x,y          = "";
	     var gap = roadAddrPart1;
	     
		 // 주소로 좌표를 검색
		 geocoder.addressSearch(gap, function(result, status) {
		  
		  // 정상적으로 검색이 완료됐으면,
		  if (status == daum.maps.services.Status.OK) {
		   
		   var coords = new daum.maps.LatLng(result[0].y, result[0].x);
		   Lng = result[0].x;
		   Lat = result[0].y;
		  }
		 }); 
}

let index = {
	
	init: function(){
	
		this.dobInputSetup();
		this.selectBirth();
		this.radiusInputSetUp();
	
		$("#btn-update").on("click", () => { 
			this.update();
		});
		$("#btn-check").on("click", () => { 
			this.passwordCheck();
		});
	},
	
		selectBirth:function(){
		$('#selectyear').change(function() {
    		$('#birthyear').val($('#selectyear').val());
    	});
    	$('#selectmonth').change(function() {
    		$('#birthmonth').val($('#selectmonth').val());
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
	
	radiusInputSetUp:function(){
		$('#selectradius').append("<option value='3'>3</option>");
		$('#selectradius').append("<option value='5' selected>5</option>");
		$('#selectradius').append("<option value='7'>7</option>");
		$('#selectradius').append("<option value='10'>10</option>");
		$('#selectradius').append("<option value='15'>15</option>");
		$('#notification_radius').val($('#selectradius').val());
		$('#selectradius').change(function() {
    		$('#notification_radius').val($('#selectradius').val());
    	});	
	},
		
	update:function(){
		alert("ss");
		var birthyear = $("#birthyear").val();
		var birthmonth =  $("#birthmonth").val();
	 	var birthdate =  $("#birthdate").val();	
		var birthdob = new Date(birthyear+ "/" + birthmonth + "/" + birthdate);				
		var fullAddr = $("#roadAddrPart1").val()+ " " + $("#addrDetail").val();
		
		let data = {
			loginPassword : $("#userpw").val(),
			userSex : $("#input_sex").val(),
			userDob : birthdob,
			userEmail: $("#useremail").val(),
			emailFlag: $("input[name='mail_rcv']:checked").val(),
			userPhone: $("#userphone").val(),
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
			alert(JSON.stringify(error));
		});
	},
	
	passwordCheck:function(){
		var password =  $("#password").val();
		
		$.ajax({
			type: "POST",
			data: {password: password},
			url: "/passwordCheckProc",
		}).done(function(resp){ // 응답의 결과를 받아주는 parameter
			if( resp.status ){
				raw = resp.data
				location.href = "/user/editInfo";
			}else{
				alert("비밀번호가 틀렸습니다.");
				location.href = "/user/infoCheck";	
			}	
		});
	},
	
}

index.init();