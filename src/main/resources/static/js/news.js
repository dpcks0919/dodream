
function goNews(newsType) {
	$("#newsType").val(newsType);
	$("#newsForm").submit();	
}

function newDetail(newsId) {
	location.href="/user/news/newsDetail/"+newsId;
}

// 소식 목록 구성을 위해 사용.
function news_upload() {
	newsInit.uploadNews();
}

let newsInit = {
	init: function() {
		
	},
	
	uploadNews:function() {
		if($("#news-title").val() == "") {
			alert("제목을 입력해주세요.");	
		} else if($("#news-content").val() == "") {
			alert("내용을 입력해주세요.");
		} else if(!$("#news-content").val().includes('<img src=')) {
			alert("대표 이미지로 필요합니다. 이미지를 하나 이상 입력해주세요.");	
		}
		else {
			var newsType = "NEIGHBOR";
			if ($("#news-type option:selected").text() == "두드림 소식") {
				var newsType = "DODREAM";
			}
			let data = {
				title : document.getElementById('news-title').value,
				content : document.getElementById('news-content').value,
				newsType : newsType
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
				console.log(JSON.stringify(error));
			});			
		}
		
	}
}