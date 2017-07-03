<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- TinyMCE -->
<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
 <script>
 tinymce.init({
	  selector: '#editor',
	  height: 500,
	  readonly: true,
	  menubar: false,
	  toolbar: false
	});
 </script>
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1>관심 페이지 이미지로~~</h1>
		<div class="row">
			<div class="col-sm-6" style="background-color: yellow;"> <!-- 왼쪽 div -->
				<input type="text" class="form-control" id="title" value="${commonBoard.title}" placeholder="제목 입력란" readonly>
				<br>
				<input type="text" class="form-control" id="title" value="${commonBoard.notice}" placeholder="공지 사항" readonly>
				<br>
				<textarea id="editor" name="content" readonly="readonly" style="width: 100%;">${commonBoard.content}</textarea>
			</div>
			
			<div class="col-sm-6" style="background-color: pink;"> <!-- 오른쪽 div -->
				<label>OpenChat</label>	
				<input type="text" class="form-control" id="title" value="${commonBoard.openchat}" placeholder="작성자" readonly>
				<br>
				<label>전화 번호</label>
				<div>
					<c:set var="telParts" value="${fn:split(commonBoard.tel, '-')}" />
					<input class="form-control" id="inputPhone" maxlength="4" name="phone1" required="required" size="3" type="tel" value="${telParts[0]}" style="width: 25%; display: inline" readonly>-
					<input class="form-control" id="inputPhone" maxlength="4" name="phone2" required="required" size="3" type="tel" value="${telParts[1]}" style="width: 25%; display: inline" readonly>-
					<input class="form-control" id="inputPhone" maxlength="4" name="phone3" required="required" size="3" type="tel" value="${telParts[2]}" style="width: 25%; display: inline" readonly>
        		</div>
        		<br>
        		<div>
					<input type="text" class="form-control" id="reply" placeholder="댓글 입력"  style="width: 75%; display: inline">
					<input type="button" class="btn btn-success" value="입력">
				</div>
				<hr>
				나머지는 댓글
			</div>
		</div>
	</div>
</body>
</html>