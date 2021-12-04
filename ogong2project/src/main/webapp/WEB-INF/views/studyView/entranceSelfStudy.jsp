<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>OGong</title>
<link rel="stylesheet" href="/resources/css/adminlte.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
font-size: 20px;
}
#container {
	margin-top: 30px;
}
#entrance {
	background-color:#88b3fa;
	border-color:white;
}
#entrance:hover{
	color:white;
}
</style>
<script type="text/javascript">
	function entranceStudy() {
		$.ajax({
			url: "/study/entranceStudy/"+`${study.studyNo}`,
			method : "GET" ,
			dataType : "text",
			success: function (data, status){
				if(data == "success"){
					popWin = window.open("https://ogong-cam-study.herokuapp.com/"+`${study.studyNo}`+"/"+`${user.email}`,
    						"CamStudy",
    						"height=" + screen.height + ",width=" + screen.width + "fullscreen=yes");
				}else{
					swal("이미 참여중입니다.","","warning");
				}
			}
		});		
	}
	
	$( function(){
		var password = "${study.selfStudyPassword}"
		$("#entrance").on("click", function(){
			//$('video')[0].pause();
			
			if(password != ""){
				swal("스터디가 잠겨있습니다.","비밀번호를 입력해주세요",{
					content: "input"
				})
				.then((value) => {
					if(value != password){
						swal("비밀번호가 틀렸습니다.","","error");
					}else{
						entranceStudy();
					}
				})
			}else{
				entranceStudy();
			}
			
		});
		
		
		navigator.mediaDevices.getUserMedia({
			audio: false,
			video: true
		}).then((stream) => {
			var myVideo = document.querySelector("video");
			myVideo.srcObject = stream;
			myVideo.onloadedmetadata = function(e) {
				myVideo.play();        
		    };
		});
	});
</script>
</head>
<body>
	<jsp:include page="../common/toolbar.jsp" />

	<div class="container" id="container">
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-2 "><strong>스 터 디 명</strong></div>
			<div class="col-md-2">${study.studyName}</div>
			<div class="col-md-2 "><strong>해 시 태 그</strong></div>
			<div class="col-md-2">${study.studyHashtag}</div>
			<div class="col-md-2"><strong>현재 인원</strong></div>
			<div class="col-md-2">${study.currentMember} / ${study.maxMember}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>규칙 및 공지사항</strong></div>
			<div class="col-xs-8 col-md-4">${study.selfStudyRule}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center"><h4>입장하기 전에 캠화면을 확인해보세요.</h4></div>
		</div>
		
		<div class="row">
	  		<div class="col-md-12 text-center">
					<video src=""></video>
	  		</div>
		</div>
		
		<hr/>

		<div class="row">
	  		<div class="col-md-12 text-center ">
					<button class="btn btn-lg btn-warning" id="entrance" >입장하기</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>

</body>
</html>
