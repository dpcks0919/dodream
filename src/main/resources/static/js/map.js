// 마커들을 모아놓는 리스트(삭제 용이)
var markerList = [];
var infowindowList = [];

// request,group 리스트
var requestList;
var groupList;

// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
	map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
	map.setLevel(map.getLevel() + 1);
}

var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다
	imageSrc2 = '../image/marker-elderly.png',
	imageSrc3 = '../image/marker-child.png',
	imageSrc4 = '../image/marker-disabled.png',
	imageSrc5 = '../image/marker-others.png',
	imageSize = new kakao.maps.Size(32, 34), // 마커이미지의 크기입니다
	imageSize2 = new kakao.maps.Size(30, 40), 
	imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	markerImage2 = new kakao.maps.MarkerImage(imageSrc2, imageSize2, imageOption),	// 노인 
	markerImage3 = new kakao.maps.MarkerImage(imageSrc3, imageSize2, imageOption),	// 아이 
	markerImage4 = new kakao.maps.MarkerImage(imageSrc4, imageSize2, imageOption),	// 장애인 
	markerImage5 = new kakao.maps.MarkerImage(imageSrc5, imageSize2, imageOption),	// 기타
	markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

let mapInit = {
	init: function() {
					
		//로딩시 marker info 란 hidden 처리
		$("#marker-info-container").css('visibility', 'hidden');
	
		// defaultmark 화면 로딩시 마커 띄워주는 부분
		this.defaultMark();

		// 검색코드 버튼 클릭시
		$("#marker-info-search-btn").on("click", () =>{
			$("#marker-info-search-input").select();
			document.execCommand( 'Copy' );	// 클립보드에 복사
			alert("클립보드에 해당코드가 복사되었습니다!");
		});
		
		//지도부분 버튼 클릭시
		$("#btn-search").on("click", () => {
			var addr = $("#input-addr").val()
			this.searchAndLocate(addr);
		});
		
		//돕고 싶은 이웃 클릭시(노인, 아이, 장애인, 기타 중 택1)
		$("#btn-elderly").on("click", () => {
			if($("#btn-elderly").hasClass("tbox-small-selected-blue") === true) {
				$('#btn-elderly').removeClass('tbox-small-selected-blue');
				this.defaultMark();
			}else{
				this.searchAndMark("ELDERLY");
				$('#btn-elderly').addClass('tbox-small-selected-blue');
				$('#btn-child').removeClass('tbox-small-selected-blue');
				$('#btn-disabled').removeClass('tbox-small-selected-blue');
				$('#btn-others').removeClass('tbox-small-selected-blue');
			}
		});
		$("#btn-child").on("click", () => {
			if($("#btn-child").hasClass("tbox-small-selected-blue") === true) {
				$('#btn-child').removeClass('tbox-small-selected-blue');
				this.defaultMark();
			}else{
				this.searchAndMark("CHILD");
				$('#btn-elderly').removeClass('tbox-small-selected-blue');
				$('#btn-child').addClass('tbox-small-selected-blue');
				$('#btn-disabled').removeClass('tbox-small-selected-blue');
				$('#btn-others').removeClass('tbox-small-selected-blue');
			}
		});
		$("#btn-disabled").on("click", () => {
			if($("#btn-disabled").hasClass("tbox-small-selected-blue") === true) {
				$('#btn-disabled').removeClass('tbox-small-selected-blue');
				this.defaultMark();
			}else{
				this.searchAndMark("DISABLED");
				$('#btn-elderly').removeClass('tbox-small-selected-blue');
				$('#btn-child').removeClass('tbox-small-selected-blue');
				$('#btn-disabled').addClass('tbox-small-selected-blue');
				$('#btn-others').removeClass('tbox-small-selected-blue');	
			}			
		});
		$("#btn-others").on("click", () => {
			if($("#btn-others").hasClass("tbox-small-selected-blue") === true) {
				$('#btn-others').removeClass('tbox-small-selected-blue');
				this.defaultMark();
			}else{
				this.searchAndMark("OTHERS");
				$('#btn-elderly').removeClass('tbox-small-selected-blue');
				$('#btn-child').removeClass('tbox-small-selected-blue');
				$('#btn-disabled').removeClass('tbox-small-selected-blue');
				$('#btn-others').addClass('tbox-small-selected-blue');
			}	
		});
		
		// 돕고 싶은 재화 클릭시(이웃과 중복 선택 가능하다)
		$("#btn-stuff").on("click", () => {
			this.searchAndMark2("STUFF"); // 기존 requestList에서 request_type 확인 후 걸러내는 함수 
			$('#btn-stuff').addClass('tbox-small-selected-red');
			$('#btn-finance').removeClass('tbox-small-selected-red');
			$('#btn-service').removeClass('tbox-small-selected-red');
			$('#btn-etc').removeClass('tbox-small-selected-red');
		});
		$("#btn-finance").on("click", () => {
			this.searchAndMark2("FINANCE"); // 기존 requestList에서 request_type 확인 후 걸러내는 함수 
			$('#btn-stuff').removeClass('tbox-small-selected-red');
			$('#btn-finance').addClass('tbox-small-selected-red');
			$('#btn-service').removeClass('tbox-small-selected-red');
			$('#btn-etc').removeClass('tbox-small-selected-red');
		});
		$("#btn-service").on("click", () => {
			this.searchAndMark2("SERVICE"); // 기존 requestList에서 request_type 확인 후 걸러내는 함수 
			$('#btn-stuff').removeClass('tbox-small-selected-red');
			$('#btn-finance').removeClass('tbox-small-selected-red');
			$('#btn-service').addClass('tbox-small-selected-red');
			$('#btn-etc').removeClass('tbox-small-selected-red');
		});
		$("#btn-etc").on("click", () => {
			this.searchAndMark2("ETC"); // 기존 requestList에서 request_type 확인 후 걸러내는 함수 
			$('#btn-stuff').removeClass('tbox-small-selected-red');
			$('#btn-finance').removeClass('tbox-small-selected-red');
			$('#btn-service').removeClass('tbox-small-selected-red');
			$('#btn-etc').addClass('tbox-small-selected-red');
		});
		
		$("#btn-etc").on("click", () => {
			$('#btn-stuff').removeClass('tbox-small-selected-red');
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
	
	//검색코드를 통한 조회(미사용)
	searchMarkerInfo: function(){
		var inputCode = $("#marker-info-search-input").val();
		var existFlag = 0;
		requestList.forEach(function(list, index) { 
			if(markerList[index].getTitle() == inputCode){	// inputCode에 해당하는 requestId가 존재할때(마커에 저장된 title 활용)
				kakao.maps.event.trigger(markerList[index], 'click');
				existFlag= 1;
				map.setCenter(markerList[index].getPosition());	// 해당위치로 이동
			}
		});
		if(existFlag == 0) alert("해당 코드가 존재하지 않습니다.");
	},
	
	// (마커 클릭시 나타나게 되는) 상세 정보 배너 채우기
	fillMarkerInfo: function(index){	// index: requestList의 index
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
	},

	// 마크하기 
	defaultMark: function() {
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

				//맵에 마커 뿌리기
				//mapInit.setMarker(requestList);
				
				// request 마커 뿌리기
				requestList.forEach(function(list, index) { 
					geocoder.addressSearch(list.requestAddress, function(result, status) { 
						if (status === daum.maps.services.Status.OK) {
							 var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
							 var tempMarkerImage; // ClientType에 따라서 imageSrc 정하기
							 if(requestList[index].clientType == 'ELDERLY')tempMarkerImage = markerImage2;	// 노인
							 else if(requestList[index].clientType == 'CHILD') tempMarkerImage = markerImage3;
							 else if(requestList[index].clientType == 'DISABLED') tempMarkerImage = markerImage4;
						     else tempMarkerImage = markerImage5	// 기타
							 var marker = new daum.maps.Marker({ 
								 title: requestList[index].id,		// tootip title을 이용해서 RequstID 식별
								 image: tempMarkerImage,
								 position: coords, 
								 clickable: true 
								}); 
							// request 마커를 지도에 표시합니다. 
							markerList.push(marker);	// list에 마커 push
							marker.setMap(map); 
							
							// IndexPage 일 경우, 인포윈도우를 추가한다
							if(isIndexPage == true){
								// 인포윈도우를 생성합니다 
								var infowindow = new kakao.maps.InfoWindow({ 
									content: '<div style="width:150px;text-align:center;padding:6px 0;">' + requestList[index].title + '</div>', 
									removable : true
								 }); 
								 	 infowindowList.push(infowindow);	// infowindow list에 push 
							}
						
							 kakao.maps.event.addListener(marker, 'click',  function() { 
								map.setCenter(coords);	// 클릭 위치로 이동
								mapInit.fillMarkerInfo(index);	// marker info 채우는 함수
								$("#marker-info-container").css('visibility', 'visible');	// 상세보기 배너 띄우기

								// 검색코드에 나타내기
								 $("#marker-info-search-input").val(requestList[index].id);
				
								//자세히 보기 클릭시
								$("#marker-info-btn").off("click"); // 기존 listener 제거(중요)
								$("#marker-info-btn").on("click", () => {
								    goDetail_request(requestList[index]);
									$("#marker-info-container").css('visibility', 'hidden');	// 상세보기 배너 가리기
								});
								
								//(Index 페이지일 경우에만)마커 위에 인포윈도우를 표시합니다 
								if(isIndexPage == true) infowindow.open(map, marker); 
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
								 //image: markerImage,	 // custome marker image(상단 전역변수 참고) 이용
								 position: coords, 
								 clickable: true 
								}); 
							// group 마커를 지도에 표시합니다. 
							markerList.push(marker);	// list에 마커 push
							marker.setMap(map); 
							// 인포윈도우를 생성합니다 
							var infowindow = new kakao.maps.InfoWindow({ 
								content: '<div style="width:150px;text-align:center;padding:6px;">' + groupList[index].userName + '</div>', 
								removable : true
							 }); // 마커에 클릭이벤트를 등록합니다 
							infowindowList.push(infowindow);	// infowindow list에 push 
							 kakao.maps.event.addListener(marker, 'click', function() { 
								$("#map-info-container").css('visibility', 'visible');
								// 마커 위에 인포윈도우를 표시합니다 
								infowindow.open(map, marker); 					
							}); 
						}
					}); 
				});
			}
		}).fail(function(error) {
			alert("groupListProc error: " + JSON.stringify(error));
		});
	},

	// 노인,아이,장애인, 기타 클릭시 
	searchAndMark: function(clientType) {	
		this.mapClean();		// map 객체 초기화
		$.ajax({// DB에서 주소 받아오기.
			type: "POST",
			url: "/markProc",
			data: { clientType: clientType },
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("주소가 DB에 없습니다.");	
			} else {
				
				requestList = resp.data;
				
				// 선택한 종류의 마커 뿌리기
				requestList.forEach(function(list, index) { 
					geocoder.addressSearch(list.requestAddress, function(result, status) { 
						var tempMarkerImage; // ClientType에 따라서 imageSrc 정하기
						if (status === daum.maps.services.Status.OK) {
							 var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
							if(requestList[index].clientType == 'ELDERLY')tempMarkerImage = markerImage2;	// 노인
							else if(requestList[index].clientType == 'CHILD') tempMarkerImage = markerImage3;
							else if(requestList[index].clientType == 'DISABLED') tempMarkerImage = markerImage4;
						    else tempMarkerImage = markerImage5	// 기타
							 var marker = new daum.maps.Marker({ 
								title: requestList[index].id,
								 image: tempMarkerImage,	 // custome marker image(상단 전역변수 참고) 이용
								 position: coords, 
								 clickable: true 
								}); 
							// 마커를 지도에 표시합니다. 
							markerList.push(marker);	// list에 마커 push
							marker.setMap(map); 
							
							// IndexPage 일 경우, 인포윈도우를 추가한다
							if(isIndexPage == true){
								// 인포윈도우를 생성합니다 
								var infowindow = new kakao.maps.InfoWindow({ 
									content: '<div style="width:150px;text-align:center;padding:6px 0;">' + requestList[index].title + '</div>', 
									removable : true
								 }); 
								 	 infowindowList.push(infowindow);	// infowindow list에 push 
							}
													
							 kakao.maps.event.addListener(marker, 'click', function() {
								map.setCenter(coords);	// 클릭 위치로 이동
								mapInit.fillMarkerInfo(index);	// marker info 채우는 함수
								$("#marker-info-container").css('visibility', 'visible');	// 상세보기 배너 띄우기
								
								 // 검색코드에 나타내기
								 $("#marker-info-search-input").val(requestList[index].id);
						
								//자세히 보기 클릭시
								$("#marker-info-btn").off("click");	// 기존 listner 삭제(중요)
								$("#marker-info-btn").on("click", () => {
									goDetail_request(requestList[index]);
									$("#marker-info-container").css('visibility', 'hidden');	// 상세보기 배너 가리기
								});
									
								//(Index 페이지일 경우에만)마커 위에 인포윈도우를 표시합니다 
								if(isIndexPage == true) infowindow.open(map, marker); 
									 // 검색코드에 나타내기
									 $("#marker-info-search-input").val(requestList[index].id);
							
									//자세히 보기 클릭시
									$("#marker-info-btn").off("click");	// 기존 listner 삭제(중요)
									$("#marker-info-btn").on("click", () => {
										goDetail_request(requestList[index]);
										$("#marker-info-container").css('visibility', 'hidden');	// 상세보기 배너 가리기
									});
								 
								 	//(Index 페이지일 경우에만)마커 위에 인포윈도우를 표시합니다 
									if(isIndexPage == true) infowindow.open(map, marker); 
							
							}); 
						}
						//좌표이동
						//map.setCenter(coords);
					}); 
				});
				
			}

		}).fail(function(error) {
			alert("결과가 없습니다.");
		});
	},
	
	// 돕고 싶은 재화(물품, 재정, 서비스,기타) 선택시 마커 걸러내는 함수 
	searchAndMark2: function(requestType){
		var validRequestList = [];	// 해당 requestType이 존재하는 valid한 request ID list
		requestList.forEach(function(list, index){	// requestList
			list.requestItem.forEach(function(list2,index2){	//request에 종속된 requestItem 리스트
				if(requestType == list2.requestType) {
					console.log(list2.requestId);
					if(validRequestList[validRequestList.length-1] != requestList[index]) {
						validRequestList.push(requestList[index]);
						return false;	// break;
					}
				}
			});
		})
		// 해당하는 마커들을 List에 넣은 후, setMarker()를 이용해 맵에 뿌리기
		mapInit.setMarker(validRequestList);
		console.log(validRequestList);
	},
	
	// requestList를 받아서 해당하는 marker를 Map에 뿌려주는 함수
	setMarker: function(InputRequestList) {	
		this.mapClean();		// map 객체 초기화
			// requestList 요청들 마커 뿌리기
			InputRequestList.forEach(function(list, index) { 
				geocoder.addressSearch(list.requestAddress, function(result, status) { 
					var tempMarkerImage; // ClientType에 따라서 imageSrc 정하기
					if (status === daum.maps.services.Status.OK) {
						 var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
						if(InputRequestList[index].clientType == 'ELDERLY')tempMarkerImage = markerImage2;	// 노인
						else if(InputRequestList[index].clientType == 'CHILD') tempMarkerImage = markerImage3;
						else if(InputRequestList[index].clientType == 'DISABLED') tempMarkerImage = markerImage4;
					    else tempMarkerImage = markerImage5	// 기타
						 var marker = new daum.maps.Marker({ 
							title: InputRequestList[index].id,
							 image: tempMarkerImage,	 // custome marker image(상단 전역변수 참고) 이용
							 position: coords, 
							 clickable: true 
							}); 
						// 마커를 지도에 표시합니다. 
						markerList.push(marker);	// list에 마커 push
						marker.setMap(map); 
						
						// IndexPage 일 경우, 인포윈도우를 추가한다
						if(isIndexPage == true){
							// 인포윈도우를 생성합니다 
							var infowindow = new kakao.maps.InfoWindow({ 
								content: '<div style="width:150px;text-align:center;padding:6px 0;">' + InputRequestList[index].title + '</div>', 
								removable : true
							 }); 
							 	 infowindowList.push(infowindow);	// infowindow list에 push 
						}
												
						 kakao.maps.event.addListener(marker, 'click', function() {
							map.setCenter(coords);	// 클릭 위치로 이동
							mapInit.fillMarkerInfo(index);	// marker info 채우는 함수
							$("#marker-info-container").css('visibility', 'visible');	// 상세보기 배너 띄우기
							
							 // 검색코드에 나타내기
							 $("#marker-info-search-input").val(InputRequestList[index].id);
					
							//자세히 보기 클릭시
							$("#marker-info-btn").off("click");	// 기존 listner 삭제(중요)
							$("#marker-info-btn").on("click", () => {
								goDetail_request(InputRequestList[index]);
								$("#marker-info-container").css('visibility', 'hidden');	// 상세보기 배너 가리기
							});
								
							//(Index 페이지일 경우에만)마커 위에 인포윈도우를 표시합니다 
							if(isIndexPage == true) infowindow.open(map, marker); 
								 // 검색코드에 나타내기
								 $("#marker-info-search-input").val(InputRequestList[index].id);
						
								//자세히 보기 클릭시
								$("#marker-info-btn").off("click");	// 기존 listner 삭제(중요)
								$("#marker-info-btn").on("click", () => {
									goDetail_request(requestList[index]);
									$("#marker-info-container").css('visibility', 'hidden');	// 상세보기 배너 가리기
								});
							 
							 	//(Index 페이지일 경우에만)마커 위에 인포윈도우를 표시합니다 
								if(isIndexPage == true) infowindow.open(map, marker); 
						
						}); 
					}
				}); 
			});
	},

	searchAndLocate: function(addr) {

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
