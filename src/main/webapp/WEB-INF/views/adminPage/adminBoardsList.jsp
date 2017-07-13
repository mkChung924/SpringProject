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

<title>관리자페이지</title>


<script>
		
	function showDetails(cno, count){
		if(count != 0){
			
		//alert(cno + "번 카테고리에 존재하는 게시글을 표시합니다");
		var w = screen.width - 200;
        var h = screen.height - 300;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2) - 80;
		window.open('/categoryDetail?cno='+cno, '카테고리 상세페이지','width='+ w +' height='+ h +' menubar=no status=no scrollbars=yes left='+ left +' top='+ top +' resizable=0')
		} else {
			alert("해당 카테고리에는 게시글이 존재하지 않습니다");
		}
	}


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

.boards:hover {
	background-color: #EAEAEA;
}

</style>

</head>
<body>
	<div class="container">
		<div class="row profile">
			<div class="header">
				<b>[ ${nick } ]</b>
				<kbd style="background-color: red">
					<a href="/admin"><font color="white">관리자</font></a>
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
							<img src="http://goo.gl/5SYWQ9"
								class="img-responsive" alt="기존사진" id="profilePic">
							<br>
						</c:if>
						<c:if test="${admin.profile != 'default.png' }">
							<img src="${admin.profile }" class="img-responsive" alt="프로필사진" id="profilePic">
							<br>
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
					<div class="col-sm-12">
	           			<h3><b>게시판 현황</b></h3>
	           			* 카테고리별 게시글의 수를 표시합니다.<br>&nbsp;&nbsp;
	            	</div>
	            	<br><br><br><br>
					<div class="row">
							<c:forEach items="${list}" var="list">
								<div class="col-md-4" style="padding-left:30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;">
									<div class="boards" style="border: 1px solid black; text-align: center; cursor: pointer;"
									 onclick="showDetails(${list.cno}, ${list.count })">
									<br>
									<h3>${list.cname}</h3>
									<br>
									<font color="#6799FF" size="6">${list.count }</font>
									<br><br><br>
									</div>
								</div>
							</c:forEach>
					</div>
				</div>
			</div>


		</div>
	</div>
</body>
</html>