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
		
		$("#replyDelBtn").click(function() {
			
			var a = $('input:checkbox[name="chbox1"]:checked').length;
			if(a < 1){
				alert('삭제할 댓글을 선택하세요');
			} else {
			
				$('input:checkbox[name="chbox1"]').each(function() {
					if (this.checked) { //checked 처리된 항목의 값	  
						alert(this.value);
						var rno = this.value.split('%')[1];
						$.ajax({
							url : 'replyRemove',
							data : 'rno=' + rno + '&page='+${page},
							success : function(result) {
								location.reload();
							}
						});
					}
				});
			}
		});
		
		
		$('#reportsDelBtn').click(function(){	
			
			var a = $('input:checkbox[name="chbox1"]:checked').length;
			if(a < 1){
				alert('삭제할 신고를 선택하세요')
			} else {
			
				$('input:checkbox[name="chbox1"]').each(function() {
					if (this.checked) {
						var repno = this.value.split('%')[0];
						 $.ajax({
								url:'replydel',
								data: 'repno='+ repno,
								success:function(result){		
									location.reload();
								},
								error:function(result){
									alert("신고가 되지 않았습니다.");
								}
						});
					}
				});
			}
		});	
		
		$('#reportsDelAllBtn').click(function(){	
			
			var a = $('input:checkbox[name="chbox1"]:checked').length;
			if(a < 1){
				alert('삭제할 댓글을 선택하세요');
			} else {
				$('input:checkbox[name="chbox1"]').each(function() {
					if (this.checked) {
						var rno = this.value.split('%')[1];
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
					}
				});
			}
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
<style>
body{
		font-family: "fontello";
	}
</style>
	
	<c:if test="${messages.size() < 1 }">
		<br><br><br><br><br><br><br><br><h4><i><font color=red>댓글</font> 신고함이 비었습니다</i></h4>
	</c:if>
		
	<c:if test="${messages.size() > 0 }">
	<br><br><br>
	<div class="col-sm-6" style="text-align: left; padding-left: 20px; display: inline">
	<label><font size=4>댓글 신고</font></label>
	</div>
	<div class="col-sm-6" style="text-align: right; padding-right: 15px; display: inline">
		<button type="button" class="btn btn-danger" id="replyDelBtn">댓글 삭제 &#xf083</button> &nbsp;
		<button type="button" class="btn btn-warning" id="reportsDelBtn">신고 삭제 &#xf083</button> &nbsp;
		<button type="button" class="btn btn-info" id="reportsDelAllBtn">같은 신고 일괄 삭제 &#xf083</button>
	</div>
	<br><br>
		<table class="table">
		<tr style="font-size: 20x;">
			<th width="70" style="text-align: center;">선택</th>
			<th width="80"style="text-align: center;">댓글 번호</th>
			<th width="300" style="text-align: center;">댓글 내용</th>
			<th width="70" style="text-align: center;">위반한 사람</th>
			<th width="100" style="text-align: center;">신고일</th>
		</tr>
		<c:forEach items="${messages}" var="reply">
			<tr style="text-align: center; font-size: 18px;">
				<td><input type="checkbox" name="chbox1" value=${reply.repno }%${reply.rno }></td>
				<td>${reply.rno }</td>
				<td>${reply.content }</td>
				<td>${reply.offender}</td>
				<td>${reply.senddate}</td>
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
	<form id="jobForm">
		<input type='hidden' name="page" value=${pageMaker.cri.perPageNum }>
		<input type='hidden' name="perPageNum"
			value=${pageMaker.cri.perPageNum }>
	</form>
	</c:if>


