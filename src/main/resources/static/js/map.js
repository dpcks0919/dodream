// 마커들을 모아놓는 리스트(삭제 용이)
var markerList = [];
var infowindowList = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
		level: 2 // 지도의 확대 레벨
	};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

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

let index = {
	init: function() {

		// defaultmark
		this.defaultMark();

		//지도부분 버튼 클릭시
		$("#btn-search").on("click", () => {
			var addr = $("#input-addr").val()
			this.searchAndLocate(addr);
		});
		$("#btn-elderly").on("click", () => {
			this.searchAndMark("ELDERLY")
			alert("노인");
		});
		$("#btn-child").on("click", () => {
			this.searchAndMark("CHILD");
			alert("아이");
		});
		$("#btn-disabled").on("click", () => {
			this.searchAndMark("DISABLED");
			alert("장애인");
		});
		$("#btn-others").on("click", () => {
			this.searchAndMark("OTHERS");
			alert("기타");
		});
		$("#btn-goods").on("click", () => {
			alert("물품");
		});
		$("#btn-finance").on("click", () => {
			alert("재정");
		});
		$("#btn-service").on("click", () => {
			alert("서비스");
		});
		$("#btn-etc").on("click", () => {
			alert("기타");
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
							 infowindowList.push(infowindow);
							 kakao.maps.event.addListener(marker, 'click', function() { 
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
			alert("searchAndMark error: " + JSON.stringify(error));
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

index.init();
