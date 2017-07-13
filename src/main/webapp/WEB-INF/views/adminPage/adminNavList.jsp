<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(function(){
	var url= location.href;
	var lastsl=url.lastIndexOf('/');
	url = url.substring(lastsl+1);
	$('.nav li').each(function(index) { 		
		 if(url==$(this).children("a").attr("href")){
			 $(this).attr("class","active");    			 
		 }else{
			 $(this).removeAttr("class");    			 
		 }
	});
	
});
</script> 
<ul class="nav">
	<li><a href="admin"> <i class="glyphicon glyphicon-exclamation-sign"></i>내 정보</a></li>
	<li><a href="memList"> <i class="glyphicon glyphicon-user"></i>회원 현황</a></li>
	<li><a href="adminFavorite"> <i class="glyphicon glyphicon-heart"></i>즐겨찾기</a></li>
	<li><a href="admessage"> <i class="glyphicon glyphicon-envelope"></i>메시지함</a></li>
	<li><a href="reportBox"> <i class="glyphicon glyphicon-warning-sign"></i>신고접수함</a></li>
	<li><a href="adminBoardsList"><i class="glyphicon glyphicon-th-list"></i>게시판 현황 </a></li>
	<li><a href="adminWroteContents"> <i class="glyphicon glyphicon-list-alt"></i>여행 추천 게시물 현황</a></li>
	<li><a href="adminWrite"> <i class="glyphicon glyphicon-tent"></i>여행 추천 게시글 작성</a></li>
</ul>
