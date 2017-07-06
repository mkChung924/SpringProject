<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/fontello.css?ver=1.1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/mypage.css?ver=1.4">

<script type="text/javascript">

	$("#replyDelBtn1").click(function() {
		$('input:checkbox[name="chbox1"]').each(function() {
			if (this.checked) { //checked 처리된 항목의 값	            
				$.ajax({
					url : 'sendRemove',
					data : 'mno=' + this.value+ '&page='+${page},
					success : function(result) {
						location.reload();
					}
				});
			}
		});
	});
	
	function readMsg(mno, page){
		window.open('senderContent?mno='+mno+'&page='+page, '받은 메시지', 'width=600 height=600 menubar=no status=no scrollbars=yes left=500 top=50 resizable=0')
	}

</script>
<style type="text/css">
body {
	font-family: "fontello";
}

</style>
	<c:if test="${messages.size() == 0 }">
		<br><br><br><i><h4>발신 메지시함이 비었습니다</h4></i>
	</c:if>
	<c:if test="${messages.size() != 0 }">
	<table class="table-striped">
		
		<tr style="font-size: 20x;">
			<th width="100" style="text-align: center;">삭제</th>
			<th width="200" style="text-align: center;">제목</th>
			<th width="200" style="text-align: center;">받는사람</th>
			<th width="100" style="text-align: center;">작성일</th>
			
		</tr>
		
		<c:forEach items="${messages }" var="send">
			<tr  style="text-align: center; font-size: 18px;">
				<td><input type="checkbox" name="chbox1" value=${send.mno }></td>
				<td><a onclick="readMsg(${send.mno }, ${page })" style="cursor: pointer;">${send.title}</a></td>
				<td><input type="hidden" value="${send.mno }" id="mno1">
					${send.targetid}</td>
				<td>${send.senddate}</td>
			</tr>
		</c:forEach>
	</table>
	</c:if>
	
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
	
	<c:if test="${messages.size() != 0 }">
	<button type="button" class="btn btn-danger" id="replyDelBtn1" >삭제 &#xf083</button>
	</c:if>
	
	
<form id="jobForm">
  <input type='hidden' name="page" value=${pageMaker.cri.perPageNum }>
  <input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
</form>
	<script type="text/javascript">
	$(".pagination li a").on("click", function(event){
		
		event.preventDefault(); 
		
		var targetPage = $(this).attr("href");
		
		var jobForm = $("#jobForm");
		jobForm.find("[name='page']").val(targetPage);
		jobForm.attr("action","/project/mailBox").attr("method", "get");
		jobForm.submit();
	});
	</script>
