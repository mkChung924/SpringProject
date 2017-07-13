<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- css파일 설정 : 경로를 바꿔주세요. -->
<link rel="stylesheet" type="text/css" href="/resources/css/admin/admin.css?ver=1.6">
<script type="text/javascript" src="/resources/js/profileUpload.js"></script>
<title>관리자페이지</title>
</head>
<body>
	<div class="container">
	    <div class="row profile">
	    <div class="header">
				<b>[ ${nick } ]</b> <kbd style="background-color: red"><a href="/admin"><font color="white">관리자</font></a></kbd>
				<div style="margin-top: 5px;">
				<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>&nbsp;&nbsp;|&nbsp;&nbsp;
				<kbd><a href="/index"><font color="white">메인페이지</font></a></kbd>
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
	            <h3><b>내 계정 정보</b></h3>
	            </div>
	            <br><br><br><br>
	            
					<table class="table">
						<tr>
						<th>등급</th>
						<th>아이디</th>
						<th>가입날짜</th>
						<th>게시글 수</th>
						<th>댓글 수</th>
						</tr>
						<tr>
						<td>${admin.auth == 2 ? '<font color=red>관리자</font>' : '<font color=blue>일반회원</font>' }</td>
						<td>${admin.id }</td>
						<td>${admin.regdate }</td>
						<td>${admin.myBoards }</td>
						<td>${admin.replyCount }</td>
						</tr>
					</table>

					<br>
					<b>계정상태 : </b> <font color=green>양호</font>
					
	            </div>
			</div>
		</div>
	</div>
</body>
</html>