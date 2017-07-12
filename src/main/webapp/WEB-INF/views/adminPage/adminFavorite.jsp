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
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/mypage.css?ver=1.4">
<script type="text/javascript" src="/resources/js/profileUpload.js"></script>
<script type="text/javascript">
	function read(tbno){
			var w = screen.width - 300;
	        var h = screen.height - 200;
	        var left = (screen.width / 2) - (w / 2);
	        var top = (screen.height / 2) - (h / 2) - 50;
	        window.open("/CommonRead?tbno=" + tbno, tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	}
</script>
<title>관리자페이지-즐겨찾기</title>
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
						<a href="/logout"><font color="black">로그아웃</font></a></kbd>&nbsp;&nbsp;|&nbsp;&nbsp;
					<kbd>
						<a href="/index"><font color="white">메인페이지</font></a>
					</kbd>
				</div>	
			</div>
			<div class="col-md-3">
				<div class="profile-sidebar">
					<!-- SIDEBAR USERPIC -->
					<div class="profile-userpic">
						<c:if test="${mypage.profile == 'default.png' }">						
						<img src="${mypage.profile }" class="img-responsive" alt="기존사진"><br>
						</c:if>
						<c:if test="${mypage.profile != 'default.png' }">
						<img src="${mypage.profile }" class="img-responsive" alt="프로필사진"><br>
						</c:if>
						<button type="button" class="btn btn-default" id="modifyProfilePicture">
  							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> <font size=2>사진 수정</font>
						</button>
						<input type="file" style="display: none;" id="fileopen">
					</div>
					<!-- END SIDEBAR USERPIC -->
					<!-- SIDEBAR USER TITLE -->
					<div class="profile-usertitle">
						<div class="profile-usertitle-name">${mypage.name}</div>
						<div class="profile-usertitle-job">${mypage.nickname}</div>
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
		            <h3><b>즐겨찾기</b></h3>
		        </div>
	            <br>
	            <c:if test="${bookmark.size() < 1 }">
	            	<div style="text-align: center; margin-top: 12%;">
	            	<h4><i>즐겨찾기에 추가된 게시글이 없습니다.</i></h4>
	            	</div>
	            </c:if>
	            <c:if test="${bookmark.size() > 0 }">
	            <div style="text-align: right; padding: 10px; font-size: 18px;">
	            총 [<b>${bookmark.size() }</b>] 건
	            </div>
	            <table class="table">
					<tr>
					<th>제목</th>					
					<th>카테고리</th>
					<th>닉네임</th>
					<th>좋아요</th>
					<th>조회수</th>
					<th>게시날짜</th>
					</tr>
					 <c:forEach items="${bookmark }" var="bookmark">
					 	<input type="hidden" value=${bookmark.tbno }>
						<tr>
						<td><a onclick="read(${bookmark.tbno})" style="cursor: pointer;">${bookmark.title }</a></td>
						<td>${bookmark.cname }[${bookmark.csname }]</td>
						<td>${bookmark.nickname }</td>
						<td>${bookmark.likes }</td>
						<td>${bookmark.viewcnt }</td>
						<td>${bookmark.regdate }</td>
						</tr>
					</c:forEach>
				</table>
	            </c:if>
	            </div>
			</div>
		</div>
	</div>
</body>
</html>