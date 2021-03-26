
function goNews(newsType) {
	$("#newsType").val(newsType);
	$("#newsForm").submit();	
}

function newDetail(newsId) {
	location.href="/news/newsDetail/"+newsId;
}

// 소식 목록 구성을 위해 사용.
function news_upload(type, id) {
	if(type == 1) {
		newsInit.uploadNews();		
	} else if(type == 2) {
		newsInit.updateNews(id);
	}
}

function news_delete(id) {
	if(confirm("정말 삭제하시겠습니까?") == true){
		newsInit.deleteNews(id);
    }
    else{
        return;
 	}
} 

let newsInit = {
	init: function() {
		
	},
	
	uploadNews:function() {
		if($("#news-title").val() == "") {
			alert("제목을 입력해주세요.");	
		} else if($("#news-content").val() == "") {
			alert("내용을 입력해주세요.");
		} else if(!$("#news-content").val().includes('<img')) {
			alert("대표 이미지가 필요합니다. 이미지를 하나 이상 입력해주세요.");	
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
				url: "/admin/newsSaveProc",
				data: JSON.stringify(data),
				contentType: "application/json; charset = utf-8 ",
				dataType: "json"
			}).done(function(resp) {
				console.log(data);
				console.log(resp);
				if(resp.status == 500) {
					alert("업로드 실패");
				} else {
					alert("새로운 소식이 등록되었습니다.");
					location.href = "/news/newsList";
					
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});			
		}
	},
	
	updateNews:function(newsId) {
		if($("#news-title").val() == "") {
			alert("제목을 입력해주세요.");	
		} else if($("#news-content").val() == "") {
			alert("내용을 입력해주세요.");
		} else if(!$("#news-content").val().includes('<img src=')) {
			alert("대표 이미지가 필요합니다. 이미지를 하나 이상 입력해주세요.");	
		}
		else {
			var newsType = "NEIGHBOR";
			if ($("#news-type option:selected").text() == "두드림 소식") {
				var newsType = "DODREAM";
			}
			let data = {
				id : newsId,
				title : document.getElementById('news-title').value,
				content : document.getElementById('news-content').value,
				newsType : newsType
			};
			$.ajax({
				type:"POST",
				url: "/admin/newsUpdateProc",
				data: JSON.stringify(data),
				contentType: "application/json; charset = utf-8 ",
				dataType: "json"
			}).done(function(resp) {
				console.log(data);
				console.log(resp);
				if(resp.status == 500) {
					alert("수정 실패");
				} else {
					alert("소식이 수정되었습니다.");
					location.href = "/news/newsList";
				}
			}).fail(function(error) {
				console.log(JSON.stringify(error));
			});			
		}
		
	},
	
	deleteNews:function(newsId) {
				
		$.ajax({
			type:"POST",
			url: "/admin/newsDeleteProc",
			data: {"newsId": newsId},
		}).done(function(resp) {
			if(resp.status == 500) {
				alert("삭제 실패");
			} else {
				alert("소식이 삭제되었습니다.");
				location.href = "/news/newsList";
			}
		}).fail(function(error) {
			console.log(JSON.stringify(error));
		});				
	}	
	
}