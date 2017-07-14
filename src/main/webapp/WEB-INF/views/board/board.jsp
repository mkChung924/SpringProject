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
<link rel="stylesheet" type="text/css" href="/resources/css/board/board.css?ver=2.4">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/daum_api2.js"></script>

<title>게시판</title>
<script type="text/javascript">
	$(function() {

		$('[data-toggle="comment"]').tooltip();
		$('[data-toggle="like"]').tooltip();
		$('[data-toggle="review"]').tooltip();
		$('[class="glyphicon glyphicon-star"]').tooltip();
		$('[class="glyphicon glyphicon-star-empty"]').tooltip();

		//게시글 작성 클릭
		$('#write').click(function() {

			window.open('/regit', '게시글 작성', 'width=750 height=850 menubar=no status=no scrollbars=yes left=500 top=50 resizable=0');
		})

		var frm = $('form[role="form"]');

		$('#search').click(function() {

			var keyword = $('#keywords').val();

			if (keyword.trim().length == 0) {

				$('#keywords').attr('placeholder', '검색어를 입력하세요');

			} else {

				$('#page').val(1);
				frm.attr('method', 'POST');
				frm.submit();
			}
		});

		$('#all').click(function() {

			$('#keywords').val('');
			$('#page').val(1);
			frm.attr('method', 'POST');
			frm.submit();

		})

		$('#together').click(function() {

			$('#keywords').val('');
			$('#page').val(1);
			$('[name=tb_kind]').val("1");
			frm.attr('method', 'POST');
			frm.submit();

		})

		$('#review').click(function() {

			$('#keywords').val('');
			$('#page').val(1);
			$('[name=tb_kind]').val("2");
			frm.attr('method', 'POST');
			frm.submit();

		})

		$('#perPageNum').change(function() {

			$('#keywords').val('${keyword }');
			$('#page').val(1);
			frm.attr('method', 'POST');
			frm.submit();
		});

		$(window).keydown(function(event) {
			if (event.keyCode == 13) {
				event.preventDefault();
				return false;
			}
		});

	});

	function nextPage(page) {

		//alert(page);
		var frm = $('form[role="form"]');
		$('#page').val(page);
		frm.attr('method', 'POST');
		frm.submit();

	}

	function prevPage(page) {
		//alert(page);
		var frm = $('form[role="form"]');
		$('#page').val(page);
		frm.attr('method', 'POST');
		frm.submit();
	}


	function thisPage(page) {
		$('#page').val(page);
		//alert($('#page').val())
		//alert("thisPage"+page);
		var frm = $('form[role="form"]');
		frm.attr('method', 'POST');
		frm.submit();
	}


	function favor(tbno) { //즐겨 찾기

		$.ajax({
			url : 'rest/bookmark',
			data : 'id=' + "${id }" + '&tbno=' + tbno,
			success : function(result) {
				if (result == "OK") {

					$('#bk-' + tbno).attr("class", "glyphicon glyphicon-star");
					$('#bk-' + tbno).attr("title", "즐겨찾기 해제");
					$('#bk-' + tbno).attr("data-original-title", "즐겨찾기 해제");

				} else {

					$('#bk-' + tbno).attr("class", "glyphicon glyphicon-star-empty");
					$('#bk-' + tbno).attr("title", "즐겨찾기 추가");
					$('#bk-' + tbno).attr("data-original-title", "즐겨찾기 추가");
				}
			},
		});

	}

  	function readPage(tbno) {
        var w = screen.width - 100;
        var h = screen.height - 120;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2) - 50;
        window.open("/CommonRead?tbno=" + tbno, tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
		$("#ViewCnt-"+tbno).html(parseInt($("#ViewCnt-"+tbno).html())+1);
    };
    
	
	function dropIt(do1,cno){
		
		var p1 = $('[name=place1]').val();
		var p2 = $('[name=place2]').val();
		
		if(p1 == null || p2 == null){
			p1='';
			p2='';
		}
		
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
	
	function moveIt(do1, si, dong){
		
		//alert(do1 +","+si);
		$('#do1').val(do1);
        $('#si').val(si);
        $('#dong').val(dong);
        
        var formObj = $('form[role="form"]');
		
		formObj.attr("method", "POST");
		formObj.attr("action", "/board");
		formObj.submit();
	}
	
  	function adminReadPage(tbno,place1,place2,cno,csno) {
        var w = screen.width - 100;
        var h = screen.height - 115;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2) - 100;
        window.open("/adminTravelRead?tbno=" + tbno+"&place1="+place1+"&place2="+place2+"&cno="+cno+"&csno="+csno, "관리자 여행 추천 "+tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
		$("#ViewCnt-"+tbno).html(parseInt($("#ViewCnt-"+tbno).html())+1);
    };
    
    function showAllTrip(){
    	var w = screen.width - 170;
        var h = screen.height - 150;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2) - 50;
        window.open("/allTrip", "여행 추천 살펴보기"+ 
        		"번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, '+
        		'width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    	
    }
</script>
</head>

<body>
	<div class="container" style="margin-bottom: 5px;">
		<div class="row">
			<div class="header">
				<c:if test="${auth == 2 }">
				<b>[ ${nick } ]</b> &nbsp;&nbsp;<kbd style="background-color: red"><a href="/admin"><font color="white">관리자</font></a></kbd>&nbsp;&nbsp;|&nbsp;
				<kbd><a href="/index"><font color="white">메인페이지</font></a></kbd>&nbsp;&nbsp;|&nbsp;
				<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>
				</c:if>
				<c:if test="${auth < 2 }">
				<b>${nick }</b>님 게시글을 남겨보세요!<br>
				<div style="margin-top: 5px;">
					<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>
					&nbsp;&nbsp;|&nbsp;&nbsp;
					<kbd><a href="/mypage"><font color="white">마이페이지</font></a></kbd>
					&nbsp;&nbsp;|&nbsp;&nbsp;
					<kbd><a href="/index"><font color="white">메인페이지</font></a></kbd>
				</div>
				</c:if>
				
			</div>
			<br>
			<!-- 관리자 여행 추천 게시글 -->
			<c:if test="${cno == 1 }">
				<c:if test="${travelList.size() > 0 }">
				<div class="row">
				<c:forEach items="${travelList }" var="travel" end="4">
					<div class="col-md-3">
						<div class="thumbnail m">
							<img src="${travel.image }" alt="ALT NAME"
								class="img-responsive" />
							<div class="caption">
								<h4><b>
									<i>${travel.title } !</i>
								</b></h4>
								<p>${travel.notice }</p>
								<p align="center">
									<a href="#" class="btn btn-primary btn-block" onclick="adminReadPage('${travel.tbno}','${travel.place1 }','${travel.place2 }','${travel.cno}','${travel.csno}')">떠날 준비!</a>
								</p>
							</div>
							<div style="padding-bottom: 10px;">
								<i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp; 
								<span class="badge" style="background-color: gray">${travel.replies }</span>&nbsp;&nbsp;&nbsp; 
								<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" data-placement="top" title="좋아요"></i>&nbsp;
								<span class="badge" style="background-color: blue">${travel.likes }</span>&nbsp;&nbsp;&nbsp; 
								<i class="glyphicon glyphicon-tags" data-toggle="review" data-placement="bottom" title="후기"></i>&nbsp;
								<span class="badge" style="background-color: green">${travel.reviews }</span>
							</div>
						</div>
					</div>
				</c:forEach>
				</div>
			</c:if>	
				<div class="row"
					style="text-align: right; margin-right: 20px; margin-top: -5px;">
					<button type="button" class="btn btn-success" onclick="showAllTrip()">
						<font size=4>추천 여행지 보기</font>&nbsp; <i
							class="glyphicon glyphicon-plus-sign"></i>
					</button>
				</div>
			</c:if>

			<!-- 검색 -->
			<div class="row" style="min-height: 65%;">
				<div class="col-md-12">
					<div class="thumbnail">
						<div class="caption"
							style="text-align: right; padding-top: 15px; padding-bottom: 0px;">
							<form role="form" method="post">
								<div class="col-sm-3" style="text-align: center; padding-top: 5">
									<button type="button" class="btn btn-warning" id="myLocBtn"
										onclick="sample4_execDaumPostcode()"
										style="padding: 0px; width: 66px;">관심위치</button>
									<i><font size=2>${do1 } ${si } ${dong }</font></i> <span
										id="guide" style="color: #999"></span> <input type="hidden"
										name="do1" id="do1" value="${do1 }"> <input
										type="hidden" name="si" id="si" value="${si }"> <input
										type="hidden" name="dong" id="dong" value="${dong }">
									<input type="hidden" name="page" id="page" value="${page }">
								</div>
								<div class="col-sm-3" style="text-align: center; padding-top: 5">
									<button type="button" class="btn btn-info"
										${cno == 1 ? 'onclick=""': 'onclick=""' }
										style="padding: 0px; width: 66px;">카테고리</button>
									<i><font size=2>${category } - ${subcategory }</font></i>
									<input type="hidden" name="cno" value="${cno }"> <input
										type="hidden" name="csno" value="${csno }">
								</div>
								<c:if test="${cno == 1 }">
									<div class="col-sm-2"
										style="text-align: center; padding-top: 5">
										<button type="button" class="btn btn-success"
											style="padding: 0px; width: 66px;">여행장소</button>
										<i><font size=2><b>${p1 } ${p2 }</b></font></i> <input
											type="hidden" name="place1" value="${p1 }"> <input
											type="hidden" name="place2" value="${p2 }">
									</div>
								</c:if>
								<select class="form-control s" id="option" name="searchType">
									<option value="n" ${searchType == 'n' ? 'selected' : '' }>닉네임</option>
									<option value="t" ${searchType == 't' ? 'selected' : '' }>제목</option>
									<!-- <option value="c">내용</option> -->
								</select> <input type="text" class="form-control t" id="keywords"
									name="keyword" autocomplete="off" value="${keyword }">
								<button type="button" class="btn btn-default" id="search">검색</button>
								
								<div class="caption">
								<div style="text-align: right; margin-top: 10px;">
									<select class="form-control" id="perPageNum" name="pageNum"
										style="display: inline; width: 120px;">
										<c:out value=""></c:out>
										<option value=9 ${pageNum == 9 ? 'selected': '' }>9개씩
											보기</option>
										<option value=15 ${pageNum == 15 ? 'selected': '' }>15개씩
											보기</option>
										<option value=30 ${pageNum == 30 ? 'selected': '' }>30개씩
											보기</option>
										<option value=60 ${pageNum == 60 ? 'selected': '' }>60개씩
											보기</option>
									</select>
									<c:if test="${cno != 1 }">
										<button type="button" class="btn btn-default" id="all" style="background-color: #5D5D5D; color: white;">
										전체 보기[${boardCount }]</button>
									</c:if>

									<c:if test="${cno == 1 }">
										<button type="button" class="btn btn-default" id="review"
											style="background-color: #5D5D5D; color: white">여행 후기
											모아보기[${reviewBoardCount }]</button>
										<input type="hidden" name="tb_kind" value="${tb_kind }">
										<button type="button" class="btn btn-default" id="together"
											style="background-color: #5D5D5D; color: white">관심글
											모아보기[${boardCount }]</button>
										<button type="button" class="btn btn-default" id="write">게시글
											및 후기 작성</button>
									</c:if>
									<c:if test="${cno != 1 }">
										<button type="button" class="btn btn-default" id="write">게시글
											작성</button>
									</c:if>
								</div>
								</div>
							</form>
						</div>
					</div>
			<!-- 게시글 -->
			<c:forEach items="${list }" var="myList">
        	<div class="col-md-4" style="max-height: 400;">
	        	<div class="thumbnail">
		        	<div class="caption">
		        		<div style="text-align: left; padding-top: 0px;">
			              	 <div style="display: block; text-align: right; padding-top: 0px;">
			              		 ${myList.regdate } 
			              		 <c:if test="${myList.tb_kind != 2 }">
			              		  <font color=red>D-${myList.ddate }</font>
			              		 </c:if>
			              		 <br>${myList.si } ${myList.dong }
			              		 <br>
			              		 <c:if test="${myList.place1 != null }">
			              		 <kbd style="background-color: #47C83E">${myList.place1 }</kbd> 
			              		 <kbd style="background-color: #6B66FF">${myList.place2 }</kbd>
			              		 </c:if>
			              		 <c:if test="${myList.csno%2 == 0}">
			              			 <kbd style="background-color: #F15F5F">${myList.csname }</kbd>
			              		 </c:if>
			              		 <c:if test="${myList.csno%2 != 0}">
			              		 	<kbd style="background-color: #4374D9">${myList.csname }</kbd>
			              		 </c:if>
			              		 
			              	 </div><br>
			              	 <div style="margin-top: -55px;">
			              	 <c:if test="${myList.profile == 'default.png' }">
			              	 <img src="http://goo.gl/5SYWQ9" draggable="false" style="border-radius: 50%; width: 10%; height: 9%; margin-top: -15px"> &nbsp;
			              	 </c:if>
			              	  <c:if test="${myList.profile != 'default.png' }">
			              	 <img src="${myList.profile }" draggable="false" style="border-radius: 50%; width: 10%; height: 9%; margin-top: -15px"> &nbsp;
		              	 	</c:if>
		              	 	<font size=4><b>${myList.nickname }</b></font>
		              	 	</div>
		                </div>
		                <hr>
		                <div style="cursor: pointer;">
		                	<b><i onclick="readPage('${myList.tbno }')"><font size="4">" ${myList.title.length() > 21 ? myList.title.substring(0,21) : myList.title } "</font></i></b>
		                </div>
		                <br>
		                <div class="row" style="padding-left: 20px;">
		                	<c:if test="${myList.myfavor == 1 }">
		                	<div class="col-md-3">
				                <p class="p-${myList.tbno }" align="left">
				                <i class="glyphicon glyphicon-star" id="bk-${myList.tbno }" onclick="favor(${myList.tbno})" data-toggle="bookmark" data-placement="bottom" title="즐겨찾기 해제" style="font-size: 25px; cursor: pointer; color: #FFE400"></i>
				                </p>
		                	</div>
		                	</c:if>
		                	<c:if test="${myList.myfavor == 0 }">
		                	<div class="col-md-3">
				                <p align="left">
				                <i class="glyphicon glyphicon-star-empty" id="bk-${myList.tbno }" onclick="favor(${myList.tbno})"  data-toggle="bookmark" data-placement="bottom" title="즐겨찾기 추가" style="font-size: 25px; cursor: pointer; color: #FFE400"></i>
				                </p>
		                	</div>
		                	</c:if>

		                	<div class="col-md-9">
				                <p align="right">
				                <span class="badge" id="ViewCnt-${myList.tbno }" style="background-color: blue">${myList.viewCnt}</span>
				                <i class="glyphicon glyphicon-eye-open" data-toggle="like" data-placement="top" title="조회수"></i>&nbsp;
				                <span class="badge" id="likeCnt-${myList.tbno }" style="background-color: blue">${myList.likes }</span>
				                <i class="glyphicon glyphicon-thumbs-up" data-toggle="like" data-placement="top" title="좋아요"></i>&nbsp;
		                   		<span class="badge" style="background-color: gray">${myList.replies }</span>
				                <i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp; &nbsp;&nbsp;&nbsp;
				                </p>
		                	</div>
		                </div>
		             </div>
		        </div>
	        </div>
        </c:forEach>
				</div>
				<div class="text-center">
					<ul class="pagination">

						<c:if test="${pageMaker.prev}">
							<%-- <li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li> --%>
							<li><a onclick="prevPage(${pageMaker.startPage -1})">&laquo;</a></li>
						</c:if>

						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
								<%-- <a href="list${pageMaker.makeSearch(idx)}">${idx}</a> --%>
								<a onclick="thisPage(${idx})">${idx}</a>
							</li>
						</c:forEach>

						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<%-- <li><a href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li> --%>
							<li><a onclick="nextPage(${pageMaker.endPage+1})">&raquo;</a></li>
						</c:if>

					</ul>
				</div>
				
				<c:forEach items="${cnoMap }" var="map" end="0">
					<c:if test="${map.size() > 0 }">
				<div class="col-sm-12" style="text-align: left; margin-bottom: 10px;">
				<b>다른 지역, 같은 관심! &nbsp; 가까운 곳이 있는지 확인해보세요..!</b>
				</div>
				<div class="thumbnail" style="display: grid; background-color: transparent;">
					<div class="col-md-12" style="background-color: transparent; text-align: center;">
						<c:forEach items="${cnoMap }" var="map">
						<div class="col-sm-1" style="text-align: center; padding: 5px">
						<div class="dropup" style="text-align: left;">
				            <button class="btn btn-danger dropdown-toggle" onclick="dropIt('${map.DO1}',${cno })" type="button" data-toggle="dropdown">
				                ${map.DO1 } 
				                <c:if test="${map.COUNT < 10 }">
				                	[0${map.COUNT }]
				                </c:if>
				                <c:if test="${map.COUNT > 9 }">
				                	[${map.COUNT }]
				                </c:if>
				                <span class="caret"></span>
				            </button>
				            <ul class="dropdown-menu" id="dropdown-menu-${map.DO1 }"> <!-- <li class="divider"></li> -->
				            </ul>
				        </div>
				        </div>
					 	</c:forEach>	
					</div>
				</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="footer">
			
			김주영 | 정명규 | 지영준 | 이재욱 | 김영대 | 김가희<br>
			&copy; Social Life All rights reserved
			</div>
		</div>
	</div>
</body>
</html>

