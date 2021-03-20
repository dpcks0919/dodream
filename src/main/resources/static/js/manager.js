var Lat, Lng;

function goPopup(){

	var pop = window.open("/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}

// kakaomap.jsp include 해야 실행됨.
function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {

	$("#roadAddrPart1").val(roadAddrPart1);
	console.log("JusoCallBack");
	
	var geocoder = new daum.maps.services.Geocoder();
	var x, y = "";
	var gap = roadAddrPart1;

	// 주소로 좌표를 검색
	geocoder.addressSearch(gap, function (result, status) {
		// 정상적으로 검색이 완료됐으면,
		if (status == daum.maps.services.Status.OK) {

			var coords = new daum.maps.LatLng(result[0].y, result[0].x);
			Lng = result[0].x;
			Lat = result[0].y;
			console.log("현재 위경도 : " + Lng +", " + Lat);
			$("#roadLongitude").val(Lng);
			$("#roadLatitude").val(Lat);
		}
	});

}


// id는 user면 user id, request면 request id, reply면 reply id
// num은 user : 0, request : 1, reply : 2
function openModal_manager(id, num) {
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
				let user = id;
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
				//openModal_manager();
				$("#view-detail").css("display", "block");
				$("#modal-bg").css("display", "block");
				$(".modal-content").html(resp);		
				manager_viewRequest(id);	
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
				openModal_manager();
				$(".modal-content").html(resp);			
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


function manager_viewRequest(rid) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/ManagerViewRequest?id=" + rid
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러 발생!");
			} else {
				var req = resp.request;
				console.log(req);
				
			    //$('.rq_item').remove();
				//$('#default_item').remove();
    			//$('.default_item').remove();
	
			    var date = req.dueDate;
			    var d_date = new Date(date.valueOf());
			    var d_time = d_date.getTime();
			    var cur = new Date(); // 현재시간
				
			    var c_time = cur.getTime();
				var org_name = req.userName;
			    var status = "";
			    if(c_time <= d_time) status = "응답 대기중";
			    else status = "마감";
			
				var client_type = req.clientType;
			    var level = req.urgentLevel;
			
			    let regDate = req.regDate.substring(0,10);
			    //var firstHtml = ("<td colspan='4' id='default_item' style='text-align:center; font-weight:bold; background-color:#e3e3e3; '>기존</td>");
				//$('#myTable > tbody[id="preItem"]:first').append(firstHtml);
			    var secondHtml = ("<td colspan='5' id='default_item' style='text-align:center; font-weight:bold; background-color:#e3e3e3; '>추가</td>");
		    	$('#myTable > tbody[id="newItem"]:first').append(secondHtml);
				$("#rq_title").val(req.title);
			    //$("#rq_id").html(rq.id);
				$("#rq_id").val(req.id);
			    //$("#rq_date").html(regDate);
				$("#rq_date").val(regDate);
			    $("#rq_userName").val(req.user.userName);
				$("#rq_status").val(req.status).prop("selected", true);
				$("#rq_clientType").val(client_type).prop("selected", true);
				$("#rq_urgentLevel").val(level).prop("selected", true);
			    $("#roadAddrPart1").val(req.requestAddress);
				$("#roadLongitude").val(req.longitude);
				$("#roadLatitude").val(req.latitude);
				$('#rq_contents_summernotes').css('display', 'block');
				$('.summernote').summernote('code', req.description);
				
			    let items = req.requestItem;

			    items.sort(function(a, b) {
			      return a.requestType < b.requestType ? -1 : a.requestType > b.requestType ? 1 : 0;
			    });

				var idArr = [];
			    for(var i = 0; i < items.length; i++) {
					idArr.push(items[i].id);
			      let needs = items[i].itemNum - items[i].receivedNum;
				  var delNumID = "delNum" + items[i].id;
				  var deltypeID = "delType" + items[i].id;
				  var delNameID = "delName" + items[i].id;
				  var selectStr = "<td class='item'><select class='request-item' id="+deltypeID+"><option name='STUFF' value='STUFF' selected>물품</option><option name='FINANCE' value='FINANCE'>재정</option><option name='SERVICE' value='SERVICE'>봉사</option><option name='ETC' value='ETC'>기타</option></select></td>" 
			      if(i == 0) {
			           if(items[i].requestType == "재정") {
			             $("#rq_item0").html(selectStr+"<td><input type='text' id='" + delNameID + "' value='" + items[i].itemName + "'/></td><td>" + items[i].receivedNum + "원</td><td><input type='number' class='response-item-count-mid' value='" + items[i].itemNum + "' id='" + delNumID + "' onkeyup='checkMoney(this)'/> 원</td><td>-</td>");
			          } else {
			            $("#rq_item0").html(selectStr+"<td><input type='text' id='" + delNameID + "' value='" + items[i].itemName + "'/></td><td>" + items[i].receivedNum + "</td><td><input type='number' class='response-item-count-mid' value='" + items[i].itemNum + "' id='" + delNumID + "' onkeyup='checkMoney(this)'/></td><td>-</td>");
			          }
			      }
			      else {
			        let qid = "#rq_item" + (i-1);
			
			        if(items[i].requestType === items[i-1].requestType) {
			          if(items[i].requestType == "재정") {
			              $(qid).after('<tr class="rq_item" id="rq_item' + i + '">' + selectStr + "<td><input type='text' id='" + delNameID + "' value='" + items[i].itemName + "'/></td><td>" + items[i].receivedNum + "원</td><td><input type='number' class='response-item-count-mid' value='" + items[i].itemNum + "' id='" + delNumID + "' onkeyup='checkMoney(this)'/>원</td><td>-</td></tr>");
			          } else {
			              $(qid).after('<tr class="rq_item" id="rq_item' + i + '">' + selectStr + "<td><input type='text' id='" + delNameID + "' value='" + items[i].itemName + "'/></td><td>" + items[i].receivedNum + "</td><td><input type='number' class='response-item-count-mid' value='" + items[i].itemNum + "' id='" + delNumID + "' onkeyup='checkMoney(this)'/></td><td>-</td></tr>");
			          }
			        } else {
			          if(items[i].requestType == "재정") {
			              $(qid).after('<tr class="rq_item" id="rq_item' + i + '" class="needs-category">' + selectStr + "<td><input type='text' id='" + delNameID + "' value='" + items[i].itemName + "'/></td><td>" + items[i].receivedNum + "원</td><td><input type='number' class='response-item-count-mid' value='" + items[i].itemNum + "' id='" + delNumID + "' onkeyup='checkMoney(this)'/>원</td><td>-</td></tr>");
			          } else {
			              $(qid).after('<tr class="rq_item" id="rq_item' + i + '" class="needs-category">' + selectStr + "<td><input type='text' id='" + delNameID + "' value='" + items[i].itemName + "'/></td><td>" + items[i].receivedNum + "</td><td><input type='number' class='response-item-count-mid' value='" + items[i].itemNum + "' id='" + delNumID + "' onkeyup='checkMoney(this)'/></td><td>-</td></tr>");
			          }
			        }
			      }
					$("#"+deltypeID).val(items[i].requestType).prop("selected", true);
			    }
				$("#rq_save").attr("onclick", ("manager_editRequest('"+ req.id +"')"));
			}
		});
}


function rowAdd() {
  var trCnt = $('#myTable tbody[id="newItem"] tr').length;
  var curCnt = trCnt+1;
  var curID = 'tr' + curCnt;
  var curItem = curID + "newItem";
  var curName = curID + "newName";
  var curCount = curID + "newCount";
  var curDiv = curID + "div";
  // alert(curItem + " "+curName + " "+curCount);
  var innerHtml = "";
  innerHtml += "<tr id="+curID+" class='default_item'>";
  innerHtml += "<th class='item'><select class='request-item' id="+curItem+">";
  innerHtml += "<option name='STUFF' value='STUFF' selected>물품</option>";
  innerHtml += "<option name='FINANCE' value='FINANCE'>재정</option>";
  innerHtml += "<option name='SERVICE' value='SERVICE'>봉사</option>";
  innerHtml += "<option name='ETC' value='ETC'>기타</option>";
  innerHtml += "</select></th>";                  
  innerHtml += "<th><input type='text' class='request-item-name' placeholder='이름 입력' id='"+curName+"'/></th><th>-</th>";
  innerHtml += "<th><div id='"+curDiv+"'>";
  innerHtml += "<input type='number' class='response-item-count-mid' name='request' placeholder='0' value='0' id='"+curCount+"' onkeyup='checkMoney(this)'/>";
  innerHtml += "</div></th>";
  innerHtml += "<th><div class='del-btn' id="+curID+" onclick='rowDelete(this, 1);'>X</div></th>";
  innerHtml += "</tr>";
  $('#myTable > tbody[id="newItem"]:first').append(innerHtml);
}

function rowDelete(current) {
  var target = document.getElementById(current.getAttribute('id')).getAttribute('id')
  $('#'+target).remove();
}

function checkMoney(me) {
	var delID = me.id;
	var curValue = document.getElementById(delID).value;
	
	$("#"+delID).on("propertychange change keyup paste input", function() {
		if(curValue == "") {
			curValue = 0;
		} else {
			curValue = document.getElementById(delID).value;			
		}
		// 빈칸 아닐 때, 첫자리 0 방지
		if(curValue[0] == 0 && curValue != 0) {
			var curValue = curValue.replace(/(^0+)/, "");
			// 맨 앞 0뺀 수
			document.getElementById(delID).value = curValue; 
		} else if(curValue == 0) {
			// 0으로 갑 바꾸기.
			document.getElementById(delID).value = 0;
		}
	});
}

function manager_editRequest(rid) {
		$.ajax({
			type : "GET",
			traditional : true,
			url : "/user/ManagerViewRequest?id=" + rid
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("에러 발생!");
			} else {
				var req = resp.request;
				// 먼저 기존 아이템들에 대해 수정
				var default_item_list1 = req.requestItem;
				var default_item_id = [];
				for(var i=0; i<default_item_list1.length; i++) {
					default_item_id.push(default_item_list1[i].id);
				} 
				console.log(default_item_id);
				for(var i=0; i<default_item_id.length; i++) {
				  var delNumID = "delNum" + default_item_id[i];
				  var deltypeID = "delType" + default_item_id[i];
				  var delNameID = "delName" + default_item_id[i];
					var _requestItem = {
						id : default_item_id[i],
						itemName : document.getElementById(delNameID).value,
						itemNum : parseInt(document.getElementById(delNumID).value),
						requestType : document.getElementById(deltypeID).value
					}
					$.ajax({
						type:"POST",
						url: "/requestItemUpdateProc",
						data: JSON.stringify(_requestItem),
						contentType: "application/json; charset = utf-8 ",
						dataType: "json"
					}).done(function(resp1) {
						if(resp.status == 500) {
							alert("업로드 실패");
						} else {
							//alert("기존 아이템 업데이트 되었습니다!");
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});			
				}
				
				// 새로운 아이템들에 대해 추가
		      var newItems = $('#myTable tbody[id="newItem"] tr').length;
			  var tr2 = $('#myTable tbody[id="newItem"] tr');
			  for(var i=0; i<newItems; i++) {
				 	var me = tr2.eq(i).attr('id'); 
					var id = me.substr(2, me.length); 
					var curCnt = id;
					var curID = 'tr' + curCnt;
				  	var rqID = parseInt($("#rq_id").val());
					var newItem = $("#"+curID + "newItem").val();
					var newName = $("#"+curID + "newName").val();
					var newCount = $("#"+curID + "newCount").val();
					newCount = parseInt(newCount.replace(",",""));
					let data2 = {
					// request id를 받아와서, requestItem.request에 입력해야하기때문에 임시로 ReceivedNum에 값을 입력받아와서
					// setRequest를 설정하고, ReceivedNum은 다시 0으로 초기화시켜주었다.
						receivedNum : rqID,
						itemNum : newCount,
						itemName : newName,
						requestType : newItem.toUpperCase()
					};
					console.log(data2);
					$.ajax({
						type : "POST",
						url : "/requestItemSaveProc_myrequest",
						data: JSON.stringify(data2),
						contentType: "application/json; charset = utf-8 ",
						dataType: "json"
					}).done(function(resp2) {
						if (resp.status == 500) {
							alert("에러발생");
						} else {
							//alert("새로운 아이템이 추가되었습니다!");
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});
			  }

				// 요청에 대해 수정
			  	var rqID = $("#rq_id").val();
				var rqTitle = $("#rq_title").val();
				var rqAddress = $("#roadAddrPart1").val();
				var rqContents = $('.summernote').summernote('code');
				// 위도 경도가 잘 안잡힘. 
				var rqLong = $("#roadLongitude").val();
				var rqLat = $("#roadLatitude").val();

				var client_type = $("#rq_clientType").val();
				var urgent_level = $("#rq_urgentLevel").val();
				var rq_status = $("#rq_status").val();
				
				let data3 = {
					id : rqID,
					title : rqTitle,
					requestAddress : rqAddress,
					longitude : rqLong,
					latitude : rqLat,
					clientType : client_type,
					urgentLevel : urgent_level,
					description : rqContents,
					status : rq_status
				};
				console.log(data3);
				
				$.ajax({
					type : "POST",
					url : "/requestUpdateProc",
					data: JSON.stringify(data3),
					contentType: "application/json; charset = utf-8 ",
					dataType: "json"
				}).done(function(resp3) {
					if (resp.status == 500) {
						alert("에러발생");
					} else {
						alert("요청 내역이 수정되었습니다.");
						menuToggle(2);
						closeModal_manager();
					}
				}).fail(function(error) {
					console.log(JSON.stringify(error));
				});
			
			}
		});

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