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

<style type="text/css">
	th {
		text-align: center;
	}
</style>
<script>
$(document).on("click",".pagination li a", function(event){
	event.preventDefault(); 
	var targetPage = $(this).attr("href");
	var paging = $("#paging");
	paging.find("[name='page']").val(targetPage);
	paging.attr("action","/myContents").attr("method", "get");
	paging.submit();
});
function readPage(tbno){
    var w = screen.width - 300;
    var h = screen.height - 200;
    var left = (screen.width / 2) - (w / 2);
    var top = (screen.height / 2) - (h / 2) - 50;
    window.open("/CommonRead?tbno=" + tbno, tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
}
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
						<img src="http://goo.gl/5SYWQ9" class="img-responsive" alt="기존사진"><br>
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
	            <div class="col-sm-12">
		            <h3><b>나의 글!</b></h3>
		        </div>
	            <c:if test="${myboardList.size() < 1 }">
	            <div style="text-align: center; margin-top: 25%;">
	            	<h4><i>게시글이 존재하지 않습니다. 글을 남겨보세요!</i></h4>
	            </div>
	            </c:if>
	            <c:if test="${myboardList.size() > 0 }">
	            <div class="col-sm-12" style="text-align: right; margin-bottom: 10px;">
	            	* 게시판의 활성화를 위해 모든 관심 게시글은 등록일로부터 15일 경과후 삭제됩니다.
	            </div>
	            <table class="table">
					<tr>
						<th>종류</th>
						<th>게시글 제목</th>
						<th>분류1</th>
						<th>분류2</th>
						<th>조회수</th>
						<th>좋아요</th>
						<th>등록일</th>
						<th>유지일(일)</th>
					</tr>	
					<c:forEach items="${myboardList }" var="myboard">
						<tr style="text-align: center">
							<td>${myboard.tb_kind == 1 ? '관심' : '<font color=red>후기</font>' }</td>
							<td><a style="cursor: pointer;" onclick="readPage(${myboard.tbno})">${myboard.title }</a></td>
							<td>${myboard.cname}</td>
							<td>${myboard.csname }</td>
							<td>${myboard.viewcnt }</td>
							<td>${myboard.likes }</td>
							<td>${myboard.regdate }</td>
							<td style="color : ${myboard.tb_kind == 1 ? (myboard.ddate <=5 ? 'red' : 'green') : 'N/A'};">
							${myboard.tb_kind == 1 ? myboard.ddate : 'N/A'}
							</td>
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
	            </c:if>
	            </div>
			</div>
		</div>
	</div>
</body>
</html>