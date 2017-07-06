<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 다음 주소 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- css파일 설정 : 경로를 바꿔주세요. -->
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/mypage.css?ver=1.4">
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/upForm.css?ver=1.1">

<title>마이페이지-정보수정</title>
</head>
<body>
	<div class="container">
		<div class="row profile">
			<div class="header">
				<b>${id }</b>님 마이페이지 입장<br>
				<div style="margin-top: 5px;">
				<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>&nbsp;&nbsp;|&nbsp;&nbsp;
				<kbd><a href="/index"><font color="white">메인페이지</font></a></kbd>
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
						<button type="button" class="btn btn-default">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
							<font size=2>사진 수정</font>
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
							<li class="active"><a href="mypageEdit"><i class="glyphicon glyphicon-edit"></i> 정보수정</a></li>
							<li><a href="favorite"> <i class="glyphicon glyphicon-heart"></i> 즐겨찾기</a></li>
							<li><a href="del"> <i class="glyphicon glyphicon-remove"></i> 탈퇴</a></li>
						</ul>
					</div>
					<!-- END MENU -->
				</div>
			</div>
			<div class="col-md-9">

				<form class="mypageUp" id="frm"
					action="/mypageEdit" method="post">
					<div class="profile-content">
						<h3><b>정보수정</b></h3>
						<br> <label style="width: 100"><b>아이디<font
								color=red>*</font></b></label> <input type="text" class="form-control"
							name="id" value="${mypage.id}" readonly> <br> <br>
						<!-- 비번 -->
						<label style="width: 100"><b>비밀번호<font color=red>*</font></b></label>
						<input type="password" class="form-control" name="password"
							placeholder="비밀번호" required style="width: 200;"> &nbsp; &nbsp; * 숫자 영문 조합 6~15자 <br>
						<br>
						<!-- 비번확인 -->
						<label style="width: 100"><b>비밀번호 확인<font color=red>*</font></b></label>
						<input type="password" class="form-control" name="repass"
							placeholder="비밀번호 확인" required> <br> <br>
						<!-- 이름 -->
						<label style="width: 100"><b>이름<font color=red>*</font></b></label>
						<input type="text" class="form-control" name="name"
							value="${mypage.name}" required readonly>&nbsp;&nbsp;
						<!-- 닉네임 -->
						<label style="width: 50"><b>닉네임<font color=red>*</font></b></label>
						<input type="text" class="form-control" name="nickname"
							value="${mypage.nickname}" required
							autocomplete="off">&nbsp;&nbsp; <br> <br>
						<!-- 생년월일 -->
						<label style="width: 100"><b>생년월일</b></label> <input type="text"
							class="form-control" name="birth"
							style="width: 200px; display: inline" value="${mypage.birth}"
							readonly> <br> <br>
						<!-- 이메일 -->
						<label style="width: 100"><b>이메일<font color=red>*</font></b></label>
						<input type="text" class="form-control" name="email"
							value="${mypage.email}" required
							style="width: 200px; display: inline">&nbsp;&nbsp;
						<!-- 폰번호 -->
						<label style="width: 80"><b>핸드폰 번호<font color=red>*</font></b></label>
						<input type="text" class="form-control" name="tel1" maxlength="3"
							size="5" style="width: 70px;" required autocomplete="off"
							onkeyup="movetoTel2()" value="${mypage.tel.split('-')[0] }"> - <input type="text"
							class="form-control" name="tel2" maxlength="4" size="5"
							style="width: 75px;" required autocomplete="off"
							onkeyup="movetoTel3()" value="${mypage.tel.split('-')[1] }"> - <input type="text"
							class="form-control" name="tel3" maxlength="4" size="5"
							style="width: 75px;" required autocomplete="off" value="${mypage.tel.split('-')[2] }"> <br>
						<br>
						<!-- 주소 -->
						 <label style="width: 100"><b>우편번호<font color=red>*</font></b></label>
		    			<input type="text" class="form-control" name="postcode"id="postcode" placeholder="우편번호" value="${mypage.addr.split('%')[2] }" required readonly>
           				<input type="button" class="btn btn-warning" onclick="execDaumPostcode()" value="우편번호 찾기"><br><br>
            			<label style="width: 100"><b>주소<font color=red>*</font></b></label>
            			<input type="text" class="form-control" name="roadAddress" id="address" placeholder="주소" value="${mypage.addr.split('%')[0] }" style="width: 300px;" required readonly>
            			<input type="text" class="form-control" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${mypage.addr.split('%')[1] }" style="width: 200px;" required readonly>
            			<br><br>
						<!-- 보안질문 -->
						<label style="width: 100"><b>보안질문<font color=red>*</font></b></label>
						<select class="form-control" name="secure"
							style="width: 200px; display: inline;">

							<c:forEach var="i" items="${slist}">
								<c:choose>
									<c:when test="${i.code eq mypage.secure }">
										<option selected="selected">${i.code }</option>
									</c:when>
									<c:otherwise>
										<option>${i.code }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>

						</select>&nbsp;&nbsp; 
						<label style="width: 65"><b>보안 답<font color=red>*</font></b></label> 
						<input type="text" class="form-control" name="secure_ans" value="${mypage.secure_ans}" maxlength="20" size=20 required autocomplete="off"> <br> <br>
						<br> 
						
						<p align="center">기존의 비밀번호를 입력하면 정보수정이 완료됩니다<p>
						<div class="row" style="text-align: center">
						<label style="width: 100"><b>기존 비밀번호<font color=red>*</font></b></label> 
						<input type="password" class="form-control" name="expass" maxlength="20" size=20>
						<br>
						<div class="result" style="text-align: center"></div>
						<br>
						<div style="text-align: center">
							<input type="button" class="btn btn-success" name="up-btn" value="수정">
						</div>
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	
	$(function(){		
		
		var result = '${msg}';

		if (result == 'SUCCESS') {
			alert("정보수정이 완료되었습니다.");
		}

		$('[name=up-btn]').click(function(){
			
			var pass1 = $('[name=password]').val();
			var pass2 = $('[name=repass]').val();
			var email = $('[name=email]').val();
			var tel1 = $('[name=tel1]').val();
			var tel2 = $('[name=tel2]').val();
			var tel3 = $('[name=tel3]').val();			
			
			var emailExp = /^[a-zA-Z0-9]{3,15}@[a-zA-Z]+\.[a-zA-Z]+$/g;
	        var passExp = /^[a-zA-Z0-9]{5,15}$/g;
			
			var pass = $('[name=expass]').val();
			
			if(pass1.length == 0 || pass2.length == 0){
				alert('비밀번호를 입력하세요.')
			} 
			else if(!passExp.test(pass1)){
				
		    	alert('비밀번호 형식이 일치하지 않습니다.')
		    	
		    }else if(pass1 != pass2){
				alert('비밀번호가 일치하지 않습니다');
				$('[name=password]').focus();
			} else if(pass1.indexOf(" ")> -1 || pass1.indexOf("\t")>=0 ||pass1.indexOf("\n")>-1 ||
					pass2.indexOf(" ")> -1 || pass2.indexOf("\t")>=0 ||pass2.indexOf("\n")>-1){
		           alert('비밀번호는 공백이 포함될 수 없습니다');       
		           $('[name=password]').focus();
		    } else if(tel1.indexOf(" ")> -1 || tel1.indexOf("\t")>=0 || tel1.indexOf("\n")>-1){
		           alert('전화번호 입력 첫째칸에 공백이 있습니다');
		           $('[name=tel1]').focus();
		    } else if(tel2.indexOf(" ")> -1 || tel2.indexOf("\t")>=0 || tel2.indexOf("\n")>-1){
		           alert('전화번호 입력 두번째칸에 공백이 있습니다');
		           $('[name=tel2]').focus();
		    } else if(tel3.indexOf(" ")> -1 || tel3.indexOf("\t")>=0 ||tel3.indexOf("\n")>-1){
		           alert('전화번호 입력 셋째칸에 공백이 있습니다');
		           $('[name=tel3]').focus();
		    } else if(email.indexOf(" ")> -1 ||email.indexOf("\t")>=0 ||email.indexOf("\n")>-1){
		           alert('이메일 입력칸에 공백이 있습니다');
		           $('[name=email]').focus();
		    } else if(!emailExp.test(email)){
		    	alert('이메일 형식이 어긋납니다.')
		    	
		    } else if(!(tel1.match("[0-9]{3}")) || !(tel2.match("[0-9]{3,4}")) || !(tel3.match("[0-9]{4}"))){
		           alert('전화번호 형식이 옳지 않습니다.');
		           $('[name=tel1]').focus();
		           
		    } else if(!passExp.test(pass)){
		    	$('.result').html('<br><font color=red>비밀번호 형식이 어긋납니다</font>')
		    	
		    } else {
		    	
				$.ajax({
					url:'/alter/'+pass,
					success:function(result){
						
							$('#frm').submit();
						
					},
					error:function(result){
						$('.result').html('<br><font color=red>기존 비밀번호와 일치하지 않습니다.</font>')
					}
			});

		    }

		});
	
	});
	
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            $('#detailAddress').val('');
            document.getElementById('detailAddress').focus();
        }
    }).open();
}
	
</script>

</html>