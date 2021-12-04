<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<title>게시판</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
<script>
	function fncAddBoard() {

		let name = $('input[name="boardTitle"]').val();
		let detail = $('textarea').val();

		if (name == null || name.length < 1) {
			alert("제목을 입력해주세요.");
			return;
		}
		if (detail == null || detail.length < 5) {
			alert("5글자 이상 입력해주세요.");
			return;
		}

		$('form').attr('method', 'POST').attr('action', '/board/updateBoard')
				.submit();
	}
	
	$(function(){
		
		$('button:contains("수 정")').on('click',function(){
			
			fncAddBoard();
		})
		
		$('button:contains("취 소")').on('click',function(){
				
			histroy.go(-1);
		})
	})
	
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
	body, table, div, p, th, td {
	
	
font-family: 'Do Hyeon', sans-serif;
}


h3 {

text-align:center;
}


</style>
</head>
<body>
	<jsp:include page="../common/toolbar.jsp" />
	<br/>
	<br/>
	<div class="container">
		<form>
			<input type="hidden" name="userId" value="${writer.email}" />
			<input type="hidden" name="boardNo" value="${board.boardNo }"/>
			<div class="page-header">
				<h3 class=" text-default">글 수정</h3>
			</div>
			<br/>

			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>제 목</strong>
				</div>
				<div class="col-xs-8 col-md-4">
					<input class="form-control" type="text" name="boardTitle"
						style="width: 500px;" value="${board.boardTitle}" />
				</div>
			</div>

		<br/>
		<br/>
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>내 용</strong>
				</div>
				<div class="col-xs-8 col-md-4">
					<textarea class="form-control" name="boardContents"
						style="resize: none; height: 300px; width: 500px;">${board.boardContents}</textarea>
				</div>
			</div>

			<br/>
			<br/>
			<div align="center">
				<button type="button" class="btn btn-default" style="width: 60px;background-color:#88b3fa;">수 정</button>
				<button type="button" class="btn btn-default" style="width: 60px;background-color:#88b3fa;">취 소</button>
			</div>
		</form>
	</div>
</body>
</html>