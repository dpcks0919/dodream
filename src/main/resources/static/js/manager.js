// id는 user면 user id, request면 request id, reply면 reply id
// num은 user : 0, request : 1, reply : 2
function openModal_manager(user, num) {
	// user Detail
	if(num == 0) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerUserDetail",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				document.getElementById("Wrapper").style.filter = "blur(5px)";
				$("#view-detail").css("display", "block");
				$("#modal-bg").css("display", "block");
				$("#detail-content").html(resp);
		
				$("#input_id").html("<h4>" + String(user.id) + "</h4>");
				if(user.ustate_flag == "APPROVED") {
					$("#input_ustate_flag_y").prop("checked", true);
				} else {
					$("#input_ustate_flag_n").prop("checked", true);
				}
				if(user.utype == "INDIVIDUAL") {
					$("#input_utype").val("INDIVIDUAL").prop("selected", true);
				} else if(user.utype == "GROUP") {
					$("#input_utype").val("GROUP").prop("selected", true);
				} else if(user.utype == "SOCIAL_WORKER") {
					$("#input_utype").val("SOCIAL_WORKER").prop("selected", true);
				} else if(user.utype == "INSTITUTION") {
					$("#input_utype").val("INSTITUTION").prop("selected", true);
				} else if(user.utype == "ADMIN") {
					$("#input_utype").val("ADMIN").prop("selected", true);
				}
				$("#input_uid").val(user.uid);
				if(user.is_social == 1) {
					$("#input_uid_container").css("display", "none");
				}
				$("#input_uname").val(user.uname);
				$("#input_uphone").val(user.uphone);
				if(user.umsg_flag == 1) {
					$("#input_umsg_flag_y").prop("checked", true);
				} else {
					$("#input_umsg_flag_n").prop("checked", true);
				}
				$("#input_uemail").val(user.uemail);
				if(user.uemail_flag == 1) {
					$("#input_uemail_flag_y").prop("checked", true);
				} else {
					$("#input_uemail_flag_n").prop("checked", true);
				}
				$("#input_uaddr").val(user.uaddr);
				if(user.ushow_flag == 1) {
					$("#input_ushow_flag_y").prop("checked", true);
				} else {
					$("#input_ushow_flag_n").prop("checked", true);
				}
				if(user.utype != "GROUP") {
					$("#input_ushow_flag_container").css("display", "none");
				}
				
				if(user.uradius == 3) {
					$("#input_uradius").val("3").prop("selected", true);
				} else if(user.uradius == 5) {
					$("#input_uradius").val("5").prop("selected", true);
				} else if(user.uradius == 7) {
					$("#input_uradius").val("7").prop("selected", true);
				} else if(user.uradius == 10) {
					$("#input_uradius").val("10").prop("selected", true);
				} else if(user.uradius == 15) {
					$("#input_uradius").val("15").prop("selected", true);
				}
				if(user.utype != "INDIVIDUAL" && user.utype != "GROUP") {
					$("#input_uradius_container").css("display", "none");
				}
				
				if(user.utype == "INDIVIDUAL" || user.utype == "SOCIAL_WORKER") {
					let today = new Date()
	              	let fullYear = today.getFullYear();
	              	let limit = fullYear - 90;
					let dob = (user.udob).substring(0, 10);
					let year = dob.substring(0, 4);
					let month = dob.substring(5, 7);
					if(month.substring(0, 1) == '0') {
						month = month.substring(1);
					}
					let date = dob.substring(8, 10);           
	              	for(var i = year; i >= limit; i--) {
	                	$("#selectyear").append("<option value='" + i + "'>" + i + "</option>");
	              	}
	             	for(var i = 1; i <= 12; i++) {
	                	$("#selectmonth").append("<option value='" + i + "'>" + i + "</option>");
	              	}
	              	for(var i = 1; i <= 31; i++) {
	                	$("#selectdate").append("<option value='" + i + "'>" + i + "</option>");
	              	}
					$('#selectyear').val(year).attr('selected', 'selected');
					$('#selectmonth').val(month).attr('selected', 'selected');
					$('#selectdate').val(date).attr('selected', 'selected');			
					$('#dob_year').val($('#selectyear').val());
					$('#dob_month').val($('#selectmonth').val());
					$('#dob_date').val($('#selectdate').val());
				} else {
					$("#input_udob_container").css("display", "none");
				}
				
				if(user.utype != "INDIVIDUAL" && user.utype != "SOCIAL_WORKER") {
					$("#input_usex_container").css("display", "none");
				} else {
					if(user.usex == 1) {
						$("#input_usex").val("1").prop("selected", true);
					} else if(user.usex == 2) {
						$("#input_usex").val("2").prop("selected", true);
					}
				}
				$("#input_uorg").val(user.uorg);
				$("#input_uorg_role").val(user.uorg_role);
				if(user.utype == "INDIVIDUAL") {
					$("#role_type").text("직위 / 역할: ");
				} else if(user.utype == "SOCIAL_WORKER") {
					$("#role_type").text("복지사 자격증 번호: ");
				} else {
					$("#input_uorg_role_container").css("display", "none");
				}
				$("#input_uorg_phone").val(user.uorg_phone);
				if(user.utype != "SOCIAL_WORKER" && user.utype != "INSTITUTION") {
					$("#input_uorg_phone_container").css("display", "none");
				}
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	}
	// request Detail check
	else if(num == 1) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerRequestDetail",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#view-detail").css("display", "block");
				$("#modal-bg").css("display", "block");
				$("#detail-content").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	} 
	// reply Detail
	else if(num == 2) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerReplyDetail",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#view-detail").css("display", "block");
				$("#modal-bg").css("display", "block");
				$("#detail-content").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	}
	
}

function menuToggle(num) {
	// 회원 관리
	if(num == 1) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerUserTable",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#table-wrapper").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	} 
	// 요청 관리
	else if(num == 2) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerRequestTable",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#table-wrapper").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	} 
	// 응답 관리
	else if(num == 3) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerReplyTable",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#table-wrapper").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	}
}


function paging(page, num) {
	// 회원 관리의 페이징
	if(num == 0) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerUserTable?page=" + page
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#table-wrapper").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});
	}
	// 요청 관리의 페이징
	else if(num == 1) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerRequestTable?page=" + page
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#table-wrapper").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	}
	// 응답 관리의 페이징
	else if(num == 2) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/managerReplyTable?page=" + page
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러발생");
			} else {
				$("#table-wrapper").html(resp);			
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});	
	}

}

/*
function update(){
		
	var birthyear = $("#dob_year").val();
	var birthmonth =  $("#dob_month").val();
 	var birthdate =  $("#dob_date").val();	
	var birthdob = new Date(birthyear+ "/" + birthmonth + "/" + birthdate);				
	
	let data = {
		stateFlag: ,
		userType: ,
		loginId: ,
		userName: ,
		userPhone: ,
		msgFlag: ,
		userEmail: ,
		emailFlag: ,
		address: ,
		showFlag: ,
		notificationRadius: ,
		userDob: ,
		userSex: ,
		orgName: ,
		orgUserRole: ,
		orgPhone: ,
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
}
*/