<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
<script src="/resources/js/jquery3.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

$(function(){
	$('#senderRemove').click(function(){
	document.getElementsByName("senderRemove").submit();
	});

	$('#gobackto2').click(function(){
		location.href="mailBox?page="+${page};
	});
});
</script>
<style type="text/css">
	body{
		font-family: "fontello";
	}
</style>
</head>
<body>
<center>
수신자
${messages.targetid}<br>
제목
${messages.title}<br>
<textarea rows="25" cols="50">${messages.content}</textarea>

<form action="sendRemove" method="post" name="senderRemove">
<button id="senderRemove">&#xf083</button>
<a href="#" id="gobackto2"><i class="glyphicon glyphicon-arrow-left">돌아가기</i></a>

<input type="hidden" name="mno" value="${messages.mno }">
<input type="hidden" name="page" value="${page }">
</form>
</center>
</body>
</html>