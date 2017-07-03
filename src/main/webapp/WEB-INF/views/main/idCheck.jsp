<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>중복확인</title>
<%-- toyLoginCheck.jsp --%>
<script type="text/javascript">

	function useId(param){
		$(".memberinfo [name=id]",opener.document).val(param);
		window.close();

	}
	
	function Check(){
	      
	      var id = $('[name=idCheck]').val();
	      
	      var idExp = /^[a-zA-Z0-9]{5,10}$/g;
	   
	      if(id == ""){
	         alert('값을 입력 해 주세요.');
	      }else if(id.indexOf(" ")> -1 || 
	            id.indexOf("\t")>=0 ||id.indexOf("\n")>-1){
	         alert('값의 공백이 있습니다.')
	      }else if(!idExp.test(id)){
	            alert('아이디 형식이 옳지 않습니다.');
	            $('[name=idCheck]').val("");
	            $('[name=idCheck]').focus();
	               
	      }else{
	       
	    	  $.ajax({
	    		 	url:'/dupCheck',
	    		 	cache:false,
	    		 	data:'id='+id,
	    		 	success:function(result){
	    		 		if(result == 'possible'){
	    		 			$('.idOk').html('[ <font color=red>'+id+'</font> ]는(은) 사용가능합니다. 사용하시겠습니까?<br><br><input type="button" class="btn btn-warning" onclick="useId(\''+id+'\')" value="사용하기" style="width: 200px;" display: inline;>')
	    		 		} else {
	    		 			$('.idOk').html('[ <font color=red>'+id+'</font> ]는(은) 이미 존재하는 아이디입니다.')

	    		 		}
	    		 	}
	    		 	
	    	  });
	      }
	   }
</script>
</head>
<body>
		<div class="body" style="text-align: center">
			<br>
			<label><b><font size=4>사용할 아이디를 입력하세요.</font></b></label><br><br>
			<input type="text" class="form-control" size="10" name="idCheck" autocomplete="off" style="width: 200px; display: inline">
			<input type="button" class="btn btn-info" value="중복확인" name = "checkB" onclick="Check()">
			<br><br>
			<div class="idOk" style="text-align: center;"></div>
		</div>
		
</body>
</html>