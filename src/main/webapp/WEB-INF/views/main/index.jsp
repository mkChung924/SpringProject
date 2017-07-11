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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/resources/js/daum_api.js"></script>
<!-- <script type="text/javascript" src="http://scmplayer.co/script.js" 
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
{'title':'Qui A Tue Grand Maman','url':'https://www.youtube.com/watch?v=-wgqxyOFngY'}]}" >
</script> -->

<script type="text/javascript">
		var msg = '${warningMSG}';
		if(msg.trim().length >0 && msg != null){
			alert('${warningMSG}번의 신고를 받았습니다 총 20번의 신고 누적 시 사이트를 이용하실수 없습니다');		
		}
</script>
<link rel="stylesheet" type="text/css" href="/resources/css/main/index.css?ver=1.2">
<title>카테고리 페이지</title>
</head>
<body>
	<div class="container" style="margin-bottom: 5px; text-align: center;">
		<div class="row">
		<div class="header">
			<c:if test="${auth == 2 }">			
				<b>[ ${nick } ]</b> <kbd style="background-color: red"><a href="/admin"><font color="white">관리자</font></a></kbd><br>
				<div style="margin-top: 5px;">
				<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd>
				</div>
			</c:if>
			<c:if test="${auth != 2 }">			
				<b>[ ${nick } ]</b>님 메인페이지 입장<br>		
				<div style="margin-top: 5px;">
				<kbd style="background-color: #EAEAEA"><a href="/logout"><font color="black">로그아웃</font></a></kbd> &nbsp;&nbsp;|&nbsp;&nbsp;
				<kbd><a href="/mypage"><font color="white">마이페이지</font></a></kbd>
				</div>
			</c:if>
		</div> 
		<div class="myLocation">
			<div class="col-sm-4" style="height: 40px; text-align: center; padding-top: 0px"><b><font size="4">자신의 <kbd><font color=white>위치</font></kbd>를 설정해주세요!!</font></b></div>
			<div class="col-sm-2"><input type="button" id="locationBtn" onclick="sample4_execDaumPostcode()" value="위치 설정"></div>
			<span id="guide" style="color:#999"></span>
			<div class="col-sm-2" style="height: 40px;"><input type="text" class="form-control" id="do1" placeholder="지역1" value="${do1 }" readonly style="width: 80px"></div>
			<div class="col-sm-2" style="height: 40px;"><input type="text" class="form-control" id="si" placeholder="지역2" value="${si }" readonly style="width: 90px"></div>
			<div class="col-sm-2" style="height: 40px;"><input type="text" class="form-control" id="dong" placeholder="지역3" value="${dong }" readonly style="width: 90px"></div>
		</div>
		<div class="row" style="text-align: center">
			<div class="col-sm-4"><img src="/resources/image/category_img/category_travel.png" id="travelBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_study.png" id="studyBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_pet.png" id="petBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_health.png" id="healthBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_elec.png" id="elecBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_diy.png" id="diyBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_concert.png" id="concertBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_beauty.png" id="beautyBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
			<div class="col-sm-4"><img src="/resources/image/category_img/category_baby.png" id="babyBtn" class="img-circle" alt="travel" width="90%" draggable="false"></div>
		</div>
		
		<div class="footer">
			
			김주영 | 정명규 | 지영준 | 이재욱 | 김영대 | 김가희<br>
			&copy; Social Life All rights reserved
		</div>

	<%@include file="categoryModal/travelModal.jsp" %>
	<%@include file="categoryModal/studyModal.jsp" %>
	<%@include file="categoryModal/petModal.jsp" %>
	<%@include file="categoryModal/healthModal.jsp" %>
	<%@include file="categoryModal/elecModal.jsp" %>
	<%@include file="categoryModal/diyModal.jsp" %>
	<%@include file="categoryModal/concertModal.jsp" %>
	<%@include file="categoryModal/beautyModal.jsp" %>
	<%@include file="categoryModal/babyModal.jsp" %>
	
<!-- 	<div id="dialog" title="위치 설정이 필요합니다">
		<p>This is the default dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>
	</div>
	
	<button id="btn" type="button">버튼</button> -->
</div>	
</div>
<script type="text/javascript">
	
/*   $( function() {
	  
	    $( "#dialog" ).dialog({
	    	autoOpen: false,
	        resizable: false,
	        position: {
                my:"center",
                at:"top center"
                }
	    });
	    
	    function failtoOpen(){
	    	$('#dialog').dialog('open');
	    }
	    
	    $('#btn').click(function(){
	    	$('#dialog').dialog('open');
	    });
	    
	  }); */
	
	var modal_no = document.getElementById('noModal');
	  
	  var kind1 = '';
	  var kind2 = '';
	
	window.onclick = function(event) {
		  
		if (event.target == modal_travel || event.target == modal_study || event.target == modal_pet
				 || event.target == modal_health || event.target == modal_elec || event.target == modal_diy
				 || event.target == modal_concert || event.target == modal_beauty || event.target == modal_baby
				 || event.target == modal_no) {
	        modal_travel.style.display = "none";
	        modal_study.style.display = "none";
	        modal_pet.style.display = "none";
	        modal_health.style.display = "none";
	        modal_elec.style.display = "none";
	        modal_diy.style.display = "none";
	        modal_concert.style.display = "none";
	        modal_beauty.style.display = "none";
	        modal_baby.style.display = "none";
	        modal_no.style.display = "none";
	        
	    }
	    
	}
</script>
</body>
</html>
