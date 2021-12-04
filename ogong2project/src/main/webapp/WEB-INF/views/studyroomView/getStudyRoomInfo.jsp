<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.2.1.js"></script> 


<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;

}
/* .container {
  background-color: orange;
  width: 400px;
  border: 1px solid red;
} */
</style>

<script type="text/javascript">
	$( function(){
		
		$("#btn").on("click", function(){
			self.location = "/studyroom/updateStudy?studyNo="+${study.studyNo}
		});
		
		$("#btn1").on("click", function(){
			history.go(-1)
		});
	});
</script>
</head>
<body>

	<jsp:include page="../layout/sidebar.jsp" />
	
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">스터디룸 상세조회</h3>
	    </div>
		
		<hr/>
		
		<div class="row">
			<input type="hidden" name="studyNo" value="${study.studyNo}"/>
	  		<div class="col-xs-4 col-md-2 "><strong>스 터 디 명</strong></div>
			<div class="col-xs-8 col-md-4">${study.studyName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>스터디 소개</strong></div>
			<div class="col-xs-8 col-md-4">${study.groupStudyInfo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>해 시 태 그</strong></div>
			<div class="col-xs-8 col-md-4">${study.studyHashtag}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>인원</strong></div>
			<div class="col-xs-8 col-md-4">${study.currentMember} / ${study.maxMember}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>모집 기간</strong></div>
			<div class="col-xs-8 col-md-4">${study.recruitmentStartDate} ~ ${study.recruitmentEndDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>진행 기간</strong></div>
			<div class="col-xs-8 col-md-4">${study.studyStartDate} ~ ${study.studyEndDate}</div>
		</div>
		
		<hr/>
		
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>썸 네 일</strong></div>
			<div class="col-xs-8 col-md-4">${study.studyThumbnail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  				<button id="btn" >수 정</button>
					<button id="btn1" >확 인</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>

</body>
</html>