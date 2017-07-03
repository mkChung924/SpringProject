<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/testcss/cssModal/travelModal.css">

	<!-- The Travel Modal -->
	<div id="travelModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close">X</div>
			<div class="trave_sub">
				<b><font size="4">1. 원하는 여행지를 선택하세요!</font></b><br><br><br>
				<input type="text" class="form-control" id="p1" style="width: 110px; display: inline;"> &nbsp;&nbsp;
				<input type="text" class="form-control" id="p2" style="width: 110px; display: inline;">
				<br><br><br>
				<b><font size="4">2. 여행 유형을 선택하세요!</font></b><br><br><br>
				<img id="subtravel" src="/resources/image/category_img/category_travel2.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="themeTravel()">
				<img id="subtravel" src="/resources/image/category_img/category_travel1.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="healingTravel()">
			</div>
		</div>
	</div>

	<script>

	var modal = document.getElementById('travelModal');
	var span = document.getElementsByClassName("close")[0];
	
	$('#travelBtn').click(function(){
		var do1 = $('[name=do1]').val();
		var si = $('[name=si]').val();
		var dong = $('[name=dong]').val();
		var p1 = $('#p1').val();
		var p2 = $('#p2').val();
				
		if(do1 == "" || si == "" || dong == ""){
			alert("현재위치를 설정하세요!");
			
		} else{
			
		modal.style.display = "block";
		}
	});
	
	span.onclick = function() {
	    modal.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
	
	function themeTravel(){
		
		var do1 = $('[name=do1]').val();
		var si = $('[name=si]').val();
		var dong = $('[name=dong]').val();
		var p1 = $('#p1').val();
		var p2 = $('#p2').val();
				
		if(do1 == "" || si == "" || dong == ""){
			alert("현재위치를 설정하세요!");
		} else if(p1 == ""){
			alert('도를 선택하세요!');
		} else if(p2 == ""){
			alert('시를 선택하세요!');
		} else {
			alert('테마 여행을 떠나볼까요!');
			window.location.reload();
		}
	}
	
	function healingTravel(){
		
		var do1 = $('[name=do1]').val();
		var si = $('[name=si]').val();
		var dong = $('[name=dong]').val();
		var p1 = $('#p1').val();
		var p2 = $('#p2').val();
				
		if(do1 == "" || si == "" || dong == ""){
			alert("현재위치를 설정하세요!");
		} else if(p1 == ""){
			alert('도를 선택하세요!');
		} else if(p2 == ""){
			alert('시를 선택하세요!');
		} else {
			alert('힐링 여행을 떠나볼까요!');
			window.location.reload();
		}
	}
	
</script>
