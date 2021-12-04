  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(function() {
	
	$( "td:nth-child(1)" ).on("click" , function() {
		var boardNo = $(this).find('input').val();
		
		 self.location ="/board/getBoard?boardNo="+boardNo;
	});
	
});	
</script>
<style>
.container {
	max-width: 1200px;
}

.title {
	margin-top: 1em;
	margin-bottom: 1em;
	font-weight: bold;
}

.btn {
	background-color: #ef6c00;
	color: white;
	font-weight: bold;
}

.btn:hover {
	background-color: rgb(240, 130, 0);
	color: white;
	font-weight: bold;
}

/* dropdown shadow */
.form-control:focus {
	border-color: #ef6c00;
	box-shadow: 0 0 0 0.2rem rgba(255, 165, 0, 0.25);
}
</style>
	<!-- ToolBar Start /////////////////////////////////////-->
	
	
	
   	<!-- ToolBar End /////////////////////////////////////-->

<!-- pagination start -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
}    
.page-link {
	color: #9fcfff !important;
}



</style>
<!-- pagination end -->


<title>나의 게시글</title>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/toolbar.jsp" />

</div>
	<!-- free board start  -->
	<div class="container" style="height: 100px">
		<div class="title">
			<h5 class="font-weight-bold">나의 게시글</h5>
		</div>
	</div>
	<div class="container">
		<table class="table table-hover">
			<thead class="thead-light">
				<tr>
					<th align="left">제목</th>
					<th align="left">조회수</th>
					<th align="left">작성일</th>
				</tr>
				  <!--  히든값 -->
				
				<c:forEach items="${list}" var = "board">
							<tr>
								<td class="col-md-7" align="left" >${board.boardTitle}
									<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}"/>
								</td>
								<td class="col-md-2" align="left" >${board.viewCount}</td>
								<td class="col-md-3" align="left" >${board.boardRegDate}</td>
							</tr>   
						</c:forEach>
			
			</thead>
			<tbody id="tableBody"></tbody>
		</table>


		<script>
	
		</script>
	</div>


	<!-- pagination start -->
	<div class="container">

		<nav aria-label="Page navigation example">
			<ul class="pagination pagination-sm justify-content-center">
				<li class="page-item disabled"><a class="page-link" href="#"
					tabindex="-1">이전</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">4</a></li>
				<li class="page-item"><a class="page-link" href="#">5</a></li>
				<li class="page-item"><a class="page-link" href="#">다음</a></li>
			</ul>
		</nav>
	</div>
	<!-- pagination end -->

	<div class="container">
		<div class="row">
			<div class="col-sm-3"></div>



			<div class="col-sm-3"></div>
		</div>
	</div>
	<!-- free board end  -->

	
</body>
</html>
  
 
