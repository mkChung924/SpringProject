
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
<title>추천 여행지 살펴보기</title>
<style>
* {box-sizing: border-box}
body {
	font-family: "Lato", sans-serif;
	background-color: #F1F3FA;
	}

/* Style the tab */
div.tab {
    float: left;
    background-color: #D5D5D5;
    width: 10%;
    height: 90%;
}

/* Style the buttons inside the tab */
div.tab button {
    display: block;
    background-color: inherit;
    color: black;
    padding: 15px 16px;
    width: 100%;
    border: none;
    outline: none;
    text-align: left;
    cursor: pointer;
    transition: 0.3s;
    font-size: 17px;
}

/* Change background color of buttons on hover */
div.tab button:hover {
    background-color: #EAEAEA;
}

/* Create an active/current "tab button" class */
div.tab button.active {
    background-color: white;
}

/* Style the tab content */
.tabcontent {
    float: left;
    padding: 0px 12px;
    
    width: 90%;
    border-left: none;
    height: 90%;
}
.m, img{
	border-radius: 5%;
}
.header {
	margin-right: 0px;
	margin-top: 20px;
	text-align: right;
}
.row{
	margin-top: 20px;
	text-align: center;
}
</style>
</head>
<body>
<div class="regions" style="margin-left: 90px; margin-right: 90px;">
	<div class="row">
		<div class="header">
			<c:if test="${auth == 2 }">
			<b>[ ${nick } ]</b> <kbd style="background-color: red"><a href="/admin"><font color="white">관리자</font></a></kbd>
			</c:if>
			<c:if test="${auth < 2 }">
			<b>${nick }</b> 님 즐거운 여행지를 찾아보세요!<br>
			</c:if>
			
		</div>

	<div class="tab">
	<c:forEach items="${regionCount }" var="region">
		<button class="tablinks" onclick="openCity(event, '${region.PLACE1}')" id="defaultOpen">${region.PLACE1 } [ ${region.COUNT } ]</button>
	</c:forEach>		
	</div>

	<c:forEach items="${regionCount }" var="region">
	<div id="${region.PLACE1 }" class="tabcontent">
		<div id="${region.PLACE1 }" class="row">
		</div>
	</div>
	</c:forEach>


<script>
	function openCity(evt, cityName) {
		var place1 = cityName;
			
	    var i, tabcontent, tablinks;
	    tabcontent = document.getElementsByClassName("tabcontent");
	    for (i = 0; i < tabcontent.length; i++) {
	        tabcontent[i].style.display = "none";
	    }
	    tablinks = document.getElementsByClassName("tablinks");
	    for (i = 0; i < tablinks.length; i++) {
	        tablinks[i].className = tablinks[i].className.replace(" active", "");
	    }
	    document.getElementById(cityName).style.display = "block";
	    evt.currentTarget.className += " active";
	    
	    $.ajax({
	    		url:'/rest/regionDetail',
	    		data:'place1='+place1,
	    		success:function(result){
	    			
	    			ht ='';
	    			for(var i = 0; i < result.length; i++){
	    			
	    				ht += '<div class="col-md-3" style="text-align: center; margin-top: 20px;">'+
							'<div class="thumbnail m">'+
								'<img src="'+result[i].image+'" alt="ALT NAME" class="img-responsive" />'+
								'<div class="caption">'+
								'<h3>'+
									'<i>'+result[i].title+' !</i>'+
								'</h3>'+
									'<p>'+result[i].notice+'</p>'+
									'<p align="center">'+
										'<a class="btn btn-primary btn-block" onclick="adminReadPage(\''+result[i].tbno+'\',\''+result[i].place1+'\',\''+result[i].place2+'\',\''+result[i].cno+'\',\''+result[i].csno+'\')">떠나자!!</a>'+
									'</p>'+
								'</div>'+
								'<div style="padding-bottom: 10px;">'+
									'<i class="glyphicon glyphicon-comment" data-toggle="comment" data-placement="bottom" title="댓글"></i>&nbsp;'+ 
									'<span class="badge" style="background-color: gray">'+result[i].replies+'</span>&nbsp;&nbsp;&nbsp; '+
									'<i class="glyphicon glyphicon-thumbs-up" data-toggle="like" data-placement="top" title="좋아요"></i>&nbsp;'+
									'<span class="badge" style="background-color: blue">'+result[i].likes+'</span>&nbsp;&nbsp;&nbsp; '+
									'<i class="glyphicon glyphicon-tags" data-toggle="review" data-placement="bottom" title="후기"></i>&nbsp;'+
									'<span class="badge" style="background-color: green">'+result[i].reviews+'</span>'+
								'</div>'+
							'</div>'+
						'</div>';
	    			}
	    			
					$('#'+place1).html(ht);
	    			
	    		},
	    		error:function(result){
	    			alert('error');
	    		}
	    });
	    
	}

	// Get the element with id="defaultOpen" and click on it
	document.getElementById("defaultOpen").click();

	function adminReadPage(tbno,place1,place2,cno,csno) {
        var w = screen.width - 100;
        var h = screen.height - 150;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2) - 50;
        window.open("/adminTravelRead?tbno="+tbno+"&place1="+place1+"&place2="+place2+"&cno="+cno+"&csno="+csno, "관리자 여행 추천"+ "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    };
</script>
</div>
</div>
</body>
</html>