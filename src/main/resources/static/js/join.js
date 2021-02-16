var Lat, Lng, idFlag; 

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
		this.dobInputSetup();
		this.selectBirth();
		this.radiusInputSetUp();
		
		$("#btn-save").on("click", () => { 
			if(this.validation()) this.save();
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
		$("#btn-login").on("click", () => { 
			this.login();
		});
		$("#userid").change(function(){
			idFlag = 0;
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
	
	login:function(){
		let data = {
			loginId : $("#loginid").val(),
			loginPassword : $("#loginpw").val(),
		}
		
		alert("LogInID: " + data.loginId);
		alert("LoginPW: " + data.loginPassword);
		
		$.ajax({
			//로그인 수행 요청.
			type: "POST",
			url: "/loginProc",
			data: JSON.stringify(data), //json으로 변경, 
			contentType: "application/json; charset = utf-8 ",  // body 데이터가 어떤 타입인지
			dataType: "json" 
		}).done(function(resp){
			if(resp.status == 500){
				alert("로그인 실패! 아이디, 비밀번호를 다시 확인해주세요.");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
			}else{
				alert("로그인 되었습니다.");
				location.href = "/";
			}
		}).fail(function(error){
			alert(JSON.stringify(error));
		});
		
	},
	
	save:function(){

			var birthyear = $("#birthyear").val();
			var birthmonth =  $("#birthmonth").val();
		 	var birthdate =  $("#birthdate").val();	
			var birthdob = new Date(birthyear+ "/" + birthmonth + "/" + birthdate);
						
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
			notificationRadius: $("#notification_radius").val(),
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
	
	validation:function(){	// Valditaion
		if($('#userid').length){	// 아이디 
			if( idFlag == 0 ){
				alert("아이디 중복 확인 눌러주세요."); // 1.아이디 체크 여부 확인
				return false;
			}
		}
		 if($("#userpw").length){ // 패스워드
			if($("#userpw").val() == "" || $("#userpw").val() != $("#userpwchk").val()){
				alert("비밀번호를 다시 확인해주세요.");	// 2.pw 체크
				return false;
			}
		}
		if($("#username").length){	// 이름
			if(!$("#username").val()){
				alert("이름(혹은 단체명)을 입력해주세요."); // 4. username 공백 체크 
				return false;
			}
		}
		if($("#birthyear").length){	// 이름
			if(!$("#birthyear").val() || !$("#birthmonth").val()  || !$("#birthdate").val()){ 
				alert("생년월일을 선택하세요.");// 4. dob 입력 체크 
				return false;
			}
		} 
		if($("#useremail").length){	// userEmail
			if(!$("#useremail").val()){
				alert("이메일을 입력해주세요.");
				return false;
			}
			
			// 이메일 정규식 체크
			var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			if(!regex.test($("#useremail").val())){
				alert("이메일 형식에 맞게 작성해주세요.");
				return false;
			}
		}  
		if($("#type").val() != "INSTITUTION" && !$("#userphone").attr('disabled')){	// userPhone
			alert("문자 인증을 진행해 주세요."); 
			return false;
		}
		if($("#type").val() == "INSTITUTION" && !$("#userphone").val()){	 // 기관 전화번호인 경우
			alert("기관 전화번호를 입력하세요."); 
			return false;
		}
		if(!$("#roadAddrPart1").val()){	// user addr
			alert("주소 검색을 진행해 주세요.");
			return false;
		}
		if($("#type").val() == "SOCIAL_WORKER"){	// 사회복지사의 경우
			if(!$("#orgname").val()){
				alert("소속 기관을 적어주세요!");
				return false;
			}
			
			if(!$("#orgphone").val()){
				alert("소속 기관 연락처를 적어주세요!");
				return false;
			}
		}
		
		return true;
	},
	
	idCheck:function(){	// 코드 확인 함수 
		let userId;
		
		userId = $("#userid").val();
		
		if(!userId){
			alert("아이디를 입력해주세요.");
		}
		else{
			$.ajax({
					url: "/idCheckProc",	// 보내기 
					data: {userId: userId},
					type: "POST",
					}).done(function(data){	// verify code를 data로 리턴
						if(!data) {
							alert("동일 아이디가 이미 존재합니다!");
							//$("#userid").val("");
						}
						else{
							alert("아이디 사용 가능"); 
							idFlag = 1;
							//$("#userid").attr('disabled', true);
							//$("#btn-id-check").off("click");
						}
					}).fail(function(){
						alert("에러 발생!");
				});
			}
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
			alert("휴대폰 인증 성공!");
		}
		else{
			$("#verify-input").val("코드 불일치!");
		}
	},
}

index.init();

