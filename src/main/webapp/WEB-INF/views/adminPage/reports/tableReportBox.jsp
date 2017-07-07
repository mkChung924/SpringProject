<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/admin/admin.css?ver=1.4">
<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/fontello.css?ver=1.1">
<script type="text/javascript">
	
	$(function(){
		alert();
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
		
		$(".pagination li a").on("click", function(event){
			
			event.preventDefault(); 
			
			var targetPage = $(this).attr("href");
			
			var jobForm = $("#jobForm");
			jobForm.find("[name='page']").val(targetPage);
			jobForm.attr("action","/project/reportBox").attr("method", "get");
			jobForm.submit();
		});
		
	})

</script>
<style>
body{
		font-family: "fontello";
	}
</style>
	
	<c:if test="${tablereport.size() < 1}">
	<br><br><br><br><br><br><br><br><h4><i><font color=red>게시글</font> 신고함이 비었습니다</i></h4>
	</c:if>
	
	<c:if test="${tablereport.size() > 0}">
	<br><br><br>
	<div class="col-sm-6" style="text-align: left; padding-left: 20px; display: inline">
	<label><font size=4>댓글 신고</font></label>
	</div>
	<div class="col-sm-6" style="text-align: right; padding-right: 15px; display: inline">
		<button type="button" class="btn btn-danger" id="boardDelBtn">게시글 삭제 &#xf083</button> &nbsp;
		<button type="button" class="btn btn-warning" id="reportsDelBtn">신고 삭제 &#xf083</button> &nbsp;
		<button type="button" class="btn btn-info" id="reportsDelAllBtn">같은 신고 일괄 삭제 &#xf083</button>
	</div>
	<br><br>
		<table class="table">
		<tr style="font-size: 20x;">
			<th width="70" style="text-align: center;">삭제</th>
			<th style="text-align: center;">게시글</th>
			<th width="100" style="text-align: center;">위반한 사람</th>
			<th width="100" style="text-align: center;">신고자</th>
			<th width="100" style="text-align: center;">신고일</th>
			
		</tr>
		<c:forEach items="${tablereport }" var="table">
			<tr  style="text-align: center; font-size: 18px;">
				<td><input type="checkbox" name="chbox1" value=${table.brno }></td>
				<td><a href="tableReportContent?trno=${table.trno }&page=${page}">${table.title}</a></td>
				<td><input type="hidden" value="${table.tbno }" id="mno1">${table.id}</td>
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
	<form id="jobForm">
	  <input type='hidden' name="page" value=${pageMaker.cri.perPageNum }>
	  <input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
	</form>
	</c:if>
