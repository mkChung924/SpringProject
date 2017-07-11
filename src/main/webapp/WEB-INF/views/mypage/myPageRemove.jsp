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
<script type="text/javascript">
	
	$(function(){
				
		$('#delBtn').click(function(){
			
			var pass = $('[name=password]').val();
			if(pass.trim().length > 5){
				
				$('.result').html('');
				
				$.ajax({
						url:'/tal',
						data: 'pass='+pass,
						success:function(result){
							
							if(confirm('정말 삭제하시겠습니까?') == true){
								$('#frm').submit();
							} else {
								return;
							}
							
						},
						error:function(result){
							$('.result').html('<br><font color=red>비밀번호가 일치하지 않습니다.</font>');
						}
					
				});
				
			} else if(pass.trim().lenth == 0){
				alert('비밀번호를 입력하세요.');
			} else {
				$('.result').html('<br><font color=red>비밀번호는 최소 6글자 입니다.</font>');
			}
			
		});
	
	});
	
</script>
<title>마이페이지-탈퇴</title>
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
						<div class="profile-usertitle-name">
							${mypage.name}
						</div>
						<div class="profile-usertitle-job">
							${mypage.nickname}
						</div>
					</div>
					<!-- END SIDEBAR USER TITLE -->
					<!-- SIDEBAR BUTTONS -->

					<!-- END SIDEBAR BUTTONS -->
					<!-- SIDEBAR MENU -->
					<div class="profile-usermenu">
						<!-- mypage/ -->
						<ul class="nav">
							<li>
								<a href="mypage">
								<i class="glyphicon glyphicon-user"></i>
								내 정보 </a>
							</li>
							<li>
								<a href="myContents">
								<i class="glyphicon glyphicon-list"></i>
								내 글보기 </a>
							</li>
							<li><a href="message"> <i class="glyphicon glyphicon-envelope"></i> 메시지함</a></li>
							<li><a href="mypageEdit"><i class="glyphicon glyphicon-edit"></i> 정보수정</a></li>
							<li><a href="favorite"> <i class="glyphicon glyphicon-heart"></i> 즐겨찾기</a></li>
							<li class="active"><a href="del"> <i class="glyphicon glyphicon-remove"></i> 탈퇴</a></li>
						</ul>
					</div>
					<!-- END MENU -->
				</div>
			</div>
			<div class="col-md-9">
	            <div class="profile-content">
	           		 <!-- 이곳에 html을 작성하면 됩니다! -->
	           		
           			<h3><b>회원탈퇴</b></h3>
           			<br>
           			[ 유의사항 ]<br><br>
           			<ul>
           			<li>탈퇴시 회원님의 모든 개인정보는 삭제됩니다.</li>
           			<li>작성하신 여행후기는 탈퇴 이후에도 관리자에 의해 사용될 수 있습니다.</li>
           			</ul>
           			<br><br>
           			<div class="row" style="text-align: center">
	           			<h4>계정을 삭제하려면 비밀번호를 입력하세요</h4>
	           			<br>
		           		<form role="form" action="/del" method="POST" id="frm"></form>
						<input type="password" class="form-control" placeholder="비밀번호 입력" name="password" style="display: inline; width: 200px;">
						<p class="result"></p>
						<br>
						<input class="btn btn-danger" id="delBtn" type="button" value="계정 삭제" >	
           			</div>
	            			
	            </div>
			</div>
		</div>
	</div>
</body>

</html>