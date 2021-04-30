function openMenu() {	
    document.getElementById("Wrapper").style.marginLeft = "70%";
    document.getElementById("mySidebar").style.width = "70%";
    document.getElementById("mainNav").style.left = "70%";
    document.getElementById("page-top").style.overflow = "hidden";
    document.getElementById("nav-profile").style.color="white";
    document.getElementById("nav-logo").style.display="none";
    document.getElementById("menu-back").style.display="block";
  }

  function openProfile() {
    document.getElementById("Wrapper").style.marginLeft = "-70%";
    document.getElementById("mySidebar2").style.width = "70%";
    document.getElementById("mainNav").style.left = "-70%";
    document.getElementById("page-top").style.overflow = "hidden";
    document.getElementById("nav-burger").style.color="white";
    document.getElementById("nav-logo").style.display="none";
    document.getElementById("menu-back").style.display="block";
  }

  function closeNav() {
    document.getElementById("mySidebar").style.width = "0";
    document.getElementById("mySidebar2").style.width = "0";
    document.getElementById("Wrapper").style.marginLeft= "0";
    document.getElementById("Wrapper").style.marginRight= "0";
    document.getElementById("mainNav").style.left = "0";
    document.getElementById("mainNav").style.right = "0";
    document.getElementById("page-top").style.overflow = "visible";
    document.getElementById("nav-profile").style.color="#e95378";
    document.getElementById("nav-burger").style.color="#e95378";
    document.getElementById("nav-logo").style.display="initial";
    document.getElementById("menu-back").style.display="none";
  }

  function goDetail_request(rq) {
	$("#reply_content").val("");
    document.getElementById("modal-bg").style.display="block";
    document.getElementById("view-detail").style.display="block";
    document.getElementById("page-top").style.overflow="hidden";
    document.getElementById("menu-back").style.filter = "blur(5px)";
    document.getElementById("Wrapper").style.filter = "blur(5px)";
	
    var date = rq.dueDate;
	date = date.split(' ')[0];
    var d_date = new Date(date.valueOf());
    var d_time = d_date.getTime();
    var cur = new Date(); // 현재시간
    var c_time = cur.getTime();
	var org_name = rq.userName;
    var status = "";

	if(rq.status == 'DELETED') status = "<span style='color:red'>삭제됨</span>";
	else if(c_time > d_time || rq.status == 'CLOSED') status = "<span style='color:red'>마감</span>";
    else status = "응답 대기중";

    let regDate = rq.regDate.substring(0,10);
    let level = rq.urgentLevel;
    if(level == 1) level = "매우 긴급(3일 이내)";
    else if(level == 2) level = "긴급(14일 이내)";
    else if(level == 3) level = "보통(14일 이상)";
    
    $("#rq_title").html("<h5>" + rq.title + "</h5>");
    $("#rq_id").html(rq.id);
    $("#rq_date").html(regDate);
    $("#rq_status").html(status);
    $("#rq_addr").html(rq.requestAddress);
    $("#rq_level").html(level);
 	if( typeof(rq.user) === 'object' ) {
 	    $("#rq_user").html(rq.user.orgName);
 	}else if( typeof(rq.user) === 'string' ) {
 		$("#rq_user").html(rq.user);
 	}
    $("#rq_contents").html(rq.description);

    let items = rq.requestItem;

          //종류 한글로 바꿔주기 
  for(var i = 0; i < items.length; i++){
      if(items[i].requestType == "STUFF") items[i].requestType = "물품";		
      else if(items[i].requestType == "FINANCE") items[i].requestType = "재정";
      else if(items[i].requestType == "SERVICE") items[i].requestType = "봉사";
      else if(items[i].requestType == "ETC") items[i].requestType = "기타";
  }

    items.sort(function(a, b) {
      return a.requestType < b.requestType ? -1 : a.requestType > b.requestType ? 1 : 0;
    });

	$(".btn-res").off("click");	
	$(".btn-res").removeAttr('onclick');
	
	if( status.includes('마감')) {
		$(".btn-res").on("click", () => {
			alert("마감되었습니다.");
		});
	} else if( rq.status == 'DELETED') {
		$(".btn-res").on("click", () => {
			alert("마감되었습니다.");
		});
	} else{
		$(".btn-res").on("click", () => {
			goResponse();
	});
	}
	
    $("#btn-com").off("click");	
	$("#btn-com").on("click", () => {
		if(confirm("정말 등록하시겠습니까?") == true){
			saveReply(rq.requestItem);
	    }
	    else{
	        return ;
	    }
	});

      // 마커 여러번 클릭했을때, 중복 출력되지 않도록 이전 것 삭제조치
      for(var i = 0; i < items.length; i++) {
        let qid = "#rq_item" + i;
        let pid = "#rp_item" + i;
        if(i == 0) {
          $(qid).empty();
          $(pid).empty();
        } else {
          $(qid).remove();
          $(pid).remove();
        }
      }
  // response-item-count-big
  
    for(var i = 0; i < items.length; i++) {
      let needs = items[i].itemNum - items[i].receivedNum;
	  if(needs < 0) {
		needs = 0;
	  }
      if(i == 0) {
           if(items[i].requestType == "재정") {
              $("#rq_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td>");
              $("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td>');
          } else {
                $("#rq_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td>");
              $("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td>');				
          }
      }
      else {
        let qid = "#rq_item" + (i-1);
        let pid = "#rp_item" + (i-1);

        if(items[i].requestType === items[i-1].requestType) {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");
              $(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td></tr>');
          } else {
              $(qid).after('<tr id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
                $(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td></tr>');				
          }
        } else {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr id="rq_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");
                $(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td></tr>');				
          } else {
              $(qid).after('<tr id="rq_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
              $(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td></tr>');
          }
        }
      }
    }

	//db와 연결해서 userInterest 여부 확인해주는 부분(heart 모양 정해주기)
	$.ajax({
		type : "POST",
		url: "/checkUserInterestProc",
		data: {requestId: rq.id},
	}).done(function(resp) {
		if (resp.status == 500) {
			alert("checkUserInterestProc 에러발생");
		} else {
			if(resp.data == true){	// 관심목록에 추가되어 있다면
				$("#btn-heart").hide();
				$("#btn-heart2").show();
			}
			else{	// 관심목록에 없다면
				$("#btn-heart").show();
				$("#btn-heart2").hide();
			}
		}
	}).fail(function(error) {
		console.log(JSON.stringify(error));
	});

    $("#modal-bg").click(function() {
      for(var i = 0; i < items.length; i++) {
        let qid = "#rq_item" + i;
        let pid = "#rp_item" + i;
        if(i == 0) {
          $(qid).empty();
          $(pid).empty();
        } else {
          $(qid).remove();
          $(pid).remove();
        }
      }
    });
  }

  function rp_minus(i) {
    let pid = "#response_num" + i;
    let num = Number($(pid).val());
    if($(pid).val() > 0) $(pid).val(num -= 1);
  }
  
  function rp_plus(i, max) {
    let pid = "#response_num" + i;
    let num = Number($(pid).val());
    if($(pid).val() < max) $(pid).val(num += 1);
    else alert("최대 수량입니다.");
  }
	function openModal_manager() {
		$("#view-detail").css("display", "block");
		$("#modal-bg").css("display", "block");
		document.getElementById("page-top").style.overflow="hidden";

	}

  function closeModal() {
    document.getElementById("modal-bg").style.display="none";
    document.getElementById("view-detail").style.display="none";
    document.getElementById("view-responseForm").style.display="none";
    document.getElementById("page-top").style.overflow="visible";
    document.getElementById("menu-back").style.filter = "none";
    document.getElementById("Wrapper").style.filter = "none";
  }

  function closeModal_manager() {
    document.getElementById("modal-bg").style.display="none";
    document.getElementById("view-detail").style.display="none";
    document.getElementById("page-top").style.overflow="visible";
    document.getElementById("Wrapper").style.filter = "none";
  }

  function closeModal_request() {
    document.getElementById("modal-bg").style.display="none";
    document.getElementById("view-detail").style.display="none";
    document.getElementById("page-top").style.overflow="visible";
    document.getElementById("menu-back").style.filter = "none";
    document.getElementById("Wrapper").style.filter = "none";
  }

  function goResponse() {
	
    document.getElementById("view-responseForm").style.display="block";
    document.getElementById("view-detail").style.display="none";
    document.getElementById("page-top").style.overflow="hidden";
  }
  function goBack() {
    document.getElementById("view-detail").style.display="block";
    document.getElementById("view-responseForm").style.display="none";
  }

function heartClick() {
	if($("#btn-heart").css("display") == "none"){
		deleteUserInterest($("#rq_id").html());
		$("#btn-heart2").hide();
		$("#btn-heart").show();
	}
	else if($("#btn-heart2").css("display") == "none"){
		addUserInterest($("#rq_id").html());
		$("#btn-heart").hide();
		$("#btn-heart2").show();
	}
}

function dueDateSetUp() {	// 마감 날짜 duedate dropbox 관련 초기설정 함수
	let today = new Date()
    let year = today.getFullYear();
    let limit = year + 10;
    let month = today.getMonth() + 1;
    let day = today.getDate();
  
    for(var i = year; i <= limit; i++) {
       $("#requestDueYear").append("<option value='" + i + "'>" + i + "</option>");
    }
    for(var i = 1; i <= 12; i++) {
       $("#requestDueMonth").append("<option value='" + i + "'>" + i + "</option>");
    }
    for(var i = 1; i <= 31; i++) {
       $("#requestDueDay").append("<option value='" + i + "'>" + i + "</option>");
    }
    $('#requestDueYear').val(year).attr('selected', 'selected');
    $('#requestDueMonth').val(month).attr('selected', 'selected');
	$('#requestDueDay').val(day).attr('selected', 'selected');
	let inputYear =  $('#requestDueYear').val();
	let inputMonth =  $('#requestDueMonth').val();
	let inputDate =  $('#requestDueDay').val();
	let inputDay = new Date(inputYear + '/' + inputMonth + '/' + inputDate + " 23:59:59");
}

$('#requestDueYear').change(function() {
	let inputYear =  $('#requestDueYear').val();
	let inputMonth =  $('#requestDueMonth').val();
	let inputDate =  $('#requestDueDay').val();
	dueDateValidation(inputYear, inputMonth, inputDate);
});
$('#requestDueMonth').change(function() {
	let inputYear =  $('#requestDueYear').val();
	let inputMonth =  $('#requestDueMonth').val();
	let inputDate =  $('#requestDueDay').val();
	dueDateValidation(inputYear, inputMonth, inputDate);
});
$('#requestDueDay').change(function() {
	let inputYear =  $('#requestDueYear').val();
	let inputMonth =  $('#requestDueMonth').val();
	let inputDate =  $('#requestDueDay').val();
	dueDateValidation(inputYear, inputMonth, inputDate);
});

function dueDateValidation(inputYear, inputMonth, inputDate) {
	let today = new Date();
	let year = today.getFullYear();
    let month = today.getMonth() + 1;
    let day = today.getDate();
	let inputDay = new Date(inputYear + '/' + inputMonth + '/' + inputDate + " 23:59:59");
	let diffDay = (inputDay.getTime() - today.getTime()) / (1000 * 60 * 60 * 24);

	if(diffDay <= 1) {
	    alert("오늘 이후 날짜를 선택하세요.");
		$('#requestDueYear').val(year).attr('selected', 'selected');
	    $('#requestDueMonth').val(month).attr('selected', 'selected');
		$('#requestDueDay').val(day).attr('selected', 'selected');
	}
}

function goDetail_myrequest(rq) {
    $('.rq_item').remove();
	$('#default_item').remove();
	$("#rq_clientType").prop('disabled', true);
	$("#rq_urgentLevel").prop('disabled', true);

    $('.default_item').remove();
	request_back();
	$('#requestDueYear').prop('disabled', true);
    $('#requestDueMonth').prop('disabled', true);
	$('#requestDueDay').prop('disabled', true);
	
	document.getElementById("modal-bg").style.display="block";
	document.getElementById("view-detail").style.display="block";
	document.getElementById("page-top").style.overflow="hidden";
	document.getElementById("menu-back").style.filter = "blur(5px)";
	document.getElementById("Wrapper").style.filter = "blur(5px)";
	$("#modal-bg").click(function() {
	    document.getElementById("modal-bg").style.display="none";
	    document.getElementById("view-detail").style.display="none";
	    document.getElementById("page-top").style.overflow="visible";
	    document.getElementById("menu-back").style.filter = "none";
	    document.getElementById("Wrapper").style.filter = "none";
	});
	$("#menu-back").click(function() {
	    document.getElementById("modal-bg").style.display="none";
	    document.getElementById("view-detail").style.display="none";
	    document.getElementById("page-top").style.overflow="visible";
	    document.getElementById("menu-back").style.filter = "none";
	    document.getElementById("Wrapper").style.filter = "none";
	});
	
    var date = rq.dueDate;
    var d_date = new Date(date.valueOf());
    var d_time = d_date.getTime();
    var cur = new Date(); // 현재시간
    var c_time = cur.getTime();
	var org_name = rq.userName;
	var statusType = rq.status;
	
    var status = "";
    if(rq.status == 'DELETED') status = "삭제됨";
	else if(c_time > d_time || rq.status == 'CLOSED') status = "마감";
    else status = "응답 대기중";

	var client_type = rq.clientType;
    var level = rq.urgentLevel;

    let regDate = rq.regDate.substring(0,10);

    //if(level == 1) level = "매우 긴급(3일 이내)";
    //else if(level == 2) level = "긴급(14일 이내)";
    //else if(level == 3) level = "보통(한 달 이내)";

    //$("#rq_title").html("<h5>" + rq.title + "</h5>");
	$("#rq_title").val(rq.title);
    //$("#rq_id").html(rq.id);
	$("#rq_id").val(rq.id);
    //$("#rq_date").html(regDate);
	$("#rq_date").val(regDate);
    //$("#rq_status").html(status);
	$("#rq_status").val(status);
	$("#rq_clientType").val(client_type).prop("selected", true);
	//$("#rq_urgentLevel").val(level).prop("selected", true);
	
	$("#rq_statusType").val(statusType);
	dueDateSetUp();
	$("#requestDueYear").val(parseInt(date.substring(0,4)));
	$("#requestDueMonth").val(parseInt(date.substring(5,7)));
	$("#requestDueDay").val(parseInt(date.substring(8,10)));
	
    $("#roadAddrPart1").val(rq.requestAddress);
	$("#roadLongitude").val(rq.longitude);
	$("#roadLatitude").val(rq.latitude);
	
    $("#rq_contents").html(rq.description);
	
	// 수정하기로 변경시에 전달될 객체
	// string들을 담은 배열로 저장해서 보낸다.
	var arr = [];
	for(var i=0; i<rq.requestItem.length; i++) {
		str_arr = rq.requestItem[i].itemId+"^!@#^"+rq.requestItem[i].itemName+"^!@#^"+rq.requestItem[i].itemNum+"^!@#^"+rq.requestItem[i].receivedNum+"^!@#^"+ rq.requestItem[i].requestType;
		arr.push(str_arr);
	}

	$("#rq_edit").attr("onclick", ("request_edit('" + arr + "')"));
	
    let items = rq.requestItem;

  //종류 한글로 바꿔주기 
  for(var i = 0; i < items.length; i++){
      if(items[i].requestType == "STUFF") items[i].requestType = "물품";		
      else if(items[i].requestType == "FINANCE") items[i].requestType = "재정";
      else if(items[i].requestType == "SERVICE") items[i].requestType = "봉사";
      else if(items[i].requestType == "ETC") items[i].requestType = "기타";
  }

    items.sort(function(a, b) {
      return a.requestType < b.requestType ? -1 : a.requestType > b.requestType ? 1 : 0;
    });


    for(var i = 0; i < items.length; i++) {
      let needs = items[i].itemNum - items[i].receivedNum;
      if(i == 0) {
           if(items[i].requestType == "재정") {
             $("#rq_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원</td><td>" + items[i].itemNum + "원</td>");
             //$("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td>');
          } else {
            $("#rq_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "</td><td>" + items[i].itemNum + "</td>");
            //$("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td>');				
          }
      }
      else {
        let qid = "#rq_item" + (i-1);
        //let pid = "#rp_item" + (i-1);

        if(items[i].requestType === items[i-1].requestType) {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</b></td><td>" + items[i].receivedNum + "원</td><td>" + items[i].itemNum + "원</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td></tr>');
          } else {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</b></td><td>" + items[i].receivedNum + "</td><td>" + items[i].itemNum + "</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td></tr>');				
          }
        } else {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '" class="needs-category"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원</td><td>" + items[i].itemNum + "원</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td></tr>');				
          } else {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '" class="needs-category"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "</td><td>" + items[i].itemNum + "</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td></tr>');
          }
        }
      }
    }
	
	$.ajax({
		type : "GET",
		traditional : true,
		url : "/user/replyTable?id="+rq.id,
	}).done(function(resp) {
		if (resp.status == 500) {
			alert("에러발생");
		} else {
			$("#content-responseList").html(resp);
		}
	}).fail(function(error) {
		console.log(JSON.stringify(error));
	});

}

// 수정일 때는 myreply_edit(rp); 를 이동하도록 한다.
// content, 연락처, 소속, 등록자 명 수정가능.
// 요청아이템들에 대해서 가능하도록 만들어야 하기 때문에 밑에꺼에서 replyNum != 0일 때의 조건 없애면 됨.
// 그리고 btn-back 버튼 visibility:hidden 시키고, btn-edit hidden 추가, btn-save hidden 없애기

//myrespose 나의 응답용 JS
function goDetail_myreply(rp, _state) {
	$("#rp-back").css("visibility", "hidden");
	$("#rp-edit").removeAttr("hidden");
	$("#rp-save").prop("hidden", "hidden");
	$("#rp-close").css("display", "block");
	$("#rp_item0").empty();
	$(".other-rpitem").remove();
	$("#rp_org").prop("readonly", "true");
	$("#rp_name").prop("readonly", "true");
	$("#rp_phone").prop("readonly", "true");
	$("#rp_content").prop("readonly", "true");
	
	$("#rp_org").css("border", "1px solid white");
	$("#rp_name").css("border", "1px solid white");
	$("#rp_phone").css("border", "1px solid white");
	$("#rp_content").css("border", "1px solid white");
	
	
	if(_state != "back") {
	    document.getElementById("modal-bg").style.display="block";
	    document.getElementById("view-detail").style.display="block";
	    document.getElementById("page-top").style.overflow="hidden";
	    document.getElementById("menu-back").style.filter = "blur(5px)";
	    document.getElementById("Wrapper").style.filter = "blur(5px)";		
	}
    //var date = rp.regDate;
	//var org_name = rp.org;
    //var status = rp.status;
    //var regDate = rp.regDate;
    var address = rp.rqAddress;
    $("#rq_title").html(rp.rqTitle);
    $("#rp_id").html(rp.id);
    $("#rp_date").html(rp.regDate);

	if(rp.status == 'WAITING') {
	    $("#rp_status").html("대기중");
		$("#rp-back").prop("visibility","hidden");
		$("#rp-edit").remove("hidden");
		$("#rp-save").prop("hidden","hidden");		
	} else if(rp.status == 'APPROVED') {
		$("#rp_status").html("승인됨");
		$("#rp-back").prop("visibility","hidden");
		$("#rp-edit").prop("hidden","hidden");
		$("#rp-save").prop("hidden","hidden");
	} else	if(rp.status == 'DELETED') {
		$("#rp_status").html("삭제됨");
		$("#rp-back").prop("visibility","hidden");
		$("#rp-edit").prop("hidden","hidden");
		$("#rp-save").prop("hidden","hidden");
	}

	$("#rp_org").val(rp.org);
	$("#rp_name").val(rp.userName);
	
	if(rp.phone == ""){
		$("#rp_phone").val("-");		
	} else {
		$("#rp_phone").val(rp.phone);
	}

	$("#rp_content").val(rp.content);
	
	//요청자 회신란 넣기
	if(rp.comment != ""){// comment가 달려있으면 보여주기(아니면 안보여줌)
		$("#response-content").html(rp.comment);
		$("#response-content").show();
		$("#response-content-nothing").hide();
	} else {// comment가 달려있으면 보여주기(아니면 안보여줌)
		$("#response-content").hide();
		$("#response-content-nothing").show();
	}
	
	if(rp.status == 'DELETED') {
		$("#response-content").show();
		$("#response-content-nothing").hide();
		$("#response-content").prop("disabled", "disabled");
		$("#response-content").html("요청이 삭제된 응답 혹은 응답자에 의해 삭제된 응답입니다.\n문의 사항이 있다면 dodream.touch@gmail.com(054-262-1070)로 문의해주시면 감사하겠습니다.");
	}

	$.ajax({
		type : "GET",
		traditional : true,
		url : "/user/replyItemObj_reply?replyId="+rp.id,
	}).done(function(resp) {
		if (resp.status == 500) {
			alert("에러발생");
		} else {
			var items = new Array();
			//requestType(request) / itemName(reply) / relyNum(reply) / receivedNum(reply) / itemNum(request)
			for(var i=0; i<resp.length; i++) {
				var item2 = resp[i].split("^!@#^");
				items.push({
					requestType : item2[0],
					itemName : item2[1],
					replyNum : item2[2],
					receivedNum : item2[3],
					itemNum : item2[4]
				});
			}
			if(rp.status == 'WAITING') {
				$("#rp-back").attr("onclick", ("myreply_back(rp"+rp.id+", "+rp.id+")"));
				$("#rp-edit").attr("onclick", ("myreply_edit(rp"+rp.id+", "+rp.id+")"));
				$("#rp-save").attr("onclick", ("myreply_edit_save(rp"+rp.id+", "+rp.id+")"));
			}
		    items.sort(function(a, b) {
		      return a.requestType < b.requestType ? -1 : a.requestType > b.requestType ? 1 : 0;
		    });
			
			var count = 0;
			  for(var i = 0; i < items.length; i++) {
			      let needs = items[i].itemNum - items[i].receivedNum;
				if(items[i].replyNum != 0) {
					count++;
			      if(i == 0) {
			           if(items[i].requestType == "재정") {
			             $("#rp_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].replyNum + "</td><td>" + items[i].receivedNum + "원</td><td><b>" + items[i].itemNum + "원</b></td>");
			          } else {
			            $("#rp_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].replyNum + "</td><td>" + items[i].receivedNum + "</td><td><b>" + items[i].itemNum + "</b></td>");
			          }
			      }
			      else {
			        let pid = "#rp_item" + (i-1);
			        if(items[i].requestType === items[i-1].requestType) {
			          if(items[i].requestType == "재정") {
			              $(pid).after('<tr class="other-rpitem" id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + items[i].replyNum +"원</td><td>" + items[i].receivedNum+"원</td><td><b>"+ items[i].itemNum +'원</b></td></tr>');
			          } else {
						  $(pid).after('<tr class="other-rpitem" id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + items[i].replyNum +"</td><td>" + items[i].receivedNum+"</td><td><b>"+ items[i].itemNum +'</b></td></tr>');				
			          }
			        } else {
			          if(items[i].requestType == "재정") {
						  $(pid).after('<tr class="other-rpitem" style="border-top: 2px solid black;" id="rp_item' + i + '"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].replyNum +"원</td><td>" + items[i].receivedNum+"원</td><td><b>"+ items[i].itemNum +'원</b></td></tr>');				
			          } else {
						  $(pid).after('<tr class="other-rpitem" style="border-top: 2px solid black;" id="rp_item' + i + '"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td>" + items[i].replyNum +"</td><td>" + items[i].receivedNum+"</td><td><b>"+ items[i].itemNum +'</b></td></tr>');				
			          }
			        }
			      }
				}
		    }
		if(count == 0) {
			$("#rp_item0").html("<td Colspan='5' style='text-align:center; padding-top:1.5rem!important; '><p>현재 응답한 아이템이 없습니다.</p></td>");
		}
		
		
		}
	}).fail(function(error) {
		console.log(JSON.stringify(error));
	});
/*
    $("#modal-bg").click(function() {
      for(var i = 0; i < items.length; i++) {
        let qid = "#rq_item" + i;
        let pid = "#rp_item" + i;
        if(i == 0) {
          $(pid).empty();
        } else {
          $(pid).remove();
        }
      }
    });	
*/
}

