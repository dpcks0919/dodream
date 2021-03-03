function menuToggle(num) {
	$(".intro1").hide();
	$(".intro2").hide();
	$(".intro3").hide();
	$(".intro4").hide();
	
	$(".intro"+num).show();
	if(num==4) {
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(lati, longi); 
	
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
	
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	}
}