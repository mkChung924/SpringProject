<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- 댓글 css -->
<link href="/resources/css/board/reply.css" rel="stylesheet">

<!-- css jquery boot 순으로 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.10/handlebars.js"></script>
<!-- TinyMCE -->
<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
<script>
	tinymce.init({
		selector : '#editor',
		height : 500,
		readonly : true,
		menubar : false,
		toolbar : false
	});
</script>
<!--======================================댓글====================================-->
<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li>
	<div class="comment-main-level" >
		<div class="comment-avatar"><img src="http://i9.photobucket.com/albums/a88/creaticode/avatar_1_zps8e1c80cd.jpg" alt=""></div>
		<div class="comment-box" >
			<div class="comment-head">
				{{#isAuthor id}}
					<h6 class="comment-name by-author"><a href="http://creaticode.com/blog">{{nickname}}</a></h6>
				{{else}}
					<h6 class="comment-name"><a href="http://creaticode.com/blog">{{nickname}}</a></h6>			
				{{/isAuthor}}
				<span>{{prettifyDate updatedate}}</span>
				<i class="fa fa-reply"></i>
				<i class="fa fa-heart"></i>
				<input type="hidden" name="{{id}}" id="{{id}}">
				<input type="hidden" name="rno" id="{{rno}}">
				<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal" style="float: right;" id="replyModify">Modify</a>
			</div>
			<div class="comment-content">{{content}}
			</div>
		</div>
	</div>
</li>
{{/each}}
</script>
<script type="text/javascript">
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth();
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	Handlebars.registerHelper('isAuthor', function(id, options) {
		if (id == '${commonBoard.id}') {
			return options.fn(this);
		} else {
			return options.inverse(this);
		}
	});

	var printData = function(replyArr, target, templateObject) {
		var template = Handlebars.compile(templateObject.html());
		var html = template(replyArr);
		target.html(html);
	}
	function getPage(pageInfo) {
		console.log(pageInfo);
		$.ajax({
			type : 'get',
			url : pageInfo,
			dataType : 'JSON',
			success : function(data) {
				printData(data, $("#comments-list"), $("#template"));
			//printPaging(data.pageMaker, $(".pagination"));
			}
		});
	}
	$(document).on("click", "#replyModify", function() { // add reply
		var reply = $(this);
		reply.parent().find("input[name=rno]").attr("id"); // 글번호
		reply.parent().parent().find("div[class=comment-content]").html(); // 글 내용

		$("#modalTitle").html(reply.parent().find("input[name=rno]").attr("id"));
		$("#modalText").val(reply.parent().parent().find("div[class=comment-content]").html());
	});

	$(document).on("click", "#addReply", function() { // add reply
		var replyerObj = $("#userid");
		var replytextObj = $("#replyContent");

		var replyer = replyerObj.val();
		var replytext = replytextObj.val();
		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : JSON.stringify({
				tbno : $("#bno").val(),
				id : replyer,
				content : replytext
			}),
			success : function(result) {
				console.log(result);
				if (result == 'SUCCESS') {
					alert('등록되었습니다');
					//replyPage =1;
					//getPage("/replies/"+bno+"/"+replyPage); 
					getPage("/replies/all/" + $("#bno").val());
					location.reload();
					replyerObj.val("");
					replytextObj.val("");

				}
			}
		});
	});

	$(document).on("click", "#replyModBtn", function() {
		if ("${commonBoard.id}" == '${id}') {

			var rno = $("#modalTitle").html();
			var replytext = $("#modalText").val();

			$.ajax({
				type : 'put',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({
					content : replytext
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert('수정되었습니다');

						getPage("/replies/all/" + $("#bno").val());
					}
				}
			});
		} else {
			alert("당신은 수정할 권한이 없습니다.");
		}
	});

	$(document).on("click", "#replyDelBtn", function() {
		if ("${commonBoard.id}" == '${id}') {
			var rno = $("#modalTitle").html();
			var replytext = $("#modalText").val();
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("삭제 되었습니다.");
						getPage("/replies/all/" + $("#bno").val());
					}
				}
			});
		}else{
			alert("당신은 삭제할 권한이 없습니다.");
		}
	});

	$(document).on("click", "#deleteBoard", function() {//게시글 삭제
		var tbno = $("#bno").val();
		alert(tbno+" : "+<%=request.getParameter("tbno")%>);
		$.ajax({
			type : 'delete',
			url : '/CommonDelete/'+tbno,
			success : function(result) {
				if(result=='success'){
					opener.location.reload();
					self.close();
				}else{
					opener.location.reload();
					self.close();
				}
			}
		});
	});
	
	$(function() {
		getPage("/replies/all/" + $("#bno").val());
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1 style="display: inline;">관심 페이지 이미지로~~</h1>
		<input type="button" class="btn btn-danger" id="deleteBoard" value="게시물 삭제" style="float: right;"/>
		<input type="text" id="userid" value="${id }" readonly> 
		<input type="text" id="bno" value="<%=request.getParameter("tbno")%>" readonly>
		<div class="row">
			<div class="col-sm-6" style="background-color: yellow;">
				<!-- 왼쪽 div -->
				<input type="text" class="form-control" id="title"
					value="${commonBoard.title}" placeholder="제목 입력란" readonly>
				<br> <input type="text" class="form-control" id="title"
					value="${commonBoard.notice}" placeholder="공지 사항" readonly>
				<br>
				<textarea id="editor" name="content" readonly="readonly"
					style="width: 100%;">${commonBoard.content}</textarea>
			</div>

			<div class="col-sm-6" style="background-color: pink;">
				<!-- 오른쪽 div -->
				<label>OpenChat</label> <input type="text" class="form-control"
					id="title" value="${commonBoard.openchat}" placeholder="작성자"
					readonly> <br> <label>전화 번호</label>
				<div>
					<c:set var="telParts" value="${fn:split(commonBoard.tel, '-')}" />
					<input class="form-control" id="inputPhone" maxlength="4"
						name="phone1" required="required" size="3" type="tel"
						value="${telParts[0]}" style="width: 25%; display: inline"
						readonly>- <input class="form-control" id="inputPhone"
						maxlength="4" name="phone2" required="required" size="3"
						type="tel" value="${telParts[1]}"
						style="width: 25%; display: inline" readonly>- <input
						class="form-control" id="inputPhone" maxlength="4" name="phone3"
						required="required" size="3" type="tel" value="${telParts[2]}"
						style="width: 25%; display: inline" readonly>
				</div>
				<div style="margin-top: 10px;">
					<input type="text" class="form-control" id="replyContent"
						placeholder="댓글 입력" style="width: 75%; display: inline"> <input
						id="addReply" type="button" class="btn btn-success" value="입력">
				</div>
				<hr>
				<!-- 여기 부터 댓글 부분 -->

				<div class="comments-container"
					style="margin-top: 10px; width: 100%; overflow: scroll; height: 500px">
					<ul id="comments-list" class="comments-list">
					</ul>
				</div>
			</div>
			<!-- 두번째 div -->
		</div>
		<!-- 통합 div -->
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="modalTitle"></h4>
				</div>
				<div class="modal-body">
					<p>
						<input class="form-control" type="text" id="modalText">
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>