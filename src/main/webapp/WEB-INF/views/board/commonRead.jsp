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
<link href="/resources/css/board/reply.css?ver=1.1" rel="stylesheet">

<!-- css jquery boot 순으로 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.10/handlebars.js"></script>
<!-- TinyMCE -->
<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
<script type="text/javascript" src="http://scmplayer.co/script.js" 
data-config="{'skin':'http://static.tumblr.com/mky4cgu/hLPmq7qjp/glsfalsa-moral.css',
'volume':50,'autoplay':true,'shuffle':true,'repeat':1,'placement':'top','showplaylist':false,
'playlist':[
{'title':'A Lover`s concerto','url':'https://www.youtube.com/watch?v=KahAPQ9sl6g'},
{'title':'Early in the morning','url':'https://www.youtube.com/watch?v=aGFuRN0n0pw'},
{'title':'How Deep Is Your Love','url':'https://www.youtube.com/watch?v=XpqqjU7u5Yc'},
{'title':'Those were the days','url':'https://www.youtube.com/watch?v=QO9A9u4GyGc'},
{'title':'You Call It Love','url':'https://www.youtube.com/watch?v=YjtemOT9tWA'},
{'title':'%uD558%uC6B8%uC758 %uC6C0%uC9C1%uC774%uB294 %uC131','url':'https://www.youtube.com/watch?v=NXt-YY3Xt8Q'},
{'title':'Reality','url':'https://www.youtube.com/watch?v=arg-TuFxmq0'},
{'title':'tie a yellow ribbon round the ole oak tree','url':'https://www.youtube.com/watch?v=CFCWv1CUhOE'},
{'title':'%uC5BC%uC74C%uC5F0%uBABB-%uB450%uBC88%uC9F8 %uB2EC','url':'https://www.youtube.com/watch?v=bfcL8KqpgKs'},
{'title':'Summer','url':'https://www.youtube.com/watch?v=Xrj9L2ez6IA&index=7&list=PLj0NDC_7rACIFN7si71ybxf89rKq1YtaL'},
{'title':'Qui A Tue Grand Maman','url':'https://www.youtube.com/watch?v=-wgqxyOFngY'}]}" >
</script>
<script>
	tinymce.init({
		selector : '#editor',
		height : 660,
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
		{{#profileCheck profile}}
		<div class="comment-avatar"><img src="{{profile}}" alt=""></div>
		{{else}}
		<div class="comment-avatar"><img src="http://goo.gl/5SYWQ9" alt=""></div>
		{{/profileCheck}}
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
	
	Handlebars.registerHelper('profileCheck', function(profile, options) {
		if (profile != 'default.png') {
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

	$(document).on("click", "#deleteBoard", function() {//게시글 삭제
		var tbno = $("#bno").val();
		//alert(tbno+" : "+<%=request.getParameter("tbno")%>);
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
							$("#likeCnt").html("좋아요 "+result);
							$("#likeCnt-${commonBoard.tbno}",opener.document).html(result);
					},
				}); 
	}
	
	$(document).on("click", "#updateBoard", function() {
		var w = 750;
		var h = 800;
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2) - 50;
		window.open("/CommonUpdate?tbno=" + ${commonBoard.tbno }, ${commonBoard.tbno } + "번 게시글 수정", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	   	self.close();
	});
	
	
	function msgSend(id) {//메시지 보내기

		var w = 370;
		var h = 500;
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2) - 100;
		var open = window.open("/msgSend?id="+id, "메시지 보내기", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
		open.document.getElementById("targetid").value = id;
	};
	
	function reportSend(content,brno,replyer,kind) {//신고 보내기 전 보여주는 부분
		
		//alert(content +"," + brno +", " + replyer +"," + kind);
		
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
	-
	
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
						$("#modalClose2").trigger('click');
						alert("신고 완료");
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
<title>${commonBoard.title }</title>
</head>
<body>
		<br>
		<div class="col-sm-12">
			<div class="col-sm-6">
				<label style="font-size: 15px;">제목</label>
				<input style="font-size: 18px; background-color: white" type="text" class="form-control" id="title" value="${commonBoard.title}" placeholder="제목 입력란" readonly><br>
				<textarea id="editor" name="content" readonly="readonly" style="width: 100%;">${commonBoard.content}</textarea>
				<input type="hidden" id="userid" value="${id }" readonly> 
				<input type="hidden" id="bno" value="${commonBoard.tbno }" readonly>
			</div>
			
			<div class="col-sm-6">
				<c:if test="${commonBoard.id == id}">
				<input type="button" class="btn btn-danger" id="deleteBoard"
					value="삭제" style="float: right;"/>
				</c:if>
				<c:if test="${commonBoard.id == id || auth == 2}">
					<input type="button" class="btn btn-info" id="updateBoard"
						value="수정" style="float: right; margin-right: 15px;"/><br>
				</c:if>
				<label style="font-size: 15px;">공지사항</label>
				<input style="font-size: 18px; background-color: white" type="text" class="form-control" id="title" value="${commonBoard.notice}" placeholder="글쓴이의 공지사항이 표시됩니다." readonly><br>
				<label style="font-size: 15px;">오픈 채팅방</label> 
				<input style="font-size: 18px; background-color: white" type="text" class="form-control" id="title" value="${commonBoard.openchat}" placeholder="오픈 채팅방이 표시됩니다." readonly> <br>
				
				<div class="col-sm-12">
				<c:if test="${commonBoard.myFavor == 1 }">
					<div class="col-sm-3" style="margin-top: -5px">
						<p align="right">
							<span class="badge" style="background-color: black; font-size: 15px;"> 즐겨찾기 </span>
							<i class="glyphicon glyphicon-star" id="bk-${commonBoard.tbno }"
								onclick="favor(${commonBoard.tbno})" data-toggle="bookmark"
								data-placement="bottom" title="즐겨찾기 해제"
								style="font-size: 30px; cursor: pointer; color: #FFBB00"></i>
						</p>
					</div>
				</c:if>
				<c:if test="${commonBoard.myFavor == 0 }">
					<div class="col-sm-3" style="margin-top: -5px">				
						<p align="right">
							<span class="badge" style="background-color: black; font-size: 15px;"> 즐겨찾기 </span>
							<i class="glyphicon glyphicon-star-empty"
								id="bk-${commonBoard.tbno }"
								onclick="favor(${commonBoard.tbno})" data-toggle="bookmark"
								data-placement="bottom" title="즐겨찾기 추가"
								style="font-size: 30px; cursor: pointer; color: #FFBB00"></i>
						</p>
					</div>	
				</c:if>
					<div class="col-sm-3" style="margin-top: -5px">
						<p align="left">
							<span class="badge" style="background-color: blue; font-size: 15px;" onclick="likes(${commonBoard.tbno})" id="likeCnt"> 좋아요 ${commonBoard.likes } </span>
							<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" style="font-size: 30px; cursor: pointer;" data-placement="top" title="좋아요"
								onclick="likes(${commonBoard.tbno})"></i>
						</p>
					</div>
					<div class="col-sm-6" style="text-align: right; margin-top: 3px;">
						<a class="btn btn-info btn-xs" style="float: right; margin-left: 5px; font-size:15px;" id="msgSend" onclick="msgSend('${commonBoard.id}')">메시지 보내기</a>
						<a class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal2" style="float: right; margin-left: 5px; font-size:15px;"
						 id="reportSendBoard" onclick="reportSend('${commonBoard.title}','${commonBoard.tbno}','${commonBoard.id}',1)">신고하기</a>			
								
					</div>
				</div>
				<br>
				<div class="reply" style="text-align: right; margin-top: 10px;">
					<input type="text" class="form-control" id="replyContent" placeholder="댓글을 남겨서 사람들과 약속을 잡아보세요!" style="width: 80%; display: inline"> 
					<input id="addReply" type="button" class="btn btn-success" value="댓글 입력!" style="display: inline;">
				</div>
				<!-- 여기 부터 댓글 부분 -->
				<div class="comments-container scrollbar force-overflow"
					style="margin-top: 10px; text-align:right; width: 100%; overflow: scroll overfl; overflow:x:hidden; height: 520px; background-color: #EAEAEA;
					border-radius: 1%;"
					id="scrollbar119">
					<ul id="comments-list" class="comments-list">
					</ul>
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