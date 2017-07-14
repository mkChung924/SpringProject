<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- css파일 설정 : 경로를 바꿔주세요. -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/admin/admin.css?ver=1.6">
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 프로필사진 업로드 -->
<script type="text/javascript" src="/resources/js/profileUpload.js"></script>
<!-- TinyMCE -->
<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>

<title>관리자페이지</title>

<script>
	tinymce.init({
		selector : '#editor', // change this value according to your HTML
		auto_focus : 'element1',
		toolbar : 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | imageupload',
		menubar : false,
		plugins : [
			'advlist autolink lists link image charmap print preview anchor',
			'searchreplace visualblocks code fullscreen',
			'insertdatetime media table contextmenu paste code'
		],
		setup : function(editor) {
			// create input and insert in the DOM
			var inp = $('<input id="tinymce-uploader" type="file" name="pic" accept="image/*" style="display:none">');
			$(editor.getElement()).parent().append(inp);

			// add the image upload button to the editor toolbar
			editor.addButton('imageupload', {
				text : '이미지',
				icon : 'image',
				onclick : function(e) { // when toolbar button is clicked, open file select modal

					inp.trigger('click');
				}
			});

			// when a file is selected, upload it to the server
			inp.on("change", function(e) {

				uploadFile($(this), editor);
			});
		}
	});
	function uploadFile(inp, editor) {
		var input = inp.get(0);
		var data = new FormData();
		data.append('files', input.files[0]);

		$.ajax({
			url : '/rest2/a/images',
			type : 'POST',
			data : data,
			enctype : 'multipart/form-data',
			dataType : 'json',
			processData : false, // Don't process the files
			contentType : false, // Set content type to false as jQuery will tell the server its a query string request
			success : function(data, textStatus, jqXHR) {
				editor.insertContent('<img class="content-img" src="${pageContext.request.contextPath}' + data.location + '" data-mce-src="${pageContext.request.contextPath}' + data.location
					+ '" alt=' + data.location + '/>');
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if (jqXHR.responseText) {
					errors = JSON.parse(jqXHR.responseText).errors
					alert('Error uploading image: ' + errors.join(", ") + '. Make sure the file is an image and has extension jpg/jpeg/png.');
				}
			}
		});
	}
</script>

<script>

	
	$(function(){		
		var str="";
		$.ajax({
			type : 'post',
			url : '/rest/selectSido',
			dateType : "json",
			success : function(result) {
				str="<option>지역 선택</option>";
				for(var i=0; i<result.length;i++){
					str+="<option>"+result[i].ds_sido+"</option>"
				}
				$("#place1").html(str);
			}
		});
		
		/* 카테고리2 변경시 그 값이 저장됨 */
		$('#place1').on("change",function(){
			var do1 = $("#place1").val();
			var str="";
			$.ajax({
				type : 'post',
				url : '/rest/selectGugun',
				dateType : "json",
				data : {ds_sido : do1}, 
				success : function(result) {
					str="<option>지역 선택</option>";
					for(var i=0; i<result.length;i++){
						str+="<option>"+result[i].ds_gugun+"</option>"
					}
					$("#place2").html(str);
				}
			});
		});
	})

</script>

<style type="text/css">
body {
	font-family: "fontello";
}

#button1 {
	color: white;
	display: inline-block;
	padding: 5px 10px;
	text-decoration: none;
	font-weight: bold;
	margin: 3px;
	background: #FF0000;
	border-radius: 10px;
	-moz-border-radius: 10px;
	-webkit-border-radius: 10px;
	box-shadow: 2px 2px 4px #999999;
	-moz-box-shadow: 2px 2px 4px #999999;
	-webkit-box-shadow: 2px 2px 4px #999999;
	background: linear-gradient(to bottom, #FF0000, #375094);
}

#button2 {
	color: white;
	display: inline-block;
	padding: 5px 10px;
	text-decoration: none;
	font-weight: bold;
	margin: 3px;
	background: #FF0000;
	border-radius: 10px;
	-moz-border-radius: 10px;
	-webkit-border-radius: 10px;
	box-shadow: 2px 2px 4px #999999;
	-moz-box-shadow: 2px 2px 4px #999999;
	-webkit-box-shadow: 2px 2px 4px #999999;
	background: linear-gradient(to bottom, #FF0000, #375094);
}
</style>

</head>
<body>
	<div class="container">
		<div class="row profile">
			<div class="header">
				<b>[ ${nick } ]</b>
				<kbd style="background-color: red">
					<a href="/admin"><font color="white"><b>관리자</b></font></a>
				</kbd>
				<div style="margin-top: 5px;">
					<kbd style="background-color: #EAEAEA">
						<a href="/logout"><font color="black">로그아웃</font></a></kbd>
					&nbsp;&nbsp;|&nbsp;&nbsp;
					<kbd>
						<a href="/index"><font color="white">메인페이지</font></a>
					</kbd>
				</div>
			</div>
			<div class="col-md-3">
				<div class="profile-sidebar">
					<!-- SIDEBAR USERPIC -->
					<div class="profile-userpic">
						<c:if test="${admin.profile == 'default.png' }">						
						<img src="http://goo.gl/5SYWQ9" class="img-responsive" alt="기존사진" id="profilePic"><br>
						</c:if>
						<c:if test="${admin.profile != 'default.png' }">
						<img src="${admin.profile }" class="img-responsive" alt="프로필사진" id="profilePic"><br>
						</c:if>
						<button type="button" class="btn btn-default" id="modifyProfilePicture">
  							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> <font size=2>사진 수정</font>
						</button>
						<input type="file" style="display: none;" id="fileopen">	
					</div>
					<!-- END SIDEBAR USERPIC -->
					<!-- SIDEBAR USER TITLE -->
					<div class="profile-usertitle">
						<div class="profile-usertitle-name">${admin.name}</div>
						<div class="profile-usertitle-job">${admin.nickname}</div>
					</div>
					<!-- END SIDEBAR USER TITLE -->
					<!-- SIDEBAR BUTTONS -->

					<!-- END SIDEBAR BUTTONS -->
					<!-- SIDEBAR MENU -->
					<div class="profile-usermenu">
						<%@include file="adminNavList.jsp" %>
					</div>
					<!-- END MENU -->
				</div>
			</div>
			<div class="col-md-9">
				<div class="profile-content">
					<!-- 이곳에 html을 작성하면 됩니다! -->
					<div class="col-sm-6">
	           	 	<h3><b>추천 여행정보 작성</b></h3>
	           	 	</div>
					<br><br><br><br>
					<div class="div1">
						<form class="form-horizontal" role="form" method="post" action="admin_regit" enctype="multipart/form-data"
							onsubmit="return checkNull()">
							<input type="hidden" value="${id}" id="id" name="id">
							<input name="tb_kind" value="0" type="hidden">
							<input type="hidden" value="1" id="cno" name="cno"> 
							
							<input type="text" class="form-control" id="title" name="title" placeholder="제목을 간략하게 입력해주세요." maxlength="50;" required>
							<br>
							<!-- 여행일 때만 보여줌 -->
								<select name="csno" required>
									<option value=1>맛집탐방</option>
									<option value=2>테마여행</option>
									<option value=3>자유여행</option>
								</select>
								<select id="place1" name="place1" required></select>
								<select id="place2" name="place2" required></select>
							<br><br>		
							<input type="text" class="form-control" id="notice" name="notice" placeholder="공지할 내용이 있다면 입력해주세요!" required="required">
							<br>
							<div class="form-group">
								<!-- <label for="name" class="col-sm-2 control-label" required>내용</label> -->
								<div class="col-sm-12">
									<textarea id="editor" name="content" rows="20"></textarea>
								</div>
							</div>
							<div class="buttons" style="text-align: center">
								<input id="submit" name="submit" type="submit" value="저장하기" class="btn btn-danger"> 
								<input id="cancel" name="cancel" type="reset" value="취소" class="btn btn-primary">
							</div>
						</form>
					</div>
				</div>
			</div>


		</div>
	</div>
</body>
</html>