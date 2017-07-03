<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/healthModal.css">

	<!-- The health Modal -->
	<div id="healthModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-health">X</div>
			<div class="health_sub">
			<form role="form-health">
				<b><font size="5">유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">				
				<img id="subhealth" src="/resources/image/category_img/category_health_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="cycle()">
				<img id="subhealth" src="/resources/image/category_img/category_health_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="gym()">
				<img id="subhealth" src="/resources/image/category_img/category_health_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="balls()">						
				<img id="subhealth" src="/resources/image/category_img/category_health_4.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="bodyWork()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_health = document.getElementById('healthModal');
	var span_health = document.getElementsByClassName("close-health")[0];
	var form_health = $('form[role=form-health]');
	
	$('#healthBtn').click(function(){
		kind1 = 4;
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_health.style.display = "block";			
		}
	});
	
	span_health.onclick = function() {
		modal_health.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal) {
	    	modal_health.style.display = "none";
	    }
	}
	
	function health_form(){
		form_health.attr('action', '/board');
		form_health.attr('method', 'post');
		form_health.submit();
	}
	
	function cycle(){
		kind2 = 11;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		health_form();
	}
	function gym(){
		kind2 = 12;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		health_form();
	}
	function balls(){
		kind2 = 13;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		health_form();
	}
	function bodyWork(){
		kind2 = 14;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		health_form();
	}
</script>
