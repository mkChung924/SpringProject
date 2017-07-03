
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/travelModal.css">

	<!-- 여행 Modal -->
	<div id="travelModal" class="modal">
		<!-- 모달 내용 -->
		<div class="modal-content">
			<div class="close-travel">X</div>
			<div class="travel_sub">
			<form role="form-travel" method="post">
				<b><font size="4">1. 원하는 여행지를 선택하세요!</font></b><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">
				<input type="text" class="form-control" name="place1" style="width: 110px; display: inline;"> &nbsp;&nbsp;
				<input type="text" class="form-control" name="place2" style="width: 110px; display: inline;">
				<br><br>
				<b><font size="4">2. 여행 유형을 선택하세요!</font></b><br><br>
				<img id="subtravel" src="/resources/image/category_img/category_travel_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="themeTravel()">
				<img id="subtravel" src="/resources/image/category_img/category_travel_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="freeTravel()">
				<img id="subtravel" src="/resources/image/category_img/category_travel_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="foodTravel()">
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_travel = document.getElementById('travelModal');
	var span_travel = document.getElementsByClassName("close-travel")[0];
	var form_travel = $('form[role=form-travel]');
	
	$('#travelBtn').click(function(){
		
		kind1 = 1;
				
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_travel.style.display = "block";			
		}
	});
	
	/* x버튼 눌렀을 때 모달 닫힘 */
	span_travel.onclick = function() {
	    modal_travel.style.display = "none";
	}
	
	/* 모달 밖을 눌렀을 때 모달 닫힘 */
	window.onclick = function(event) {
	    if (event.target == modal_travel) {
	        modal_travel.style.display = "none";
	    }
	}
	
	/* 테마여행 */
	function themeTravel(){
		
		kind2 = 1;
		
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		/* 여행지 선택 유무 확인후 submit */
		if($('[name=place1]').val() == ""){
			alert("여행지를 선택하세요!");
			
		} else if($('[name=place2]').val() == ""){
			alert("여행지를 선택하세요!");
		} else {
			
			form_travel.attr('action', '/board');
			form_travel.attr('method', 'post');
			form_travel.submit();

		}
	}
	
	/* 자유여행 */
	function freeTravel(){
		
		kind2 = 2;
		
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		/* 여행지 선택 유무 확인후 submit */
		if($('[name=place1]').val() == ""){
			alert("여행지를 선택하세요!");
			
		} else if($('[name=place2]').val() == ""){
			alert("여행지를 선택하세요!");
		} else {

			form_travel.attr('action', '/board');
			form_travel.attr('method', 'post');
			form_travel.submit();

		}
	}
	
	/* 맛집탐방 */
	function foodTravel(){
		
		kind2 = 3;
		
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		/* 여행지 선택 유무 확인후 submit */
		if($('[name=place1]').val() == ""){
			alert("여행지를 선택하세요!");
			
		} else if($('[name=place2]').val() == ""){
			alert("여행지를 선택하세요!");
		} else {
			
			form_travel.attr('action', '/board');
			form_travel.attr('method', 'post');
			form_travel.submit();

		}
	}
	
</script>
