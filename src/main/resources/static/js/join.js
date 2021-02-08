let index = {
	init: function(){
		$("#btn-save").on("click", () => { 
			this.save();
		});
		$("#btn-update").on("click", () => { 
			this.update();
		});
		$("#btn-addr-search").on("click", () => { 
			this.addrSearch();
		});

	},
		
	
	save:function(){

			var birthyear = $("#birthyear").val();
			var birthmonth =  $("#birthmonth").val();
		 	var birthdate =  $("#birthdate").val();	
			var birthdob = new Date(birthyear+ "-" + birthmonth + "-" + birthdate);
		
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
			address : $("#useraddr").val(),
			orgName: $("#orgname").val(),
			orgUserRole: $("#userpos").val(),
			orgPhone: $("#orgphone").val(),
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
	
}

index.init();