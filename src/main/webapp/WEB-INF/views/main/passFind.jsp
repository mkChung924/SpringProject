<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/passFind.css?ver=1.1">

<div id="passModal" class="modal">
  <!-- Modal content -->
  <div id="modal-content-passfind" class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <h2>비밀번호 찾기</h2>
    </div>
    <br>
    <div class="modal-body">
    	
    	<div class="passFind" style="text-align: center;">
    		<p><b><font size=4>가입시 입력한 <font color=red>이름</font>, <font color=red>아이디</font>, <font color=red>보안질문 및 답안</font>을 입력하세요.</font></b></p>
    		<br>
    		<input type='text' class="form-control" name="name_proove" placeholder="이름" pattern="[ㄱ-힣]{2,10}" autocomplete="off" style="width: 200px; text-align: center">
    		<br>
	    	<input type="text" class="form-control" name="id_proove" placeholder="아이디" pattern="[a-zA-Z0-7]{2,10}" style="width: 200px; text-align: center; display: inline;">
	    	<br>
	    	<select name="secure_code" class="form-control" style="width: 200px; display: inline">
					<option>==보안질문선택==</option>
					<option>당신의 고향은 어디신가요?</option>
					<option>가장 소중한 것은 무엇입니까?</option>
					<option>내가 졸업한 고등학교는?</option>
					<option>유년시절 나의 별명은?</option>
					<option>아버지의 성함은?</option>
					<option>어머님의 성함은?</option>
			</select><br>
			<input type="text" class="form-control" name="secure_proove" placeholder="보안답" style="width: 200px; text-align: center; display: inline;">
	    	<br>
	    	<input type="hidden" name="getid">
    	</div>
    	<div class="result"></div><br>
    	<div class="search-btn">
	    	<input type="button" class="btn btn-success" value="찾기" name="search_pass_btn"><br><br>
	    </div>
	    <div class="login-btn" style="display: none;">
	    	<input type="button" class="btn btn-success" value="로그인 하기" name="login_btn_pass" onclick="closePassModal()">
	    	<br><br>
	    </div>
	    <div class="passList" style="text-align: center; display: none;">
    	</div>
    </div>
    

</div>

</div>

<script>	

	// When the user clicks the button, open the modal 
	$('#passBtn').click(function(){
		$('#passModal').css("display","block");
	});

	// When the user clicks on <span> (x), close the modal
	$('#passModal .close').click(function(){
		if(confirm("비밀번호 찾기를 종료하시겠습니까?") == true){
			
			window.location.reload();
			/* $('#passModal').css("display","none"); */
		}
	});
	
	$('[name=search_pass_btn]').click(function(){
		
	      var name = $('[name=name_proove]').val();
	      var id = $('[name=id_proove]').val();
	      var secure = $('[name=secure_code]').val();
	      var secure_ans = $('[name=secure_proove]').val();
	      
	      //alert(name + ", " + id + ", " + secure + ", " + secure_ans);
	      //$('[name=getid]').val(id);
	      
	      if(name.length == 0 || id.length == 0 || secure == '==보안질문선택==' || secure_ans.length == 0){
	    	  alert("빈칸은 존재할 수 없습니다.");
	    	  return;
	      }
	       
   	  $.ajax({
   		 	type:'post',
				url:'/passFind/',
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "POST" },
				dataType:'text',
				data: JSON.stringify({id:id, name:name, secure:secure, secure_ans:secure_ans}),
  		 		cache:false,
  		 		success:function(result){
  		 		
  		 		if(result === 'pass'){
  		 			$('.passFind').css('display','none');
  		 			$('.search-btn').css('display','none');
  		 			$('.result').css('display','none');
  		 			$('.passList').css('display','');
  		 			$('.passFind [name=getid]').val(id);
  		 			$('.passList').html('<label><b><font size="4">새 비밀번호를 입력하세요.</font></b></label><br><br>'+
  		 		    		'<input type="password" class="form-control" name="pass1" placeholder="비밀번호" style="width: 200px; text-align: center"><br>'+
  		 		    		'<input type="password" class="form-control" name="pass2" placeholder="비밀번호 확인" style="width: 200px; text-align: center"><br><br>'+
  		 		    		'<input type="button" class="btn btn-info" class="modbtn" name="changePassword" value="변경하기" onclick="modify()"><br><br><br>');
  		 			
  		 		} else if(result === 'not_pass'){
  		 			$('.result').html('<font color=red>보안질문 또는 답안이 일치하지 않습니다.</font>');
  		 		} else {
  		 			$('.result').html('<font color=red>일치하는 회원정보가 없습니다.</font>');
 
  		 		}
  		 	}
  	  });
	});
	
	function modify(){
		var id = $('[name=getid]').val();
		var pass1 = $('[name=pass1]').val();
		var pass2 = $('[name=pass2]').val();
		
		if(pass1 != pass2){
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}
		if(pass1.trim().length < 6 || pass2.trim().length < 6){
			alert('비밀번호는 최소 6글자로 구성되어야 합니다.');
			return;
		}
		
		$.ajax({
				url:'/passUp',
				data:'id='+id+'&pass='+pass1,
				success:function(result){
					alert(result);
					if(result == 'SUCCESS'){
						$('.passList').remove();
						$('.result').css('display','');
						$('.result').html('<font size="4">비밀번호가 성공적으로 변경되었습니다.</font><br><br>');
						$('.login-btn').css('display','');
					}
					
				},
				error:function(result){
					alert('오류가 발생하였습니다.');
				}
		});
	}
	
	function closePassModal(){
		
		/* $('#passModal').css("display","none"); */
		window.location.reload();

	}
	

</script>