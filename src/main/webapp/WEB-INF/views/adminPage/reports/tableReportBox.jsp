<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/admin/admin.css?ver=1.4">
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">

<%-- 이 페이지는 관리자 신고페이지 중 게시글에 관한 신고를 처리하는 페이지 입니다 --%>
<%-- 관련 함수는/resources/js/reportFunction.js --%>
<style>
body {
	font-family: "fontello";
}
</style>

<script type="text/javascript">
	$(function(){
		$('#searchIt').click(function(){
			//alert('haha');
			var jobForm = $("#jobForm");
			jobForm.attr("action","/reportBox").attr("method", "get");
			jobForm.submit();
		})
	})
</script>
	
	<c:if test="${tablereport.size() < 1}">
	<br><br><br><br><br><br><br><h4><i><font color=red>게시글</font> 신고함이 비었습니다</i></h4>
	</c:if>
	
	<c:if test="${tablereport.size() > 0}">
	<br><br>
	<div class="col-sm-3" style="text-align: left; padding-left: 20px; margin-top:10px; display: inline">
	<label><font size=4>게시글 신고</font></label>
	</div>
	<form id="jobForm">
		<input type='hidden' name="page" value=${pageMaker.cri.page }>
		<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
		<div class="col-sm-9" style="text-align: right; padding-right: 10px; display: inline">
		<button type="button" class="btn btn-danger" id="reportsDelPenalty">게시글 삭제 &#xf083</button>
		<button type="button" class="btn btn-warning" id="reportsDelBtn">신고 삭제 &#xf083</button>&nbsp;
		<input type="hidden" value=1 id="hiddenKind">
           	<select class="form-control s" id="option" name="searchType">
				<option value="n" ${cri.searchType == 'n' ? 'selected' : '' }>게시글번호</option>
				<option value="t" ${cri.searchType == 't' ? 'selected' : '' }>아이디</option>
			</select>
           <input type="text" class="form-control t" name="keyword" placeholder="검색" autocomplete="off" value="${cri.keyword }">
           <button type="button" class="btn btn-info" id="searchIt">검색</button>   
		<input type="hidden" value=2 id="hiddenKind">
		</div>
	</form>
	<br><br>
		<table class="table">
		<tr style="font-size: 20x;">
			<th width="70" style="text-align: center;">삭제</th>
			<th width="90" style="text-align: center;">번호</th>
			<th style="text-align: center;">게시글</th>
			<th style="text-align: center;">위반 유형</th>
			<th width="100" style="text-align: center;">위반한 사람</th>
			<th width="100" style="text-align: center;">신고일</th>

		</tr>
		<c:forEach items="${tablereport }" var="table">
			<tr style="text-align: center; font-size: 18px;">
				<td><input type="checkbox" name="chbox1" value=${table.repno }></td>
				<td>${table.tbno}</td>
				<td>
					<a style="cursor: pointer;" onclick="readPage('${table.brno}')">
					${table.content.length() > 21 ? table.content.substring(0,21) : table.content } 
					</a>
				</td> <!-- adminReport.jsp 부분에 readPage() -->
				<td>${table.reporttype}</td>
				<td id="off-${table.repno }">${table.offender}</td>
				<td>${table.senddate } <input type="hidden" id="brnoRow-${table.repno }" value="${table.brno }"> </td>
			</tr>
		</c:forEach>
	</table>
	<div class="div1" style="text-align: center;">
		<c:if test="${pageMaker.prev}">
			<ul class="pagination">
				<li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
			</ul>
		</c:if>
		<ul class="pagination">
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="idx">
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
	</div>


</c:if>
