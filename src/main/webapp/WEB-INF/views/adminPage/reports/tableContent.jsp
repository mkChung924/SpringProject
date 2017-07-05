<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.2">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
<script src="/resources/js/jquery3.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 내용</title>
<script type="text/javascript">

$(function(){
	$('#report').click(function(){
	document.getElementsByName("tableContentReport").submit();
	});

	$('#gobackto2').click(function(){
		location.href="tableSelect";
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
글쓴이
${tablecontent.id}<br>
제목
${tablecontent.title}<br>

<textarea rows="25" cols="50">${tablecontent.content}</textarea>

<form action="tableReport" method="post" name="tableContentReport">
<button id="report" class="btn btn-warning">신고 &#xe801</button>
<a href="#" id="gobackto2"><i class="glyphicon glyphicon-arrow-left">돌아가기</i></a>

<input type="hidden" name="tbno" value="${tablecontent.tbno }">

</form>
</center>
</body>
</html>