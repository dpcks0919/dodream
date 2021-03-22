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
		
				$("#title_id").html("<h4>" + String(user.id) + "</h4>");

				$("#isPwChange").change(function() {
					if($("#isPwChange").is(":checked")) {
						$("#input_upw_title").css("color", "black");
						$("#input_upw").css("border", "1px solid black");
						$("#input_upw").prop("disabled", false);
						$("#pw_change_btn").css("display", "block");
					} else {
						$("#input_upw_title").css("color", "lightgray");
						$("#input_upw").css("border", "1px solid lightgray");
						$("#input_upw").val(null);
						$("#input_upw").prop("disabled", true);
						$("#pw_change_btn").css("display", "none");
					}
				})
				
				$("#input_id").val(user.id);
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
				$("#noradius").css("display", "none");
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
				} else {
					$("#input_uradius").val("0").prop("selected", true);
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
				if(user.utype != "INDIVIDUAL" && user.utype != "SOCIAL_WORKER") {
					$("#input_uorg_phone").val($("#input_uphone").val());
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
				$("#view-detail").css("display", "block");
				$("#modal-bg").css("display", "block");
				$(".modal-content").html(resp);
				manager_viewReply(id); 			
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

//myrespose 나의 응답용 JS
function manager_viewReply(rid) {
		$.ajax({
		type : "GET",
		traditional : true,
		url : "/user/ManagerViewReply?id=" + rid
	}).done(function(resp) {
		if (resp.status == 500) {
			alert("에러 발생!");
		} else {
			var rp = resp.reply;
			console.log(rp);
			$("#rp_item0").empty();
			$(".other-rpitem").remove();

		    var address = rp.rqAddress;
		    $("#rq_title").html("등록번호 #"+rp.request.id+" : "+rp.request.title);
		    $("#rp_id").html(rp.id);
		    let regDate = rp.regDate.substring(0,10);
		    $("#rp_date").html(regDate);

			$("#rp_org").val(rp.replyOrg);
			$("#rp_name").val(rp.replyUser);
			$("#rp_status").val(rp.status).prop("selected", true);
			
			if(rp.replyPhone == ""){
				$("#rp_phone").val("");		
			} else {
				$("#rp_phone").val(rp.replyPhone);
			}
		
			$("#rp_content").val(rp.replyContent);
		
			//요청자 회신란 넣기
			if(rp.comment != ""){// comment가 달려있으면 보여주기(아니면 안보여줌)
				$("#response-content").html(rp.comment);
			} else {// comment가 달려있으면 보여주기(아니면 안보여줌)
				$("#response-content").html("");
			}
			$.ajax({
				type : "GET",
				traditional : true,
				url : "/user/replyItemObj_reply?replyId="+rid,
			}).done(function(resp) {
				if (resp.status == 500) {
					alert("에러발생");
				} else {
					var items = new Array();
					for(var i=0; i<resp.length; i++) {
						var item2 = resp[i].split("^!@#^");
						items.push({
							requestType : item2[0],
							itemName : item2[1],
							replyNum : item2[2],
							receivedNum : item2[3],
							itemNum : item2[4],
							replyItemId : item2[5] 
						});
					}
				
				    items.sort(function(a, b) {
				      return a.requestType < b.requestType ? -1 : a.requestType > b.requestType ? 1 : 0;
				    });
					
					  for(var i = 0; i < items.length; i++) {
						  // 수정하려는 응답 아이템 개수
						  var curID = 'tr' + items[i].replyItemId;
						  var rcNum = items[i].receivedNum - items[i].replyNum;
						  var rItemId = curID + "count";
						  // 응답 아이템 개수의 변동에 따른 쌓이는 수
						  var rcItemId = curID + "rccount";
						  var tItemId = curID + "tcount";
					      let needs = items[i].itemNum - items[i].receivedNum;
					      if(i == 0) {
					           if(items[i].requestType == "재정") {
					             $("#rp_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><input type='number' id='"+rItemId+"' class='response-item-big' value='"+ items[i].replyNum +"' onkeyup='checkMoney_reply(this, "+rcNum+")'/>원</td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span>원</td><td><span style='font-weight:bold;' id='"+tItemId+"'>" + items[i].itemNum + "</span>원</td>");
					          } else {
					            $("#rp_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 2, 0);'></i><input type='text' id='"+rItemId+"' class='response-item-count' value='"+ items[i].replyNum +"' readonly/><i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 2);'></i></td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span></td><td><span style='font-weight:bold;' id='"+tItemId+"'>" + items[i].itemNum + "</span></td>");
					          }
					      }
					      else {
					        let pid = "#rp_item" + (i-1);
					        if(items[i].requestType === items[i-1].requestType) {
					          if(items[i].requestType == "재정") { 
					              $(pid).after('<tr class="other-rpitem" id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td><input type='number' id='"+rItemId+"' class='response-item-big' value='"+ items[i].replyNum +"' onkeyup='checkMoney_reply(this, "+rcNum+")'/>원</td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span>원</td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span>원</td></tr>');
					          } else {
								  $(pid).after('<tr class="other-rpitem" id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td><i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 2, 0);'></i><input type='text' id='"+rItemId+"' class='response-item-count' value='"+ items[i].replyNum +"' readonly/><i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 2);'></i></td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span></td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span></td></tr>');				
					          }
					        } else {
					          if(items[i].requestType == "재정") {
								  $(pid).after('<tr class="other-rpitem" style="border-top: 2px solid black;" id="rp_item' + i + '"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><input type='number' id='"+rItemId+"' class='response-item-big' value='"+ items[i].replyNum +"' onkeyup='checkMoney_reply(this, "+rcNum+")'/>원</td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span>원</td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span>원</td></tr>');				
					          } else {
								  $(pid).after('<tr class="other-rpitem" style="border-top: 2px solid black;" id="rp_item' + i + '"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 2, 0);'></i><input type='text' id='"+rItemId+"' class='response-item-count' value='"+ items[i].replyNum +"' readonly/><i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 2);'></i></td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span></td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span></td></tr>');				
					          }
					        }
					      }
				    }
					$("#rp-save").attr("onclick", ("manager_editReply('"+ rp.id +"')"));
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
			
			
		}
	});
}

function manager_editReply(rid) {	
	console.log("rid : "+rid);
	// 관리자의 reply 수정
	$.ajax({
		type : "GET",
		traditional : true,
		url : "/user/replyItemObj_reply?replyId="+rid,
	}).done(function(resp) {
		if (resp.status == 500) {
			alert("에러발생");
		} else {
			var items = new Array();
			for(var i=0; i<resp.length; i++) {
				var item2 = resp[i].split("^!@#^");
				items.push({
					requestType : item2[0],
					itemName : item2[1],
					replyNum : item2[2],
					receivedNum : item2[3],
					itemNum : item2[4],
					replyItemId : item2[5] 
				});
			}
		
		    items.sort(function(a, b) {
		      return a.requestType < b.requestType ? -1 : a.requestType > b.requestType ? 1 : 0;
		    });
			
			  for(var i = 0; i < items.length; i++) {
				  // 수정하려는 응답 아이템 개수
				  var replyItemID = items[i].replyItemId;
				  var curID = 'tr' + items[i].replyItemId;
				  var rItemId = curID + "count";
				  // 응답 아이템 개수의 변동에 따른 쌓이는 수
				  var rcItemId = curID + "rccount";
				  var tItemId = curID + "tcount";
				  
				  var receivedNum = document.getElementById(rcItemId).innerText * 1;
				  var replyNum = document.getElementById(rItemId).value * 1;
				  var totalNum = document.getElementById(tItemId).innerText * 1;

				  $.ajax({
						type : "GET",
						traditional : true,
						url : "/user/replyItemEdit?replyItemId="+replyItemID+"&replyNum="+replyNum+"&receivedNum="+receivedNum,
					}).done(function(resp) {
						if (resp.status == 500) {
							alert("에러발생");
						} else {
							//alert("replyItem 업데이트 완료!");
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});
		    }
			  
			// reply Update 
			let data = {
				id : rid,
				replyOrg : $("#rp_org").val(),
				replyUser : $("#rp_name").val(),
				replyPhone : $("#rp_phone").val(),
				replyContent : $("#rp_content").val()
			};
			console.log(data);
			
			$.ajax({
				type : "POST",
				url : "/replyUpdateProc",
				data: JSON.stringify(data),
				contentType: "application/json; charset = utf-8 ",
				dataType: "json"
			}).done(function(resp) {
				if (resp.status == 500) {
					alert("에러발생");
				} else {
					//alert("응답 내역이 수정되었습니다.");
					$.ajax({
						type : "GET",
						traditional : true,
						url : "/user/replyUpload?id="+rid+"&status="+$("#rp_status").val()+"&message="+ $("#response-content").val(),
					}).done(function(resp) {
						if (resp.status == 500) {
							alert("에러발생");
						} else {
							//alert("등록되었습니다!");
							menuToggle(3);
							closeModal_manager();
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
		}
	}).fail(function(error) {
		console.log(JSON.stringify(error));
	});
	
			
}
// 관리자 페이지 for reply
function minusCount(_current, flag, receivedNum) {
	var str = "";
	if(flag == 0 || flag == 2) {
		str = "count";
	} else if(flag == 1) {
		str = "newCount";
	}
  var target = _current.id + str;
  var cnt = document.getElementById(target).value;
  if(cnt>receivedNum) {
    document.getElementById(target).value=cnt*1 - 1;
	if(flag == 2) {
		var rcItemId = _current.id + "rccount";
		var rNum = document.getElementById(rcItemId).innerText * 1;
		document.getElementById(rcItemId).innerText = rNum - 1; 	
	}
  }
  else {
	if(flag == 0) {
		if(receivedNum == 0) {
			alert("0이상의 수를 입력하세요.");
		} else {
			alert("응답된 항목이 존재합니다. "+ receivedNum + " 이상의 수를 입력하세요.");			
		}
	} else if(flag == 2) {
		alert("0이상의 수를 입력하세요.");		
	} 
  }
}
// 관리자 페이지 for reply
function plusCount(_current, flag) {
	var str = "";
	if(flag == 0 || flag == 2) {
		str = "count";
	} else if(flag == 1) {
		str = "newCount";
	}
  var target = _current.id + str;
  var cnt = document.getElementById(target).value;
  // document.getElementById(target).setAttribute('value', cnt+1);
  if(flag == 2) {
	var rcItemId = _current.id + "rccount";
	var tItemId = _current.id +"tcount";
	var rNum = document.getElementById(rcItemId).innerText * 1;	
	var tNum = document.getElementById(tItemId).innerText * 1;
	
	if(rNum != tNum) {
	    document.getElementById(target).value=cnt*1 + 1;
		document.getElementById(rcItemId).innerText = rNum+1; 		
	} else {
		alert("더이상 추가할 수 없습니다.");
	}
  } else {
	  document.getElementById(target).value=cnt*1 + 1;
  }
}


// 관리자 페이지 요청 관리에서 사용
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

// 관리자 페이지 for reply
function checkMoney_reply(me, rcNum) {
	// rcNum은 내가 응답한 아이템 개수를 제외한 다른 사람들이 이미 등록한 개수
	console.log(rcNum);
	var curValue = document.getElementById(me.id).value;

	var rItemId = me.id;
	var _temp = rItemId;
	var tItemId = _temp.replace("count", "") + "tcount";
	var _temp = rItemId;
	var rcItemId = _temp.replace("count", "") +"rccount";
	
	var rNum = document.getElementById(rcItemId).innerText * 1;	
	var tNum = document.getElementById(tItemId).innerText * 1;
	
	$("#"+rItemId).on("propertychange change keyup paste input", function() {
		if(curValue == "") {
			curValue = 0;
		} else {
			curValue = document.getElementById(rItemId).value;			
		}
		// 빈칸 아닐 때, 첫자리 0 방지
		if(curValue[0] == 0 && curValue != 0) {
			var curValue = curValue.replace(/(^0+)/, "");
			// 맨 앞 0뺀 수
			document.getElementById(rItemId).value = curValue; 
		} else if(curValue == 0) {
			// 0으로 갑 바꾸기.
			document.getElementById(rItemId).value = 0;
			document.getElementById(rcItemId).innerText = rcNum;
			return 0;
		}
		// 여기서 현재 값이 배정된 상태. 이제 rcItem, tItem 변경해야함. 
		// rcNum + 현재 값이 총값보다 크면 rcNum은 꽉 채워야함.
		if (rcNum*1 + curValue*1 > tNum*1) {
			alert('값이 초과되었습니다.');
			document.getElementById(rItemId).value = tNum*1 - rcNum*1; 
			document.getElementById(rcItemId).innerText = tNum;
		}
		 else {
			document.getElementById(rcItemId).innerText = rcNum*1 + document.getElementById(rItemId).value *1;		
		}
	});
}

// 관리자 페이지 for request
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


function update(){
	var idNum = $("#input_id").val();
	var isApproved;
	if($("#input_ustate_flag_y").is(":checked")) {
		isApproved = "APPROVED";
	} else {
		isApproved = "WAITING";
	}
	var utype = $("#input_utype option:selected").val();
	var uid = $("#input_uid").val();
	var uname = $("#input_uname").val();
	var uphone = $("#input_uphone").val();
	var msgflag;
	if($("#input_umsg_flag_y").is(":checked")) {
		msgflag = 1;
	} else {
		msgflag = 0;
	}
	var uemail = $("#input_uemail").val();
	var emailflag;
	if($("#input_uemail_flag_y").is(":checked")) {
		emailflag = 1;
	} else {
		emailflag = 0;
	}
	var uaddr = $("#input_uaddr").val();
	var showflag;
	if($("#input_ushow_flag_y").is(":checked")) {
		showflag = 1;
	} else {
		showflag = 0;
	}
	var uradius = Number($("#input_uradius option:selected").val());
	var birthyear = $("#dob_year").val();
	var birthmonth =  $("#dob_month").val();
 	var birthdate =  $("#dob_date").val();	
	var udob;
	if(utype != "INDIVIDUAL" && utype != "SOCIAL_WORKER") {
		udob = null;
	} else {
		udob = new Date(birthyear+ "/" + birthmonth + "/" + birthdate);
	}				
	var usex = Number($("#input_usex option:selected").val());
	var uorg = $("#input_uorg").val();
	var uorgrole = $("#input_uorg_role").val();
	var uorgphone = $("#input_uorg_phone").val();
	
	let data = {
		id: idNum,
		stateFlag: isApproved,
		userType: utype,
		loginId: uid,
		userName: uname,
		userPhone: uphone,
		msgFlag: msgflag,
		userEmail: uemail,
		emailFlag: emailflag,
		address: uaddr,
		showFlag: showflag,
		notificationRadius: uradius,
		userDob: udob,
		userSex: usex,
		orgName: uorg,
		orgUserRole: uorgrole,
		orgPhone: uorgphone,
	};	
	$.ajax({
		type: "PUT",
		url: "/updateUserProc",
		data: JSON.stringify(data), //json으로 변경, 
		contentType: "application/json; charset = utf-8 ",  // body 데이터가 어떤 타입인지
		//dataType: "json" // 요청을 서버로해서 응답이 왔을 때 기본적으로 모든 것이 문자열, (생긴게 json이라면 => javascript로 변경해줌)
	}).done(function(resp){ // 응답의 결과를 받아주는 parameter
		if(resp.status == 500){
			alert("수정에 실패하였습니다.");
		}else{
			alert("수정이 완료되었습니다.");
			location.href = "manager";
		}
	}).fail(function(error){
		console.log(JSON.stringify(error));
	});
}
<<<<<<< HEAD
=======

function pwChange(){
		var userId = $("#input_uid").val();
		var password = $("#input_upw").val();
		if(password == "") {
			alert("비밀번호를 입력하세요.");
		} else {
			$.ajax({
				//회원가입 수행 요청.
				type: "PUT",
				url: "/updateUserPwProc",
				data: {
					id: userId,
					password: password,
				}, //json으로 변경, 
			}).done(function(resp){ // 응답의 결과를 받아주는 parameter
				if(resp.status == 500){
					alert("비밀번호 변경에 실패하였습니다.");
				}else{
					alert("비밀번호가 변경되었습니다.");
					$("#isPwChange").prop("checked", false);
					$("#input_upw_title").css("color", "lightgray");
					$("#input_upw").css("border", "1px solid lightgray");
					$("#input_upw").val(null);
					$("#input_upw").prop("disabled", true);
					$("#pw_change_btn").css("display", "none");
				}
			});
		}
	}
>>>>>>> branch 'master' of https://github.com/dpcks0919/dodream.git
