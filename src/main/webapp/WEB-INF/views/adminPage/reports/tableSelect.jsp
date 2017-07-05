<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<table>
<tr>
<th>글번호</th><th>작성자</th><th>제목</th><th>내용</th>
</tr>
<c:forEach items="${table}" var="ts">
<tr>
<td>${ts.tbno }</td>
<td>${ts.id }</td>
<td><a href="tableContent?tbno=${ts.tbno }">${ts.title }</a></td>
<td>${ts.content }</td>

</tr>
</c:forEach>
</table>
</body>
</html>