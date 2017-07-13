<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/join.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <h2>회원가입</h2>
    </div>
    <br>
    <form id="signUp" action="/signUp" method="post" enctype="multipart/form-data" onsubmit="return check()">
    <div class="modal-body">
   		<p align="left"><b><font size="5">1.이용약관</font></b></p>
		<textarea rows="4" style="min-width: 100%" readonly>개인정보를 수집합니다. 수집된 정보는 탈퇴할 때까지 보관되며 탈퇴시 모두 파기됩니다.</textarea><br>

    	<p align="right" style="padding-right: 20px;"><input type="checkbox" name="agree" value="agree" onclick="aaa(this)"> 내용을 읽었으며, 동의함</p><br>
    	<p align="left"><b><font size="5">2.정보입력</font></b></p>
    	<div class="memberinfo">
	    	<label style="width: 90"><b>아이디<font color=red>*</font></b></label>
		    <input type="text" class="form-control" name="id" placeholder="아이디" pattern="[a-z]{1}[a-zA-Z0-9]{5,20}" required readonly autocomplete="off" onclick="dupCheck()">
		    <input type="button" class="btn btn-info" id="idCheck" value="중복확인" onclick="dupCheck()"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <label style="width: 80"><b>프로필 사진</b></label>
        	<input type="file" class="form-control" name="profilePicture" style="width: 200px; display: inline"><br>
		   	
		   	<label style="width: 90"><b>비밀번호<font color=red>*</font></b></label>
		    <input type="password" class="form-control" name="password" pattern="[a-zA-Z0-9]{5,15}" placeholder="비밀번호" required>&nbsp;&nbsp;영문, 숫자 조합 5~15자
		    <br>
		    <label style="width: 90"><b>비밀번호 확인<font color=red>*</font></b></label>
		    <input type="password" class="form-control" name="repass" pattern="[a-zA-Z0-9]{5,15}" placeholder="비밀번호 확인" required><br>
		    
		    <label style="width: 90"><b>이름<font color=red>*</font></b></label>
		    <input type="text" class="form-control" name="name" placeholder="이름" pattern="[ㄱ-힣]{2,10}" required autocomplete="off">&nbsp;&nbsp;
		    
		    <label style="width: 50"><b>닉네임<font color=red>*</font></b></label>
		    <input type="text" class="form-control" name="nickname" placeholder="닉네임" pattern="[a-ZA-Zㄱ-힣]{3,20}" title="한글 영어 조합 3~20자" required autocomplete="off" onkeydown="nickCheck()">&nbsp;&nbsp;
		    <b class="nick"></b>
		    <br>
		    
        	<label style="width: 90"><b>생년월일</b></label>
        	<input type="date" class="form-control" name="birth" style="width: 200px; display: inline" min="1940-01-01"><br>
		    
		    <label style="width: 90"><b>이메일<font color=red>*</font></b></label>
		    <input type="email" class="form-control" name="email" placeholder="이메일" pattern="[a-zA-Z0-9]{3,15}@[a-zA-Z]+\.[a-zA-Z]+" required style="width: 200px; display: inline">&nbsp;&nbsp;
		    
		    <label style="width: 80"><b>핸드폰 번호<font color=red>*</font></b></label>
		    <input type="text" class="form-control" name="tel1" maxlength="3" size="5" style="width: 70px;" pattern="[0-9]{3}" required autocomplete="off" onkeyup="movetoTel2()"> -
            <input type="text" class="form-control" name="tel2" maxlength="4" size="5" style="width: 75px;" pattern="[0-9]{3,4}"required autocomplete="off" onkeyup="movetoTel3()"> -
            <input type="text" class="form-control" name="tel3" maxlength="4" size="5" style="width: 75px;" pattern="[0-9]{4}"required autocomplete="off"><br>
		    
		    <label style="width: 90"><b>우편번호<font color=red>*</font></b></label>
		    <input type="text" class="form-control" name="postcode"id="postcode" placeholder="우편번호" required readonly>
            <input type="button" class="btn btn-warning" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
            <label style="width: 90"><b>주소<font color=red>*</font></b></label>
            <input type="text" class="form-control" name="address" id="address" placeholder="주소" style="width: 300px;" required readonly>
            <input type="text" class="form-control" name="detailAddress" id="detailAddress" placeholder="상세주소" style="width: 200px; required readonly">
            
            <%
              String secure[] = { "==선택==", "당신의 고향은 어디신가요?", "가장 소중한 것은 무엇입니까?", "내가 졸업한 고등학교는?", "유년시절 나의 별명은?","아버지의 성함은?", "어머님의 성함은?",
                    "기타" };
          	%> 
          	<br><label style="width: 90"><b>보안질문<font color=red>*</font></b></label>
          	<select class="form-control" name="secure" style="width: 200px; display: inline;">
            <%
               for (int i = 0; i < secure.length; i++) {
            %>
            <option value="<%=secure[i]%>"><%=secure[i]%></option>
            <%
               }
            %>
        	</select>&nbsp;&nbsp;
        	<label style="width: 50"><b>보안 답<font color=red>*</font></b></label>
        	<input type="text" class="form-control" name="secure_ans" maxlength="20" size=20 required autocomplete="off"><br>
	    
    	</div>
    	<br>
    	<input type="submit" class="btn btn-success" value="회원가입">
    	
    </div>
    </form>
  </div>
  
</div>
<div>

</div>

<script>
	// Get the modal
	var modal = document.getElementById('myModal');
	
	// Get the button that opens the modal
	var btn = document.getElementById("myBtn");
	
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	
	// When the user clicks the button, open the modal 
	btn.onclick = function() {
	    modal.style.display = "block";
	}
	
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		if(confirm("회원가입을 취소하시겠습니까?") == true){
			
	    modal.style.display = "none";
		}
	}
	
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == modal) {
	    	if(confirm("회원가입을 취소하시겠습니까?") == true){
	    		
	    	    modal.style.display = "none";
	    		}
	    }
	}
	
	
	var checked = false;
	var nicknameChecked = false;

	//약관 동의 유무 확인 후 submit
	function check(){
		
		var id = $('.memberinfo [name=id]').val();
		var pass = $('[name=password]').val();
		var repass = $('[name=repass]').val();
		var secure = $('[name=secure]').val();
		var birth = $('[name=birth]').val();
		var postcode = $('[name=postcode]').val();
		var roadAddress = $('[name=roadAddress]').val();		
        var passExp = /^[a-z][a-zA-Z0-9]{5,15}$/g;
		
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();

		if(dd<10) {
		    dd = '0'+dd
		} 

		if(mm<10) {
		    mm = '0'+mm
		} 

		today = yyyy + '-' + mm + '-' + dd;
		
		
		if(checked == false){
			alert('약관에 동의하세요.');
		} else if(!nicknameChecked){
			alert('불가능한 닉네임 입니다');
		} else if(id.length == 0){
			alert('아이디를 입력하세요.');
		} else if(pass != repass){
			alert('비밀번호가 일치하지 않습니다.');
		} else if(secure == '==선택=='){
			alert('보안 질문을 선택하세요.');
		} else if(birth.length > 10){
			alert('잘못된 생년월일입니다.');	
		} else if(birth < '1940-01-01' || birth > today){
			alert('생년월일을 확인해주세요.');
		} else if(postcode.length == 0 || roadAddress.length == 0){
			alert('주소를 입력하세요.');
		} else if(nickname.indexOf(" ")> -1 || nickname.indexOf("\t")>=0 || nickname.indexOf("\n")>-1){
			alert('닉네임에 공백이 있습니다');
		} else {
			
			return true;
		}
		
		return false;
				
	}

	
	//약관 동의 유무
	function aaa(box){
		
		if(box.checked == true){
			checked = true;
		} else {
			checked = false;
		}
		
	}
	
	//중복확인 창
	function dupCheck(){
		var idcheck = window.open('/idCheck','idcheck',+
				'toolbar=yes,location=1,status=1,menubar=1,scrollbars=no,'+
				'resizable=yes,width=500,height=300,top=200,left=700')
	}
	
	
	
	
	function nickCheck(){
		
		var nick = $('[name=nickname]').val().trim();
		
		if(nick.length > 2){
			
			if(nick.indexOf(" ") > -1 || nick.indexOf("\t") >= 0 || nick.indexOf("\n") > -1){
				$('.nick').html('<font color=red>공백은 존재할수 없습니다.</font>');
				nicknameChecked = false;
				
			} else {
			
			
				$.ajax({
					url:'/nickCheck',
					data:'nickname='+nick,
					success:function(result){
						$('.nick').html('<font color=green>가능한 닉네임 입니다.</font>');
						nicknameChecked = true;
					},
					error:function(result){
						$('.nick').html('<font color=red>불가능한 닉네임 입니다..</font>');
						nicknameChecked = false;
						
					}
				});
				
			}
		} else if(nick.length <= 2 && nick.length > 0){
			$('.nick').html('<font color=red>닉네임이 너무 짧습니다</font>');
			nicknameChecked = false;
			
		} else {
			$('.nick').html('');
			nicknameChecked = false;
			
		}
	}
	//생년월일 년 입력시 월로 이동
	function movetoMonth(){
		if($('[name=year]').val().length == 4){
			$('[name=month]').focus();
		}
	}

	//월 입력시 일로 이동
	function movetoDay(){
		if($('[name=month]').val().length == 2){
			$('[name=day]').focus();
		}
	}
	
	function movetoTel2(){
		if($('[name=tel1]').val().length == 3){
			$('[name=tel2]').focus();
		}
	}

	function movetoTel3(){
		if($('[name=tel2]').val().length == 4){
			$('[name=tel3]').focus();
		}
	}
	
	
	
	
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
                document.getElementById('detailAddress').focus();
            }
        }).open();
    }
</script>