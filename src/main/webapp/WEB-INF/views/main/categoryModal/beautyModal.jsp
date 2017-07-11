<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/beautyModal.css">

	<!-- The beauty Modal -->
	<div id="beautyModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-beauty">X</div>
			<div class="beauty_sub">
			<form role="form-beauty">
				<b><font size="5">유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">				
				<img id="subbeauty" src="/resources/image/category_img/category_beauty_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="fashion()">
				<img id="subbeauty" src="/resources/image/category_img/category_beauty_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="makeUp()">
				<img id="subbeauty" src="/resources/image/category_img/category_beauty_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="plastic()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_beauty = document.getElementById('beautyModal');
	var span_beauty = document.getElementsByClassName("close-beauty")[0];
	var form_beauty = $('form[role=form-beauty]');
	
	$('#beautyBtn').click(function(){
		kind1 = 8;
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_beauty.style.display = "block";			
		}
	});
	
	span_beauty.onclick = function() {
		modal_beauty.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal_beauty) {
	    	modal_beauty.style.display = "none";
	    }
	}
	
	function beauty_form(){
		form_beauty.attr('action', '/board');
		form_beauty.attr('method', 'post');
		form_beauty.submit();
	}
	
	function fashion(){
		kind2 = 25;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		beauty_form();
	}
	function makeUp(){
		kind2 = 26;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		beauty_form();
	}
	function plastic(){
		kind2 = 27;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		beauty_form();
	}
</script>
