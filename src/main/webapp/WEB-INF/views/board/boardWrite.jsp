<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- TinyMCE -->
<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
  <script>
tinymce.init({      
      selector: '#editor',  // change this value according to your HTML
      auto_focus: 'element1',
      toolbar: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | imageupload',
      menubar: false,
      plugins: [
        'advlist autolink lists link image charmap print preview anchor',
        'searchreplace visualblocks code fullscreen',
        'insertdatetime media table contextmenu paste code'
      ],
      setup: function(editor) {
              // create input and insert in the DOM
              var inp = $('<input id="tinymce-uploader" type="file" name="pic" accept="image/*" style="display:none">');
              $(editor.getElement()).parent().append(inp);

              // add the image upload button to the editor toolbar
              editor.addButton('imageupload', {
                text: '이미지',  
                icon: 'image',
                onclick: function(e) { // when toolbar button is clicked, open file select modal

                  inp.trigger('click');
                }
              });

              // when a file is selected, upload it to the server
              inp.on("change", function(e){

                uploadFile($(this), editor);
              });
      	}
	});
function uploadFile(inp, editor) {
    var input = inp.get(0);
    var data = new FormData();
    data.append('files', input.files[0]);
	
    $.ajax({
      url: '/rest2/a/images',
      type: 'POST',
      data: data,
      enctype: 'multipart/form-data',
      dataType : 'json',
      processData: false, // Don't process the files
      contentType: false, // Set content type to false as jQuery will tell the server its a query string request
      success: function(data, textStatus, jqXHR) {
        editor.insertContent('<img class="content-img" src="${pageContext.request.contextPath}' + data.location + '" data-mce-src="${pageContext.request.contextPath}' + data.location 
        		+ '" alt='+data.location+'/>');
      },
      error: function(jqXHR, textStatus, errorThrown) {
        if(jqXHR.responseText) {
          errors = JSON.parse(jqXHR.responseText).errors
          alert('Error uploading image: ' + errors.join(", ") + '. Make sure the file is an image and has extension jpg/jpeg/png.');
        }
      }
    });
  }
</script>
	
<script>

	
	$(function(){
				
		$(document).on("change", "#mainC", function() {

			var str="";
				$.ajax({
					type : 'post',
					url : '/rest/'+$(this).find(":selected").val(),
					dateType : "json",
					success : function(result) {
						console.log(result);
						for(var i=0;  i<result.length;i++){
							
							if(result[i]["CSNO"] == ${csno}){
								continue;
							}
							str +="<option value="+result[i]["CSNO"]+">"+result[i]['CSNAME']+"</option>";
						}
						$("#subC").html(str);
					}
				});
			});
		
		var str="";
		$.ajax({
			type : 'post',
			url : '/rest/'+${cno},
			dateType : "json",
			success : function(result) {
				
				str +="<option value="+${csno}+">${subcategory}</option>";
				for(var i=0;  i<result.length;i++){
					
					if(result[i]["CSNO"] == ${csno}){
						continue;
					}
					str +="<option value="+result[i]["CSNO"]+">"+result[i]['CSNAME']+"</option>";
				}
				$("#subC").html(str);
			}
		});
		
		/* 카테고리2 변경시 그 값이 저장됨 */
		$('#subC').on("change",function(){
			$('[name=csno]').val($('#subC').val());
		});
	})

</script>
<style>
#title {
	display: inline;
	width: 350px;
}
#tel {
	display: inline;
	width: 130px;
}
.form-control{
	display: inline;
	width: 500px;
}
.row{	
	padding-left: 40px;
	padding-right: 40px;
	
}
</style>

<div class="row">
<form class="form-horizontal" role="form" method="post" action="common_regit" enctype="multipart/form-data">
	<input type="hidden" value="${id}" id="id" name="id">
	<input type="hidden" value="${cno}" id="id" name="cno">
	<input type="hidden" value="${csno}" id="id" name="csno">
	<h4>게시글 작성</h4><hr>
	<div class="form-group">
	<label for="name" class="col-sm-2 control-label">제목</label>
	<div class=col-sm-10>
	<input type="text" class="form-control" id="title" name="title" placeholder="제목을 간략하게 입력해주세요." maxlength="50">
	<span style="display: inline; margin-left: 25px;"><label>설정 위치 &nbsp;</label> <i><kbd>${do1 }</kbd> <kbd>${si }</kbd> <kbd>${dong }</kbd></i></span>
	<input type="hidden" name="do1" value="${do1 }">
	<input type="hidden" name="si" value="${si }">
	<input type="hidden" name="dong" value="${dong }">
	</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">카테고리</label>
		<div class="col-sm-10">
			<select name="mainC" id="mainC" style="width: 80px;">
				<option value="${cno }">${category }</option>
				<c:if test="${cno != 1 }">
					<c:forEach var="mainc" items="${mainCategory}" varStatus="status">
						<c:if test="${mainc.CNO != 1}">				
							<option value="${mainc.CNO}">${mainc.CNAME}</option>
						</c:if>
					</c:forEach>
				</c:if>
				
			</select> 
			<select name="subC" id="subC" style="width: 80px;">
			</select>
			 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			<c:if test="${cno == 1}"><!-- 여행일 때만 보여줌 -->
			<select name="tb_kind">
				<option value="1">여행 글쓰기</option>
				<option value="2">여행 후기글</option>
			</select>
			<span style="display: inline; margin-left: 25px;"><label>여행 장소 &nbsp;</label> <i><kbd>${p1 }</kbd> <kbd>${p2 }</kbd></i></span>
			<input type="hidden" name="place1" value="${p1 }">
			<input type="hidden" name="place2" value="${p2 }">
			</c:if>
			
<!-- 			<div style="display: none">
					<select name="tb_kind">
						<option value="1">여행 글쓰기</option>
						<option value="2">여행 후기글</option>
					</select>
				<pre style="display: inline; margin-left: 25px;"><label>여행 장소 &nbsp;</label> <i><kbd>강원도</kbd> <kbd>강릉</kbd></i></pre>
				<input type="hidden" name="place1" value="">
				<input type="hidden" name="place2" value="">
			</div> -->
			 
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">공지사항</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="notice" name="notice" placeholder="공지할 내용이 있다면 입력해주세요!" value="">
		</div>
	</div>
		<div class="form-group">
		<label for="name" class="col-sm-2 control-label">오픈 채팅방</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="openchat" name="openchat" placeholder="더욱 수월하게 소통할 수있는 오픈카톡방이 있나요?" value="">
		</div>
	</div>
		<div class="form-group">
		<label for="name" class="col-sm-2 control-label">연락처</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="tel" name="tel" placeholder="전화 번호" value="">
			&nbsp; &nbsp;&nbsp;<input type="checkbox" id="chbox" name="tel_ch" value="1"><b>&nbsp; 연락처 공개</b>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">내용</label>
		<div class="col-sm-10">
			<textarea id="editor" name="content" rows="20"></textarea>
		</div>
	</div>
	<div class="form-group" style="text-align: center">
		<div class="col-sm-10 col-sm-offset-2">
			<input id="submit" name="submit" type="submit" value="저장하기" class="btn btn-danger">
			<input id="cancel" name="cancel" type="reset" value="취소" class="btn btn-primary">
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-10 col-sm-offset-2">
			<! Will be used to display an alert to the user>
		</div>
	</div>
</form>
</div>
