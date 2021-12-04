<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>스터디 목록</title>
<!-- <link rel="stylesheet" href="/resources/css/adminlte.min.css"> -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css"> -->
<script src="https://kit.fontawesome.com/e3409dba93.js"></script>

<script type="text/javascript">

	function entranceStudy(studyNo) {
		location.href = "/study/getStudy?studyNo=" + studyNo;
	}
	
	function entranceStudyRoom(studyNo) {
		location.href = "/studyroom/getStudyRoom?studyNo=" + studyNo;
	}
	
	function getStudy(studyNo) {
		location.href = "/study/getStudy?studyNo=" + studyNo;
	}

</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap')
	;
body, table, div, p, th, td {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}

.row {
	margin: 30px 0px 30px 0px;
}

img.img-thumbnail {
	-webkit-transform: scale(1, 1);
	-ms-transform: scale(1, 1);
	transform: scale(1, 1);
	transition-duration: 0.3s;
	width: 300px;
	height: 220px;
}

img.img-thumbnail:hover {
	cursor: pointer;
	-webkit-transform: scale(1.1, 1.1);
	-ms-transform: scale(1.1, 1.1);
	transform: scale(1.1, 1.1);
	transition-duration: 0.3s;
	box-shadow: 10px 10px 5px #888888;
	z-index: 1;
}
</style>
</head>

<body>

	<jsp:include page="../common/toolbar.jsp" />

	<div class="container">
		<br/><br/>
		<h2>나의 스터디</h2>

		<hr/>
		<h4>진행중인 자율스터디</h4>
		<div class="row" id="mySelfStudyList">
			<c:forEach var="study" items="${mySelfStudyList}">
				<div class="col-xs-12 col-md-3">
					<img class="img-fluid img-thumbnail rounded" src="/resources/upload_files/study/${study.studyThumbnail}" alt="None"
					onclick="entranceStudy(${study.studyNo})">
					<p class="text-center">진행기간:${study.studyStartDate}~${study.studyEndDate}</p>
					<p class="text-center">
					<c:if test="${study.studyRoomGrade == 'premium'}">
						<i class="fa fa-product-hunt"></i>&nbsp;
					</c:if>
					${study.studyName}&nbsp;&nbsp;&nbsp;${study.currentMember}/${study.maxMember}
					<c:if test="${study.selfStudyPassword != null}">
						&nbsp;<i class="fas fa-lock"></i>
					</c:if>
					</p>
					
				</div>
			</c:forEach>
			<c:if test="${mySelfStudyList.size() == 0}">
				<div class="col-md-12 text-center" id="notfound">
					<i class="fas fa-exclamation-triangle"></i>
					스터디가 없습니다
				</div>
			</c:if>
		</div>

		<hr/>
		<h4>진행중인 그룹스터디</h4>
		<div class="row" id="myGroupStudyList">
			<c:forEach var="study" items="${myGroupStudyList}">
				<div class="col-xs-12 col-md-3">
					<img class="img-fluid img-thumbnail rounded" src="/resources/upload_files/study/${study.studyThumbnail}" alt="None"
					onclick="entranceStudyRoom(${study.studyNo})">
					<p class="text-center">진행기간:${study.studyStartDate}~${study.studyEndDate}</p>
					<p class="text-center">
					<c:if test="${study.studyRoomGrade == 'premium'}">
						<i class="fa fa-product-hunt"></i>&nbsp;
					</c:if>
					${study.studyName}&nbsp;&nbsp;&nbsp;${study.currentMember}/${study.maxMember}
					<c:if test="${study.selfStudyPassword != null}">
						&nbsp;<i class="fas fa-lock"></i>
					</c:if>
					</p>
					<p class="text-center">${study.studyHashtag}</p>
					
				</div>
			</c:forEach>
			<c:if test="${myGroupStudyList.size() == 0}">
				<div class="col-md-12 text-center" id="notfound">
					<i class="fas fa-exclamation-triangle"></i>
					스터디가 없습니다
				</div>
			</c:if>
		</div>
		
		<hr/>
		<h4>참가 신청한 그룹스터디</h4>
		<div class="row" id="myApprovalGroupStudyList">
			<c:forEach var="study" items="${myApprovalGroupStudyList}">
				<div class="col-xs-12 col-md-3">
					<img class="img-fluid img-thumbnail rounded" src="/resources/upload_files/study/${study.studyThumbnail}" alt="None"
					onclick="getStudy(${study.studyNo})">
					<p class="text-center">모집기간:${study.recruitmentStartDate}~${study.recruitmentEndDate}</p>
					<p class="text-center">
					<c:if test="${study.studyRoomGrade == 'premium'}">
						<i class="fa fa-product-hunt"></i>&nbsp;
					</c:if>
					${study.studyName}&nbsp;&nbsp;&nbsp;${study.currentMember}/${study.maxMember}
					<c:if test="${study.selfStudyPassword != null}">
						&nbsp;<i class="fas fa-lock"></i>
					</c:if>
					</p>
					<p class="text-center">${study.studyHashtag}</p>
					
				</div>
			</c:forEach>
			<c:if test="${myApprovalGroupStudyList.size() == 0}">
				<div class="col-md-12 text-center" id="notfound">
					<i class="fas fa-exclamation-triangle"></i>
					스터디가 없습니다
				</div>
			</c:if>
		</div>
		
		<hr/>
		<h4>종료된 그룹스터디</h4>
		<div class="row" id="myEndGroupStudyList">
			<c:forEach var="study" items="${myEndGroupStudyList}">
				<div class="col-xs-12 col-md-3">
					<img class="img-fluid img-thumbnail rounded" src="/resources/upload_files/study/${study.studyThumbnail}" alt="None"
					onclick="entranceStudyRoom(${study.studyNo})">
					<p class="text-center">진행기간:${study.studyStartDate}~${study.studyEndDate}</p>
					<p class="text-center">
					<c:if test="${study.studyRoomGrade == 'premium'}">
						<i class="fa fa-product-hunt"></i>&nbsp;
					</c:if>
					${study.studyName}&nbsp;&nbsp;&nbsp;${study.currentMember}/${study.maxMember}
					<c:if test="${study.selfStudyPassword != null}">
						&nbsp;<i class="fas fa-lock"></i>
					</c:if>
					</p>
					<p class="text-center">${study.studyHashtag}</p>
					
				</div>
			</c:forEach>
			<c:if test="${myEndGroupStudyList.size() == 0}">
				<div class="col-md-12 text-center" id="notfound">
					<i class="fas fa-exclamation-triangle"></i>
					스터디가 없습니다
				</div>
			</c:if>
		</div>

	</div>
	<!--  table End /////////////////////////////////////-->
</body>
</html>