function menuToggle(num) {
	$(".intro1").hide();
	$(".intro2").hide();
	$(".intro3").hide();
	$(".intro4").hide();
	
	$(".intro"+num).show();
	if(num == 2) {
		var x1 = 120;
		var x2 = 1032910;
		var x3 = 85;
		
		  $({ val : 0 }).animate({ val : x1 }, {
		   duration: 4000,
		  step: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#x1").text("+ "+num + " 건");
		  },
		  complete: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#x1").text("+ "+num+" 건");
		  }
		});
		  $({ val : 0 }).animate({ val : x2 }, {
		   duration: 3000,
		  step: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#x2").text("+ "+num + " 원");
		  },
		  complete: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#x2").text("+ "+num+" 원");
		  }
		});
		  $({ val : 0 }).animate({ val : x3 }, {
		   duration: 4000,
		  step: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#x3").text(num + "%");
		  },
		  complete: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#x3").text(num + "%");
		  }
		});
		
	} else if(num == 4) {
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		map = new kakao.maps.Map(mapContainer, mapOption); 
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

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}