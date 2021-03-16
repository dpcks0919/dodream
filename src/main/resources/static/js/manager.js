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