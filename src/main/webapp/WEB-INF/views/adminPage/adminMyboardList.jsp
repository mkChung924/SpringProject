<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- css파일 설정 : 경로를 바꿔주세요. -->
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/mypage.css?ver=1.4">
<!-- 프로필사진 업로드 -->
<script type="text/javascript" src="/resources/js/profileUpload.js"></script>
<script>
$(document).on("click",".pagination li a", function(event){
	event.preventDefault(); 
	var targetPage = $(this).attr("href");
	var paging = $("#paging");
	paging.find("[name='page']").val(targetPage);
	paging.attr("action","/adminWroteContents").attr("method", "get");
	paging.submit();
});

//삭제
$(document).on("click","#deleteBoard",function(){
		var chkedSize = $('input:checkbox[name="chbox1"]:checked').length;
		var deleteList ="";
		if(chkedSize < 1){
			alert('삭제할 신고를 선택하세요')
		} else {
			$('input:checkbox[name="chbox1"]').each(function() {
				if (this.checked) {
					deleteList += this.value+",";
				}
			});
			 $.ajax({
					url:'deleteAdminBoard',
					type : 'post',
					data: {
						deleteList : deleteList.substring(0, deleteList.length-1)
					},
					success:function(result){
						alert("삭제 성공")
						location.reload();
					},
					error:function(result){
						alert("삭제가 정상적으로 이루어지지 않았습니다.("+result.status+")");
					}
			}); 
		}
});
//수정
$(document).on("click","#updateBoard",function(){
	$("#deleteBoard").attr("disabled","disabled");// 삭제 막아두고
	$("#updateBoard").attr("disabled","disabled");// 수정도 막아두고
	
	var tbno = $("input[type=checkbox]:checked").val();
	
	if(typeof tbno=='undefined'){
		alert("게시물을 선택하지 않았습니다");
		$("#deleteBoard").removeAttr("disabled");// 삭제 해제
		$("#updateBoard").removeAttr("disabled");// 수정도 해제
	}else{
		var w = screen.width - 300;
        var h = screen.height - 200;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2) - 50;
        window.open("/adminTravelUpdate?tbno=" + tbno, "관리자 여행 "+tbno + "번 게시글 수정", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
		
	}
});

function adminReadPage(tbno,place1,place2,cno,csno) {
    var w = screen.width - 100;
    var h = screen.height - 100;
    var left = (screen.width / 2) - (w / 2);
    var top = (screen.height / 2) - (h / 2) - 100;
    window.open("/adminTravelRead?tbno=" + tbno+"&place1="+place1+"&place2="+place2+"&cno="+cno+"&csno="+csno, "관리자 여행 추천 "+tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
};
</script>
<title>관리자페이지-내글보기</title>
</head>
<body>
	<div class="container">
	    <div class="row profile">
	    <div class="header">
				<b>[ ${nick } ]</b>
				<kbd style="background-color: red">
					<a href="/admin"><font color="white"><b>관리자</b></font></a>
				</kbd>
				<div style="margin-top: 5px;">
					<kbd style="background-color: #EAEAEA">
						<a href="/logout"><font color="black">로그아웃</font></a></kbd> &nbsp;&nbsp;|&nbsp;&nbsp;
					<kbd>
						<a href="/index"><font color="white">메인페이지</font></a>
					</kbd>
				</div>		
			</div>
			<div class="col-md-3">
				<div class="profile-sidebar">
					<!-- SIDEBAR USERPIC -->
					<div class="profile-userpic">
						<c:if test="${mypage.profile == 'default.png' }">						
						<img src="http://goo.gl/5SYWQ9" class="img-responsive" alt="기존사진"><br>
						</c:if>
						<c:if test="${mypage.profile != 'default.png' }">
						<img src="${mypage.profile }" class="img-responsive" alt="프로필사진"><br>
						</c:if>
						<button type="button" class="btn btn-default" id="modifyProfilePicture">
  							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> <font size=2>사진 수정</font>
						</button>
						<input type="file" style="display: none;" id="fileopen">
					</div>
					<!-- END SIDEBAR USERPIC -->
					<!-- SIDEBAR USER TITLE -->
					<div class="profile-usertitle">
						<div class="profile-usertitle-name">${mypage.name}</div>
						<div class="profile-usertitle-job">${mypage.nickname}</div>
					</div>
					<!-- END SIDEBAR USER TITLE -->
					<!-- SIDEBAR BUTTONS -->

					<!-- END SIDEBAR BUTTONS -->
					<!-- SIDEBAR MENU -->
					<div class="profile-usermenu">
						<%@include file="adminNavList.jsp" %>
					</div>
					<!-- END MENU -->
				</div>
			</div>
			<div class="col-md-9">
	            <div class="profile-content">
	            <!-- 이곳에 html을 작성하면 됩니다! -->
	            
	            <div class="col-sm-12">
		            <h3><b>여행 추천 게시물 현황</b></h3>
		        </div>

	            <c:if test="${myboardList.size() < 1 }">
	            <div style="text-align: center; margin-top: 25%;">
	            	<h4><i>게시글이 존재하지 않습니다. 글을 남겨보세요!</i></h4>
	            </div>
	            </c:if>
	            <br>
	            <c:if test="${myboardList.size() > 0 }">
	            <br><br>
	            <div class="col-sm-12" style="text-align: right; display: inline">
	            	<input id="updateBoard" name="submit" type="button" value="수정" class="btn btn-primary"> 
	            	<input id="deleteBoard" name="delete" type="button" value="삭제" class="btn btn-danger">
	            </div>
	            <table class="table table-striped">
	           		<thead class="thead-inverse">
					<tr>
						<th>선택</th>
						<th>제목</th>
						<th>지역1</th>
						<th>지역2</th>
						<th>조회수</th>
						<th>등록날짜</th>
					</tr>
					</thead>	
					<tbody>
					<c:forEach items="${myboardList }" var="myboard">
						<tr>
							<td><input type="checkbox" name=chbox1 value="${myboard.tbno }"></td>
							<td onclick="adminReadPage('${myboard.tbno}','${myboard.place1}','${myboard.place2}','${myboard.cno}','${myboard.csno}')" style="cursor: pointer;">${myboard.title }</td>
							<td>${myboard.place1 == '1' ? 'N/A' : myboard.place1 }</td>
							<td>${myboard.place2 == '2' ? 'N/A' : myboard.place2 }</td>
							<td>${myboard.viewcnt }</td>
							<td>${myboard.regdate }</td>
						</tr>
					</c:forEach>
					</tbody>
	            </table>
				
				<div class="div1" style="text-align: center">
					<c:if test="${pageMaker.prev}">
						<ul class="pagination">
							<li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
						</ul>
					</c:if>
					<ul class="pagination">
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
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
					
					<form id="paging">
						<input type='hidden' name="page" value=${pageMaker.cri.page }>
				 		<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
					</form>
					</c:if>
	            </div>
			</div>
		</div>
	</div>
</body>
</html>