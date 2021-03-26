// 마커들을 모아놓는 리스트(삭제 용이)
let markerList = [];
let infowindowList = [];

// request,group 리스트
var defaultRequestList;	// default로 맨 처음 뜨는 requestList 전역변수
var currRequestList; // 버튼 선택에 따라 바뀌는 requestList
var groupList;

// 돕고 싶은 이웃, 돞고 싶은 재화 눌렸는지 확인하는 cnt 
var selectedCnt = 0;
//selectedBtnNum1 : '이웃' 카테고리 / selectedBtnNum2: '재화' 카테고리
var selectedBtnNum1 = 0, selectedBtnNum2 = 0;// 1:노인, 2:아이, 3:장애인, 4:기타(이웃), 5:물품, 6:재정,7:서비스, 8:기타

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
	imageSrc6 = '../image/marker-group.png',
	imageSize = new kakao.maps.Size(32, 34), // 마커이미지의 크기입니다
	imageSize2 = new kakao.maps.Size(30, 40), 
	imageOption = { offset: new kakao.maps.Point(15, 20) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	markerImage2 = new kakao.maps.MarkerImage(imageSrc2, imageSize2, imageOption),	// 노인 
	markerImage3 = new kakao.maps.MarkerImage(imageSrc3, imageSize2, imageOption),	// 아이 
	markerImage4 = new kakao.maps.MarkerImage(imageSrc4, imageSize2, imageOption),	// 장애인 
	markerImage5 = new kakao.maps.MarkerImage(imageSrc5, imageSize2, imageOption),	// 기타
	markerImage6 = new kakao.maps.MarkerImage(imageSrc6, imageSize2, imageOption),		// 그룹
	markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

let mapInit = {
	init: function() {
					
		//로딩시 marker info 란 hidden 처리
		$("#marker-info-container").css('display', 'none');
	
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
			mapInit.btnCheck(1);
		});
		$("#btn-child").on("click", () => {
			mapInit.btnCheck(2);
		});
		$("#btn-disabled").on("click", () => {
			mapInit.btnCheck(3);
		});
		$("#btn-others").on("click", () => {
			mapInit.btnCheck(4);
		});
		
		// 돕고 싶은 재화 클릭시(돕고 싶은 이웃과 중복 선택 가능하다)
		$("#btn-stuff").on("click", () => {
			mapInit.btnCheck(5);
		});
		$("#btn-finance").on("click", () => {
			mapInit.btnCheck(6);
		});
		$("#btn-service").on("click", () => {
			mapInit.btnCheck(7);
		});
		$("#btn-etc").on("click", () => {
			mapInit.btnCheck(8);
		});
		
	},
	
	mapClean: function(){	
		for(var i = 0; i < markerList.length; i++){
			markerList[i].setMap(null);
		}
		
		for(var i = 0; i < infowindowList.length; i++){
			infowindowList[i].setMap(null);
		}
		
		markerList = [];
		infowindowList = [];
	},
	
	// 돕고싶은이웃, 돕고싶은재화 버튼 클릭시 작동하는 함수
	btnCheck: function(newBtnNum){	// btnNum=클릭된 버튼 
		if(selectedCnt == 0){	// 처음에 아무것도 안눌려 있을 때
			selectedCnt++;
			mapInit.selectBtn(newBtnNum);	//해당하는 버튼을 select 처리 하는 함수
		}
		else if(selectedCnt == 1){	// 1개가 이미 눌려있을 때
			if(newBtnNum == selectedBtnNum1 || newBtnNum == selectedBtnNum2){	// 이미 눌렀던 버튼을 다시 클릭했을 때
				//btn Count 감소 
				selectedCnt--;
				
				// 초기화
				mapInit.defaultMark();
				selectedBtnNum1 = 0;
				selectedBtnNum2 = 0;
				
				//그냥 일괄로 removeClass
				mapInit.btnClassRemove();
			}
			else if(newBtnNum <= 4 && selectedBtnNum1 != 0){	// 눌려있던 것과, 새로 누른것 모두 '이웃' 버튼일 경우
				mapInit.btnClassRemove();
				mapInit.selectBtn(newBtnNum);
			}
			else if(newBtnNum >= 5 && selectedBtnNum2 != 0){ // 눌려있던 것과, 새로 누른것 모두 '재화' 버튼일 경우
				mapInit.btnClassRemove();
				mapInit.selectBtn(newBtnNum);
			}
			else{	// 눌려있던 것과, 새로 누른 버튼의 카테고리가 다른 경우(순서:이웃이 먼저 눌리고, 재화가 눌려야 한다)
				selectedCnt++;
				if(selectedBtnNum1 == 0){	// 재화 버튼을 먼저 눌러놓은 상태일때
					mapInit.selectBtn(newBtnNum);	//이웃 먼저 실행
					mapInit.selectBtn(selectedBtnNum2);	//그다음 재화 실행
				}
				else if(selectedBtnNum2 == 0){	// 이웃 버튼을 먼저 눌러놓은 상태일때	
					mapInit.selectBtn(selectedBtnNum1);
					mapInit.selectBtn(newBtnNum);
				}
			}
		}
		else if(selectedCnt == 2){	// 이미 두개가 눌려있을 때
			if(newBtnNum == selectedBtnNum1 || newBtnNum == selectedBtnNum2){	// 같은 버튼 눌렀을때
				//btn Count 감소 
				selectedCnt--;
				mapInit.btnClassRemove();
				
				if(newBtnNum <= 4){	// 눌린 버튼이 이웃 일때
					selectedBtnNum1 = 0;
					mapInit.defaultMark();
					mapInit.selectBtn(selectedBtnNum2); 
				}
				else if(newBtnNum >=5){	// 눌린 버튼이 재화 일때
					selectedBtnNum2 = 0;
					mapInit.defaultMark();
					mapInit.selectBtn(selectedBtnNum1); 
				}
			}
			else{	// 다른 버튼 일때
				if(newBtnNum <= 4){	// 눌린 버튼이 이웃 일때
					mapInit.btnClassRemove();
					mapInit.selectBtn(newBtnNum); 
					mapInit.selectBtn(selectedBtnNum2); 
				}
				else if(newBtnNum >=5){	// 눌린 버튼이 재화 일때
					$('#btn-stuff').removeClass('tbox-small-selected-red');
					$('#btn-finance').removeClass('tbox-small-selected-red');
					$('#btn-service').removeClass('tbox-small-selected-red');
					$('#btn-etc').removeClass('tbox-small-selected-red');
					mapInit.selectBtn(newBtnNum); 
				}
			}
		}
	},
	
	// 해당하는 버튼을 select하는 함수 
	selectBtn(newBtnNum){
		if(newBtnNum <= 4){	// 이웃 버튼 일때 
			selectedBtnNum1 = newBtnNum;
			switch(newBtnNum){
				case 1: //노인
					mapInit.searchAndMark("ELDERLY");
					$('#btn-elderly').addClass('tbox-small-selected-blue');
					break;
				case 2: //아이
					mapInit.searchAndMark("CHILD");
					$('#btn-child').addClass('tbox-small-selected-blue');
					break;
				case 3: //장애인 
					mapInit.searchAndMark("DISABLED");
					$('#btn-disabled').addClass('tbox-small-selected-blue');
					break;
				case 4: //기타
					mapInit.searchAndMark("OTHERS");
					$('#btn-others').addClass('tbox-small-selected-blue');
					break;
				}
			}
			else if(newBtnNum >= 5){	// 재화 버튼 일때
				selectedBtnNum2 = newBtnNum;
				switch(newBtnNum){
					case 5: //물품
						mapInit.searchAndMark2("STUFF");
						$('#btn-stuff').addClass('tbox-small-selected-red');
						break;
					case 6: //재정
						mapInit.searchAndMark2("FINANCE");
						$('#btn-finance').addClass('tbox-small-selected-red');
						break;
					case 7: //서비스
						mapInit.searchAndMark2("SERVICE");
						$('#btn-service').addClass('tbox-small-selected-red');
						break;
					case 8: //기타
						mapInit.searchAndMark2("ETC");
						$('#btn-etc').addClass('tbox-small-selected-red');
						break;
				}
			}
	},
	
	//버튼들의 class를 remove 하는 함수
	btnClassRemove: function(){	
		//그냥 일괄로 removeClass
		$('#btn-elderly').removeClass('tbox-small-selected-blue');
		$('#btn-child').removeClass('tbox-small-selected-blue');
		$('#btn-disabled').removeClass('tbox-small-selected-blue');
		$('#btn-others').removeClass('tbox-small-selected-blue');
		$('#btn-stuff').removeClass('tbox-small-selected-red');
		$('#btn-finance').removeClass('tbox-small-selected-red');
		$('#btn-service').removeClass('tbox-small-selected-red');
		$('#btn-etc').removeClass('tbox-small-selected-red');
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
	fillMarkerInfo: function(InputRequest){	// index: requestList의 index
			$("#marker-info-title").text(InputRequest.title); 
			$("#marker-info-date").text(InputRequest.regDate.substring(0,10)); 
	
		  // 날짜로 상태 계산 
		  var date = InputRequest.dueDate;
		  var d_date = new Date(date.valueOf());
		  var d_time = d_date.getTime();
	      var cur = new Date(); // 현재시간
		  var c_time = cur.getTime();
	      var status = "";
		  if(c_time <= d_time) status = "응답 대기중";
	      else status = "마감";
		 $("#marker-info-status").text(status);
	
		 // 긴급정도 나타내기
		 if(InputRequest.urgentLevel == 1) var urgentLevel = "매우 긴급(24시간 이내)";
		 else if(InputRequest.urgentLevel == 2) var urgentLevel = "긴급(일주일 이내)";
		 else if(InputRequest.urgentLevel == 3) var urgentLevel = "보통(한달 이내)";
		 else var urgentLevel = "기타";
		 $("#marker-info-urgentlevel").text(urgentLevel); 
		 $("#marker-info-address").text(InputRequest.requestAddress); 
		 $("#marker-info-phone").text(InputRequest.user.userPhone); 
	},

	// 마크하기 
	defaultMark: function() {		
		//1. request 마커 찍기
		$.ajax({// DB에서 주소 받아오기.
			type: "POST",
			url: "/requestListProc",
		}).done(function(resp) {
			if (resp.status == 500) {
				alert("requestListProc에서 에러 발생");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
			} else {
				defaultRequestList = resp.data;	// defaultRequestList 는 전역변수화 해서 어디서든 접근 가능하도록 한다
				currRequestList = defaultRequestList;
				
				//(버튼이 안눌렸을 경우) 맵에 마커 뿌리기
				if(selectedCnt == 0) mapInit.setMarker(defaultRequestList);
			}
		}).fail(function(error) {
			console.log("requestListProc error: " + JSON.stringify(error));
		});
		
		if(selectedCnt == 0){// 카운트가 0일때(버튼이 하나도 안눌렸을 때)만 그룹마커 찍기
			//2. group(단체) 마커 찍기
			$.ajax({// DB에서 주소 받아오기.
				type: "POST",
				url: "/groupListProc",
			}).done(function(resp) {
				if (resp.status == 500) {
					alert("groupListProc에서 에러 발생");	//1. 등록된 아이디가 아예 없거나 / 2. 아이디와 비번 매치가 안되거나
				} else {
					groupList = resp.data;
					
					// Group 주소 마커 뿌리기
					groupList.forEach(function(list, index) { 
						geocoder.addressSearch(list.address, function(result, status) { 
							if (status === daum.maps.services.Status.OK) {
								 var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
								 var marker = new daum.maps.Marker({ 
									 image: markerImage6,	 // custome marker image(상단 전역변수 참고) 이용
									 position: coords, 
									 clickable: true 
									}); 
								// group 마커를 지도에 표시합니다. 
								markerList.push(marker);	// list에 마커 push
								marker.setMap(map); 
								// 인포윈도우를 생성합니다 
								var infowindow = new kakao.maps.InfoWindow({ 
									content: '<div style="width:150px;text-align:center;padding:6px;">' + list.userName + '</div>', 
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
				console.log("groupListProc error: " + JSON.stringify(error));
			});
		}
	},

	// 노인,아이,장애인, 기타 클릭시 
	searchAndMark: function(clientType) {	
		currRequestList = [];	// currRequestList 초기화
		
		defaultRequestList.forEach(function(list, index){
			if(list.clientType == clientType) currRequestList.push(list);
		});
		
		// 눌린버튼이 '이웃' 1개일때, 마커 찍기 
		if(selectedCnt == 1 && selectedBtnNum1 != 0) mapInit.setMarker(currRequestList);
		
	},
	
	// 돕고 싶은 재화(물품, 재정, 서비스,기타) 선택시 마커 걸러내는 함수 (currReqeustList안에서 거른다)
	searchAndMark2: function(requestType){
		var validRequestList = [];	// 해당 requestType이 존재하는 valid한 request ID list
		currRequestList.forEach(function(list, index){	// currRequestList
			list.requestItem.forEach(function(list2,index2){	//request에 종속된 requestItem 리스트
				if(requestType == list2.requestType) {
					if(validRequestList[validRequestList.length-1] != list) {
						validRequestList.push(list);
						return false;	// break;
					}
				}
			});
		})
		// 해당하는 마커들을 List에 넣은 후, setMarker()를 이용해 맵에 뿌리기
		// 이웃, 재화가 함께 눌리거나, 재화만 눌려있을 경우
		if(selectedBtnNum2 != 0) mapInit.setMarker(validRequestList);
		
	},
	
	// requestList를 받아서 해당하는 marker를 Map에 뿌려주는 함수
	setMarker: function(InputRequestList) {	
		mapInit.mapClean();		// map 객체 초기화
		InputRequestList.forEach(function(list, index) { 
			geocoder.addressSearch(list.requestAddress, function(result, status) { 
				var tempMarkerImage; // ClientType에 따라서 imageSrc 정하기
				if (status === daum.maps.services.Status.OK) {
					var coords = new daum.maps.LatLng(result[0].y, result[0].x); 
					if(list.clientType == 'ELDERLY') tempMarkerImage = markerImage2;	// 노인
					else if(list.clientType == 'CHILD') tempMarkerImage = markerImage3;
					else if(list.clientType == 'DISABLED') tempMarkerImage = markerImage4;
				    else if(list.clientType == 'OTHERS') tempMarkerImage = markerImage5	// 기타
					 var marker = new daum.maps.Marker({ 
						 title: list.id,
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
							content: '<div style="width:150px;text-align:center;padding:6px 0;">' + list.title + '</div>', 
							removable : true
						 }); 
						 	 infowindowList.push(infowindow);	// infowindow list에 push 
					}
											
					 kakao.maps.event.addListener(marker, 'click', function() {
						map.setCenter(coords);	// 클릭 위치로 이동
						mapInit.fillMarkerInfo(list);	// marker info 채우는 함수
						// 상세보기 배너 띄우기 (이미 띄워져 있으면 없애는 기능)
						if($("#marker-info-container").css('display') == 'block') {
							$("#marker-info-container").css('display', 'none');
						} else if($("#marker-info-container").css('display') == 'none') {
							$("#marker-info-container").css('display', 'block');
						}
						 // 검색코드에 나타내기
						 $("#marker-info-search-input").val(list.id);
				
						//자세히 보기 클릭시
						$("#marker-info-btn").off("click");	// 기존 listner 삭제(중요)
						$("#marker-info-btn").on("click", () => {
							goDetail_request(list);
							$("#marker-info-container").css('display', 'none');	// 상세보기 배너 가리기
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
