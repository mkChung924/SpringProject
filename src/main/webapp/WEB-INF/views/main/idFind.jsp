<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/idFind.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<div id="idModal" class="modal">
  <!-- Modal content -->
  <div id="modal-content-idfind" class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <h2>아이디 찾기</h2>
    </div>
    <br>
    <div class="modal-body">
    	
    	<div class="idFind" style="text-align: center;">
    		<p><b><font size=4>가입 당시 입력한 <font color=red>이름</font>과 <font color=red>생년월일</font>을 입력하세요.</font></b></p>
    		<br>
    		<input type='text' class="form-control" name="name_find" placeholder="이름" pattern="[ㄱ-힣]{2,10}" required autocomplete="off" style="width: 200px;">
    		<br>
	    	<input type="date" class="form-control" name="birth_find" required style="width: 200px; text-align: center; display: inline">
	    	<br><br>
    	</div>
    	<div class="idList" style="text-align: center; display: inline-block;">
    	</div>
    	<div>
    		<br>
	    	<input type="submit" class="btn btn-success" value="찾기" name="search_id_btn" onclick="idFindCheck()">
	    	<input type="button" class="btn btn-success" value="로그인 하기" name="login_btn" onclick="closeIdModal()" style="display: none">
	    	<br><br>
	    </div>
    </div>
    

</div>

</div>

<script>	

	// When the user clicks the button, open the modal 
	$('#idBtn').click(function(){
		$('#idModal').css("display","block");
	});

	// When the user clicks on <span> (x), close the modal
	$('#idModal .close').click(function(){
		if(confirm("아이디 찾기를 종료하시겠습니까?") == true){
			
			$('#idModal').css("display","none");
		}
	});
	
	function idFindCheck(){
		
	      var name = $('[name=name_find]').val();
	      var birth = $('[name=birth_find]').val();
	       
    	  $.ajax({
    		 	url:'/idFind/'+name+'/'+birth,
    		 	cache:false,
    		 	success:function(result){
    		 		var output = "";
    		 		
    		 		$.each(result, function(index,item){
    		 			output += "<div class=col-sm-3>"+item+"</div>";	
    		 		});
    		 		
    		 		$('.idList').html("<b>회원님의 아이디는 다음과 같습니다.</b><br><br>"+ output);
    		 		$('[name=search_id_btn]').css("display","none");
    		 		$('[name=login_btn]').css("display","");
	
    		 	},
    		 	error:function(result){
    		 		$('.idList').html('일치하는 값 없음.');
    		 		
    		 	}
    		 	
    	  });
	 }
	
	function closeIdModal(){
		$('#idModal').css("display","none");
		$('[name=name_find]').val("");
	   	$('[name=birth_find]').val("");
		$('[name=search_id_btn]').css("display","");
 		$('[name=login_btn]').css("display","gone");
 		$('.idList').html("");
	}

</script>