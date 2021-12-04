<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://kit.fontawesome.com/e3409dba93.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
font-size: 15px;
}
#studyThumbnail {
	width: 300px;
	height: 300px;
}
.img_wrap {
	width: 300px;
	margin-top: 50px;
}

.img_wrap img {
	max-width: 100%;
}
</style>
    

<script type="text/javascript">

$(function() {
	$( "button.btn.btn-info" ).on("click" , function() {
		fncUpdateStudy();
	});
	
	$("a[href='#' ]").on("click" , function() {
		history.go(-1);
	});
});		

function fncUpdateStudy() {
	$("form").attr("method","POST").attr("action","/studyroom/updateStudy").submit();
}

$(function() {
    $("#file").on("change", handleImgFileSelect);
}); 

function handleImgFileSelect(e) {
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);
	$("#studyThumbnail").remove();
    filesArr.forEach(function(f) {
        if(!f.type.match("image.*")) {
            alert("확장자는 이미지 확장자만 가능합니다.");
            return;
        }

        sel_file = f;

        var reader = new FileReader();
        reader.onload = function(e) {
            $("#img").attr("src", e.target.result);
        }
        reader.readAsDataURL(f);
    });
}
	</script>
	
</head>

<body>

	<jsp:include page="../layout/sidebar.jsp" />
	 <section id="main-content">
       <section class="wrapper">

		<div class="container">
			<div class="page-header text-center">
		       <h3 class=" text" align="left" style="margin-left:200px;">스터디룸 정보 수정</h3>
		    </div>

			<form class="form-horizontal" enctype="multipart/form-data">
				<div class="form-group">
					<label for="studyName">스터디명</label> 
					<input type="hidden" name="studyNo" value="${study.studyNo}">
					<input type="text" id="studyName" name="studyName" value="${study.studyName}" class="form-control col-sm-4" maxlength="15">
					
				</div><hr/>
				<div class="form-group">
					<label for="studyInterest">관심주제</label> 
					<input type="text" id="studyInterest" name="studyInterest" value="${study.studyInterest}" class="form-control col-sm-4" maxlength="15" readonly>
				</div><hr/>
				
				<div class="form-group">
					<label for="groupStudyInfo">스터디 소개</label>
					<textarea id="groupStudyInfo" name="groupStudyInfo"class="form-control col-sm-6" rows="4"
					 maxlength="200">${study.groupStudyInfo}</textarea>
				
				</div><hr/>
				<div class="form-group">
					<label for="groupStudyPlan">스터디 계획</label>
					<textarea id="groupStudyPlan" name="groupStudyPlan" class="form-control col-sm-6" rows="4"
					 maxlength="200">${study.groupStudyPlan}</textarea>
				</div><hr/>
				
				<div class="form-group">
					<label for="groupStudyCondition">스터디 참가조건</label>
					<textarea id="groupStudyCondition" name="groupStudyCondition" class="form-control col-sm-6" rows="4"
					maxlength="50">${study.groupStudyCondition}</textarea>
				</div><hr/>
				
				<div class="hashTag_area">
					<div class="form-group">
						<input type="hidden" value="" name="studyHashtag" id="studyHashtag" />
					</div>
					<div class="form-group">
						<label for="studyHashtag">해시태그</label>
						<input type="text" value="${study.studyHashtag}" class="form-control col-sm-4" id="tag" size="7" readonly />
					</div>
				</div><hr/>

				<div class="form-group">
					<label for="studyThumbnail">스터디 썸네일</label>
					<input type="hidden" name="studyThumbnail" value="${study.studyThumbnail}">
					<img  id="studyThumbnail" src="/resources/upload_files/study/${study.studyThumbnail}">
					<div class="input-group mb-3">
						<div class="custom-file col-sm-4">
							<input type="file" class="custom-file-input" id="file" name="file"> 
							<label class="custom-file-label" for="file">썸네일 이미지를 선택해주세요.</label>
						</div>
					</div>
					<div>
						<div class="img_wrap">
							<img id="img"/>
						</div>
					</div>
				</div><hr/>
				<div class="form-group">
					<div class="form-group">
						<label> 모집 기간 </label>
							<input type="text" class="form-control col-sm-4" id="recruitment" value="${study.recruitmentStartDate} ~ ${study.recruitmentEndDate}"  readonly>
					</div>
					<div class="form-group">
						<label> 진행 기간 </label>
						<input type="text" class="form-control col-sm-4" id="studyStartEnd" value="${study.studyStartDate} ~ ${study.studyEndDate}" readonly>
					</div>
				</div><hr/>
			
				<div class="form-group">
					<label for="inputRadio">인원</label>
						<input type="text" class="form-control col-sm-4" id="studymember" value="${study.currentMember}명 / ${study.maxMember}명" readonly>
                   </div><hr/>
                   
                <div class="form-group">
				    <div class="col-sm-offset-4  col-sm-2 text-center">
				      <button type="button" class="btn btn-info"  >수 &nbsp;정</button>
					  <a class="btn btn-default btn" href="#" role="button">취 &nbsp;소</a>
				    </div>
			    </div>
			</form>
						
		    
	    
		   
			<!-- form Start /////////////////////////////////////-->

	    
 	</div>

	<!--  화면구성 div Start /////////////////////////////////////-->
 		</section>
	</section>
</body>

</html>