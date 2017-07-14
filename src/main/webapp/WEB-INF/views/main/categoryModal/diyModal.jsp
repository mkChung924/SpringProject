<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main/modalcss/diyModal.css?ver=1.2">

	<!-- The diy Modal -->
	<div id="diyModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div class="close-diy">X</div>
			<div class="diy_sub">
			<form role="form-diy">
				<b><font size="5">유형을 선택하세요!</font></b><br><br><br>
				<input type="hidden" name="do1">
				<input type="hidden" name="si">
				<input type="hidden" name="dong">
				<input type="hidden" name="cno">
				<input type="hidden" name="csno">				
				<img id="subdiy" src="/resources/image/category_img/category_diy_1.png" draggable="false"
										width="250" height="250" style="margin-right: 10px" onclick="tree()">
				<img id="subdiy" src="/resources/image/category_img/category_diy_2.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="clothes()">
				<img id="subdiy" src="/resources/image/category_img/category_diy_3.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="miniature()">						
				<img id="subdiy" src="/resources/image/category_img/category_diy_4.png" draggable="false"
										width="250" height="250" style="margin-left: 10px" onclick="accessory()">						
			</form>
			</div>
		</div>
	</div>

	<script>

	var modal_diy = document.getElementById('diyModal');
	var span_diy = document.getElementsByClassName("close-diy")[0];
	var form_diy = $('form[role=form-diy]');
	
	$('#diyBtn').click(function(){
		
		kind1 = 2;
 		if($('#do1').val() == "" || $('#si').val() == "" || $('#dong').val() == ""){
 			alert('현재위치를 설정하세요');
		} else{
			modal_diy.style.display = "block";			
		}
	});
	
	span_diy.onclick = function() {
		modal_diy.style.display = "none";
	}
	
	window.onclick = function(event) {
	    if (event.target == modal_diy) {
	    	modal_diy.style.display = "none";
	    }
	}
	
	function diy_form(){
		form_diy.attr('action', '/board');
		form_diy.attr('method', 'post');
		form_diy.submit();
	}
	
	function tree(){
		kind2 = 4;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		diy_form();		
	}
	function clothes(){
		kind2 = 5;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		diy_form();	
	}
	function miniature(){
		kind2 = 6;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		diy_form();	
	}
	function accessory(){
		kind2 = 7;
		$('[name=do1]').val($('#do1').val());
		$('[name=si]').val($('#si').val());
		$('[name=dong]').val($('#dong').val());
		$('[name=cno]').val(kind1);
		$('[name=csno]').val(kind2);
				
		//alert($('[name=cno]').val() + ", " + $('[name=csno]').val() + ", " + $('[name=do1]').val() + ", " + $('[name=si]').val() + ", " + $('[name=dong]').val());
		diy_form();	
	}
</script>
