<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/concertModal.css">

	<!-- The concert Modal -->
	<div id="concertModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-concert">X</div>
			<div class="concert_sub">
			<form role="form-concert">
				<b><font size="5">유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">				
				<img id="subconcert" src="/resources/image/category_img/category_concert_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="festival()">
				<img id="subconcert" src="/resources/image/category_img/category_concert_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="musical()">
				<img id="subconcert" src="/resources/image/category_img/category_concert_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="concert()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_concert = document.getElementById('concertModal');
	var span_concert = document.getElementsByClassName("close-concert")[0];
	var form_concert = $('form[role=form-concert]');
	
	$('#concertBtn').click(function(){
		kind1 = 9;
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_concert.style.display = "block";			
		}
	});
	
	span_concert.onclick = function() {
		modal_concert.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal_concert) {
	    	modal_concert.style.display = "none";
	    }
	}
	
	function concert_form(){
		form_concert.attr('action', '/board');
		form_concert.attr('method', 'post');
		form_concert.submit();
	}
	
	function festival(){
		kind2 = 28;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		concert_form();
	}
	function musical(){
		kind2 = 29;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		concert_form();
	}
	function concert(){
		kind2 = 30;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		concert_form();
	}
</script>
