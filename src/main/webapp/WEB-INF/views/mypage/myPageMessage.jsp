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
<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/fontello.css?ver=1.1">
<script type="text/javascript">

     $(function(){//HTML문서가 브라우저 출력되었을때

	form = document.removeCheck;
    	 if(${msg != "send"}){
    		 $.ajax({
     			url:"receiveMailBox",
     			data: "page="+${page},
     			success:function(result){
 					  $('#div1').html(result);
 					   $('#div2').css('display','none')
 					  $('#div1').css('display','block')
 					  
 				  }
     		 });
    	 }
    	 
    	$('#button1').click(function(){
    		 $.ajax({
    			url:"receiveMailBox",
    			data: "page=1",
    			success:function(result){
					 /*  $('#div1').html(result);
					   $('#div2').css('display','none')
					  $('#div1').css('display','block') */
    				location.href="message?page=1";
				  }
    		 });
    	});//click
    	
     if(${msg == "send"} ){
		 $.ajax({
			url:"sendMailBox",
			data: "page="+${page},
			success:function(result){
				  $('#div2').html(result);
				   $('#div1').css('display','none')
				  $('#div2').css('display','block')
			  }
		 });
     }
    	$('#button2').click(function(){
    		 $.ajax({
    			url:"sendMailBox",
    			data: "page=1",
    			success:function(result){
					  /* $('#div2').html(result);
					   $('#div1').css('display','none');
					  $('#div2').css('display','block'); */
					  location.href="message?page=1";
				  }
    		 });
    	});//click
     });//function
</script>
<style type="text/css">
	body{
		font-family: "fontello";
	}

	#button1{
        color: white;
        display: inline-block;
        padding: 5px 10px;
        text-decoration: none;
        font-weight: bold;
        margin: 3px;
        background: #000099;
        border-radius: 10px;
        -moz-border-radius: 10px;
        -webkit-border-radius: 10px;
        box-shadow: 2px 2px 4px #999999;
        -moz-box-shadow: 2px 2px 4px #999999;
        -webkit-box-shadow: 2px 2px 4px #999999;
        background: linear-gradient(to bottom, #000099, #375094);
	}
	#button2{
        color: white;
        display: inline-block;
        padding: 5px 10px;
        text-decoration: none;
        font-weight: bold;
        margin: 3px;
        background: #000099;
        border-radius: 10px;
        -moz-border-radius: 10px;
        -webkit-border-radius: 10px;
        box-shadow: 2px 2px 4px #999999;
        -moz-box-shadow: 2px 2px 4px #999999;
        -webkit-box-shadow: 2px 2px 4px #999999;
        background: linear-gradient(to bottom, #000099, #375094);
	}
</style>
<title>마이페이지-메시지함</title>
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
							<li>
								<a href="myContents">
								<i class="glyphicon glyphicon-list"></i>
								내 글보기 </a>
							</li>
							<li class="active">
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
	            	
	            	<div class="col-sm-6">
		            <h3><b>메시지함</b></h3>
		            </div>
		            <div class="col-sm-6" style="text-align: right; margin-top: 15px">
		           	<form name="removeCheck">
							<input type="button" id="button1" value="수신 메세지함"> &nbsp; 
							<input type="button" id="button2" value="발신 메세지함">
					</form>
		            </div>
		            <br><br>
					
					<div id="div1" style="display: none;"></div>
					<div id="div2" style="display: none;"></div>
					<form action="msgSend">
					</form>
					
					</div>
	            
				 
	            </div>
			</div>
		</div>
	</div>
</body>
</html>