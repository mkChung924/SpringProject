<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/resources/js/jquery3.js"></script>
<script type="text/javascript">

	var bno = 2641920;
	$.ajax({
		
			url:'/replies/all/' + bno,
			success:function(data){
				//alert(data.length); ---> 5
				console.log(data);
				
				var str = "";
				$(data).each(function(){
					
					str += "<li data-rno='"+this.rno+"' class='replyLi'>" + this.rno + " : " + this.replytext + " ----- "+ this.replyer +"</li>";
					
				});
				
				//ul태그안에 데이터 출력
				$("#replies").html(str);
			}//success
		
	});
</script>
<style type="text/css">
	#modDiv{
		background-color: gray;
		width: 300px;
		height: 100px;
		padding: 10px;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		z-index: 1000px;
	}
</style>
<title>댓글 ajax 테스트</title>

</head>
<body>
<h3>Ajax 댓글 테스트</h3>
<ul id="replies"></ul>

<div id="modDiv" style="display: none">
	<div class="modal-title">안녕하세요 나는 모달창입니다.</div>
	<div>
		<input type="text" id='replytext'>
	</div>
	<div>
		<button type="button" id="replyModBtn">수정</button>
		<button type="button" id="replyDelBtn">삭제</button>
		<button type="button" id="CloseBtn">닫기</button>
	</div>
</div>

</body>
</html>