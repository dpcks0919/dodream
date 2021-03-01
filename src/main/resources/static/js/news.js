
// 소식 목록 구성을 위해 사용.
function news_upload() {
	newsInit.uploadNews();
}

let newsInit = {
	init: function() {
		
	},
	
	uploadNews:function() {
		
		let data = {
			title : document.getElementById('news-title').value,
			content : document.getElementById('news-content').value
		};
		console.log(data);
		$.ajax({
			type:"POST",
			url: "/newsSaveProc",
			data: JSON.stringify(data),
			contentType: "application/json; charset = utf-8 ",
			dataType: "json"
		}).done(function(resp) {
			console.log(data);
			console.log(resp);
			if(resp.status == 500) {
				alert("업로드 실패");
			} else {
				alert("업로드 성공!");
				location.href = "/user/news/newsList";
				
			}
		}).fail(function(error) {
			alert(JSON.stringify(error));
		});
	}
}