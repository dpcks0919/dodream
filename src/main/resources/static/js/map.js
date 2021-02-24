// 마커들을 모아놓는 리스트(삭제 용이)
var markerList = [];
var infowindowList = [];

// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
	map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
	map.setLevel(map.getLevel() + 1);
}

var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다  
	imageSize = new kakao.maps.Size(32, 34), // 마커이미지의 크기입니다
	imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다


// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

let mapInit = {
	init: function() {
		
		//marker info 란 hidden 처리
		$("#marker-info-container").css('visibility', 'hidden');
	
		// defaultmark
		this.defaultMark();

		//지도부분 버튼 클릭시
		$("#btn-search").on("click", () => {
			var addr = $("#input-addr").val()
			this.searchAndLocate(addr);
		});
		$("#btn-elderly").on("click", () => {
			this.searchAndMark("ELDERLY");
			$('#btn-elderly').addClass('tbox-small-selected-blue');
			$('#btn-child').removeClass('tbox-small-selected-blue');
			$('#btn-disabled').removeClass('tbox-small-selected-blue');
			$('#btn-others').removeClass('tbox-small-selected-blue');
		});
		$("#btn-child").on("click", () => {
			this.searchAndMark("CHILD");
			$('#btn-elderly').removeClass('tbox-small-selected-blue');
			$('#btn-child').addClass('tbox-small-selected-blue');
			$('#btn-disabled').removeClass('tbox-small-selected-blue');
			$('#btn-others').removeClass('tbox-small-selected-blue');
		});
		$("#btn-disabled").on("click", () => {
			this.searchAndMark("DISABLED");
			$('#btn-elderly').removeClass('tbox-small-selected-blue');
			$('#btn-child').removeClass('tbox-small-selected-blue');
			$('#btn-disabled').addClass('tbox-small-selected-blue');
			$('#btn-others').removeClass('tbox-small-selected-blue');		
		});
		$("#btn-others").on("click", () => {
			this.searchAndMark("OTHERS");
			$('#btn-elderly').removeClass('tbox-small-selected-blue');
			$('#btn-child').removeClass('tbox-small-selected-blue');
			$('#btn-disabled').removeClass('tbox-small-selected-blue');
			$('#btn-others').addClass('tbox-small-selected-blue');
		});
		$("#btn-goods").on("click", () => {
			$('#btn-goods').addClass('tbox-small-selected-red');
			$('#btn-finance').removeClass('tbox-small-selected-red');
			$('#btn-service').removeClass('tbox-small-selected-red');
			$('#btn-etc').removeClass('tbox-small-selected-red');
		});
		$("#btn-finance").on("click", () => {
			$('#btn-goods').removeClass('tbox-small-selected-red');
			$('#btn-finance').addClass('tbox-small-selected-red');
			$('#btn-service').removeClass('tbox-small-selected-red');
			$('#btn-etc').removeClass('tbox-small-selected-red');
		});
		$("#btn-service").on("click", () => {
			$('#btn-goods').removeClass('tbox-small-selected-red');
			$('#btn-finance').removeClass('tbox-small-selected-red');
			$('#btn-service').addClass('tbox-small-selected-red');
			$('#btn-etc').removeClass('tbox-small-selected-red');
		});
		$("#btn-etc").on("click", () => {
			$('#btn-goods').removeClass('tbox-small-selected-red');
			$('#btn-finance').removeClass('tbox-small-selected-red');
			$('#btn-service').removeClass('tbox-small-selected-red');
			$('#btn-etc').addClass('tbox-small-selected-red');
		});
	},

	
	mapClean: function(){
		for(var i = 0; i < markerList.length; i++){
			markerList[i].setMap(null);
		}
		
		for(var i = 0; i < infowindowList.length; i++){
			infowindowList[i].setMap(null);
		}
	},

	// 마크하기 
	defaultMark: function() {
		var requestList;
		var groupList;
		this.mapClean();		// map 객체 초기화
		
		//1. request 마커 찍기
		$.ajax({// DB에서 주소 받아오기.
			type: "POST",
			url: "/requestListProc",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("주소가 DB에 없습니다.");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
			} else {
				requestList = resp.data;

				//마커 뿌리기
				requestList.forEach(function(list, index) { 
					geocoder.addressSearch(list.requestAddress, function(result, status) { 
						if (status === daum.maps.services.Status.OK) {
							 var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
							 var marker = new daum.maps.Marker({ 
								 position: coords, 
								 clickable: true 
								}); 
							// 마커를 지도에 표시합니다. 
							markerList.push(marker);	// list에 마커 push
							marker.setMap(map); 
							// 인포윈도우를 생성합니다 
							var infowindow = new kakao.maps.InfoWindow({ 
								content: '<div style="width:150px;text-align:center;padding:6px 0;"> #' + requestList[index].id + '</div>', 
								removable : true
							 }); // 마커에 클릭이벤트를 등록합니다 
							 	 infowindowList.push(infowindow);	// infowindow list에 push 
							 	 kakao.maps.event.addListener(marker, 'click', function() {
								 $("#marker-info-container").css('visibility', 'visible');
								 $("#marker-info-title").text(requestList[index].title); 
								 $("#marker-info-date").text(requestList[index].regDate.substring(0,10)); 
							
								  // 날짜로 상태 계산 
								  var date = requestList[index].dueDate;
								  var d_date = new Date(date.valueOf());
								  var d_time = d_date.getTime();
							      var cur = new Date(); // 현재시간
								  var c_time = cur.getTime();
							      var status = "";
								  if(c_time <= d_time) status = "응답 대기중";
							      else status = "응답 완료";
								 $("#marker-info-status").text(status);
							
								 // 긴급정도 나타내기
								 if(requestList[index].urgentLevel == 1) var urgentLevel = "매우 긴급(24시간 이내)";
								 else if(requestList[index].urgentLevel == 2) var urgentLevel = "긴급(일주일 이내)";
								 else if(requestList[index].urgentLevel == 3) var urgentLevel = "보통(한달 이내)";
								 else var urgentLevel = "기타";
								 $("#marker-info-urgentlevel").text(urgentLevel); 
							
								 $("#marker-info-address").text(requestList[index].requestAddress); 
								 $("#marker-info-phone").text(requestList[index].user.userPhone); 
							
								//자세히 보기 클릭시
								$("#marker-info-btn").on("click", () => {
								     goDetail_request(requestList[index]);
								});

								 // 마커 위에 인포윈도우를 표시합니다 
								 infowindow.open(map, marker); 
							}); 
						} 
					}); 
				});
			}
		}).fail(function(error) {
			alert("requestListProc error: " + JSON.stringify(error));
		});
		
		//2. group(단체) 마커 찍기
		$.ajax({// DB에서 주소 받아오기.
			type: "POST",
			url: "/groupListProc",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("주소가 DB에 없습니다.");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
			} else {
				groupList = resp.data;
				
				// Group 주소 마커 뿌리기
				groupList.forEach(function(list, index) { 
					geocoder.addressSearch(list.address, function(result, status) { 
						if (status === daum.maps.services.Status.OK) {
							 var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
							 var marker = new daum.maps.Marker({ 
								 image: markerImage,	 // custome marker image(상단 전역변수 참고) 이용
								 position: coords, 
								 clickable: true 
								}); 
							// 마커를 지도에 표시합니다. 
							markerList.push(marker);	// list에 마커 push
							marker.setMap(map); 
							// 인포윈도우를 생성합니다 
							var infowindow = new kakao.maps.InfoWindow({ 
								content: '<div style="width:150px;text-align:center;padding:6px 0;">' + '#' + groupList[index].userName + '</div>', 
								removable : true
							 }); // 마커에 클릭이벤트를 등록합니다 
							infowindowList.push(infowindow);	// infowindow list에 push 
							 kakao.maps.event.addListener(marker, 'click', function() { 
							$("#map-info-container").css('visibility', 'visible');
							// 마커 위에 인포윈도우를 표시합니다 
							infowindow.open(map, marker); 
								
							}); 
						}
						//좌표이동
						map.setCenter(coords);
					}); 
				});
			}
		}).fail(function(error) {
			alert("groupListProc error: " + JSON.stringify(error));
		});
	},

	// 노인,아이,장애인, 기타 클릭시 
	searchAndMark: function(clientType) {	
		var requestList;
		
		this.mapClean();		// map 객체 초기화
		$.ajax({// DB에서 주소 받아오기.
			type: "POST",
			url: "/markProc",
			data: { clientType: clientType },
			type: "POST",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("주소가 DB에 없습니다.");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
			} else {
				
				var requestList = resp.data;
				
				// Group 주소 마커 뿌리기
				requestList.forEach(function(list, index) { 
					geocoder.addressSearch(list.requestAddress, function(result, status) { 
						if (status === daum.maps.services.Status.OK) {
							 var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
							 var marker = new daum.maps.Marker({ 
								 image: markerImage,	 // custome marker image(상단 전역변수 참고) 이용
								 position: coords, 
								 clickable: true 
								}); 
							// 마커를 지도에 표시합니다. 
							markerList.push(marker);	// list에 마커 push
							marker.setMap(map); 
							// 인포윈도우를 생성합니다 
							var infowindow = new kakao.maps.InfoWindow({ 
								content: '<div style="width:150px;text-align:center;padding:6px 0;">' + '#' + requestList[index].title + '</div>', 
								removable : true
							 }); // 마커에 클릭이벤트를 등록합니다 
							
							 // list에 infowindow push 
							 infowindowList.push(infowindow);
							 kakao.maps.event.addListener(marker, 'click', function() { 
								 $("#map-info-container").css('visibility', 'visible');
								 // 마커 위에 인포윈도우를 표시합니다 
								 infowindow.open(map, marker); 
							}); 
						}
						//좌표이동
						map.setCenter(coords);
					}); 
				});
				
			}

		}).fail(function(error) {
			alert("결과가 없습니다.");
		});
	},

	searchAndLocate: function(addr) {
		alert(addr);

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
			else {
				alert("정확한 주소 입력 부탁드립니다.");
			}
		});

	},

}

mapInit.init();
