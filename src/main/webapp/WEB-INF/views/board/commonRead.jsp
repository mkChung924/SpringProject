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
		<div class="comment-avatar"><img src="{{profile}}" alt=""></div>
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
				<input type="hidden" name="userid" id="{{id}}" value={{id}}>
				<input type="hidden" name="rno" id="{{rno}}">
				<a class="btn btn-info btn-xs" style="float: right; margin-left: 5px;" id="msgSend" onclick="msgSend('{{id}}')">메시지함</a>
				{{#viewModifyBtn id}}
				<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal" style="float: right; margin-left: 5px;" id="replyModify">Modify</a>
				{{else}}
				<a class="btn btn-danger btn-xs"  data-toggle="modal" data-target="#myModal2" style="float: right; margin-left: 5px;" id="reportSend" onclick="reportSend('{{content}}','{{rno}}','{{id}}',2)">신고</a>
				{{/viewModifyBtn}}
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
	
	Handlebars.registerHelper('viewModifyBtn', function(id, options) {
		if (id == '${id}') {
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
				$("#userid").val('${id}');
				printData(data, $("#comments-list"), $("#template"));
				$('#userid').val('${id }');
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
		var profile = '${profile}';

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
				content : replytext,
				profile : profile
			}),
			success : function(result) {
				console.log(result);
				if (result == 'SUCCESS') {
					alert('등록되었습니다');
					getPage("/replies/all/" + $("#bno").val());
					replyerObj.val("");
					replytextObj.val("");
					$("#modalClose").trigger('click');
				}
			}
		});
	});

	$(document).on("click", "#replyModBtn", function() {
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
						$("#modalClose").trigger('click');
					}
				}
			});
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
						$("#modalClose").trigger('click');
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
	
	function favor(tbno) { //즐겨 찾기
		$.ajax({
			url : '/rest/bookmark',
			data : 'id=' + "${id }" + '&tbno=' + tbno,
			success : function(result) {
				if (result == "OK") {

					$('#bk-' + tbno).attr("class", "glyphicon glyphicon-star");
					$('#bk-' + tbno).attr("title", "즐겨찾기 해제");
					$('#bk-' + tbno).attr("data-original-title", "즐겨찾기 해제");
					
					$('#bk-' + tbno,opener.document).attr("class", "glyphicon glyphicon-star");
					$('#bk-' + tbno,opener.document).attr("title", "즐겨찾기 해제");
					$('#bk-' + tbno,opener.document).attr("data-original-title", "즐겨찾기 해제");
				} else {

					$('#bk-' + tbno).attr("class", "glyphicon glyphicon-star-empty");
					$('#bk-' + tbno).attr("title", "즐겨찾기 추가");
					$('#bk-' + tbno).attr("data-original-title", "즐겨찾기 추가");
					
					$('#bk-' + tbno,opener.document).attr("class", "glyphicon glyphicon-star-empty");
					$('#bk-' + tbno,opener.document).attr("title", "즐겨찾기 추가");
					$('#bk-' + tbno,opener.document).attr("data-original-title", "즐겨찾기 추가");
				}
			},
		});
	}
	
	function likes(tbno) { //좋아요
		 		$.ajax({
					url : '/like/add',
					data : 'id=' + "${id }" + '&tbno=' + tbno,
					success : function(result) {
							$("#likeCnt").html(result);
							$("#likeCnt-${commonBoard.tbno}",opener.document).html(result);
					},
				}); 
	}
	
	$(document).on("click", "#updateBoard", function() {
		var w = 800;
		var h = 400;
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2);
		window.open("/CommonUpdate?tbno=" + ${commonBoard.tbno }, ${commonBoard.tbno } + "번 게시글 수정", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	   	self.close();
	});
	
	
	function msgSend(id) {//메시지 보내기
		var w = 300;
		var h = 500;
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2);
		alert(id);
		var open = window.open("/msgSend?id="+id, "메시지 보내기", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
		open.document.getElementById("targetid").value = id;
	};
	
	function reportSend(content,brno,replyer,kind) {//신고 보내기 전 보여주는 부분
		var str = "";
		$.ajax({
			url : '/reportList',
			type : 'POST',
			success : function(result) {
				for(var i=1;i<result.length;i++){
					str += "<option>"+result[i]+"</option>";
				}
				$("#modalTitle2").html(replyer+"님을 신고 중입니다");
				$("#brContent").val(content);
				$("#brno").val(brno);
				$("#brReportkind").val(kind);
				$("#roportType").html(str);
			},
		}); 
	};
	
	
	$(document).on("click","#addReport",function(){//진짜 신고로 날라가는 부분
		var input = confirm('정말로 신고 하시겠습니까?'); 
		if(input){
			$.ajax({
				url : '/addReport',
				type : 'POST',
				data : {
					brno : $("#brno").val(),
					content : $("#brContent").val(),
					reportkind : $("#brReportkind").val(),
					reporttype :$("#roportType option:selected").val()
				},
				success : function(result) {
					if(result=="SUCCESS"){
						alert("신고 완료");
						$("#modalClose2").trigger('click');
					}
				},
			}); 
		}else{
			$("#modalClose2").trigger('click');
		}
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
		<c:if test="${commonBoard.id == id}">
			<input type="button" class="btn btn-danger" id="deleteBoard"
				value="게시물 삭제" style="float: right;" />
		</c:if>
		<c:if test="${commonBoard.id == id || auth == 2}">
			<input type="button" class="btn btn-info" id="updateBoard"
				value="게시물 수정" style="float: right; margin-right: 15px;" />
		</c:if>
		<input type="hidden" id="userid" value="${id }" readonly> <input
			type="hidden" id="bno" value="${commonBoard.tbno }" readonly>
		<div class="row">
			<div class="col-sm-6">
				<!-- 왼쪽 div -->
				<input type="text" class="form-control" id="title"
					value="${commonBoard.title}" placeholder="제목 입력란" readonly>
				<br> <input type="text" class="form-control" id="title"
					value="${commonBoard.notice}" placeholder="공지 사항" readonly>
				<br>
				<textarea id="editor" name="content" readonly="readonly"
					style="width: 100%;">${commonBoard.content}</textarea>
			</div>

			<div class="col-sm-6">
				<!-- 오른쪽 div -->
				<label>OpenChat</label> <input type="text" class="form-control"
					id="title" value="${commonBoard.openchat}" placeholder="작성자"
					readonly> <br>

				<!-- ================ 즐겨 찾기 표시 -->
				<c:if test="${commonBoard.myFavor == 1 }">
					<div class="col-md-6">
						<p class="p-${commonBoard.tbno }" align="left">
							<i class="glyphicon glyphicon-star" id="bk-${commonBoard.tbno }"
								onclick="favor(${commonBoard.tbno})" data-toggle="bookmark"
								data-placement="bottom" title="즐겨찾기 해제"
								style="font-size: 25px; cursor: pointer;"></i>
						</p>
					</div>
				</c:if>
				<c:if test="${commonBoard.myFavor == 0 }">
					<div class="col-md-6">
						<p align="left">
							<i class="glyphicon glyphicon-star-empty"
								id="bk-${commonBoard.tbno }"
								onclick="favor(${commonBoard.tbno})" data-toggle="bookmark"
								data-placement="bottom" title="즐겨찾기 추가"
								style="font-size: 25px; cursor: pointer;"></i>
						</p>
					</div>
				</c:if>
				<!-- ================ 즐겨 찾기 표시 끝 -->
				
				<!-- ================ 게시글 작성자에게 메시지 보내기 표시 -->
				<a class="btn btn-info btn-xs" style="float: right; margin-left: 5px;" id="msgSend" onclick="msgSend('${commonBoard.id}')">메시지함</a>
				<!-- ================ 게시글 작성자에게 메시지 보내기 표시 끝 -->
				
				<!-- 신고 -->	
				<a class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal2" style="float: right; margin-left: 5px;" id="reportSendBoard" onclick="reportSend('${commonBoard.title}','${commonBoard.tbno}','${commonBoard.id}',1)">신고</a>			
				
				<!-- ================ 좋아요 표시 끝 -->
				<p align="right">
					<span class="badge" style="background-color: blue"
						onclick="likes(${commonBoard.tbno})" id="likeCnt">${commonBoard.likes }</span>
					<i class="glyphicon glyphicon-thumbs-up" data-toggle="like"
						style="size: 50px;" data-placement="top" title="좋아요"
						onclick="likes(${commonBoard.tbno})"></i>
				</p>
				<!-- ================ 좋아요 표시 끝 -->


				<label>전화 번호</label>
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

				<div class="comments-container scrollbar force-overflow"
					style="margin-top: 10px; width: 100%; overflow: scroll overfl; overflow:x:hidden; height: 500px"
					id="scrollbar119">
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
						<button type="button" class="btn btn-default" data-dismiss="modal" id="modalClose">Close</button>
					</div>
				</div>
		</div>
	</div>
	

	<!-- Modal -->
	<div class="modal fade" id="myModal2" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" id="modalTitle2"></h4>
					</div>
					<div class="modal-body">
						<p>
							<input type="hidden" id="brno" name="brno"><!-- 게시글 or 댓글 번호 -->
							<input type="hidden" id="brContent" name="content"><!--글 내용 -->
							<input type="hidden" id="brReportkind" name="reportkind"><!--신고 종류 1:게시글, 2: 댓글  -->
							<select name="roportType" id="roportType"></select><!-- 신고 유형 -->	
						</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" id="addReport">신고</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" id="modalClose2">Close</button>
					</div>
				</div>
		</div>
	</div>
</body>
</html>