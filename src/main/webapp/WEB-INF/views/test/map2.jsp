<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="/resources/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	var output = document.getElementById("out");

	  if (!navigator.geolocation){
	    output.innerHTML = "<p>사용자의 브라우저는 지오로케이션을 지원하지 않습니다.</p>";
	    return;
	  }

	  function success(position) {
	    var latitude  = position.coords.latitude;
	    var longitude = position.coords.longitude;

	    output.innerHTML = '<p>위도 : ' + latitude + '° <br>경도 : ' + longitude + '°</p>';

	    var img = new Image();
	    img.src = "http://maps.googleapis.com/maps/api/staticmap?center=" + latitude + "," + longitude + "&zoom=13&size=300x300&sensor=false";

	    output.appendChild(img);
	  };

	  function error() {
	    output.innerHTML = "사용자의 위치를 찾을 수 없습니다.";
	  };

	  output.innerHTML = "<p>Locating…</p>";

	  navigator.geolocation.getCurrentPosition(success, error);
	
});


	
/* 
	navigator.geolocation.getCurrentPosition(function(pos) {
	    var latitude = pos.coords.latitude;
	    var longitude = pos.coords.longitude;
	    alert("현재 위치는 : " + latitude + ", "+ longitude);
	    
	    $("#out").html("현재 위치는 : " + latitude + ", "+ longitude);
	});
 */
</script>
<title>Insert title here</title>
</head>
<body>
<div id="out"></div>

</body>
</html>