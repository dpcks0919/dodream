$(document).ready(function() {
			$('.summernote').summernote({
				height : 350, // 에디터 높이
				minHeight : null, // 최소 높이
				maxHeight : null, // 최대 높이		
				focus : false, // 에디터 로딩후 포커스를 맞출지 여부
				lang : "ko-KR", // 한글 설정
				placeholder : '내용을 입력하여 주세요.', //placeholder 설정
				callbacks: {	//여기 부분이 이미지를 첨부하는 부분
					onImageUpload : function(files) {
						uploadSummernoteImageFile(files[0],this);
					},
					onPaste: function (e) {
						var clipboardData = e.originalEvent.clipboardData;
						if (clipboardData && clipboardData.items && clipboardData.items.length) {
							var item = clipboardData.items[0];
							if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
								e.preventDefault();
							}
						}
					}
				}
			});
			$("div.note-editable").on('drop',function(e){
		         for(i=0; i< e.originalEvent.dataTransfer.files.length; i++){
		         	uploadSummernoteImageFile(e.originalEvent.dataTransfer.files[i],$("#summernote")[0]);
		         }
		        e.preventDefault();
		   });
		});

function uploadSummernoteImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : "/uploadSummernoteImageFile",
				contentType : false,
				processData : false,
				success : function(data) {
					if( data.responseCode == "success" ){
						//항상 업로드된 파일의 url이 있어야 한다.		
						$(editor).summernote('insertImage', data.url);							
					}else{
						alert("이미지 업로드 실패");
					}	
				}
			});
		}