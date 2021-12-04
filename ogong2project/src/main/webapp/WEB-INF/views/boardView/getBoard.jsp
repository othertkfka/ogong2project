<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/csssss/font-awesome.min.css">

<style>
	#userImage {
	width: 300px;
	height: 300px;
	margin-top: 10px;
	object-fit: cover;
  	left: 50%;
  	border-radius: 3.0rem !important;
  	max-width: 100%;
	}
</style>

<script>
    let boardNo = "<c:out value='${board.boardNo}'/>";
	let boardCategory = "<c:out value='${board.boardCategory}'/>";
	let userEmail = "<c:out value='${user.email}'/>";
	let currentPage = 1;
	let pageSize = 10;
	

	
	
	
	function fncDeleteBoard() {
		
		swal({
			  title: "삭제 하시겠습니까??",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
			    swal("게시글이 삭제되었습니다.", {
			      icon: "success",
			    });
			    location.href = "/board/deleteBoard?boardNo="+`${board.boardNo}`+"&boardCategory="+`${board.boardCategory}`; 
			  } else {
				  return;
			  }
			});
	}
	
	function recommend() {
		var cnt = $('#cnt');
		$.ajax({
			url:'/board/updateRecommend',
			type:'post',
			data: {
				'boardNo': boardNo
			},
			dateType:'json',
			success:function(res){
				cnt.text(res);
			}
		});
	}
	
	$(function(){
		
/*  		$("body #div3 #listComment").on("click", function(){
			alert("asdasd");
			$("#myModal3").find('#receiver2').val($(this).find('#writer1').val());
		    $("#myModal3").find('#receiver2').val($(this).find('input').val()); 
			$("#myModalReport2").find('#commentContents2').val("값이 들어가는지 확인");
		});  */

 		$(document).on('click','.dropdown',function(){

 	          $("#myModalReport2").find('#receiveReporter2').val($(this).find('#drop2').find('#writer1').val());
 	          $("#myModalReport2").find('#commentContents2').val($(this).find('#drop2').find('#writer3').val());
 	          $("#myModal3").find('#receiver2').val($(this).find('#drop2').find('#writer1').val());
 	          $("#myModalReport2").find('#commentNo').val($(this).find('#drop2').find('#writer4').val());
 	          
 				var email = $(this).find('#drop2').find('#writer1').val()
 				
 	 			$.ajax({
 					url : "/integration/json/getMyProfile/"+email,
 					method : "GET",
 					dataType : "JSON",
 					headers : {
 						"Accept" : "application/json",
 						"Content-Type" : "application/json"	 						
 					} ,
 					
 					success : function(JSONData, status){
 						$("#profile").html(JSONData.nickname+" 의 프로필");
 						$("#email").html(JSONData.email);
 						$("#email2").html(JSONData.email);
 						$("#nickname").html(JSONData.nickname);
 						$("#name").html(JSONData.name);
 						$("#birth").html(JSONData.birth);
 						$("#goal").html(JSONData.goal);
 						if(JSONData.userImage != null){
 							$("#image").html("<img id='userImage' src='/resources/upload_files/user_images/"+JSONData.userImage+"' alt='User profile picture'>")	
 						}else{
 							$("#image").html("<img id='userImage' src='/resources/upload_files/user_images/basic.jpg' alt='User profile picture'>");
 						}
 						$("#interest1").html(JSONData.studyInterest1);
 						$("#interest2").html(JSONData.studyInterest2);
 						$("#interest3").html(JSONData.studyInterest3);
 						
 					}

 					
 					
 				})  	          
 	     });  
	
	})
	
	
	
	
	
	function getCommentList(type) {
		if('M' === type){
			currentPage = currentPage+1; 
		}
		$.ajax({
			url:'/board/listComment',
			type:'get',
			data: {
				'boardNo': boardNo,
				'currentPage': currentPage,
				'pageSize': pageSize
			},
			dateType:'json',
			success:function(res){
				var list = res.list;
				var ul = $('#listComment');
				var li = "";
				var div = $('#commentContainer');
				var commentMore = $('<button type="buttonn" class="btn btn-dark" onclick="more()" style="margin-left:12px; margin-bottom:25px;" >더보기</button>');
				for(var i=0 ; i<list.length ; i++){
					var record = list[i];
				    li += "<li class='listComment2' style='margin-bottom:20px;'>"
						+ "<div class='dropdown'>"
			  			+ "		<a id='dropdownMenu2' data-toggle='dropdown' aria-expanded='true' style='text-decoration: underline;'><strong>"
						+ 		record.nickname
						+ "		</strong></a>"
						+ "     <span style='color:#aaa; padding-left:5px;'>"+record.commentRegDate+"</span>"
						+ "		<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' id='drop2'>"
						+ "			<li role='presentation'><a role='menuitem' tabindex='-1' href='#' data-toggle='modal' data-target='#getMyProfile'>프로필보기"
						+ "				<input type='hidden' value='"+record.commentWriter.email+"' /></a></li>"
						+ "			<li role='presentation'><a role='menuitem' id='commentDrop' tabindex='-1' href='#' data-toggle='modal' data-target='#myModal3'>쪽지보내기"
						+ "				<input type='hidden' id='writer1' value='"+record.commentWriter.email+"' /></a></li>"
						+ "			<li role='presentation'><a role='menuitem' tabindex='-1' href='#' data-toggle='modal' data-target='#myModalReport2'>신고하기"
						+ "				<input type='hidden' id='writer2' value='"+record.commentWriter.email+"' /></a></li>"
						+ "				<input type='hidden' id='writer3' value='"+record.commentContents+"' /></a></li>"
						+ "				<input type='hidden' id='writer4' value='"+record.commentNo+"' /></a></li>"
						+ "		</ul>"
						+ "</div>"
						+ "		<div class='comment' style='margin-bottom:5px;' value='"+record.commentContents+"'>"+record.commentContents+"</div>"
						+ "		<input type='hidden' class='commentNo'>";
					if(userEmail == record.commentWriter.email){
						li += "		<button type='button' onClick='updateModal(\""+record.commentNo+"\",\""+record.commentContents+"\")' class='btn-sm btn-primary' style='margin-right:2px;'>수정</button>"
							+ "		<button type='button' onClick='commentDelete("+record.commentNo+")' class='btn-sm btn-danger'>삭제</button>";
					}
						
					li += "</li>";
				}
				$("#listComment").append(li); 
				if(list.length == 10){
					div.append(commentMore);
				}
			}
			
		});
	}
	
	function updateModal(commentNo, commentContents) {
		$('#commentNo').val(commentNo);
		$('#commentCts').text(commentContents);
		/* var div = $('#modal');
		div.css("position", "absolute");
		div.css("top", Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
		div.css("left", Math.max(0, (($(window).width() - div.outerWidth()) / 2) + $(window).scrollLeft()) + "px"); */
		$('#modal').show();
	}
	
	function modalClose() {
		$('#modal').hide();
	}
	
	
	function updateComment(){
		var commentNo = $('#commentNo').val();
		var commentContents = $('#commentCts').val();
		$.ajax({
			url:'/board/updateComment',
			type:'POST',
			data: JSON.stringify({
				'boardNo': boardNo,
				'commentNo': commentNo,
				'commentContents': commentContents
			}),
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			dateType:'json',
			success:function(res){
				if (res) {
					$('#modal').hide();
					var ul = $('#listComment');
					var div = $('#commentContainer');
					ul.children('li').remove();
					div.children('button').remove();
					$('#commentCts').val("");
					currentPage=1;
					getCommentList();
				} else{
					alert('실패');
				}
			}
		});
		
	}
	
	function commentDelete(commentNo) {
	        swal({
	        	  title: "삭제 하시겠습니까?",
	        	  icon: "warning",
	        	  buttons: true,
	        	  dangerMode: true,
	        	})
	        	.then((willDelete) => {
	        	  if (willDelete) {
	        		  $.ajax({
	      				url:'/board/deleteComment',
	      				type:'POST',
	      				data: JSON.stringify({
	      					'commentNo': commentNo,
	      					'boardNo': boardNo
	      				}),
	      				headers : {
	      					"Accept" : "application/json",
	      					"Content-Type" : "application/json"
	      				},
	      				dateType:'json',
	      				success:function(res){
	      					if (res) {
	      						swal('삭제가 완료되었습니다.','','success');
	      						var ul = $('#listComment');
	      						var div = $('#commentContainer');
	      						
	      						ul.children('li').remove();
	      						div.children('button').remove();
	      						currentPage = 1;
	      						getCommentList();
	      					}
	      				}
	      			});
	        	  } else {
	        	    swal("취소되었습니다.");
	        	  }
	        	});
		
		}
	
	
	function addComment() {
		var commentContents = $('#comment').val();
		
		currentPage = 1; 
		$.ajax({
			url:'/board/addComment',
			type:'post',
			data: JSON.stringify({
				'boardNo': boardNo,
				'commentContents': commentContents
			}),
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			dateType:'json',
			success:function(res){
				if (res) {
					var ul = $('#listComment');
					var div = $('#commentContainer');
					ul.children('li').remove();
					div.children('button').remove();
					$('#comment').val("");
					
					currentPage=1;
					getCommentList();
				} else{
					alert('실패');
				}
			}
		});
	}

 	$(function(){
 		$("ul li:nth-child(1)").on("click", function(){
			
			var email = $(this).find('input').val();
			
 			$.ajax({
				url : "/integration/json/getMyProfile/"+email,
				method : "GET",
				dataType : "JSON",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				
				success : function(JSONData, status){
					$("#profile").html(JSONData.nickname+" 의 프로필");
					$("#email").html(JSONData.email);
					$("#email2").html(JSONData.email);
					$("#nickname").html(JSONData.nickname);
					$("#name").html(JSONData.name);
					$("#birth").html(JSONData.birth);
					$("#goal").html(JSONData.goal);
					if(JSONData.userImage != null){
						$("#image").html("<img id='userImage' src='/resources/upload_files/user_images/"+JSONData.userImage+"' alt='User profile picture'>")	
					}else{
						$("#image").html("<img id='userImage' src='/resources/upload_files/user_images/basic.jpg' alt='User profile picture'>");
					}
					$("#interest1").html(JSONData.studyInterest1);
					$("#interest2").html(JSONData.studyInterest2);
					$("#interest3").html(JSONData.studyInterest3);
					
				}

			}) 

		})
	}) 	

	$(function(){
		
		/*  		
				$("body #div3 #listComment").on("click", function(){
					alert("asdasd");
				$("#myModal3").find('#receiver2').val($(this).find('#writer1').val());
				$("#myModal3").find('#receiver2').val($(this).find('input').val()); 
				$("#myModalReport2").find('#commentContents2').val("값이 들어가는지 확인");
				});  
		*/


		 		$(document).on('click','.dropdown',function(){

		 	          $("#myModalReport2").find('#receiveReporter2').val($(this).find('#drop2').find('#writer1').val());
		 	          $("#myModalReport2").find('#commentContents2').val($(this).find('#drop2').find('#writer3').val());
		 	          $("#myModal3").find('#receiver2').val($(this).find('#drop2').find('#writer1').val());
		 	          $("#myModalReport2").find('#commentNo').val($(this).find('#drop2').find('#writer4').val());
		 	          if($(this).find('#drop2').find('#writer1').val() != null){
		 				var email = $(this).find('#drop2').find('#writer1').val()
		 	          }else if($(this).find('#drop1').find('#boardWriter').val() != null){
		 	        	 var email = $(this).find('#drop1').find('#boardWriter').val()
		 	          }
		 				
		 	 			$.ajax({
		 					url : "/integration/json/getMyProfile/"+email,
		 					method : "GET",
		 					dataType : "JSON",
		 					headers : {
		 						"Accept" : "application/json",
		 						"Content-Type" : "application/json"	 						
		 					} ,
		 					
		 					success : function(JSONData, status){
		 						$("#profile").html(JSONData.nickname+" 의 프로필");
		 						$("#email").html(JSONData.email);
		 						$("#email2").html(JSONData.email);
		 						$("#nickname").html(JSONData.nickname);
		 						$("#userNickname").html(JSONData.name);
		 						$("#birth").html(JSONData.birth);
		 						$("#goal").html(JSONData.goal);
		 						if(JSONData.userImage != null){
		 							$("#image").html("<img id='userImage' src='/resources/upload_files/user_images/"+JSONData.userImage+"' alt='User profile picture' id='userImage'>")	
		 						}else{
		 							$("#image").html("<img id='userImage' src='/resources/images/basic.jpg' alt='User profile picture'>");
		 						}
		 						$("#interest1").html(JSONData.studyInterest1);
		 						$("#interest2").html(JSONData.studyInterest2);
		 						$("#interest3").html(JSONData.studyInterest3);
		 						
		 					}

		 					
		 					
		 				})  	          
		 	     });  
			
			});

	function more() {
		
		var div = $('#commentContainer');
		div.children('button').remove();
		getCommentList('M');
	}
	
	function fileDown(fileNo){
		location.href = "/board/fileDown?fileNo=" + fileNo;	
	}
	
	$(function() {
		getCommentList();
		
		
		$('button:contains("수 정")').on('click', function() {
			location.href = "/board/updateBoard?boardNo=" + boardNo;
		})
		$('button:contains("삭 제")').on('click', function() {
			fncDeleteBoard();
		})
		$('button:contains("목 록")').on('click', function() {
			location.href = "/board/listBoard?boardCategory=" + boardCategory;
		})

		$('#updatebtn').on('click', function() {
			updateComment();
		})
		
	}) 	
	
	
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap')
	;
body, table, div, p, th, td {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}
pre {
	border: 0;
	background-color: transparent;
}


pre:LINK, pre:VISITED {
	text-decoration: none;
	color: black;
}
pre:HOVER { /* 마우스 커서 올렸을때 */
	text-decoration: underline;
	color: #6E92A1;
	font-weight: bold;
}
pre:ACTIVE { /* 마우스 버튼을 눌렀을때 */
	text-decoration: none;
	color: black;
}
ul, li {
	list-style:none;
}

#modal{
  display: none;
  width:100%;
  height: 100%;
  position:fixed;
  top:0;
  left:0;
}

#subModal {
  position: fixed;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 402px;
  height: 102px;
  z-index: 20;
} 

#subModal textarea{
  width: 400px;
  height: 100px;
  border-radius: 7px;
  padding: 0px 7px;
}

#bgModal{
  background-color: #000;
  opacity: 0.5;
  width:100%;
  height: 100%;
} 
#addBtn {
	background-color: #88b3fa;
}
#addBtn:hover {
	color: #fff;
}
button {
	border:none;
}
button:hover{
	color:white;
}

</style>
</head>

<body>
	<jsp:include page="../common/toolbar.jsp" />
	<jsp:include page="../adminView/addReport.jsp" />
	<jsp:include page="../adminView/addReport2.jsp" />
	<jsp:include page="../integrationView/getMyProfile.jsp" />
	<jsp:include page="../integrationView/addSendMessage2.jsp" />
	<jsp:include page="../integrationView/addSendMessage3.jsp" />

	<div class="container" id="div1">
		
		<br/>
		<c:if test="${board.boardCategory == 1}">
			<a href='/board/listBoard?boardCategory=${board.boardCategory}' style="color:#007bff;">정보공유게시판 > </a>
		</c:if>
		<c:if test="${board.boardCategory == 3}">
			<a href='/board/listBoard?boardCategory=${board.boardCategory}' style="color:#007bff;">합격후기게시판 > </a>
		</c:if>
		<c:if test="${board.boardCategory == 4}">
			<a href='/board/listBoard?boardCategory=${board.boardCategory}' style="color:#007bff;">자유게시판 > </a>
		</c:if>
		
		<br/><br/>
		<input type="hidden" name="boardEmail" id="boardEmail" value="${board.writer.email}" />
		<div class="row">
			<div class="col-xs-8 col-md-8"><h3>${board.boardTitle}</h3></div>
		</div>

		<br/>

		<div class="row">
			<div class="dropdown">
				<a class="col-xs-8 col-md-4"  id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" style="color:black;text-decoration: underline;">
				<strong>${board.writer.nickname}</strong></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="drop1">
				    <li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#getMyProfile">프로필보기
				    <input type="hidden" value="${board.writer.email}" /></a></li>
				    <li><a><input type="hidden" id="boardWriter" value="${board.writer.email}" /></a></li>
				    <li><a><input type="hidden" id="boardWriter" value="${board.writer.email}" /></a></li>
					<li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#myModal2">쪽지보내기
					<input type="hidden" value="${board.writer.email}" /></a></li>
				</ul>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<h6>${board.boardRegDate}</h6>
		</div>
		<hr />
		
		<br/>
		<div class="row">
			<div class="col-xs-6 col-md-8">
				<textarea cols="100" rows="10" readonly><c:out value="${board.boardContents}" /></textarea>
			</div>
		</div>
		<br/>
		<c:if test="${fileList.size() != 0}">			
			<hr />
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>첨부파일</strong>
				</div>
				<div class="col-xs-6 col-md-4">
					<c:forEach var="file" items="${fileList}">
						<pre onClick="fileDown(${file.fileNo})" style="cursor: pointer; width: 500px; height: 80px; "cursor:pointer;">${file.fileName}&nbsp;<i class="fa fa-file-text" aria-hidden="true"></i></pre>
					</c:forEach>
				</div>
			</div>
		</c:if>	
		<hr />
		<div align="right">
			<div id="recommend" class="btn-sm btn-danger" onclick="recommend()" style="width: 60px;">
				추 천 <span id="cnt">${board.recommendCount}</span>
			</div>
		<div>
		</div>
		<br/>
			<button type="button" class="btn-sm" style="width: 60px; background-color:#88b3fa;"
				data-toggle="modal" data-target="#myModalReport">신 고</button>
			<c:if test="${board.writer.email == user.email}">
				<button type="button" class="btn-sm" style="width: 60px; background-color:#88b3fa;">수 정</button>
				<button type="button" class="btn-sm" style="width: 60px; background-color:#88b3fa;">삭 제</button>
			</c:if>
			<input type="hidden" value="${message.sender.email}" />
			<button type="button" class="btn-sm" style="width: 60px; background-color:#88b3fa;">목 록</button>
		</div>
	</div>


	<div class="container">
			<div>
				<div>
					<span><strong>comment</strong></span> &nbsp;<i class="fa fa-commenting-o" aria-hidden="true"></i>
				</div>
				<br/>
				<c:if test="${board.writer.email != user.email}">
				<div>
					<table class="table">
						<tr>
							<td><textarea style="width: 1100px" rows="3" cols="30"
									id="comment" placeholder="댓글을 입력하세요"></textarea> <br>
								<div style="display: flex;justify-content: flex-end;">
									<a href='#' onClick="addComment()" id="addBtn"
										class="btn pull-right">등록</a>
								</div>
							</td>
						</tr>
					</table>
				</div>
				</c:if>
			</div>
	</div>
	



	<div class="container" id="commentContainer">

		<ul id="listComment" style="padding:0px;">
		
		</ul>
	</div>
	
	<div id="modal">
		<div id="subModal">
			<input type="hidden" id="commentNo">
			<textarea id="commentCts" rows="3" cols="30" 
				placeholder="수정할 내용을 입력하세요"></textarea>
			<div>
				<button type="button" class="btn-sm btn-warning"
					onClick="updateComment()" style="width: 50px;">확인</button>
				<button type="button" class="btn-sm btn-warning"
					onClick="modalClose()" style="width: 50px;">취소</button>
			</div>
		</div>		
		<div id="bgModal"></div>
	</div>
	
</body>
</html>