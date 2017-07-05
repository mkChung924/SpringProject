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
<link rel="stylesheet" type="text/css" href="/resources/css/board/board.css?ver=2.0">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/daum_api2.js"></script>
<title>게시판</title>
<script type="text/javascript">
	$(function(){
		
		$('[data-toggle="comment"]').tooltip();
		$('[data-toggle="like"]').tooltip();   
		$('[data-toggle="review"]').tooltip();   
		$('[class="glyphicon glyphicon-star"]').tooltip();   
		$('[class="glyphicon glyphicon-star-empty"]').tooltip();   
		
		//게시글 작성 클릭
		$('#write').click(function(){
			
			window.open('/regit', '게시글 작성','width=750 height=850 menubar=no status=no scrollbars=yes left=500 top=50 resizable=0');
			
		})
		
		var frm = $('form[role="form"]');
		
		$('#search').click(function(){
			
			var keyword = $('#keywords').val();
			
			if(keyword.trim().length == 0){
				
				$('#keywords').attr('placeholder','검색어를 입력하세요');
				
			} else {
				
				$('#page').val(1);
				frm.attr('method','POST');
				frm.submit();
			}
		});
		
		$('#all').click(function(){
			
			$('#keywords').val('');
			$('#page').val(1);
			frm.attr('method','POST');
			frm.submit();
			
		})
		
		$('#together').click(function(){
			
			$('#keywords').val('');
			$('#page').val(1);
			$('[name=tb_kind]').val("1");
			frm.attr('method','POST');
			frm.submit();
			
		})
		
		$('#review').click(function(){
			
			$('#keywords').val('');
			$('#page').val(1);
			$('[name=tb_kind]').val("2");
			frm.attr('method','POST');
			frm.submit();
			
		})
	
		$('#perPageNum').change(function(){
			
			$('#keywords').val('${keyword }');
			$('#page').val(1);
			frm.attr('method','POST');
			frm.submit();
		});
		
		$(window).keydown(function(event){
		    if(event.keyCode == 13) {
		      event.preventDefault();
		      return false;
		    }
		  });
		
	});
	
    function nextPage(page){
    	
    	//alert(page);
    	var frm = $('form[role="form"]');
    	$('#page').val(page);
		frm.attr('method','POST');
		frm.submit();
    	
    }
    
    function prevPage(page){
    	//alert(page);
    	var frm = $('form[role="form"]');
    	$('#page').val(page);
		frm.attr('method','POST');
		frm.submit();
    }
    
    
    function thisPage(page){
    	$('#page').val(page);
    	//alert($('#page').val())
    	//alert("thisPage"+page);
    	var frm = $('form[role="form"]');
		frm.attr('method','POST');
		frm.submit();
    }
	

  	function favor(tbno){
				
		$.ajax({
				url:'/rest/bookmark',
				data:'id='+"${id }"+'&tbno='+tbno,
				success:function(result){
					if(result == "OK"){
						
						$('#bk-'+tbno).attr("class","glyphicon glyphicon-star");
						$('#bk-'+tbno).attr("title","즐겨찾기 해제");
						$('#bk-'+tbno).attr("data-original-title","즐겨찾기 해제");
						
					} else {
						
						$('#bk-'+tbno).attr("class","glyphicon glyphicon-star-empty");
						$('#bk-'+tbno).attr("title","즐겨찾기 추가");
						$('#bk-'+tbno).attr("data-original-title","즐겨찾기 추가");
					}
				},
		})
	}
  	
  	function readPage(tbno) {
  		alert(tbno);
        var w = 800;
        var h = 400;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);
        window.open("/CommonRead?tbno=" + tbno, tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    };
    

 	
 	
</script>
</head>

<body>
<div class="container" style="margin-bottom: 5px;">
    <div class="row">
    	<div class="header">
			<b>${id }</b>님 게시글을 남겨보세요!<br>
			<div style="margin-top: 5px;">
			<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>&nbsp;&nbsp;|&nbsp;&nbsp;<kbd><a href="/mypage"><font color="white">마이페이지</font></a></kbd>
			</div>
		</div>
		<br>
		<!-- 관리자 여행 추천 게시글 -->
		<c:if test="${cno == 1 }">
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
        </div> 
        <div class="row" style="text-align: right; margin-right: 20px; margin-top: -5px;">
        	<button type="button" class="btn btn-success"><font size=4>추천 여행지 더보기</font>&nbsp; <i class="glyphicon glyphicon-plus-sign"></i></button>
        </div>
        </c:if>
        <!-- 검색 -->
        <div class="row">
        	<div class="col-md-12">
				<div class="thumbnail">	
					<div class="caption" style="text-align: right; padding-top: 15px; padding-bottom: 0px;">
						<form role="form" method="post">
						<div class="col-sm-3" style="text-align: center; padding-top: 5">
							<button type="button" class="btn btn-warning" id="myLocBtn" onclick="sample4_execDaumPostcode()" style="padding: 0px; width: 66px;">내 위치</button>&nbsp;
							<i><font size=3>${do1 } ${si } ${dong }</font></i>
							<span id="guide" style="color:#999"></span>
							<input type="hidden" name="do1" id="do1" value="${do1 }">
							<input type="hidden" name="si" id="si" value="${si }">
							<input type="hidden" name="dong" id="dong" value="${dong }">
							<input type="hidden" name="page" id="page" value="${page }">
						</div>
						<div class="col-sm-3" style="text-align: center; padding-top: 5">
							<button type="button" class="btn btn-info" ${cno == 1 ? 'onclick="alert(1)"': 'onclick="alert(2)"' } style="padding: 0px; width: 66px;">카테고리</button>&nbsp;
							<i><font size=3>${category } - ${subcategory }</font></i>
							<input type="hidden" name="cno" value="${cno }">
							<input type="hidden" name="csno" value="${csno }">
						</div>
						<c:if test="${cno == 1 }">
						<div class="col-sm-2" style="text-align: center; padding-top: 5">
							<button type="button" class="btn btn-success" style="padding: 0px; width: 66px;">여행 장소</button>&nbsp;
							<i><font size=3><b>${p1 } ${p2 }</b></font></i>
							<input type="hidden" name="place1" value="${p1 }">
							<input type="hidden" name="place2" value="${p2 }">
						</div>
						</c:if>
						<select class="form-control s" id="option" name="searchType">
							<option value="n" ${searchType == 'n' ? 'selected' : '' }>닉네임</option>
							<option value="t" ${searchType == 't' ? 'selected' : '' }>제목</option>
							<!-- <option value="c">내용</option> -->
						</select>
						<input type="text" class="form-control t" id="keywords" name="keyword" autocomplete="off" value="${keyword }">
						<button type="button" class="btn btn-default" id="search">검색</button>
						<div style="text-align: right; margin-top: 10px;">
						<c:if test="${cno != 1 }">
							<button type="button" class="btn btn-default" id="all">전체 보기</button>
						</c:if>
						<select class="form-control" id="perPageNum" name="pageNum" style="display: inline; width: 100px;">
							<c:out value=""></c:out>
							<option value=9 ${pageNum == 9 ? 'selected': '' }>9개씩 보기</option>
							<option value=15 ${pageNum == 15 ? 'selected': '' }>15개씩 보기</option>
							<option value=30 ${pageNum == 30 ? 'selected': '' }>30개씩 보기</option>
							<option value=60 ${pageNum == 60 ? 'selected': '' }>60개씩 보기</option>

						</select>

						<c:if test="${cno == 1 }">	
							<button type="button" class="btn btn-default" id="review" style="background-color: black; color: white">여행 후기 모아보기</button>	
							<input type="hidden" name="tb_kind" value="${tb_kind }">				
							<button type="button" class="btn btn-default" id="together" style="background-color: black; color: white">관심글 모아보기</button>
							<button type="button" class="btn btn-default" id="write">게시글 및 후기 작성</button>	
						</c:if>		
						<c:if test="${cno != 1 }">	
							<button type="button" class="btn btn-default" id="write">게시글 작성</button>	
						
						</c:if>	
						</div>
						</form>		
					</div>		
				</div>
			</div>
			<!-- 게시글 -->
			<c:forEach items="${list }" var="myList">
        	<div class="col-md-4" style="max-height: 400">
	        	<div class="thumbnail">
		        	<div class="caption">
		        		<div style="text-align: left; padding-top: 0px;">
			              	 <div style="display: block; text-align: right; padding-top: 0px;">
			              		 ${myList.regdate } <font color=red>D-${myList.ddate }</font>
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
			              	 <img src="/resources/upload/default.png" draggable="false" style="border-radius: 50%; width: 10%; height: 9%; margin-top: -15px"> &nbsp;
			              	 </c:if>
			              	  <c:if test="${myList.profile != 'default.png' }">
			              	 <img src="/resources/upload/${myList.id }/${myList.profile }" draggable="false" style="border-radius: 50%; width: 10%; height: 9%; margin-top: -15px"> &nbsp;
		              	 	</c:if>
		              	 	<font size=4><b>${myList.nickname }</b></font>
		              	 	</div>
		                </div>
		                <hr>
		                <div style="cursor: pointer;">
		                	<b><i onclick="readPage('${myList.tbno }')"><font size="4">" ${myList.title } "</font></i></b>
		                </div>
		                <br>
		                <div class="row" style="padding-left: 20px;">
		                	<c:if test="${myList.myfavor == 1 }">
		                	<div class="col-md-6">
				                <p class="p-${myList.tbno }" align="left">
				                <i class="glyphicon glyphicon-star" id="bk-${myList.tbno }" onclick="favor(${myList.tbno})" data-toggle="bookmark" data-placement="bottom" title="즐겨찾기 해제" style="font-size: 25px; cursor: pointer;"></i>
				                </p>
		                	</div>
		                	</c:if>
		                	<c:if test="${myList.myfavor == 0 }">
		                	<div class="col-md-6">
				                <p align="left">
				                <i class="glyphicon glyphicon-star-empty" id="bk-${myList.tbno }" onclick="favor(${myList.tbno})"  data-toggle="bookmark" data-placement="bottom" title="즐겨찾기 추가" style="font-size: 25px; cursor: pointer;"></i>
				                </p>
		                	</div>
		                	</c:if>
		                	<div class="col-md-6">
				                <p align="right">
				                <span class="badge" id="likeCnt" style="background-color: blue">${myList.likes }</span>
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
    </div>
</div>


</body>
</html>

