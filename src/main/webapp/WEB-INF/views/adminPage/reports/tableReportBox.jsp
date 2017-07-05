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


	$("#tableDelBtn1").click(function() {
		$('input:checkbox[name="chbox1"]').each(function() {
			if (this.checked) { //checked 처리된 항목의 값	            
				$.ajax({
					url : 'tableReportRemove',
					data : 'trno=' + this.value+ '&page='+${page},
					success : function(result) {
						location.reload();
					}
				});
			}
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
	게시글 신고함
	<table class="table-striped">

		<tr style="font-size: 20x;">
			<th width="100" style="text-align: center;">삭제</th>
			<th width="200" style="text-align: center;">번호</th>
			<th width="200" style="text-align: center;">제목</th>
			<th width="200" style="text-align: center;">위반자</th>
			<th width="200" style="text-align: center;">신고자</th>
			<th width="100" style="text-align: center;">작성일</th>
			
		</tr>
		<c:forEach items="${tablereport}" var="table">
			<tr  style="text-align: center; font-size: 18px;">
				<td><input type="checkbox" name="chbox1" value=${table.trno }></td>
				<td>${table.trno }</td>
				<td><a href="tableReportContent?trno=${table.trno }&page=${page}">${table.title}</a></td>
				<td><input type="hidden" value="${table.tbno }" id="mno1">
					${table.id}</td>
				<td>${table.reporter}</td>
				<td>${table.senddate }</td>
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
	<button type="button" class="btn btn-danger" id="tableDelBtn1" >삭제 &#xf083</button>
<form id="jobForm">
  <input type='hidden' name="page" value=${pageMaker.cri.perPageNum}>
  <input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum}>
</form>
	<script type="text/javascript">
	$(".pagination li a").on("click", function(event){
		
		event.preventDefault(); 
		
		var targetPage = $(this).attr("href");
		
		var jobForm = $("#jobForm");
		jobForm.find("[name='page']").val(targetPage);
		jobForm.attr("action","/project/reportBox").attr("method", "get");
		jobForm.submit();
	});
	</script>

</body>
</html>