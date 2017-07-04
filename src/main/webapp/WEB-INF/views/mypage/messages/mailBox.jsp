<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap/css/fontello.css?ver=1.1">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>메세지 함</title>
<script type="text/javascript">

     $(function(){//HTML문서가 브라우저 출력되었을때

	form = document.removeCheck;
    	 if(${msg != "send"}){
    		 $.ajax({
     			url:"receiveMailBox",
     			data: "page="+${page},
     			success:function(result){
 					  $('#div1').html(result);
 					   $('#div2').css('display','none')
 					  $('#div1').css('display','block')
 					  
 				  }
     		 });
    	 }
    	 
    	$('#button1').click(function(){
    		 $.ajax({
    			url:"receiveMailBox",
    			data: "page=1",
    			success:function(result){
					 /*  $('#div1').html(result);
					   $('#div2').css('display','none')
					  $('#div1').css('display','block') */
    				location.href="mailBox?page=1";
				  }
    		 });
    	});//click
    	
     if(${msg == "send"} ){
		 $.ajax({
			url:"sendMailBox",
			data: "page="+${page},
			success:function(result){
				  $('#div2').html(result);
				   $('#div1').css('display','none')
				  $('#div2').css('display','block')
			  }
		 });
     }
    	$('#button2').click(function(){
    		 $.ajax({
    			url:"sendMailBox",
    			data: "page=1",
    			success:function(result){
					  /* $('#div2').html(result);
					   $('#div1').css('display','none');
					  $('#div2').css('display','block'); */
					  location.href="mailBox?page=1";
				  }
    		 });
    	});//click
     });//function
</script>
<style type="text/css">
	body{
		font-family: "fontello";
	}

	#button1{
        color: white;
        display: inline-block;
        padding: 5px 10px;
        text-decoration: none;
        font-weight: bold;
        margin: 3px;
        background: #000099;
        border-radius: 10px;
        -moz-border-radius: 10px;
        -webkit-border-radius: 10px;
        box-shadow: 2px 2px 4px #999999;
        -moz-box-shadow: 2px 2px 4px #999999;
        -webkit-box-shadow: 2px 2px 4px #999999;
        background: linear-gradient(to bottom, #000099, #375094);
	}
	#button2{
        color: white;
        display: inline-block;
        padding: 5px 10px;
        text-decoration: none;
        font-weight: bold;
        margin: 3px;
        background: #000099;
        border-radius: 10px;
        -moz-border-radius: 10px;
        -webkit-border-radius: 10px;
        box-shadow: 2px 2px 4px #999999;
        -moz-box-shadow: 2px 2px 4px #999999;
        -webkit-box-shadow: 2px 2px 4px #999999;
        background: linear-gradient(to bottom, #000099, #375094);
	}
</style>
</head>
<body>
<center>
<h1>MESSAGE </h1>
<HR>
<form name="removeCheck">
<input type="button" id="button1" value="수신 메세지함">
<input type="button" id="button2" value="발신 메세지함">

</form>
<div class="container">

<div id="div1" style="display: none;">
</div>
<div id="div2" style="display: none;">
</div>
<form action="msgSend">
</form>
<font size="5"><a href="/project/msgSend" style="color: black" id="writer">메일 쓰기 &#xe800</a></font>
</div>
</center>
</body>
</html>