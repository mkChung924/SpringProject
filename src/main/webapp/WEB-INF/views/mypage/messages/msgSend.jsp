<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메시지 보내기</title>
<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/fontello.css?ver=1.1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery3.js"></script>
<script type="text/javascript">
	$(function() {


		$('#goback').click(function() {
			self.close();
		});
		$('#goback2').click(function() {
			self.close();
		});


		$('.sendr').click(function() {
			var targetid = $('[name=targetid]').val();
			var title = $('[name=title]').val();
			var content = $('[name=content]').val();
			
			if(targetid == '관리자'){
				targetid = 'wjdaudrb7';
			}
			
			if(targetid.trim().length == 0){
				alert('아이디를 입력하세요')
			}else if(title.trim().length == 0){
				alert('제목을 입력하세요')
			}else if(content.trim().length == 0){
				alert('내용을 입력하세요')
			} else if(targetid.indexOf(" ") > -1 || targetid.indexOf("\t") >= 0 || targetid.indexOf("\n") > -1){	
				alert('아이디에는 공백이 존재할 수 없습니다')	
			} else {
				
				var form = $('[name=send]')[0]
				var formData = new FormData(form);
				$.ajax({
					type : 'post',
					url : '/msgSend',
					data : 'targetid=' + targetid + '&title=' + title + '&content=' + content,
					/* data:formData, */
					success : function(result) {
						if (result == 'success') {
							opener.document.location.reload();
							self.close();
							alert('메시지를 전송하였습니다')
						}
					},
					error : function() {
						alert("error");
					}
				})
			}
		});
	});

</script>
<style type="text/css">
	body {
		font-family: "fontello";
	}
	
	.form-control{
			width: 300px;
		}
		
	.msg {
			padding: 30px;
		}
	b {
		cursor: pointer;
	}
</style>
</head>
<body>
	<div class="msg">
		<form method="post" name="send" action="/msgSend">
			<label>받는 사람</label>
			<input type="text" class="form-control" placeholder="수 신 자" name="targetid"value='${id == "wjdaudrb7" ? '관리자' : id}' readonly id="targetid">
			<br> 
			<label>제목</label>
			<input type="text" class="form-control" placeholder="제 목" name="title" required="required" autocomplete="off">
			<br>
			<label>내용</label>
			<textarea class="form-control" placeholder="내 용" rows="10" cols="25" name="content" required="required"></textarea>
			<br> 
			<div class="buttons" style="text-align: center">
			<b id="goback" class="glyphicon glyphicon-arrow-left"></b> <b id="goback2">닫기</b> &nbsp; &nbsp; &nbsp; &nbsp;
			<b class="sendr"><font color=green size="4">&#xe800 보내기</font></b>
			</div>
		</form>
	</div>
</body>
</html>