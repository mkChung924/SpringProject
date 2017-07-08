//신고 삭제 , 패널티 없음
	$(document).on("click","#reportsDelBtn",function(){	
		var chkedSize = $('input:checkbox[name="chbox1"]:checked').length;
		var kind = $("#hiddenKind").val();
		var repnoList ="";
		if(chkedSize < 1){
			alert('삭제할 신고를 선택하세요')
		} else {
			$('input:checkbox[name="chbox1"]').each(function() {
				if (this.checked) {
					repnoList += this.value+",";
				}
			});
			alert(repnoList);
			 $.ajax({
					url:'selectedReprotListDelete',
					type : 'post',
					data: {
						repnoList : repnoList.substring(0, repnoList.length-1),
						kind : kind
					},
					success:function(result){
						alert("삭제 성공")
						location.reload();
					},
					error:function(result){
						alert("신고가 되지 않았습니다.");
					}
			});
		}
	});
	
	//신고 삭제 유저에게 패널티
		$(document).on("click","#reportsDelPenalty",function() {	//
			var chkedSize = $('input:checkbox[name="chbox1"]:checked').length;
			var kind = $("#hiddenKind").val();
			var repnoList ="";
			var offenderList="";
			var brnoList="";
			if(chkedSize < 1){
				alert('삭제할 신고를 선택하세요')
			} else {
				$('input:checkbox[name="chbox1"]').each(function() {
					if (this.checked) {
						repnoList += this.value+",";
						offenderList += $("#off-"+this.value).html()+",";
						brnoList += $("#brnoRow-"+this.value).val()+",";
					}
				});
				
	 			 $.ajax({
						url:'selectedReprotListDeletePenalty',
						type : 'post',
						data: {
							repnoList : repnoList.substring(0, repnoList.length-1),
							offenderList : offenderList.substring(0, offenderList.length-1),
							brnoList : brnoList.substring(0, brnoList.length-1),
							kind : kind
						},
						success:function(result){
							alert("패널티를 주고 삭제하였습니다.");
							location.reload();
						},
						error:function(result){
							alert("신고가 되지 않았습니다.");
						}
				}); 
			}
		});	
	
	$(document).on("click",".pagination li a", function(event){ //실제  페이징 된 버튼
		event.preventDefault(); 
		var targetPage = $(this).attr("href");
		var jobForm = $("#jobForm");
		jobForm.find("[name='page']").val(targetPage);
		jobForm.attr("action","/reportBox").attr("method", "get");
		jobForm.submit();
	});
	
  	function readPage(tbno) {//신고된 게시글 보기
        var w = 1300;
        var h = 850;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);
        window.open("/CommonRead?tbno=" + tbno, tbno + "번 게시글", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    };
