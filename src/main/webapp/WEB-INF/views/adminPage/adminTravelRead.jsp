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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- 프로필사진 업로드 -->
<script type="text/javascript" src="/resources/js/profileUpload.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.10/handlebars.js"></script>
<!-- TinyMCE -->
<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
<script>
	tinymce.init({
		selector : '#editor',
		height : 800,
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
				<a class="btn btn-info btn-xs" style="float: right; margin-left: 5px;" id="msgSend" onclick="msgSend('{{id}}')">메시지</a>
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

<script id="reviewTemplate" type="text/x-handlebars-template">
<kbd>여행 후기 리뷰</kbd>
<ul class="list-group" style="margin-top: 3px;">
{{#each .}}
	<li style="padding: 5px;" id="reviewLink-{{tbno}}" href="#" class="list-group-item justify-content-between" onclick="linkReview('{{tbno}}')"><font color=red>{{nickname}}</font> 님의 후기! <span style="float:right; padding-right: 45%;">"{{title}}"</span></li>
{{/each}}
</ul>
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
	
	var printDataReview = function(reviewArr, target, templateObject) {
		var template = Handlebars.compile(templateObject.html());
		var html = template(reviewArr);
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
							$("#likeCnt").html("좋아요 &nbsp; "+result);
							$("#likeCnt-${commonBoard.tbno}",opener.document).html(result);
					},
				}); 
	}
	
	
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
	
	
	$(document).on("click",".pagination li a", function(event){
		event.preventDefault(); 
		var page = $(this).html();
		getPageReview("adminTravelRie/"+page);
		$(".pagination li[class=active]").attr("class","");
		$(this).parent().attr("class","active");
	});
	
	function getPageReview(pageInfo) {
		console.log("review page : "+pageInfo);
		$.ajax({
			type : 'post',
			url : pageInfo,
			data :{
				tbno :$("#bno").val(),
				place1 :$("#place1").val(),
				place2 : $("#place2").val(),
				cno :$("#cno").val(),
				csno : $("#csno").val()
			},
			dataType : 'JSON',
			success : function(data) {
				printDataReview(data, $("#reviewDiv"), $("#reviewTemplate"));
			}
		});
	}
	
	function linkReview(tbno) {
		var w = screen.width-200;
		var h = screen.height-100;
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2) - 50;
		var open = window.open("/CommonRead?tbno="+tbno, tbno+"번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	};
	
	$(function() {
		getPage("/replies/all/" + $("#bno").val());
		getPageReview("/adminTravelRie/1");
	});
	

</script>
<title>${commonBoard.title }</title>
</head>
<body>
		<br>
		<div class="col-sm-12">
			<div class="col-sm-7">
				<textarea id="editor" name="content" readonly="readonly" style="width: 100%;">${commonBoard.content}</textarea>
				<input type="hidden" id="userid" value="${id }" readonly> 
				<input type="hidden" id="bno" value="${commonBoard.tbno }" readonly>
			</div>
			
			<div class="col-sm-5">
				<label>제목</label>
				<input type="text" class="form-control" id="title" value="${commonBoard.title}" placeholder="제목 입력란" readonly><br>
				<label>간략설명</label>
				<input type="text" class="form-control" id="title" value="${commonBoard.notice}" placeholder="간략 설명" readonly><br>
				
				<div class="col-sm-12">
				<c:if test="${commonBoard.myFavor == 1 }">
					<div class="col-sm-1">
						<p class="p-${commonBoard.tbno }" align="left">
							<i class="glyphicon glyphicon-star" id="bk-${commonBoard.tbno }"
								onclick="favor(${commonBoard.tbno})" data-toggle="bookmark"
								data-placement="bottom" title="즐겨찾기 해제"
								style="font-size: 25px; cursor: pointer;"></i>
						</p>
					</div>
				</c:if>
				<c:if test="${commonBoard.myFavor == 0 }">
					<div class="col-sm-1">				
						<p align="left">
							<i class="glyphicon glyphicon-star-empty"
								id="bk-${commonBoard.tbno }"
								onclick="favor(${commonBoard.tbno})" data-toggle="bookmark"
								data-placement="bottom" title="즐겨찾기 추가"
								style="font-size: 25px; cursor: pointer; color: yellow"></i>
						</p>
					</div>	
				</c:if>
					<div class="col-sm-5">
						<p align="left">
							<span class="badge" style="background-color: blue" onclick="likes(${commonBoard.tbno})" id="likeCnt">좋아요 &nbsp; ${commonBoard.likes }</span>
							<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" style="size: 50px; font-size: 20px; cursor: pointer;" data-placement="top" title="좋아요"
								onclick="likes(${commonBoard.tbno})"></i>
						</p>
					</div>
					<div class="col-sm-6" style="text-align: right; margin-top: 3px;">
						<a class="btn btn-info btn-xs" style="margin-left: 5px;" id="msgSend" onclick="msgSend('${commonBoard.id}')"><font size="2">메시지 보내기</font></a>		
								
					</div>
				</div>
				<br>
				<div class="reply" style="text-align: right; margin-top: 10px;">
					<input type="text" class="form-control" id="replyContent" placeholder="댓글 입력" style="width: 85%; display: inline"> 
					<input id="addReply" type="button" class="btn btn-success" value="입력" style="display: inline;">
				</div>
				<!-- 여기 부터 댓글 부분 -->
				<div class="comments-container scrollbar force-overflow"
					style="margin-top: 10px; width: 100%; overflow: scroll overfl; overflow:x:hidden; height: 200px; background-color: #EBF7FF;
					border-radius: 1%;"
					id="scrollbar119">
					<ul id="comments-list" class="comments-list">
					</ul>
				</div>
				
				<div><!-- 후기 부분 링크 -->
					<div id="reviewDiv"></div>
				
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
					
					<form id="paging"><!-- hidden -->
						<input type='hidden' id="page" value=${pageMaker.cri.page }>
			 			<input type='hidden' id="perPageNum" value=${pageMaker.cri.perPageNum }>
			 			<input type='hidden' id="cno" value=${cri.cno }>
			 			<input type='hidden' id="csno" value=${cri.csno }>
			 			<input type='hidden' id="place1" value=${cri.place1 }>
			 			<input type='hidden' id="place2" value=${cri.place2 }>
					</form>
				</div>

			</div> <!-- 오른쪽  -->
		
		</div>

		<!-- 통합 div -->
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