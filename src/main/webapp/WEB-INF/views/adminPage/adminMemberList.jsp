
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="/resources/css/admin/admin.css?ver=1.6">
<script>
$(document).on("click","#modifyProfilePicture",function(){
	var fileName = $("#fileopen").trigger('click',function(){
	});
});

$(document).on("change","#fileopen",function(){
	
	var formData = new FormData();
	 //첫번째 파일태그
	 formData.append("file",$("#fileopen")[0].files[0]);

	$.ajax({
		url : '/rest2/profile/image',
		data : formData,
		type : "POST",
		contentType: false,
		processData: false,
		success : function(result) {
			alert("프로필 변경");
			$("#profilePic").attr("src",result);			
		},
	});
});
	
	$(function(){
		
		$('#upgrade').click(function(){
			
			var ad = $('input:checkbox[name="auth-ad"]:checked').val();
			var mem = $('input:checkbox[name="auth-mem"]:checked').val();
						
			if(ad != null){
					
				$('input:checkbox[name="auth-ad"]').each(function(){
					if(this.checked){
						var ad_id = this.value.split('%')[0];
						var ad_auth = this.value.split('%')[1];
						//alert(ad_id)
						//alert(ad_auth)
						
						if(ad_auth == 2){
							
							alert("불가능한 작업입니다.");
							return;
							
						}
					}
				})
				
			}
			
			if(mem != null){
				
				$('input:checkbox[name="auth-mem"]').each(function(){
					if(this.checked){
						var mem_id = this.value.split('%')[0];
						var mem_auth = this.value.split('%')[1];
						//alert(mem_id)
						//alert(mem_auth)
						
						if(mem_auth < 2){
							
							//alert('업글')
							
							$.ajax({
								url: '/upgrade',
								data: 'id='+mem_id,
								success: function(result){
									
									location.reload();
								},
								error: function(result){
									alert('error');
								}
							});
							
						} 	
					}
				})
			}
		})
		
		
		$('#downgrade').click(function(){
			
			var ad = $('input:checkbox[name="auth-ad"]:checked').val();
			var mem = $('input:checkbox[name="auth-mem"]:checked').val();
						
			if(ad != null){
					
				$('input:checkbox[name="auth-ad"]').each(function(){
					if(this.checked){
						var ad_id = this.value.split('%')[0];
						var ad_auth = this.value.split('%')[1];
						//alert(ad_id)
						//alert(ad_auth)
						
						if(ad_auth == 2){
							
							$.ajax({
								url: '/downgrade',
								data: 'id='+ad_id,
								success: function(result){
									
									location.reload();
								},
								error: function(result){
									
								}
							});
							
						}			
					}
				})	
			}
			
			if(mem != null){
				
				$('input:checkbox[name="auth-mem"]').each(function(){
					if(this.checked){
						var mem_id = this.value.split('%')[0];
						var mem_auth = this.value.split('%')[1];
						//alert(mem_id)
						//alert(mem_auth)
						
						if(mem_auth == 0){
							alert("불가능한 작업입니다");	
							return;
						}
					}
				})
			}

		
		});	
		
		$(".pagination li a").on("click", function(event){
			
			event.preventDefault(); 
			
			var targetPage = $(this).attr("href");
			
			var paging = $("#paging");
			paging.find("[name='page']").val(targetPage);
			paging.attr("action","/memList").attr("method", "get");
			paging.submit();
		});
		
		$("#searchIt").click(function(event){
			
			event.preventDefault();
			
			var paging = $("#paging");
			
			paging.find("[name='page']").val(1);
			paging.attr("action","/memList").attr("method", "get");
			paging.submit();
			
		});
		
		
	});
	
	$(document).on("click", "#deleteBoard", function() {//게시글 삭제
		var tbno = $("#bno").val();
		alert(tbno+" : "+<%=request.getParameter("tbno")%>);
		$.ajax({
			type : 'delete',
			url : '/CommonDelete/'+tbno,
			success : function(result) {
				if(result=='success'){
					$('form[role="form"]',opener.document).attr('method', 'POST');
					$('form[role="form"]',opener.document).submit();
					self.close();
				}else{
					opener.location.reload();
					self.close();
				}
			}
		});
	});

</script>
<title>관리자페이지</title>
</head>
<body>
	<div class="container">
	    <div class="row profile">
	    <div class="header">
				<b>[ ${nick } ]</b> <kbd style="background-color: red"><a href="/admin"><font color="white">관리자</font></a></kbd>
				<div style="margin-top: 5px;">
				<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>&nbsp;&nbsp;|&nbsp;&nbsp;
				<kbd><a href="/index"><font color="white">메인페이지</font></a></kbd>
				</div>			
			</div>
			<div class="col-md-3">
				<div class="profile-sidebar">
					<!-- SIDEBAR USERPIC -->
					<div class="profile-userpic">
						<c:if test="${admin.profile == 'default.png' }">						
						<img src="${admin.profile }" class="img-responsive" alt="기존사진" id="profilePic"><br>
						</c:if>
						<c:if test="${admin.profile != 'default.png' }">
						<img src="${admin.profile }" class="img-responsive" alt="프로필사진" id="profilePic"><br>
						</c:if>
						<button type="button" class="btn btn-default" id="modifyProfilePicture">
  							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> <font size=2>사진 수정</font>
						</button>
						<input type="file" style="display: none;" id="fileopen">	
					</div>
					<!-- END SIDEBAR USERPIC -->
					<!-- SIDEBAR USER TITLE -->
					<div class="profile-usertitle">
						<div class="profile-usertitle-name">${admin.name}</div>
						<div class="profile-usertitle-job">${admin.nickname}</div>
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
	            <div class="col-sm-6">
		           	 <h3><b>모든 회원 정보</b></h3>
		        </div>
		        <div class="col-sm-6" style="text-align: right; margin-top: 15px">
					<button type="button" class="btn btn-success" id="upgrade">등급 Up</button>
					<button type="button" class="btn btn-danger" id="downgrade">등급 Down</button>
		        </div>
	  			<br><br><br><br>
	            <b><font size="4" color="red">관리자</font></b>
	            <table class="table">           	
					<tr>
					<th style="text-align: center">선택</th>
					<th style="text-align: center">이름</th>
					<th style="text-align: center">아이디</th>
					<th style="text-align: center">게시글 수</th>
					<th style="text-align: center">댓글 수</th>
					<th style="text-align: center">가입일</th>
					</tr>
	            <c:forEach items="${adminlist }" var="ad">
	            <c:if test="${ad.auth == 2 }">
	            	<tr>
	            	<td align="center"><input type="checkbox" name="auth-ad" value="${ad.id }%${ad.auth }"></td>
					<td align="center">${ad.name }</td>
					<td align="center">${ad.id }</td>
					<td align="center">${ad.myBoards }</td>
					<td align="center">${ad.replyCount }</td>
					<td align="center">${ad.regdate }</td>
					</tr>
	            </c:if>
	            </c:forEach>    
	            </table>        
	            <br>
	            <!-- 회원정보 -->
	            <form id="paging">
				  <input type='hidden' name="page" value=${pageMaker.cri.page }>
				  <input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
					 * 검색란을 비우고 검색을 하면 전체 회원을 검색할 수 있습니다.
		            <div class="memInfo" style="margin-left: -10px; margin-right: -15px;">
		            <div class="col-sm-6" style="margin-top: 10px;">
		          	  <b><font size="4" color="oramge">회원</font></b>
		            </div>
		            <div class="col-sm-6" style="text-align: right;">
			            <select class="form-control s" id="option" name="searchType">
							<option value="n" ${cri.searchType == 'n' ? 'selected' : '' }>이름</option>
							<option value="t" ${cri.searchType == 't' ? 'selected' : '' }>아이디</option>
						</select>
			            <input type="text" class="form-control t" name="keyword" placeholder="회원 검색" autocomplete="off" value="${	cri.keyword }">
			            <button type="button" class="btn btn-info" id="searchIt">검색</button>   
		            </div>
		            </div>
	            </form>
	            <br><br>
	            <table class="table">           	
					<tr>
					<th style="text-align: center">선택</th>
					<th style="text-align: center">이름</th>
					<th style="text-align: center">아이디</th>
					<th style="text-align: center">게시글 수</th>
					<th style="text-align: center">댓글 수</th>
					<th style="text-align: center">가입일</th>
					<th style="text-align: center">상태</th>
					</tr>
	            <c:forEach items="${memlist }" var="mem">
	            <c:if test="${mem.auth < 2 }">
					<tr>
					<td align="center"><input type="checkbox" name="auth-mem" value="${mem.id }%${mem.auth }"></td>
					<td align="center">${mem.name }</td>
					<td align="center">${mem.id }</td>
					<td align="center">${mem.myBoards }</td>
					<td align="center">${mem.replyCount }</td>
					<td align="center">${mem.regdate }</td>
					<c:if test="${mem.state == 0 }">
						<td align="center"><font color="green">양호</font></td>					
					</c:if>
					<c:if test="${mem.state == 1 }">
						<td align="center"><font color="red">경고</font></td>					
					</c:if>
					<c:if test="${mem.state == 2 }">
						<td align="center"><font color="red">정지</font></td>					
					</c:if>
					</tr>
				
	            </c:if>
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
	            </div>
			</div>
		</div>
	</div>
</body>
</html>