<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<title>파일공유 게시판</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- jQuery -->

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- Bootstrap CSS -->

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">



<script>
	$(function() {

		$("#addForm").submit(function(e) {
			e.preventDefault();
			
			let name = $('input[name="boardTitle"]').val();
			let detail = $('textarea').val();
			var formData = new FormData($(this)[0]);
			
			if (name == null || name.length < 1) {
				swal("제목을 입력해주세요.","","warning");
				return;
			}else if (detail == null || detail.length < 5) {
				swal("내용을 5글자 이상 입력해주세요.","","warning");
				return;
			}else{
				$.ajax({
					url : '/board/json/addBoard',
					type : 'POST',
					data : formData,
					async : false,
					cache : false,
					contentType : false,
					enctype : 'multipart/form-data',
					processData : false,
					success : function(res) {
						location.href = "/board/getBoard?boardNo=" + res;
					}
				});
				return false;
			}
			
			
		});
		
		
		$("button[id=cancelbtn]").on("click",function(){
			history.back();
		})
	});
	
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
body, table, div, p, th, td {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}

h3 {
	text-align: center;
}
button.btn {
	background-color:#88b3fa;
}
button.btn:hover {
	background-color:#88b3fa;
	color: white;
}
</style>

</head>

<body>
	<jsp:include page="../common/toolbar.jsp" />

	<div class="container">

	<br/>
		<h3>게시글 쓰기</h3>

		<form id="addForm">


			<div class="mb-3">
				<label for="title">제목</label> <input type="text"
					class="form-control" name="boardTitle" id="boardTitle"
					placeholder="제목을 입력해 주세요">

			</div>

			<div class="mb-3">

				<label for="content">내용</label>

				<textarea class="form-control" rows="5" name="boardContents"
					id="boardContents" placeholder="내용을 입력해 주세요"></textarea>

			</div>

			<h2>파일업로드</h2>

			<input id="input_file" multiple="multiple" type="file" name="file">
			<input type="hidden" name="boardCategory" value="${boardCategory}">
			<!-- 			<input type="text" name="boardTitle" value="제목을 입력해주세요">
			<input type="text" name="boardContents" value="내용을 입력해주세요">
			<input type="hidden" name="boardInterest" value=""> 	  -->
			<!-- <button type="submit" style="border: 1px solid #ddd; outline: none;">전송</button> -->

			<div align="center">
				<br />
				<button type="submit" style="width: 80px"
					class="btn btn-xl" id="btn">등록</button>

				<button type="button" style="width: 80px"
					class="btn btn-xl" id="cancelbtn">취소</button>

			</div>

		</form>
	</div>


</body>
</html>