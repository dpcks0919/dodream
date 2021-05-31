<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>​
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../layout/header.jsp"%>

<link href="/css/mypage.css" rel="stylesheet" />
<link href="/css/modal-info.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<style>
</style>

<body id="page-top">
	<div class="modal-bg" id="modal-bg" onclick="closeModal();"></div>

	<!-- 요청 항목 세부정보 보기 -->
	<div class="modal-container" id="view-detail">
		<div class="modal-content">
			<div class="" style="display:flex; justify-content:space-between;">
				<h5>나의 응답 확인</h5>
				<span id="rq_title" style="font-size:0.75rem;"></span>
			</div>
			<div class="content-info">
				<div class="div-table" style="border-top:2px solid black; padding-top:1rem!important; padding-bottom:1rem;">
					<div class="div-table-wrapper">
						<div class="div-table-left">
							<div class="div-table-title"><b>등록번호</b></div><span class="input-span" id="rp_id"></span>
						</div>
						<div class="div-table-right">
							<div class="div-table-title"><b>등록날짜</b></div><span class="input-span" id="rp_date"></span>
						</div>
					</div>
					<div class="div-table-wrapper">
						<div class="div-table-left">
							<div class="div-table-title"><b>상태<span style="visibility:hidden;">상태</span></b></div><span class="input-span" id="rp_status"></span>
						</div>
						<div class="div-table-right">
							<div class="div-table-title"><b>소속<span style="visibility:hidden;">소속</span></b></div><input id="rp_org" style="border:1px solid white;" readonly />
						</div>						
					</div>
					<div class="div-table-wrapper">
						<div class="div-table-left">
							<div class="div-table-title"><b>요청자<span style="visibility:hidden;">요</span></b></div><input id="rp_name" style="border:1px solid white;" readonly/>
						</div>
						<div class="div-table-right">
							<div class="div-table-title"><b>연락처<span style="visibility:hidden;">연</span></b></div><input id="rp_phone" style="border:1px solid white;" readonly />
						</div>						
					</div>
				</div>
			
				<div class="content-text">
					<textarea style="border:1px solid white; width:100%; resize: none; outline:none;" id="rp_content" placeholder="-" readonly></textarea>
				
				</div>
				<div class="content-needs ">
					<table class="info-table ">

					</table>
				</div>
			</div>
			
			<div class="modal-container" id="view-responseForm"></div>
			<!-- modal.js에 click event 생성 -->
			<div class=" " style="width:100%; display:flex; justify-content: space-between; margin-bottom:1rem;">
				<div class="btn-close" id="rp-close" onclick="closeModal();" style="position:relative; float:left;">창 닫기</div>
				<div class="btn-com" id="rp-back" style="visibility:hidden;">뒤로가기</div>
				<div class="btn-res" id="rp-edit">수정하기</div>
				<div class="btn-res" id="rp-save" hidden>저장하기</div>
			</div>
			<div class="response-wrapper " id="response-wrapper">
				<div class="response-title ">요청자 회신</div>
				<div class="response-content " id="response-content" style="display:none;"></div>
				<div class="response-content-nothing" id="response-content-nothing" style="font-weight:bold; text-align:center;">-</div>
			</div>
		</div>
	</div>
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<!-- Navigation-->
		<%@include file="../layout/navbar.jsp"%>

		<header class="bg-primary text-white text-center gradient-bgcolor">
			<div class="container d-flex flex-column title-info">
				<div class="reg-info">
					<h4>내 응답내역</h4>
					<p>
						지금까지 응답하신 목록들을 <br>모두 확인할 수 있습니다.
					</p>
				</div>
			</div>
		</header>
		<section class="myreply-section text-center " id="portfolio" style="text-align: center;">
			<div class="container">
				<div class="request-table">
					<table style="table-layout: fixed">
						<thead>
							<tr style="border-bottom: 3px solid #d3d3d3;">
								<th class="table-num">No</th>
								<th class="table-title">응답 내용</th>
								<th class="table-date">등록일</th>
								<th class="table-status">상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="reply" items="${myreplyList.content}">
								<fmt:formatDate value="${reply.regDate}" pattern="yyyy. MM. dd." var="regdate" />
								
								<script>

								const rp${reply.id} = {
										id: ${reply.id},
										userName : "${reply.replyUser}",
										org : "${reply.replyOrg}",
										phone: "${reply.replyPhone}",
										content: "${reply.replyContent}",
										status : "${reply.status}",
										comment : "${reply.comment}",
										regDate : "${regdate}",
										rqTitle : "${reply.request.title}",
										rqAddress : "${reply.request.requestAddress}"
									};
								</script>
										

								<c:choose>
									<c:when test="${reply.status == 'APPROVED'}" >
										<c:set var="status" value="승인"/>
									</c:when>
									<c:when test="${reply.status == 'NON_APPROVED'}" >
										<c:set var="status" value="미승인"/>
									</c:when>
									<c:when test="${reply.status == 'WAITING'}" >
										<c:set var="status" value="대기"/>
									</c:when>
									<c:when test="${reply.status == 'CLOSED'}" >
										<c:set var="status" value="마감"/>
									</c:when>
									<c:when test="${reply.status == 'DELETED'}" >
										<c:set var="status" value="삭제됨"/>
									</c:when>
								</c:choose>
								<c:set var="replyContent" value="${reply.replyContent}"/>
								<c:set var="replyContent" value="[${reply.request.title}]에 대한 응답" />
								<c:if test="${reply.replyContent ==  ''}">
								</c:if>
								<tr class="reply-item" onclick="goDetail_myreply(rp${reply.id}, 'default');" style="cursor:pointer;">
									<td class="table-num">${reply.id}</td>
									<td class="table-title fbold">${replyContent}</td>
									<td class="table-date">${regdate}</td>
									<td class="table-status">${status}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>				
				</div>
			</div>
		</section>
		
		<div class="paging-wrapper">
			<c:set var="page" value="${myreplyList.number}" />
			<!-- 첫번째 페이지 -->
			<c:set var="startNum" value="${page - (page) % 5}" />
			<!-- 마지막 페이지 -->
			<c:set var="lastNum" value="${myreplyList.totalPages-1}" />
			<c:set var="isLast" value="5" />
			<c:choose>
				<c:when test="${myreplyList.totalPages == 0}">
					<div style="margin-bottom: 1rem; text-align:center;">
						응답내역이 존재하지 않습니다.
					</div>
					<c:set var="isLast" value="1" />
				</c:when>
				<c:otherwise>
					<div class="pagination">
						<c:if test="${startNum >= 5}">
							<a href="?page=${startNum - 1}" style="float: left;" class="btn btn-prev paging-left">&laquo;</a>
						</c:if>
			
						<c:if test="${startNum == 0}">
							<span class="btn btn-prev" style="color: #e3e3e3; float: left; cursor: initial;" disabled>&laquo;</span>
						</c:if>
						<c:if test="${myreplyList.totalPages ne 0}">
							<!-- 마지막수 - 첫번째수 -->
							<c:if test="${startNum + 5 >= lastNum }">
								<c:set var="isLast" value="${lastNum - startNum + 1}" />
							</c:if>
						</c:if>
						<c:forEach var="i" begin="0" end="${isLast-1}">
							<c:choose>
								<c:when test="${i eq page%5}">
									<a class="-text- orange bold selected_page" href="?page=${startNum + i}">${startNum + i + 1}</a>
								</c:when>
								<c:otherwise>
									<a class="-text- orange bold" href="?page=${startNum + i}">${startNum + i + 1}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
			
						<!-- 마지막번호는 DB레코드 수와 연관이 있다! 우선은 lastpage 개수를 임의로 지정. -->
						<c:if test="${startNum + 4 <= lastNum }">
							<a href="?page=${startNum + 5}" class="btn btn-next paging-right">&raquo;</a>
						</c:if>
						<c:if test="${startNum + 4 > lastNum }">
							<span class="btn btn-next" style="color: #e3e3e3; cursor: initial;" disabled>&raquo;</span>
						</c:if>
					</div>	
				</c:otherwise>
			</c:choose>
		</div>				
		
		
		
		<!-- Footer-->
		<%@include file="../layout/footer.jsp"%>
		<%@include file="../layout/sidebar_back.jsp"%>
	</div>

	<%@include file="../layout/jsFile.jsp"%>
	<script src="/js/my.js"></script>

	<script>
		/* 
			1. 뒤로가기 버튼 보이게 visibility : visible
			2. 수정버튼 사라지게 hidden : hidden
			3. 저장버튼 생기게 removeAttr hidden
			4. 모든 아이템들 나타나게 (replyNum 부분이 input형식으로 변하도록)
		*/
		
		function myreply_edit(rp, rid) {
			$("#rp_item0").empty();
			$(".other-rpitem").remove();
			alert("수정 후 저장하시면 됩니다.");
			$("#rp-back").css("visibility", "visible");
			$("#rp-edit").prop("hidden", "hidden");
			$("#rp-close").css("display", "none");
			$("#rp-save").removeAttr("hidden");
			$("#rp_org").removeAttr("readonly");
			$("#rp_name").removeAttr("readonly");
			$("#rp_phone").removeAttr("readonly");
			$("#rp_content").removeAttr("readonly");
			$("#rp_org").css("border", "1px solid black");
			$("#rp_name").css("border", "1px solid black");
			$("#rp_phone").css("border", "1px solid black");
			$("#rp_content").css("border", "1px solid black");
			
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
					             $("#rp_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><input type='number' id='"+rItemId+"' min='0' class='response-item-big' value='"+ items[i].replyNum +"' onkeyup='checkMoney(this, "+rcNum+")'/>원</td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span>원</td><td><span style='font-weight:bold;' id='"+tItemId+"'>" + items[i].itemNum + "</span>원</td>");
					          } else {
					            $("#rp_item0").html("<td><b>" + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 2, 0);'></i><input type='text' id='"+rItemId+"' class='response-item-count' value='"+ items[i].replyNum +"' readonly/><i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 2);'></i></td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span></td><td><span style='font-weight:bold;' id='"+tItemId+"'>" + items[i].itemNum + "</span></td>");
					          }
					      }
					      else {
					        let pid = "#rp_item" + (i-1);
					        if(items[i].requestType === items[i-1].requestType) {
					          if(items[i].requestType == "재정") { 
					              $(pid).after('<tr class="other-rpitem" id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td><input type='number' id='"+rItemId+"' min='0' class='response-item-big' value='"+ items[i].replyNum +"' onkeyup='checkMoney(this, "+rcNum+")'/>원</td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span>원</td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span>원</td></tr>');
					          } else {
								  $(pid).after('<tr class="other-rpitem" id="rp_item' + i + '"><td>' + "</td><td>" + items[i].itemName + "</td><td><i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 2, 0);'></i><input type='text' id='"+rItemId+"' class='response-item-count' value='"+ items[i].replyNum +"' readonly/><i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 2);'></i></td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span></td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span></td></tr>');				
					          }
					        } else {
					          if(items[i].requestType == "재정") {
								  $(pid).after('<tr class="other-rpitem" style="border-top: 2px solid black;" id="rp_item' + i + '"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><input type='number' min='0' id='"+rItemId+"' class='response-item-big' value='"+ items[i].replyNum +"' onkeyup='checkMoney(this, "+rcNum+")'/>원</td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span>원</td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span>원</td></tr>');				
					          } else {
								  $(pid).after('<tr class="other-rpitem" style="border-top: 2px solid black;" id="rp_item' + i + '"><td><b>' + items[i].requestType + "</b></td><td>" + items[i].itemName + "</td><td><i class='fas fa-minus minus-icon' id='"+curID+"' onclick='minusCount(this, 2, 0);'></i><input type='text' id='"+rItemId+"' class='response-item-count' value='"+ items[i].replyNum +"' readonly/><i class='fas fa-plus plus-icon' id='"+curID+"' onclick='plusCount(this, 2);'></i></td><td><span id='"+rcItemId+"'>" + items[i].receivedNum + "</span></td><td><span style='font-weight:bold;' id='"+tItemId+"'>"+ items[i].itemNum +'</span></td></tr>');				
					          }
					        }
					      }
				    }
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
			
			
		}
		function myreply_edit_save(rp, rid) {
			var regex = /^\d{2,3}\d{3,4}\d{4}$/;
			if(!regex.test($("#rp_phone").val())){
				alert("하이픈(-) 없이 번호만 입력해주세요.");
				return 0;
			}
			
			// replyItem Update
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
							alert("응답 내역이 수정되었습니다.");
							location.href = "/user/myreply";
						}
					}).fail(function(error) {
						console.log(JSON.stringify(error));
					});
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});
			
			
			
		}
	
		function myreply_back(rp, rid) {
			$("#rp_item0").empty();
			$(".other-rpitem").remove();
			//console.log(org+", "+name+", "+phone);
			//$("#rp-back").css("visibility", "hidden");
			$("#rp-edit").removeAttr("hidden");
			$("#rp-save").prop("hidden", "hidden");
			$("#rp-back").css("visibility", "hidden");
			$("#rp-close").css("display", "block");

			
			$("#rp-edit").removeAttr("hidden");
			$("#rp_org").val(rp.org);
			$("#rp_name").val(rp.userName);
			
			if(rp.phone == ""){
				$("#rp_phone").val("-");		
			} else {
				$("#rp_phone").val(rp.phone);
			}
			$("#rp_content").val(rp.content);

			
			$("#rp_org").prop("readonly", "true");
			$("#rp_name").prop("readonly", "true");
			$("#rp_phone").prop("readonly", "true");
			$("#rp_content").prop("readonly", "true");
			
			$("#rp_org").css("border", "1px solid white");
			$("#rp_name").css("border", "1px solid white");
			$("#rp_phone").css("border", "1px solid white");
			$("#rp_content").css("border", "1px solid white");

			$.ajax({
				type : "GET",
				traditional : true,
				url : "/user/replyItemObj_reply?replyId="+rid,
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
					
					$("#rp-back").attr("onclick", ("myreply_back(rp"+rp.id+", "+rp.id+")"));
					$("#rp-edit").attr("onclick", ("myreply_edit(rp"+rp.id+", "+rp.id+")"));

				
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
			
			
		}

	</script>

</body>
</html>