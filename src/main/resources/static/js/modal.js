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

	  var date = rq.dueDate;
	  var d_date = new Date(date.valueOf());
	  var d_time = d_date.getTime();
      var cur = new Date(); // 현재시간
	  var c_time = cur.getTime();
      var status = "";
	  if(c_time <= d_time) status = "응답 대기중";
      else status = "응답 완료";

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
	  $("#rq_user").html(rq.userName);
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

	
	  for(var i = 0; i < items.length; i++) {
		let needs = items[i].itemNum - items[i].receivedNum;
		if(i == 0) {
		  $("#rq_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td>");
		  $("#rp_item0").html("<td>" + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td>');
		}
		else {
		  let qid = "#rq_item" + (i-1);
		  let pid = "#rp_item" + (i-1);

		  if(items[i].requestType === items[i-1].requestType) {
			$(qid).after('<tr id="rq_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
		  	$(pid).after('<tr id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td></tr>');
		  } else {
			$(qid).after('<tr id="rq_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + items[i].receivedNum + " / " + items[i].itemNum + "</td></tr>");
		  	$(pid).after('<tr id="rp_item' + i + '" class="needs-category"><td>' + items[i].requestType + "</td><td>" + items[i].itemName + "</td><td>" + '<div><i class="fas fa-minus minus-icon" onclick="rp_minus(' + i + ')"></i><input type="text" id="response_num' + i + '" class="response-item-count" name="response-item" value="0" readonly><i class="fas fa-plus plus-icon" onclick="rp_plus(' + i + ',' + needs + ')"></i></div></td><td>' + needs + '</td></tr>');
		  }
		}
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

	function rp_minus(i) {
	  let pid = "#response_num" + i;
      let num = Number($(pid).val());
	  if($(pid).val() > 0) $(pid).val(num -= 1);
      else alert($(pid).val());
	}
	
	function rp_plus(i, max) {
	  let pid = "#response_num" + i;
	  let num = Number($(pid).val());
      if($(pid).val() < max) $(pid).val(num += 1);
      else alert($(pid).val());
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
            
            
// 성민 request.jsp

