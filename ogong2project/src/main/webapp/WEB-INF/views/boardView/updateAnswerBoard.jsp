<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<title>글 쓰기</title>

<!-- jQuery -->

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<!-- Bootstrap CSS -->

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">


	
</script>

<script type="text/javascript">

	let boardNo = "<c:out value='${answer.boardNo}'/>";
	let answerNo = "<c:out value='${answer.answerNo}'/>";

	function fnUpdateBoard() {
		var answerContents = $('textarea').val();
		
		$.ajax({
			url:'/board/updateAnswer',
			type:'post',
	        headers : {
	            "Accept" : "application/json",
	            "Content-Type" : "application/json"
	        },
	        data : JSON.stringify({
	        	"answerNo" : answerNo,
	        	"boardNo" : boardNo,
	        	"answerContents" : answerContents
	        }), 
			dateType:'json',
			success:function(JSONData, status){
				
			}
		}); 
	}

	$(function() {

		$('button:contains("등 록")').on('click', function() {
			
			fnUpdateBoard();
			location.href = "/board/getBoard?boardNo=" + boardNo;
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
}


h3 {

text-align:center;
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
		
			<h3>Q&A 게시글 수정</h3>
			<form name="AddBoard" id="form" method="post">
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="answerContent" id="content" placeholder="내용을 입력해 주세요">${answer.answerContents}</textarea>
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
