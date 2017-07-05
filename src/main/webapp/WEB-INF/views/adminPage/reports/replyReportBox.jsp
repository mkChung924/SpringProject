<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript">


	$("#replyDelBtn1").click(function() {
		$('input:checkbox[name="chbox1"]').each(function() {
			if (this.checked) { //checked 처리된 항목의 값	            
				$.ajax({
					url : 'replyRemove',
					data : 'rno=' + this.value+ '&page='+${page},
					success : function(result) {
						location.reload();
					}
				});
			}
		});
	});
	
	$(function(){			
		$('#del_button').click(function(){	
			var rno = $(this).val();
			
			 $.ajax({
					url:'replydel',
					data: 'rno='+rno,
					success:function(result){		
						location.reload();
					},
					error:function(result){
						alert("신고가 되지 않았습니다.");
					}
			});
	});	
});

</script>
<style type="text/css">
body {
	font-family: "fontello";
}
</style>
</head>
<body>
	댓글 신고함
	<table class="table-striped">

		<tr style="font-size: 20x;">
			<th width="100" style="text-align: center;">삭제</th>
			<th width="100" style="text-align: center;">댓글번호</th>
			<th width="400" style="text-align: center;">내용</th>
			<th width="200" style="text-align: center;">위반자</th>
			<th width="100" style="text-align: center;">작성일</th>
			<th width="200" style="text-align: center;">한 행 삭제</th>
			

		</tr>
		<c:forEach items="${messages}" var="reply">
			<tr style="text-align: center; font-size: 18px;">
				<td><input type="checkbox" name="chbox1" value=${reply.repno }></td>
				<td>${reply.repno }</td>
				<td>${reply.content }</td>
				<td>${reply.offender}</td>
				<td>${reply.senddate}</td>
				<td><button  id="del_button" class="btn btn-danger" value="${reply.rno }" style="font-size: small;">댓글삭제</button></td>
			</tr>
		</c:forEach>

	</table>
	<c:if test="${pageMaker.prev}">
		<ul class="pagination">
			<li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
		</ul>
	</c:if>
	<ul class="pagination">
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }"
			var="idx">
			<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
				<a href="${idx}">${idx}</a>
			</li>
		</c:forEach>
	</ul>
	<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		<ul class="pagination">
			<li><a href="${pageMaker.endPage +1}">&raquo;</a></li>
		</ul>
	</c:if>
	<button type="button" class="btn btn-danger" id="replyDelBtn1">일괄 삭제
		&#xf083</button>
	<form id="jobForm">
		<input type='hidden' name="page" value=${pageMaker.cri.perPageNum}>
		<input type='hidden' name="perPageNum"
			value=${pageMaker.cri.perPageNum}>
	</form>
	<script type="text/javascript">
		$(".pagination li a").on("click", function(event) {
	
			event.preventDefault();
	
			var targetPage = $(this).attr("href");
	
			var jobForm = $("#jobForm");
			jobForm.find("[name='page']").val(targetPage);
			jobForm.attr("action", "/reports/replyBox").attr("method", "get");
			jobForm.submit();
		});
	</script>

</body>
</html>