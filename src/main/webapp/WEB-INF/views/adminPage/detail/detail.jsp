<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>카테고리 디테일 페이지</title>
<style>
/* 회원현황 검색란 */
.t {
	width: 120;
	display: inline;
	padding-top: 5;
}
.s {
	display: inline;
	width: 85;
}
</style>
<script type="text/javascript">
	$(function(){
		$(".pagination li a").on("click", function(event){
			
			event.preventDefault(); 
			
			var targetPage = $(this).attr("href");
			
			var paging = $("#paging");
			paging.find("[name='page']").val(targetPage);
			paging.attr("action","/categoryDetail").attr("method", "get");
			paging.submit();
		});
		
		$("#searchIt").click(function(event){
			
			event.preventDefault();
			
			var paging = $("#paging");
			
			paging.find("[name='page']").val(1);
			paging.attr("action","/categoryDetail").attr("method", "get");
			paging.submit();
			
		});
	});


	function dropIt(do1,cno){

			p1='';
			p2='';

		$.ajax({
			url:'citylist',
			data:'do1='+do1+'&cno='+cno+'&place1='+p1+'&place2='+p2,
			success:function(result){
				
				var div = $('#dropdown-menu-'+do1);
				html = "";
				
				for(var i = 0; i < result.length; i++){

					html += "<li><a onclick='moveIt(\""+do1 +"\",\""+result[i].SI+"\",\""+result[i].DONG+"\")'>"+result[i].SI +" "+ result[i].DONG +" ["+ result[i].COUNT +"]</a></li>";
						
				}
				
				div.html(html);
			},
			error:function(result){
				alert('error');
			}
		});
		
	}
	
	function openBoard(tbno){
		
        var w = screen.width - 300;
        var h = screen.height - 200;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2) - 50;
        window.open("/CommonRead?tbno=" + tbno, tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);	
	}
</script>
</head>
<body>
<div class="container">
 <div class="row">
<c:if test="${cno == 1 }">
 <h3><b>지역별 여행 게시글 현황</b></h3>
 	
 	<c:forEach items="${map }" var="map">
 		<div class="col-sm-1" style="text-align: center; padding: 20px">
	 	<div class="dropdown">
		    <button type="button" class="btn btn-primary dropdown-toggle" onclick="dropIt('${map.DO1}',${cno })" data-toggle="dropdown">
			    ${map.DO1 }
				<c:if test="${map.COUNT < 10 }">
                	[0${map.COUNT }]
                </c:if>
                <c:if test="${map.COUNT > 9 }">
                	[${map.COUNT }]
                </c:if>
			    <span class="caret"></span>
		    </button>
		    <ul class="dropdown-menu" id="dropdown-menu-${map.DO1 }"> 
		    </ul>
		 </div>
	 		
 		</div>
 	</c:forEach>
      <form id="paging">
      	<input type="hidden" name="cno" value="${cno }">
	  	<input type='hidden' name="page" value=${pageMaker.cri.page }>
	  	<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
           <div class="col-sm-12" style="text-align: right; margin-bottom: 10px;">
            <select class="form-control s" id="option" name="searchType">
				<option value="d" ${cri.searchType == 'd' ? 'selected' : '' }>지역1</option>
				<option value="s" ${cri.searchType == 's' ? 'selected' : '' }>지역2</option>
				<option value="p1" ${cri.searchType == 'p1' ? 'selected' : '' }>여행지1</option>
				<option value="p2" ${cri.searchType == 'p2' ? 'selected' : '' }>여행지2</option>
				<option value="k" ${cri.searchType == 'k' ? 'selected' : '' }>여행유형</option>
			</select>
            <input type="text" class="form-control t" name="keyword" placeholder="검색" autocomplete="off" value="${	cri.keyword }">
            <button type="button" class="btn btn-info" id="searchIt">검색</button>   
           </div>
        </form>
	 	<table class="table" style="text-align: center">
	 	<tr>
	 	<th style="text-align: center">지역1</th>
	 	<th style="text-align: center">지역2</th>
	 	<th style="text-align: center">여행지1</th>
	 	<th style="text-align: center">여행지2</th>
	 	<th style="text-align: center">여행유형</th>
	 	<th style="text-align: center">게시글 제목</th>
	 	<th style="text-align: center">글쓴이(닉네임)</th>
	 	<th style="text-align: center">게시일</th>
	 	</tr>
	<c:forEach items="${list }" var="list">
	 		<tr>
	 			<td>${list.do1 }</td>
	 			<td>${list.si }</td>
	 			<td>${list.place1 }</td>
	 			<td>${list.place2 }</td>
	 			<td>${list.csname }</td>
	 			<td><a onclick="openBoard(${list.tbno})" style="cursor: pointer;">${list.title }</a></td>
	 			<td>${list.nickname }</td>
	 			<td>${list.regdate }</td>
	 		</tr>
	</c:forEach>
	 	</table>
	 	<div class="div1" style="text-align: center">
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
				</div>
	 	
</c:if>

<!-- 여행이 아닐시 -->
<c:if test="${cno != 1}">
	<c:forEach items="${list }" var="list" end="0">
      <h3><b>지역별 <font color=red>${list.cname }</font> 게시글 현황</b></h3>
    </c:forEach>

 	<c:forEach items="${map }" var="map">
 		<div class="col-sm-1" style="text-align: center; padding: 20px">
 		
	 	<div class="dropdown">
		    <button type="button" class="btn btn-primary dropdown-toggle" onclick="dropIt('${map.DO1}',${cno })" data-toggle="dropdown">
			    ${map.DO1 }
				<c:if test="${map.COUNT < 10 }">
                	[0${map.COUNT }]
                </c:if>
                <c:if test="${map.COUNT > 9 }">
                	[${map.COUNT }]
                </c:if>
			    <span class="caret"></span>
		    </button>
		    <ul class="dropdown-menu" id="dropdown-menu-${map.DO1 }"> 
		    </ul>
		 </div>
 		</div>
 	</c:forEach>
      <form id="paging">
      	<input type="hidden" name="cno" value="${cno }">
	  	<input type='hidden' name="page" value=${pageMaker.cri.page }>
	  	<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
           <div class="col-sm-12" style="text-align: right; margin-bottom: 10px;">
            <select class="form-control s" id="option" name="searchType">
				<option value="d" ${cri.searchType == 'd' ? 'selected' : '' }>지역1</option>
				<option value="s" ${cri.searchType == 's' ? 'selected' : '' }>지역2</option>
				<option value="k" ${cri.searchType == 'k' ? 'selected' : '' }>관심사</option>
			</select>
            <input type="text" class="form-control t" name="keyword" placeholder="검색" autocomplete="off" value="${	cri.keyword }">
            <button type="button" class="btn btn-info" id="searchIt">검색</button>   
            </div>
        </form>
	 	<table class="table" style="text-align: center">
	 	<tr>
	 	<th style="text-align: center">지역1</th>
	 	<th style="text-align: center">지역2</th>
	 	<th style="text-align: center">관심사</th>
	 	<th style="text-align: center">게시글 제목</th>
	 	<th style="text-align: center">글쓴이(닉네임)</th>
	 	<th style="text-align: center">게시일</th>
	 	</tr>
	<c:forEach items="${list }" var="list">
	 		<tr>
	 			<td>${list.do1 }</td>
	 			<td>${list.si }</td>
	 			<td>${list.csname }</td>
	 			<td><a onclick="openBoard(${list.tbno})" style="cursor: pointer;">${list.title }</a></td>
	 			<td>${list.nickname }</td>
	 			<td>${list.regdate }</td>
	 		</tr>
	</c:forEach>
	 	</table>
	 	<div class="div1" style="text-align: center">
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
		</div>

</c:if>
 </div>
</div>


</body>
</html>