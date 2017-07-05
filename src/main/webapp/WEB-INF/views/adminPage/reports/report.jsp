<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>댓글 신고</title>
<script type="text/javascript" src="/resources/js/jquery3.js"></script>
<script type="text/javascript">	
	$(function(){			

			$('.report').click(function(){	
				//alert('rno: '+$(this).val());
				var rno = $(this).val(); //$('[name="rno"]').val();
				/* var id = $('[name="id"]').val();
				var content = $('[name="content"]').val() */
				
				 $.ajax({
						url:'reportinsert',
						data: 'rno='+rno,
						success:function(result){		
								location.href="/project/reportBox";	
						},
						error:function(result){
							alert("신고가 되지 않았습니다.");
						}
				});
		});	
	});
</script>
</head>
<body>
	<table>
		<tr>
			<td>글번호 </td>
			<td>아이디 </td>
			<td>내용 </td>
		</tr>
		<c:forEach items="${list}" var="report" >
			<tr>
				<td><input name="rno" value="${report.rno}"></td>
				<td><input name="id" value="${report.id}"></td>
				<td><input name="content" value="${report.content}"></td>	
				<td><button class="report" value="${report.rno }">신고</button></td>
			<tr>
		</c:forEach>
	</table>
</body>
</html>