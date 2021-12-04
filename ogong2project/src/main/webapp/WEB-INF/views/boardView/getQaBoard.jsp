<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Q&A 게시판 보기</title>


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">


<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
	let boardTitle = "<c:out value='${board.boardTitle}'/>";
	let adoptionFlag = "<c:out value='${board.adoptionFlag}'/>";
	let writerEmail = "<c:out value='${board.writer.email}'/>";
	let boardRegBanana = "<c:out value='${board.boardRegBanana}'/>";
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

	
	function adoption(answerNo) {
		var adp = $('#adp');
		var ul = $('#listAnswer');
		$.ajax({
			url:'/board/json/updateAdoption/'+answerNo+'/'+boardNo+'/'+boardRegBanana,
			type:'get',
            headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json"
             },
			dateType:'json',
			success:function(JSONData, status){
				adoptionFlag = 1
				ul.empty()
				getAnswerList() 
			}
		});
			
	}
	
	
	function addAnswer() {
		var answerContents = $('#answerCts').val();
		var email = "${user.email}";
		
		if(email == writerEmail){
			swal("작성자는 답변할 수 없습니다.","","error");
			$("#answerCts").val("");
			
			return;
		}
		
		$.ajax({
			url:'/board/addAnswer',
			type:'post',
			data: JSON.stringify({
				'boardNo': boardNo,
				'email': email,
				'answerContents': answerContents
			}),
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			dateType:'json',
			success:function(res){
					var ul = $('#listAnswer');
					var div = $('#answerContainer');
					ul.children('div').remove();
					div.children('button').remove();
					$('#answerCts').val("");
		
					getAnswerList();

			}
		});
	}
	

	function getAnswerList() {
		var cnt = $('#cnt');
		$.ajax({
			url:"/board/listAnswer/"+boardNo,
			type:'get',	
			dateType:'json',
			success:function(res){
				var list = res;
				var ul = $('#listAnswer');
				var display = "";
						
				$("#answerCnt").text(list.length+"개의 답변");
				for(var i=list.length-1 ; i>=0 ; i--){
					var record = list[i];
              			 
					display += '<div class="container" id="answerDiv" style="background-color:white;"><br/>'
						+ '<div id="user">'
						+ '<div class="box" style="background: #BDBDBD;">'
						+ '<img class="profile" src="/resources/upload_files/user_images/'+record.userImage+'">'
						+ '</div>&nbsp;'
						+ '<div>'+record.nickname+' 님의 답변</div>'
						+ '<div><h6>&nbsp;&nbsp;&nbsp;'+record.answerRegDate+'</h6></div>'
						+ '&nbsp;&nbsp;&nbsp;';
						
						if (adoptionFlag != '1' && writerEmail == userEmail) {
							display += '<div id="recommend" class="btn btn-danger" onclick="adoption('+record.answerNo+')" style="width: 55px;height:40px;">채택</div>';
	              		}
	              		if (record.adoptionFlag == '1'){
	              			 display += '<div class="btn btn-danger" id="adoptionc" style="width: 80px;height:40px;">채택완료<span id="cnt"></span>'
	              					 + '</div>';
	              		}
					display += '</div>'
						+ '<hr/>'
						+ '<p>'+record.answerContents+'</p>'
						+ '<hr/>';
						if (record.email == "${user.email}"){
	              			 display += '<button type="button" id="answera" class="btn" onclick="updateAnswer('+record.answerNo+')" style="height: 40px;">답변 수정</button>&nbsp;'
	              		 			+ '<button type="button" id="answera" class="btn" onclick="deleteAnswer('+record.answerNo+')" style="height: 40px;">답변 삭제</button>';
						}
					display += '<br/><br/></div>';
						
				}
				
				$("#listAnswer").append(display);
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

	
	function updateAnswer(answerNo) {
		location.href = "/board/updateAnswer?answerNo=" + answerNo;
	}
	
	
	
	function deleteAnswer(answerNo) {
		 $.ajax({
			url:'/board/deleteAnswer',
			type:'post',
            headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json"
            },
            data : JSON.stringify({
            	"answerNo" : answerNo,
            	"boardNo" : boardNo
            }), 
			dateType:'json',
			success:function(JSONData, status){
				if(JSONData){
					$("#listAnswer").children().remove();
					getAnswerList();
					
				} else{
					alert("실패");
				}
			}
		});
	}
	
	
	
	$(function() {
		getAnswerList();
		
		
		$('button:contains("답변등록")').on('click', function() {

			location.href = "/board/addAnswer?boardNo=" + boardNo;
		})
		
		$('button:contains("수 정")').on('click', function() {

			location.href = "/board/updateBoard?boardNo=" + boardNo;
		})

		$('button:contains("삭 제")').on('click', function() {

			fncDeleteBoard();
		})

		$('button:contains("목 록")').on('click', function() {

			location.href = "/board/listBoard?boardCategory=" + boardCategory;
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
td {
	text-align: left !important;
}
#modal {
	display: none;
	width: 400px;
	height: 365px;
	position: fixed;
	top: 350px;
	right: 50%;
	z-index: 20;
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

.box {
    width: 50px;
    height: 50px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
#user{
	display: flex;
}
#answerDiv {
	margin: 20px 0px 20px 0px;
}
#addAnswer {
	background-color: #88b3fa;
}
#addAnswer:hover {
	color: #fff;
}
button {
	border:none;	
}
button:hover{
	color: #fff;
}
#answera {
	background-color:#88b3fa;
}
#answera:hover{
	color: #fff;
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
	
<div class="content">	
	<div class="container" id="div1">
		<br/>
		<input type="hidden" name="boardEmail" id="boardEmail" value="${board.writer.email}" />
		<div class="row">
			<div class="col-xs-8 col-md-8"><h3>Q : ${board.boardTitle}</h3></div>
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
					<li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#myModal2">쪽지보내기
					<input type="hidden" value="${board.writer.email}" /></a></li>
				</ul>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<h6>${board.boardRegDate}</h6>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${board.adoptionFlag == 1}">
				<h5>채택 완료</h5>
			</c:if>
			<c:if test="${board.adoptionFlag != 1}">
				<h5>걸려있는 바나나 : ${board.boardRegBanana}</h5>
			</c:if>
			
		</div>
		<hr />
		
		<br/>
		<div class="row">
			<div class="col-xs-6 col-md-8">
				<textarea cols="100" rows="10" readonly><c:out value="${board.boardContents}" /></textarea>
			</div>
		</div>
		<div align="right">
			<br/>
			<button type="button" class="btn-sm btn-warning" style="width: 60px; background-color:#88b3fa; "
				data-toggle="modal" data-target="#myModalReport">신 고</button>
			<c:if test="${board.writer.email == user.email}">
				<button type="button" class="btn-sm btn-warning" style="width: 60px; background-color:#88b3fa;">수 정</button>
				<button type="button" class="btn-sm btn-warning" style="width: 60px; background-color:#88b3fa;">삭 제</button>
			</c:if>
			<input type="hidden" value="${message.sender.email}" />
			<button type="button" class="btn-sm btn-warning" style="width: 60px; background-color:#88b3fa;">목 록</button>
		</div>
		<br/>
	</div>


	<div class="container" id="div2">
		<c:if test="${board.writer.email != user.email}">
			<div class="container">
				<div>
					<div>
						<span><strong>답변등록</strong></span>&nbsp;<i class="fa fa-commenting-o" aria-hidden="true"></i>
					</div>
					<div>
						<table class="table">
							<tr>
								<td><textarea style="width: 1100px" rows="3" cols="30"
										id="answerCts" placeholder="답변을 입력하세요"></textarea> <br>
									<div>
										<a href='#' onClick="addAnswer()" id="addAnswer"
											class="btn pull-right">등록</a>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	
	<div class="content-wrapper">
		<br/>
		<div class="container" id="answerContainer">
			<span>A : </span>
			<a id="answerCnt"></a>
	
			<ul id="listAnswer">
				
			</ul>
		</div>
	</div>
</div>
</body>
</html>