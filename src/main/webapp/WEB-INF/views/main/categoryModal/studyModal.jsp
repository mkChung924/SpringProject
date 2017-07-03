<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/studyModal.css">
	<!-- The study Modal -->
	<div id="studyModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-study">X</div>
			<div class="study_sub">
			<form role="form-study">
				<b><font size="5">스터디 유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">
				<img id="substudy" src="/resources/image/category_img/category_study_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="english()">
				<img id="substudy" src="/resources/image/category_img/category_study_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="certificate()">
				<img id="substudy" src="/resources/image/category_img/category_study_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="interview()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_study = document.getElementById('studyModal');
	var span_study = document.getElementsByClassName("close-study")[0];
	var form_study = $('form[role=form-study]');
	
	$('#studyBtn').click(function(){
		kind1 = 7;
		
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_study.style.display = "block";			
		}
	});
	
	span_study.onclick = function() {
		modal_study.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal_study) {
	    	modal_study.style.display = "none";
	    }
	}
	
	function study_form(){
		form_study.attr('action', '/board');
		form_study.attr('method', 'post');
		form_study.submit();
	}
	
	function english(){
		kind2 = 22;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		
		study_form();
		
	}
	function certificate(){
		kind2 = 23;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		study_form();
	}
	function interview(){
		kind2 = 24;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		study_form();
	}
</script>
