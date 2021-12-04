<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<title>글 쓰기</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<script type="text/javascript">
	function fncAddBoard() {
		let userBanana = "${user.bananaCount}";
		let contents = $('input[name="boardContents"]').val();	
		let name = $('input[name="boardTitle"]').val();
		let detail = $('textarea').val();
		let boardRegBanana = $("input[name='boardRegBanana']").val();
				
		if (name == null || name.length < 1) {
			swal("제목을 입력해주세요.","","warning");
			return;
		}
		if (Number(boardRegBanana) > Number("200")){
			swal("바나나는 최대 200까지 입력가능합니다.","","warning");
			return;
		}
		if(Number(userBanana) < Number(boardRegBanana)){
			swal("바나나가 부족합니다.","","error");
			return;
		}
		if (detail == null || detail.length < 1) {
			swal("내용을 입력해주세요.","","warning");
			return;
		}

		$('form').attr('method', 'POST').attr('action', "/board/addBoard")
				.submit();
	}

	$(function() {

		$('button:contains("등 록")').on('click', function() {
			
			fncAddBoard();
		});

		$('button:contains("취 소")').on('click', function() {

			$('form')[0].reset();
		});
		
	});
</script>
<style>

@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
font-size: 20px;
}
button.btn {
	background-color:#88b3fa;
}
button.btn:hover {
	background-color:#88b3fa;
	color: white;
}
h3 {
text-align:center;
}
</style>
</head>

<body>
	<jsp:include page="../common/toolbar.jsp" />

	<div class="container">
	
	<div class="page-header text-default">
				<c:if test="${boardCategory == '1'}">
	       				<h3>정보공유 게시판</h3>
	       		</c:if>
	       		<c:if test="${boardCategory == '2'}">
	       				
	       		</c:if>
	       		<c:if test="${boardCategory == '3'}">
	       				<h3>합격후기 게시판</h3>
	       		</c:if>
	       		<c:if test="${boardCategory == '4'}">
	       				<h3>자유 게시판</h3>
	       		</c:if>
	       		<c:if test="${boardCategory == '5'}">
	       				<h3>자율스터디 모집 게시판</h3>
	       		</c:if>
	       		<c:if test="${boardCategory == '6'}">
	       				<h3>파일공유 게시판</h3>
	       		</c:if>
		</div>
		<article>
	<br/>
		<div class="container" role="main">
		
			<h3>Q&A 게시글 쓰기</h3>

			<form name="AddBoard" id="form" method="post">

				<div class="mb-3">

					<label for="title">제목</label>

					<input type="text" class="form-control" name="boardTitle" id="boardTitle" placeholder="제목을 입력해 주세요">
					<input type="hidden" name="boardCategory" id="boardCategory" value="${boardCategory}"/>
				</div>
				
				<div class="mb-3">

					<label for="banana">바나나 수</label>

					<input type="number" min="0" max="200" step='5' class="form-control col-md-4" name="boardRegBanana" id="boardRegBanana" placeholder="채택 시 답변자에게 줄 바나나 수를 입력해주세요"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">

				</div>			

				<div class="mb-3">

					<label for="content">내용</label>

					<textarea class="form-control" rows="5" name="boardContents" id="boardContents" placeholder="내용을 입력해 주세요"></textarea>

				</div>
			

			</form>

		</div>

<br/>
	</article>


			<div align="center">
				<button type="button" class="btn" style="width: 60px;">등 록</button>
				<button type="button" class="btn" style="width: 60px;">취 소</button>
			</div>
		</div>
	
</body>
</html>
