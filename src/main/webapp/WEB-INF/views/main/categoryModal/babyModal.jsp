<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/babyModal.css">

	<!-- The baby Modal -->
	<div id="babyModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-baby">X</div>
			<div class="baby_sub">
			<form role="form-baby">
				<b><font size="5">유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">				
				<img id="subbaby" src="/resources/image/category_img/category_baby_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="goods()">
				<img id="subbaby" src="/resources/image/category_img/category_baby_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="infos()">
				<img id="subbaby" src="/resources/image/category_img/category_baby_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="regMeeting()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_baby = document.getElementById('babyModal');
	var span_baby = document.getElementsByClassName("close-baby")[0];
	var form_baby = $('form[role=form-baby]');
	
	$('#babyBtn').click(function(){
		kind1 = 3;
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_baby.style.display = "block";			
		}
	});
	
	span_baby.onclick = function() {
		modal_baby.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal_baby) {
	    	modal_baby.style.display = "none";
	    }
	}
	
	function baby_form(){
		form_baby.attr('action', '/board');
		form_baby.attr('method', 'post');
		form_baby.submit();
	}
	
	function goods(){
		kind2 = 8;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		baby_form();
	}
	function infos(){
		kind2 = 9;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		baby_form();
	}
	function regMeeting(){
		kind2 = 10;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		baby_form();
	}
</script>
