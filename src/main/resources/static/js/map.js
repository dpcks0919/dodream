var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
		level: 4 // 지도의 확대 레벨
	};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

/*
// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
function setMapType(maptype) { 
    var roadmapControl = document.getElementById('btnRoadmap');
    var skyviewControl = document.getElementById('btnSkyview'); 
    if (maptype === 'roadmap') {
        map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);    
        roadmapControl.className = 'selected_btn';
        skyviewControl.className = 'unselected_btn';
    } else {
        map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);    
        skyviewControl.className = 'selected_btn';
        roadmapControl.className = 'unselected_btn';
    }
}
*/

// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
    map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
    map.setLevel(map.getLevel() + 1);
}

var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
	imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
	position: markerPosition,
	image: markerImage // 마커이미지 설정 
});


//마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	iwRemoveable = false; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
	content: iwContent,
	removable: iwRemoveable
});

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

let index = {
	init: function() {

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 마커에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			// 마커 위에 인포윈도우를 표시합니다
			infowindow.open(map, marker);
			alert("hello");
		});

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

	searchAndMark: function(clientType) {
		$.ajax({// DB에서 주소 받아오기.
			type: "POST",
			url: "/markProc",
			data: {clientType: clientType},
			type: "POST",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("주소가 DB에 없습니다.");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
			} else {
				alert("성공ㅇ");
				map = new kakao.maps.Map(mapContainer, mapOption); // 지도 재설정

				for(var i = 0; i < resp.data.length; i++){
					var addr = resp.data[i].requestAddress;
					geocoder.addressSearch(addr, function(result, status) {
					if (status === kakao.maps.services.Status.OK) {// 정상적으로 검색이 완료됐으면 
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						marker = new kakao.maps.Marker({// 결과값으로 받은 위치를 마커로 표시합니다
							map: map,
							position: coords
						});
						
						var infowindow = new kakao.maps.InfoWindow({// 인포윈도우로 장소에 대한 설명을 표시합니다
							content: '<div style="width:150px;text-align:center;padding:6px 0;">요기</div>'
						});
						infowindow.open(map, marker);
						map.setCenter(coords); // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						
					}
					else {
						alert("정확한 주소 입력 부탁드립니다.");
					}
				});
				}
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


				/*
				// 결과값으로 받은 위치를 마커로 표시합니다
				marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});

				// 인포윈도우로 장소에 대한 설명을 표시합니다
				var infowindow = new kakao.maps.InfoWindow({
					content: '<div style="width:150px;text-align:center;padding:6px 0;">요기</div>'
				});
				infowindow.open(map, marker);
				*/

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

