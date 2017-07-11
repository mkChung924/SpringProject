<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/petModal.css">

	<!-- The pet Modal -->
	<div id="petModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-pet">X</div>
			<div class="pet_sub">
			<form role="form-pet">
				<b><font size="5">유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">
				<img id="subpet" src="/resources/image/category_img/category_pet_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="mammal()">
				<img id="subpet" src="/resources/image/category_img/category_pet_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="reptile()">
				<img id="subpet" src="/resources/image/category_img/category_pet_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="fish()">						
				<img id="subpet" src="/resources/image/category_img/category_pet_4.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="birds()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_pet = document.getElementById('petModal');
	var span_pet = document.getElementsByClassName("close-pet")[0];
	var form_pet = $('form[role=form-pet]');
	
	$('#petBtn').click(function(){
		kind1 = 6;
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_pet.style.display = "block";			
		}
	});
	
	span_pet.onclick = function() {
		modal_pet.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal_pet) {
	    	modal_pet.style.display = "none";
	    }
	}
	
	function pet_form(){
		form_pet.attr('action', '/board');
		form_pet.attr('method', 'post');
		form_pet.submit();
	}
	
	function mammal(){
		kind2 = 18;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		pet_form();
	}
	function reptile(){
		kind2 = 19;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		pet_form();
	}
	function fish(){
		kind2 = 20;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		pet_form();
	}
	function birds(){
		kind2 = 21;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		pet_form();
	}
	
	
</script>
