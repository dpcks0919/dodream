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
    document.getElementById("mainNav").style.right = "70%";
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
    document.getElementById("modal-bg").style.display="block";
    document.getElementById("view-detail").style.display="block";
    document.getElementById("page-top").style.overflow="hidden";
    document.getElementById("menu-back").style.filter = "blur(5px)";
    document.getElementById("Wrapper").style.filter = "blur(5px)";
	
	console.log(rq);
    var date = rq.dueDate;
    var d_date = new Date(date.valueOf());
    var d_time = d_date.getTime();
    var cur = new Date(); // 현재시간
    var c_time = cur.getTime();
	var org_name = rq.userName;
    var status = "";
    if(c_time <= d_time) status = "응답 대기중";
    else status = "마감";

    let regDate = rq.regDate.substring(0,10);
    let level = rq.urgentLevel;
    if(level == 1) level = "매우 긴급(3일 이내)";
    else if(level == 2) level = "긴급(14일 이내)";
    else if(level == 3) level = "보통(한 달 이내)";
    
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

    $("#btn-com").off("click");	
	$("#btn-com").on("click", () => {
		if(confirm("정말 등록하시겠습니까?") == true){
			saveReply(rq.requestItem);
			location.href = "/user/requestMap";
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
			//console.log(resp.data);
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
    //else alert($(pid).val());
  }
  
  function rp_plus(i, max) {
    let pid = "#response_num" + i;
    let num = Number($(pid).val());
    if($(pid).val() < max) $(pid).val(num += 1);
    else alert("최대 수량입니다.");
  }

  function closeModal() {
    document.getElementById("modal-bg").style.display="none";
    document.getElementById("view-detail").style.display="none";
    document.getElementById("view-responseForm").style.display="none";
    document.getElementById("page-top").style.overflow="visible";
    document.getElementById("menu-back").style.filter = "none";
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

function goDetail_myrequest(rq) {
    $('.rq_item').remove();
	$('#default_item').remove();
	$("#rq_clientType").prop('disabled', true);
	$("#rq_urgentLevel").prop('disabled', true);

    $('.default_item').remove();
	request_back();
	
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
	
	console.log("rq" + rq);
    var date = rq.dueDate;
    var d_date = new Date(date.valueOf());
    var d_time = d_date.getTime();
    var cur = new Date(); // 현재시간
    var c_time = cur.getTime();
	var org_name = rq.userName;
    var status = "";
    if(c_time <= d_time) status = "응답 대기중";
    else status = "마감";

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
	$("#rq_urgentLevel").val(level).prop("selected", true);
	
    $("#roadAddrPart1").val(rq.requestAddress);
	$("#roadLongitude").val(rq.longitude);
	$("#roadLatitude").val(rq.latitude);
	
	console.log("기존 위경도 : " + $("#roadLongitude").val() +", " + $("#roadLatitude").val());
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

    $("#btn-com").off("click");	
	$("#btn-com").on("click", () => {
		if(confirm("정말 등록하시겠습니까 ?") == true){
			saveReply(rq.requestItem);
	    }
	    else{
	        return ;
	    }
	});

    for(var i = 0; i < items.length; i++) {
      let needs = items[i].itemNum - items[i].receivedNum;
      if(i == 0) {
           if(items[i].requestType == "재정") {
             $("#rq_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td>");
             //$("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td>');
          } else {
            $("#rq_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td>");
            //$("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td>');				
          }
      }
      else {
        let qid = "#rq_item" + (i-1);
        //let pid = "#rp_item" + (i-1);

        if(items[i].requestType === items[i-1].requestType) {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td></tr>');
          } else {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td></tr>');				
          }
        } else {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + needs + "원" + '</td></tr>');				
          } else {
              $(qid).after('<tr class="rq_item" id="rq_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
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


//myrespose 나의 응답용 JS
function goDetail_myResponse(rq, rp) {
    document.getElementById("modal-bg").style.display="block";
    document.getElementById("view-detail").style.display="block";
    document.getElementById("page-top").style.overflow="hidden";
    document.getElementById("menu-back").style.filter = "blur(5px)";
    document.getElementById("Wrapper").style.filter = "blur(5px)";
	
    var date = rq.dueDate;
    var d_date = new Date(date.valueOf());
    var d_time = d_date.getTime();
    var cur = new Date(); // 현재시간
    var c_time = cur.getTime();
	var org_name = rq.userName;
    var status = "";
    if(c_time <= d_time) status = "응답 대기중";
    else status = "마감";

    let regDate = rq.regDate.substring(0,10);
    let level = rq.urgentLevel;
    if(level == 1) level = "매우 긴급(3일 이내)";
    else if(level == 2) level = "긴급(14일 이내)";
    else if(level == 3) level = "보통(한 달 이내)";
    
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
	let replyItems = rp.replyItem;

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

    $("#btn-com").off("click");	
	$("#btn-com").on("click", () => {
		if(confirm("정말 수정하시겠습니까?") == true){
			    
				location.href = "/user/requestMap";
			
	    }
	    else{
	        return ;
	    }
	});
	
		console.log(items);
		console.log(replyItems);

  
    for(var i = 0; i < items.length; i++) {
      let needs = items[i].itemNum - items[i].receivedNum;
      if(i == 0) {
           if(items[i].requestType == "재정") {
              $("#rq_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + replyItems[i].replyNum + " 원/" + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td>");
              //$("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td>");
          } else {
		        $("#rq_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + replyItems[i].replyNum + " / " +  items[i].receivedNum + " / " + items[i].itemNum + "</td>");
		      	//$("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + items[i].receivedNum + " / " + items[i].itemNum + "</td>");				
          }
      }
      else {
        let qid = "#rq_item" + (i-1);
        let pid = "#rp_item" + (i-1);

        if(items[i].requestType === items[i-1].requestType) {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + replyItems[i].replyNum + " 원/ " + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");
          } else {
              $(qid).after('<tr id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>"  + replyItems[i].replyNum + " / " +  items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
                //$(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");				
          }
        } else {
          if(items[i].requestType == "재정") {
              $(qid).after('<tr id="rq_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" +  items[i].itemName + "</td><td>" + replyItems[i].replyNum + "원 / " + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");
                //$(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><input type="text" id="response_num' + i + '" class="response-item-count-big" name="response-item" value="0"/> 원</div></td><td>' + items[i].receivedNum + "원 / " + items[i].itemNum + "원</td></tr>");				
          } else {
              $(qid).after('<tr id="rq_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + replyItems[i].replyNum + " / " + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
              //$(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly /><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
          }
        }
      }
    }

	//요청자 회신란 넣기
	if(rp.comment != ""){// comment가 달려있으면 보여주기(아니면 안보여줌)
		$("#response-wrapper").show()
		$("#response-content").html(rp.comment);
	}

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

