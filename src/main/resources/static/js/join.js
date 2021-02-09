var Lat, Lng; 

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

var verifyCode;

let index = {
	init: function(){
		$("#btn-save").on("click", () => { 		
			this.save();
		});
		$("#btn-update").on("click", () => { 
			this.update();
		});
		$("#btn-send-text").on("click", () => { 
			this.sendText();
		});
		$("#btn-code-verify").on("click", () => { 
			this.codeVerify();
		});
		$("#btn-id-check").on("click", () => { 
			this.idCheck();		
		});

	},
		
	
	save:function(){

			var birthyear = $("#birthyear").val();
			var birthmonth =  $("#birthmonth").val();
		 	var birthdate =  $("#birthdate").val();	
			var birthdob = new Date(birthyear+ "-" + birthmonth + "-" + birthdate);
			
			var fullAddr = $("#roadAddrPart1").val()+ " " + $("#addrDetail").val();
		
		let data = {
			userType: $("#type").val(),
			loginId : $("#userid").val(),
			loginPassword : $("#userpw").val(),
			userName : $("#username").val(),
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
		};	 
						
		//ajax호출 시 default가 비동기 호출. 
		$.ajax({
			//회원가입 수행 요청.
			type: "POST",
			url: "/joinProc",
			data: JSON.stringify(data), //json으로 변경, 
			contentType: "application/json; charset = utf-8 ",  // body 데이터가 어떤 타입인지
			dataType: "json" // 요청을 서버로해서 응답이 왔을 때 기본적으로 모든 것이 문자열, (생긴게 json이라면 => javascript로 변경해줌)
		}).done(function(resp){ // 응답의 결과를 받아주는 parameter
			if(resp.status == 500){
				alert("회원가입이 실패하였습니다. ");
			}else{
				alert("회원가입이 완료되었습니다.");
				location.href = "/";
			}
		}).fail(function(error){
			alert(JSON.stringify(error));
		}); // ajax통신을 이용해서 3개의 데이터를 json으로 변겨해서 insert 요청  
	},

	/*
	update:function(){
		let data = {
			id : $("#id").val(),
			username : $("#username").val(),
			password: $("#password").val(),
			email: $("#email").val()
		};	 
		
		console.log(data);
		
		$.ajax({
			type: "PUT",
			url: "/user",
			data: JSON.stringify(data), //json으로 변경, 
			contentType: "application/json; charset = utf-8 ",  // body 데이터가 어떤 타입인지
			dataType: "json" // 요청을 서버로해서 응답이 왔을 때 기본적으로 모든 것이 문자열, (생긴게 json이라면 => javascript로 변경해줌)
		}).done(function(resp){ // 응답의 결과를 받아주는 parameter
			console.log(resp);
			alert("회원수정이 완료되었습니다.");
			location.href = "/";
		}).fail(function(error){
			alert(JSON.stringify(error));
		});
	},
	*/
	
	idCheck:function(){	// 코드 확인 함수 
		let userId;
		
		userId = $("#userid").val();
		
		$.ajax({
				url: "/idCheckProc",	// 보내기 
				data: {userId: userId},
				type: "POST",
				}).done(function(data){	// verify code를 data로 리턴
					if(!data) {
						alert("동일 아이디가 존재합니다!");
						$("#userid").val("");
					}
					else{
						alert("아이디 사용 가능"); 
						$("#userid").attr('disabled', true);
						$("#btn-id-check").off("click");
					}
				}).fail(function(){
					alert("에러 발생!");
			});
	},
		
				
	sendText:function(){	// 해당 번호로 verify 코드 보내기
		let userPhone;

		userPhone = $("#userphone").val();
		window.alert("수신번호: " + userPhone);
		
		$.ajax({
				url: "/textProc",	// 보내기 
				data: {userPhone: userPhone},
				type: "POST",
				}).done(function(data){	// verify code를 data로 리턴
					if(!data) {
						alert("발송 실패! 전화번호를 다시 확인하세요.");
					}
					else{
			    		verifyCode = data;	// assigning the rand number(verification code): 전역 변수에 할당 
						alert("할당된 확인코드: " + verifyCode);
						/* TimeOut */
						/*$("#btn-send-text").off("click");*/
					}
				}).fail(function(){
					alert("에러 발생!");
			});
	},
	
	codeVerify:function(){	// 코드 확인 함수 
		let verifyInput;
		
		verifyInput = $("#verify-input").val();
		
		if(verifyInput == verifyCode){
			$("#userphone").attr('disabled', true);	// 코드 확인 후 비활성화
			$("#verify-input").attr('disabled', true);
			$("#verify-input").val("휴대폰 인증 완료!");
			$("#btn-send-text").off("click");	// div 추가 클릭 방지
			$("#btn-code-verify").off("click");	 // div 추가 클릭 방지
		}
		else{
			$("#verify-input").val("코드 불일치!");
		}
	},
}

index.init();

