<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$('[data-toggle="comment"]').tooltip();
		$('[data-toggle="like"]').tooltip();   
		$('[data-toggle="review"]').tooltip();   
	});
	
</script>
<style>
body{
	background-color: #F1F3FA;
	height: 1500px
}
.row{
	margin-top: 20px;
	text-align: center;
}

.header {
	margin-right: 7px;
	margin-top: 20px;
	text-align: right;
}

.m, img{
	border-radius: 5%;
}

#together, #review, #write{
	margin-top: 10px;
}

/*
#together:hover {
	background-color: pink;
}

#together:focus {
	background-color: pink;
} */

.t {
	width: 180;
	display: inline;
	padding-top: 5;
}
.s {
	display: inline;
	width: 80;
}

.glyphicon {
	font-size: 20px;
}
</style>
</head>

<body>
<div class="container" style="margin-bottom: 5px;">
    <div class="row">
    	<div class="header">
			<b>${id }</b>님 환영합니다<br>
			<div style="margin-top: 5px;">
			<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>&nbsp;&nbsp;|&nbsp;&nbsp;<kbd><a href="/index"><font color="white">메인페이지</font></a></kbd>
			</div>
		</div>

		<br>
		<div class="row">
            <div class="col-md-3">
                <div class="thumbnail m">
                    <img src="http://placehold.it/320x200" alt="ALT NAME" class="img-responsive"/>
                    <div class="caption">
                        <h3><i>속초로 떠나요 !</i></h3>
                        <p>Description</p>
                        <p align="center"><a href="#" class="btn btn-primary btn-block">Open</a>
                        </p>
                    </div>
                    <div style="padding-bottom: 10px;">
                   		 <i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp;
                   		<span class="badge" style="background-color: gray">2</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" data-placement="top" title="좋아요"></i>&nbsp;
                   		<span class="badge" style="background-color: blue">5</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-tags" data-toggle="review" data-placement="bottom" title="후기"></i>&nbsp;
                   		<span class="badge" style="background-color: green">1</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="thumbnail m">
                    <img src="http://placehold.it/320x200" alt="ALT NAME" class="img-responsive" />
                    <div class="caption">
                        <h3><i>삼척으로 떠나요 !</i></h3>
                        <p>Description</p>
                        <p align="center"><a href="#" class="btn btn-primary btn-block">Open</a>
                        </p>
                    </div>
                    <div style="padding-bottom: 10px;">
                   		 <i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp;
                   		<span class="badge" style="background-color: gray">2</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" data-placement="top" title="좋아요"></i>&nbsp;
                   		<span class="badge" style="background-color: blue">5</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-tags" data-toggle="review" data-placement="bottom" title="후기"></i>&nbsp;
                   		<span class="badge" style="background-color: green">1</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="thumbnail m">
                    <img src="http://placehold.it/320x200" alt="ALT NAME" class="img-responsive" />
                    <div class="caption">
                        <h3><i>동해로 떠나요 !</i></h3>
                        <p>Description</p>
                        <p align="center"><a href="#" class="btn btn-primary btn-block">Open</a>
                        </p>
                    </div>
                    <div style="padding-bottom: 10px;">
                   		 <i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp;
                   		<span class="badge" style="background-color: gray">2</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" data-placement="top" title="좋아요"></i>&nbsp;
                   		<span class="badge" style="background-color: blue">5</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-tags" data-toggle="review" data-placement="bottom" title="후기"></i>&nbsp;
                   		<span class="badge" style="background-color: green">1</span>
                    </div>
                </div>
            </div>  
            <div class="col-md-3">
                <div class="thumbnail m">
                    <img src="http://placehold.it/320x200" alt="ALT NAME" class="img-responsive" />
                    <div class="caption">
                        <h3><i>강릉으로 떠나요 !</i></h3>
                        <p>Description</p>
                        <p align="center"><a href="#" class="btn btn-primary btn-block">Open</a></p>
                    </div>
                    <div style="padding-bottom: 10px;">
                   		 <i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp;
                   		<span class="badge" style="background-color: gray">2</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" data-placement="bottom" title="좋아요"></i>&nbsp;
                   		<span class="badge" style="background-color: blue">5</span> &nbsp;&nbsp;&nbsp;
                   		<i class="glyphicon glyphicon-tags" data-toggle="review" data-placement="bottom" title="후기"></i>&nbsp;
                   		<span class="badge" style="background-color: green">1</span>
                    </div>
                </div>
            </div>
        </div> 
        
        <!-- 검색 -->
        <div class="row">
        	<div class="col-md-12">
				<div class="thumbnail">
					<div class="caption" style="text-align: right">
						<div class="col-sm-3" style="text-align: right; padding-top: 5">
							<button type="button" class="btn btn-warning" style="padding: 0px; width: 66px;">내 위치</button>&nbsp;
							<i><font size=3>${do1 } ${si } ${dong }</font></i>
						</div>
						<div class="col-sm-3" style="text-align: right; padding-top: 5">
							<button type="button" class="btn btn-info" style="padding: 0px; width: 66px;">카테고리</button>&nbsp;
							<i><font size=3>${category } - ${subcategory }</font></i>
						</div>
						<select class="form-control s" id="option">
							<option value="0">작성자</option>
							<option value="1">제목</option>
						</select>
						<input type="text" class="form-control t" name="search">
						<button type="button" class="btn btn-default" id="search">검색</button><br>
						<c:if test="${cno == 1 }">	
							<button type="button" class="btn btn-default" id="review">여행 후기 모아보기</button>					
							<button type="button" class="btn btn-default" id="together">관심글 모아보기</button>
						</c:if>		
							<button type="button" class="btn btn-default" id="write">게시글 작성</button>			
					</div>
				</div>
			</div>
			<!-- 게시글 -->
        	<div class="col-md-4" style="max-height: 400">
	        	<div class="thumbnail">
		        	<div class="caption">
		        		<div style="text-align: left; padding-top: 0px;">
		              	 <img src="/resources/image/category_img/noprofile.png" style="border-radius: 50%; width: 10%; margin-top: -15px"> &nbsp;
		              	 <font size=4><b>홍길동</b></font>
			              	 <div style="display: inline-block; text-align: right; width: 71%; padding-top: 5px;">
			              		 2017-06-30 <font color=red>D-10</font><br>${si } ${dong }
			              	 </div>
		                </div>
		                <hr>
		                <div>
		                	<b><i><font size="4">떠나자</font></i></b>
		                </div>
		                <br>
		                <div class="row" style="padding-left: 20px;">
		                	<div class="col-md-6">
				                <p align="left">
				                <i class="glyphicon glyphicon-star-empty" style="font-size: 25px; cursor: pointer;"></i>
				                </p>
		                	</div>
		                	<div class="col-md-6">
				                <p align="right">
		                   		<span class="badge" style="background-color: gray">2</span>
				                <i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp; &nbsp;&nbsp;&nbsp;
				                </p>
		                	</div>
		                </div>
		             </div>
		        </div>
	        </div>
        </div>
    </div>
</div>


</body>
</html>

