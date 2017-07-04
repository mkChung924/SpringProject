<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
<script src="/resources/js/jquery3.js"></script>
<script type="text/javascript">
$(function(){
	
	
	$('#gobackto3').click(function(){
			location.href="mailBox?page=1";
	});
	
	$('.sendr').click(function(){
	
		$('[name=send]').submit();
	})
	
});

</script>
<style type="text/css">
	body{
		font-family: "fontello";
	}
a{
	margin-left: 20px;
	color : black;
	font-size: 15px;
}
</style>
</head>
<body>
<center>
<h1>MESSAGE</h1>
<hr>
<form method="post" name="send" action="/project/msgSend">
<input type="text" placeholder="수 신 자" name="targetid" width="150" height="50"><br><br>
<input type="text" placeholder="제 목" name="title" width="300" height="50"><br><br>

<textarea  placeholder="내 용" rows="15" cols="25" name="content"></textarea><br><br>
 <a href="#" class="sendr">보내기 &#xe800</a>
<a href="#" id="gobackto3"><i class="glyphicon glyphicon-arrow-left">돌아가기</i></a>
</form>



</center>
</body>
</html>