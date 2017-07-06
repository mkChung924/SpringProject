<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/admin/admin.css?ver=1.4">
<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/fontello.css?ver=1.1">
<script type="text/javascript">
	
	$(function(){		
		
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
		
		$(".pagination li a").on("click", function(event) {
			
			event.preventDefault();

			var targetPage = $(this).attr("href");

			var jobForm = $("#jobForm");
			jobForm.find("[name='page']").val(targetPage);
			jobForm.attr("action", "/reports/replyBox").attr("method", "get");
			jobForm.submit();
		});
		
	});
	
</script>
<title>Insert title here</title>
	
	<c:if test="${messages.size() < 1 }">
		<br><i><h4>댓글 신고함이 비었습니다.</h4></i>
	</c:if>
		
	<c:if test="${messages.size() > 0 }">
		<table class="table">
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
	<button type="button" class="btn btn-danger" id="replyDelBtn1">일괄 삭제 &#xf083</button>
	<form id="jobForm">
		<input type='hidden' name="page" value=${pageMaker.cri.perPageNum }>
		<input type='hidden' name="perPageNum"
			value=${pageMaker.cri.perPageNum }>
	</form>
	</c:if>


