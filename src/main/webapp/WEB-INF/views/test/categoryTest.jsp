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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                
                $('[name=do1]').val(data.jibunAddress.split(" ")[0]);
                $('[name=si]').val(data.jibunAddress.split(" ")[1]);
                $('[name=dong]').val(data.jibunAddress.split(" ")[2]);

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    
                    $('[name=do1]').val(data.autoJibunAddress.split(" ")[0]);
                    $('[name=si]').val(data.autoJibunAddress.split(" ")[1]);
                    $('[name=dong]').val(data.autoJibunAddress.split(" ")[2]);
                    //document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>
<style type="text/css">
body{
	background-color: #FFFFFF;
}
.container {
	width: 65%;
	text-align: center;
	/* border: 1px solid black; */
}

/* 로그인 정보 및 마이페이지 표시란 */
.header{
	padding: 10px;
	/* border: 1px solid black; */
	text-align: right;
}

.footer{
	padding: 50px;
	background-color: #FFD9EC
}

.categories{
	height: 1050px;
}

/* 내 위치 설정란 */
.myLocation{
	padding: 20px;
}

.myLocation .specificLocation{
	padding: 15px;
	padding-left: 100px;
	padding-right: 100px;
	border: 3px dashed fuchsia;
	border-radius: 25px;
	display: inline-block;
}

.myLocation .form-control{
	margin-left: 10px;
	margin-right: 10px;
	color: #F15F5F;
	text-align: center;
	font-size: 15px;
	width: 100;
	display: inline;
}

/* 카테고리 표시란 */
.col-sm-4 {
	
	/* border: 1px solid black; */
	padding-top: 20px;
	padding-left: 30px;
	padding-right: 30px;
	padding-bottom: 20px;
	height: 300px;
	width: 33.3333%;
}
.col-sm-4 .img-circle{
	cursor: pointer;
	opacity: 0.6;
}

.col-sm-4 .img-circle:hover{
	opacity: 1;
}
</style>
<title>카테고리 페이지</title>
</head>
<body>
	<div class="container">
		<div class="header">
			${id }님 환영합니다<br>
			<a href="/logout">로그아웃</a> | <a href="#">마이페이지</a>
		</div>
		<div class="categories">
			<div class="myLocation">
				<div class="specificLocation">
				<b><font size="4">나의 <font color=red>위치</font>를 설정해주세요!</font></b>
				<input type="button" class="btn btn-warning" onclick="sample4_execDaumPostcode()" value="위치 설정" style="margin-left: 10px; margin-right: 10px;">
				<span id="guide" style="color:#999"></span>
				<input type="text" class="form-control" name="do1" placeholder="지역1" readonly>
				<input type="text" class="form-control" name="si" placeholder="지역2" readonly>
				<input type="text" class="form-control" name="dong" placeholder="지역3" readonly>
				</div>
			</div>
			<div class="categoryList">
				<div class="col-sm-4"><img src="/resources/image/category_img/category_travel1.png" id="travelBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_study1.png" id="studyBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_pet1.png" id="petBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_health1.png" id="healthBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_elec1.png" id="elecBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_diy1.png" id="diyBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_concert1.png" id="concertBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_beauty1.png" id="beautyBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
				<div class="col-sm-4"><img src="/resources/image/category_img/category_baby1.png" id="babyBtn" class="img-circle" alt="travel" width="100%" height="100%" draggable="false"></div>
			</div>
		</div>
		<div class="footer">
			
			김주영 | 정명규 | 지영준 | 이재욱 | 김영대 | 김가희<br>
			&copy; Social Life All rights reserved
		</div>
	<%@include file="categoryModal/travelModal.jsp" %>
	</div>
</body>
</html>
