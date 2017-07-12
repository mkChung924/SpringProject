
	$(document).on("click","#modifyProfilePicture",function(){
		var fileName = $("#fileopen").trigger('click',function(){
		});
	});
	
	$(document).on("change","#fileopen",function(){
		
		var formData = new FormData();
		 //첫번째 파일태그
		 formData.append("file",$("#fileopen")[0].files[0]);
	
		$.ajax({
			url : '/rest2/profile/image',
			data : formData,
			type : "POST",
			contentType: false,
			processData: false,
			success : function(result) {
				alert("프로필 변경");
				$("#profilePic").attr("src",result);			
			},
		});
	});