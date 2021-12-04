<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<title>자율스터디 모집게시판</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
	
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/css/boardStudy.css" rel="stylesheet" />

<!-- Bootstrap CSS -->

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<script>

	//무한 스크롤
	var page = 1;
	
      $(window).scroll(function() {
        if(((window.innerHeight + window.scrollY) >= document.body.offsetHeight)){
          console.log(++page); 
		 
			 $.ajax({
				url : "/board/json/listStudyBoard/",
				type : "POST",
				data : JSON.stringify({currentPage: page}),
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(result) {
				
				var list = result.list;
				var display = "";
				
				if(list.length > 0){
					
					$.each(list, function(index, list){
						
							display += '<div class="col mb-5">'
									+ '<div class="card h-100">'
									+ '<div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">new</div>'
									+ '<img class="card-img-top" src="/resources/images/studythumb.jpg" alt="..." />'
									+ '<div class="card-body p-4">'
									+ '<div class="text-center">'
									+ '<h5 class="fw-bolder">'+list.boardTitle+'</h5>'
									+ '</div>'
									+ '<input type="hidden" value="${board.boardNo}" />'
									+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
									+ '<td align="center">'+list.writer.nickname+'</td>'
									+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
									+ '<td align="left">'+list.boardRegDate+'</td>'
									+ '</div>'
									+ '<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">'
									+ '<div class="text-center">'
									+ '<a class="btn btn-outline-dark mt-auto" href="/board/getBoard?boardNo='+list.boardNo+'">View Study</a>'
									+ '</div>'
									+ '</div>'
									+ '</div>'
									+ '</div>';										
					
					});
					
					$("#listStudyBoard").append(display);
							
				}
			},
			error:function(request, status, error){
				
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			}); 
			 
		}	 
	});
  	  		

</script>

</head>
<body>
	<!-- Navigation-->
<jsp:include page="../common/toolbar.jsp" />
	<article>
		<!-- Header-->
		<header class="bg-darky py-5">
			<div class="container px-4 px-lg-5 my-5">
				<div class="text-center text-white">
					<h1 class="display-4 fw-bolder">자율스터디 모집게시판</h1>
					<p class="lead fw-normal text-white-50 mb-0">함께 공부할 친구들을 모집 해
						보세요!</p>
					<br /> 
					<a href="/board/addBoard?boardCategory=5">
					<img src="/resources/images/banana.png" onmouseover="this.src='/resources/images/banana2.png'"></a>

				</div>
			</div>
		</header>
		<!-- Section-->
		<section class="py-5">
			<div class="container px-4 px-lg-5 mt-5">
				<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center" id="listStudyBoard">


					<c:forEach var="board" items="${list}">


						<div class="col mb-5">
							<div class="card h-100">
								<!-- Sale badge-->
								<div class="badge bg-dark text-white position-absolute"
									style="top: 0.5rem; right: 0.5rem">new</div>
								<!-- Product image-->
								<img class="card-img-top" src="/resources/images/studythumb.jpg"
									alt="..." />
								<!-- Product details-->
								<div class="card-body p-4">
									<div class="text-center">
										<!-- Product name-->
										<h5 class="fw-bolder">${board.boardTitle}</h5>
									</div>
									<input type="hidden" value="${board.boardNo}" />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<td align="center">${board.writer.nickname}</td>
									<br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<td align="left">${board.boardRegDate}</td>
								</div>
								<!-- actions-->
								<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
									<div class="text-center">
										<a class="btn btn-outline-dark mt-auto"
											href="/board/getBoard?boardNo=${board.boardNo}">View</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					
				</div>
			</div>
		</section>
	</article>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; 2021 -
				ogong</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/resources/javascript/scripts.js"></script>

</body>
</html>
