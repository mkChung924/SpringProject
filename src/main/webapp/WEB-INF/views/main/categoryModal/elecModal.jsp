<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/elecModal.css?ver=1.2">

	<!-- The elec Modal -->
	<div id="elecModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-elec">X</div>
			<div class="elec_sub">
			<form role="form-elec">
				<b><font size="5">유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">				
				<img id="subelec" src="/resources/image/category_img/category_elec_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="computer()">
				<img id="subelec" src="/resources/image/category_img/category_elec_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="gadget()">
				<img id="subelec" src="/resources/image/category_img/category_elec_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="misc()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_elec = document.getElementById('elecModal');
	var span_elec = document.getElementsByClassName("close-elec")[0];
	var form_elec = $('form[role=form-elec]');
	
	$('#elecBtn').click(function(){
		kind1 = 5;
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_elec.style.display = "block";			
		}
	});
	
	span_elec.onclick = function() {
		modal_elec.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal_elec) {
	    	modal_elec.style.display = "none";
	    }
	}
	
	function elec_form(){
		form_elec.attr('action', '/board');
		form_elec.attr('method', 'post');
		form_elec.submit();
	}
	
	function computer(){
		kind2 = 15;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		elec_form();
	}
	function gadget(){
		kind2 = 16;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		elec_form();
	}
	function misc(){
		kind2 = 17;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		elec_form();
	}
</script>
