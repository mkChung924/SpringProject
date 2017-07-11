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
<script>
$(document).on("click",".pagination li a", function(event){
	event.preventDefault(); 
	var targetPage = $(this).attr("href");
	var paging = $("#paging");
	paging.find("[name='page']").val(targetPage);
	paging.attr("action","/myContents").attr("method", "get");
	paging.submit();
});
</script>
<title>마이페이지-내글보기</title>
</head>
<body>
	<div class="container">
	    <div class="row profile">
	    <div class="header">
				<b>[ ${nick } ]</b>님 마이페이지 입장<br>
				<div style="margin-top: 5px;">
				<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd> &nbsp;&nbsp;|&nbsp;&nbsp;
				<kbd><a href="/index"><font color="white">메인페이지</font></a></kbd>
				</div>			
			</div>
			<div class="col-md-3">
				<div class="profile-sidebar">
					<!-- SIDEBAR USERPIC -->
					<div class="profile-userpic">
						<c:if test="${mypage.profile == 'default.png' }">						
						<img src="/resources/upload/${mypage.profile }" class="img-responsive" alt="기존사진"><br>
						</c:if>
						<c:if test="${mypage.profile != 'default.png' }">
						<img src="${mypage.profile }" class="img-responsive" alt="프로필사진"><br>
						</c:if>
						<button type="button" class="btn btn-default">
  						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> <font size=2>사진 수정</font>
						</button>
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
						<ul class="nav">
							<li>
								<a href="mypage">
								<i class="glyphicon glyphicon-user"></i>
								내 정보 </a>
							</li>
							<li class="active">
								<a href="myContents">
								<i class="glyphicon glyphicon-list"></i>
								내 글보기 </a>
							</li>
							<li>
								<a href="message">
								<i class="glyphicon glyphicon-envelope"></i>
								메시지함 </a>
							</li>
							<li>
								<a href="mypageEdit">
								<i class="glyphicon glyphicon-edit"></i>
								정보수정 </a>
							</li>
							<li>
								<a href="favorite">
								<i class="glyphicon glyphicon-heart"></i>
								즐겨찾기 </a>
							</li>
							<li>
								<a href="del">
								<i class="glyphicon glyphicon-remove"></i>
								탈퇴 </a>
							</li>
						</ul>
					</div>
					<!-- END MENU -->
				</div>
			</div>
			<div class="col-md-9">
	            <div class="profile-content">
	            <!-- 이곳에 html을 작성하면 됩니다! -->
	            <table class="table">
					<tr>
						<th>게시물 번호</th>
						<th>제목</th>
						<th>지역1</th>
						<th>지역2</th>
						<th>조회수</th>
						<th>등록날짜</th>
					</tr>	
					<c:forEach items="${myboardList }" var="myboard">
						<tr>
							<td>${myboard.tbno }</td>
							<td>${myboard.title }</td>
							<td>${myboard.place1 }</td>
							<td>${myboard.place2 }</td>
							<td>${myboard.viewcnt }</td>
							<td>${myboard.regdate }</td>
						</tr>
					</c:forEach>
	            </table>
				
				<div class="div1" style="text-align: center">
					<c:if test="${pageMaker.prev}">
						<ul class="pagination">
							<li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
						</ul>
					</c:if>
					<ul class="pagination">
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
							<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
								<a href="${idx}">${idx}</a>
							</li>
						</c:forEach>
					</ul>
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<ul class="pagination">
							<li><a href="${pageMaker.endPage +1}">&raquo;</a></li>
						</ul>
					</c:if>		
				</div>
					
					<form id="paging">
						<input type='hidden' name="page" value=${pageMaker.cri.page }>
				 		<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
					</form>
	            </div>
			</div>
		</div>
	</div>
</body>
</html>