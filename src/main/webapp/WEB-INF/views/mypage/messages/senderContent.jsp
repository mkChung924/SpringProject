<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
<script src="/resources/js/jquery3.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>보낸 메시지</title>
<script type="text/javascript">

$(function(){
	$('#senderRemove').click(function(){
		
		var mno = $('[name=mno]').val();
		var page = $('[name=page]').val();
		
		$.ajax({
				url:'sendRemove',
				data:'mno='+mno+'&page='+page,
				success:function(result){
					if(result == 'success'){
						opener.location.reload();
						self.close();
					}
					
				},
				error:function(result){
					alert('삭제중 에러가 발생하였습니다');
				}
		});

	});

	$('#goback').click(function(){
		self.close();
	});
	
	$('#goback2').click(function(){
		self.close();
	});
});
</script>
<style type="text/css">
	body{
		font-family: "fontello";
	}
	
	.form-control{
		width: 300px;
	}
	label{
		text-align: left;
	}
	.msg {
		padding: 30px;
	}
	b{
		cursor: pointer;
	}
</style>
</head>
<body>
<div class="msg">
	<label>받는 사람</label><br>
	<input type="text" class="form-control" value="${messages.targetid == 'wjdaudrb7' ? '관리자' : messages.targetid}" readonly="readonly">
	<br>
	<label>제목</label><br>
	<input type="text" class="form-control" value="${messages.title}" readonly="readonly">
	<br>
	<label>내용</label><br>
	<textarea class="form-control" rows="10" cols="50" readonly="readonly">${messages.content}</textarea>
	<br>
	<div class="buttons" style="text-align: center">
	<form action="sendRemove" method="post" name="remove" id="remove">
	
		<b id="goback" class="glyphicon glyphicon-arrow-left"></b> <b id="goback2">닫기</b> &nbsp; &nbsp; &nbsp; &nbsp;
		<b id="senderRemove"><font color=red size="4">&#xf083</font> 삭제</b> &nbsp; &nbsp; &nbsp; &nbsp;
	
	<input type="hidden" name="mno" value="${messages.mno }">
	<input type="hidden" name="page" value="${page }">
	</form>
	</div>
</div>
</body>
</html>