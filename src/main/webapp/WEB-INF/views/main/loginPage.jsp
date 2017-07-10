<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="/resources/css/main/loginPage.css">
<style type="text/css">
.loader {
    border: 16px solid #f3f3f3; /* Light grey */
    border-top: 16px solid #3498db; /* Blue */
    border-radius: 50%;
    width: 120px;
    height: 120px;
    animation: spin 2s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
</style>
<script type="text/javascript">


 		$(function(){
			
			var result = '${msg}';

			if (result == 'SUCCESS') {
				alert("회원가입이 완료되었습니다. 환영합니다.");
			}
			
			$('#login').click(function(){
				popup();
				setTimeout(login, 2000);
			});
			
			function login(){
				var id = $('[name=id]').val();
				var pass = $('[name=pass]').val();
				
				if(id.length==0){
					$('#loadingModal').css('display','none');
					$("#Fail").html('<br><font color=red>아이디를 입력하세요.</font>');
				} else if(pass.length == 0){
					$('#loadingModal').css('display','none');
					$("#Fail").html('<br><font color=red>비밀번호를 입력하세요.</font>');
				} else {
				
					$.ajax({
							url: "/loggingIn",
							cache: false,
							data: "id="+id+"&pass="+pass,
							success:function(result){
								if(result == 'SUCCESS'){
									
									//alert('success');
									$('#loadingModal').css('display','none');
									$("#frm").submit();
									
								} else {
									//alert('fail');
									$('#loadingModal').css('display','none');
									$("#Fail").html('<br><font color=red>아이디 또는 비밀번호를 확인하세요.</font>');
									$("[name=id]").val("");
									$("[name=pass]").val("");
									return;
								}
							}
							
					});//ajax
				}
			}	
			
			function popup(){
				$('#loadingModal').css('display','block');
			}

			
		});
			
			
</script>
<title>Log-In</title>
</head>
<body> 
	<br><br><br>
	<form id="frm" action="/login" method="post">
	  <div class="imgcontainer">
	    <img src="/resources/image/socialLife.png" alt="logo" class="logo">
	  </div>
	
	  <div class="loginform" align="center">
	    <div class="id"><b>ID</b></div><br>
	    <input type="text" class="form-control" placeholder="ID" name="id" pattern="[a-z0-9]{8,15}" title="아이디는 영문 소문자와 숫자로 조합된 8~15자입니다." required autocomplete="off"><br>
	    <div class="pass"><b>PASSWORD</b></div><br>
	    <input type="password" class="form-control" placeholder="PASSWORD" name="pass" required>
	    <div id="Fail"></div><br>
	    <button type="button" class="btn btn-success" id="login">Login</button><br><br>
	    
	 	   <b><a id="myBtn" style="cursor: pointer;">Sign-Up</a></b>&nbsp;&nbsp;&nbsp;
		   <b><a id="idBtn" style="cursor: pointer;">Forgot id?</a></b>&nbsp;&nbsp;&nbsp;
		   <b><a id="passBtn" style="cursor: pointer;">Forgot password?</a></b>
	
	  </div>
	</form>
	
<div id="loadingModal" class="modal">
		<div class="modal-body" style="margin-top: 20%; margin-left: 40%">
			<div class="loader"></div><br>
			<b>로그인 중...</b>
		</div>
</div>
	
	<%@ include file="join.jsp" %>
	<%@ include file="idFind.jsp" %>
	<%@ include file="passFind.jsp" %>
</body>
</html>