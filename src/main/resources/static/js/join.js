
var Lat, Lng, idFlag = 0, verifyCode, smsVerifyFlag = false; 
let smsFlag = 0;

function goPopup(){
	
	var pop;
	
	if( $(window).width() < 600 ){
		pop = window.open("/jusoPopupMobile","pop","scrollbars=yes, resizable=yes"); 
	}else{
		pop = window.open("/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
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

function checkSpecial(str) { 
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi; 
	if(special_pattern.test(str) == true) { 
		return true; 
	} else {
		return false; 
	} 
}


let joinInit = {
	init: function(){
		$("#btn-code-verify").css('display', 'none');
		$("#sms_check").css('width', '100%');
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
			if (  $("#loginid").val() == '' ){
				alert("아이디를 입력하여 주세요!");
			}else if (  $("#loginpw").val() == '' ){
				alert("비밀번호를 입력하여 주세요!");
			}else{
				this.login();
			}
		});
		$("#userid").change(function(){
			idFlag = 0;
		});
		$("#btn-find-id").on("click", () => { 
			this.findId();
		});
		$("#btn-find-password").on("click", () => {
			this.findPassword();
		});
	},
	
	findId:function(){
		var email = $("#input1-find-id").val() + "@" + $("#input2-find-id").val();
		$.ajax({
			//로그인 수행 요청.
			type: "POST",
			url: "/findIdProc",
			data: {email: email}, 
		}).done(function(resp){
			if(resp.data == false){
				alert("해당하는 이메일이 없습니다.");	
			}else{
				alert("해당 이메일로 아이디를 발송드렸습니다.");
				location.href = "/";
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
		});
	},
	
	findPassword:function(){
		var id = $("#input1-find-pw").val();
		var email = $("#input2-find-pw").val() + "@"  + $("#input3-find-pw").val();
		$.ajax({
			//로그인 수행 요청.
			type: "POST",
			url: "/findPwProc",
			data: {
				id: id,
				email: email
			}, 
		}).done(function(resp){
			if(resp.data == false){
				alert("회원정보를 다시 확인해주세요.");
			}else{
				alert("해당 이메일로 변경된 비밀번호를 발송드렸습니다. 확인 후 로그인 부탁드립니다.");
				location.href = "/";
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
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
              if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
			    for(var i = 1; i <= 31; i++) {
			      $("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
			    }
			  } else if(month == 4 || month == 6 || month == 9 || month == 11) {
			    for(var i = 1; i <= 30; i++) {
			      $("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
			    }
			  } else if(month == 2) {
				for(var i = 1; i <= 29; i++) {
			      $("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
			    }
			  }
              
			$('#selectmonth').val(month).attr('selected', 'selected');
			$('#selectdate').val(day).attr('selected', 'selected');
			$('#birthyear').val($('#selectyear').val());
			$('#birthmonth').val($('#selectmonth').val());
			$('#birthdate').val($('#selectdate').val());
			
			$('#selectmonth').change(function() {
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
			});
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
		
		$.ajax({
			//로그인 수행 요청.
			type: "POST",
			url: "/loginProc",
			data: JSON.stringify(data), //json으로 변경, 
			contentType: "application/json; charset = utf-8 ",  // body 데이터가 어떤 타입인지
			dataType: "json" 
		}).done(function(resp){
			if(resp.status == 500){
				alert("로그인 실패! \n아이디, 비밀번호를 다시 확인해주세요.");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
			}else{
				alert("로그인 되었습니다.");
				location.href = "/";
			}
		}).fail(function(error){
			console.log(JSON.stringify(error));
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
			userEmail: $("#useremail").val().trim(),
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
			console.log(JSON.stringify(error));
		}); // ajax통신을 이용해서 3개의 데이터를 json으로 변겨해서 insert 요청  
	},
	
	validation:function(){	// Valditaion
		if($('#userid').length){	// 아이디
			if( idFlag == 0 ){
				alert("아이디 중복 확인 눌러주세요."); // 1.아이디 체크 여부 확인
				return false;
			}
		}
		 if($("#userpw").length){ // 패스워드
			var pass = $("#userpw").val() ;
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
			
			if(!joinInit.emailCheck($("#useremail").val())){
				alert("중복되는 이메일이 존재합니다. 다시 한번 확인해주세요.");
				return false;
			}
		}  
		if($("#userphone").length){	// 이름
			if(!$("#userphone").val()){
				alert("전화번호를 입력해주세요."); 
				return false;
			}
		}
		if($("#type").val() != "INSTITUTION" && smsVerifyFlag == false){	// userPhone
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
					}).done(function(resp){
					if(resp.status == 500){
						alert("다시 한번 확인해주세요!");
					}else{
						if(!resp.data) {
							alert("동일 아이디가 이미 존재합니다!");
						}
						else{
							alert("아이디 사용 가능"); 
							idFlag = 1;
						}
					}					
					}).fail(function(){
						alert("에러 발생!");
				});
			}
	},

	sendText:function(){	// 해당 번호로 verify 코드 보내기
		let userPhone;

		userPhone = $("#userphone").val();
		
		var regex = /^\d{2,3}\d{3,4}\d{4}$/;
		if(!regex.test( userPhone )){
			alert("하이픈(-) 없이 번호만 입력해주세요.");
			return;
		}
		
		window.alert("수신번호: " + userPhone);
		
		$.ajax({
				url: "/textProc",	// 보내기 
				data: {userPhone: userPhone},
				type: "POST",
				}).done(function(data){	// verify code를 data로 리턴
					if(!data.data) {
						alert("발송 실패! 전화번호를 다시 확인하세요.");
					}
					else{
			    		verifyCode = data.data;	// assigning the rand number(verification code): 전역 변수에 할당 
						alert("할당된 확인코드: " + verifyCode);
						/* TimeOut */
						let count = 120;
						let min = 0;
						let second = 0;
						let counter = setInterval(timer, 1000);
						$("#userphone").attr('disabled', true);
						$("#btn-send-text").css('display', 'none');
						$("#sms_confirm").css('width', '100%');
						$("#sms_check").css('width', '-=50px');
						$("#btn-code-verify").css('display', 'block');
						
						function timer() {
							count--;
							min = parseInt(count / 60);
							second = count % 60;
							if(count <= 0) {			
								if(smsFlag == 1) {
									return;
								}	
								clearInterval(counter);
								$('#smstimer').html('<em>인증 시간 초과</em>');
								$("#sms_confirm").css('width', '-=50px');
								$("#btn-send-text").css('display', 'block');
								$("#btn-code-verify").css('display', 'none');
								$("#sms_check").css('width', '100%');
								$("#userphone").attr('disabled', false);
								return;
							}
							let text = "";
							if(min > 0) {
								text = "<em>남은시간: " + min + "분 " + second + "초</em>"
							} else {
								text = "<em>남은시간: " + second + "초</em>";
							}
							$('#smstimer').html(text);
						}
					}
				}).fail(function(){
					alert("에러 발생!");
			});
	},
	
	codeVerify:function(){	// 코드 확인 함수 
		let verifyInput;
		
		verifyInput = $("#verify-input").val();
		
		if(verifyInput == verifyCode){
			smsFlag = 1;
			$("#sms_check").css('width', '100%');
			$("#btn-code-verify").css('display', 'none');
			$("#userphone").attr('disabled', true);	// 코드 확인 후 비활성화
			$("#verify-input").attr('disabled', true);
			$("#verify-input").val("휴대폰 인증 완료!");
			$("#btn-send-text").off("click");	// div 추가 클릭 방지
			$("#btn-code-verify").off("click");	 // div 추가 클릭 방지
			$('#smstimer').css('display', 'none');
			smsVerifyFlag = true;
			alert("휴대폰 인증 성공!");
		}
		else{
			alert("인증 번호가 맞지 않습니다!");
		}
	},
}

joinInit.init();


let privacy =  {
	init: function(){
		$("input:radio[name=privacy]").click(function(){
			if($("#agree").prop("disabled") == false) {
				$('input[name="privacy"]').each(function() {
					var checked = $(this).prop('checked');
					if(checked) {
						$(this).css("background-color", "black");
					} else {
						$(this).css("background-color", "white");
					}
				});
				if($("input:radio[name=privacy]:checked").val()=='agree'){
					$("#privacy_submit").css("color", "#e95378");
					$("#privacy_submit").css("border", "1px solid #e95378");
					if($("#input-page").val() == 1) {
						document.getElementById("privacy_submit").setAttribute("onClick", "document.location.href='/joinFormMain'");
					} else if($("#input-page").val() == 2) {
						document.getElementById("privacy_submit").setAttribute("onClick", "document.location.href='/oauth2/authorization/kakao'");						
					} else if($("#input-page").val() == 3) {
						document.getElementById("privacy_submit").setAttribute("onClick", "document.location.href='/oauth2/authorization/naver'");
					} else if($("#input-page").val() == 4) {
						document.getElementById("privacy_submit").setAttribute("onClick", "document.location.href='/oauth2/authorization/google'");
					}
				} else {
					$("#privacy_submit").css("color", "#e3e3e3");
					$("#privacy_submit").css("border", "1px solid #e3e3e3");
					document.getElementById("privacy_submit").setAttribute("onClick", "alert('약관 동의 후 이용 가능합니다.')");
				}
			}
		});


		
		$("#privacy_scroll").scroll(function(){
			var scrollTop = $(this).scrollTop();
			//var scrollHeight = $(this).prop('scrollHeight');
			
			
			//if (scrollTop + 350 > scrollHeight) {  -> 스크롤 다 내려야 하는 경우
			if (scrollTop > 0) {
				$("#agree").removeAttr("disabled");
				$("#disagree").removeAttr("disabled");
				$("#privacy-text1").css("color","black");
				$("#privacy-text2").css("color","black");
				$("#privacy_submit").attr("disabled");
				$("#agree").css("border", "1px solid black");
				$("#disagree").css("border", "1px solid black");
				$('input[name="privacy"]').each(function() {
					var checked = $(this).prop('checked');
					if(checked) {
						$(this).css("background-color", "black");
					} else {
						$(this).css("background-color", "white");
					}
				});
			}
		});
	},
	submit: function() {
		$()
	}
}



