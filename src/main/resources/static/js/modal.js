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

	  var date = rq.duedate;
	  var d_date = new Date(date.valueOf());
	  var d_time = d_date.getTime();
      var cur = new Date(); // 현재시간
	  var c_time = cur.getTime();
      var status = "";
	  if(c_time <= d_time) status = "응답 대기중";
      else status = "응답 완료";

      let regdate = rq.regdate.substring(0,10);
	  let level = rq.level;
	  if(level == 1) level = "매우 긴급(3일 이내)";
	  else if(level == 2) level = "긴급(14일 이내)";
      else if(level == 3) level = "보통(한 달 이내)";


	  $("#rq_title").html("<h5>" + rq.title + "</h5>");
      $("#rq_id").html(rq.id);
      $("#rq_date").html(regdate);
	  $("#rq_status").html(status);
	  $("#rq_addr").html(rq.address);
	  $("#rq_level").html(level);
	  $("#rq_user").html(rq.writer);
	  $("#rq_contents").html(rq.contents);

	  let items = rq.item;
	  items.sort(function(a, b) {
	    return a.type < b.type ? -1 : a.type > b.type ? 1 : 0;
	  });
		
	  for(var i = 0; i < items.length; i++) {
		if(i == 0) {
		  $("#rq_item0").html("<td>"+ items[i].type + "</td><td>" + items[i].name + "</td><td>" + items[i].receivednum + " / " + items[i].itemnum + "</td>");
		}
		else {
		  let nid = "#rq_item" + (i-1);
		  if(items[i].type === items[i-1].type) {
			$(nid).after('<tr id="rq_item' + i + '"><td>' + items[i].type + "</td><td>" + items[i].name + "</td><td>" + items[i].receivednum + " / " + items[i].itemnum + "</td></tr>");
		  } else {
			$(nid).after('<tr id="rq_item' + i + '" class="needs-category"><td>' + items[i].type + "</td><td>" + items[i].name + "</td><td>" + items[i].receivednum + " / " + items[i].itemnum + "</td></tr>");
		  }
		}
	  }

	  $("#modal-bg").click(function() {
		for(var i = 0; i < items.length; i++) {
		  let nid = "#rq_item" + i;
		  if(i == 0) $(nid).empty();
		  else $(nid).remove();
		}
	  })
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

