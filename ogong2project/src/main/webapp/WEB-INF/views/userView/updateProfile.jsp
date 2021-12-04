<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
/////////////////////////////////////////////////////////// 관심사 
	$(function(){
		
		bsCustomFileInput.init();
		
		$ ( "#btn1").on("click", function(){
			fncupdateProfile();
		});
		$("#calcel").on("click",function(){
			history.back();
		})
			
		
	});
	
	function fncupdateProfile() {
		$("form").attr("method","POST").attr("action","/user/updateProfile").submit();
		
	}
	
	var sel_file;
	 
    $(function() {
        $("#file").on("change", handleImgFileSelect);
    }); 

    function handleImgFileSelect(e) {
    	
        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
        $("img#userImage").remove();
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
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
body, table, div, p, th, td{
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}      
.img_wrap {
	width: 300px;
	margin-top: 50px;
}

.img_wrap img {
	max-width: 100%;
}
#btn1:hover, #calcel:hover {
	color:white;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/toolbar.jsp" />
	<div class="container">
		<br>
		<br>
		<h1 class="text-left">내 프로필 수정</h1>
		<br>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">

			<input type="hidden" name="email" value="${user.email}" />
			<input type="hidden" name="userImage" value="${user.userImage}" />
			<!--  히든값 -->
		
			<div class="form-group">
				<label for="studyName"
					class="col-sm-offset-1 col-sm-3 control-label">닉 네 임</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="nickname" name="nickname" value="${user.nickname}" placeholder="닉네임">
				</div>
			</div>

			<div class="form-group">
				<label for="studyRoomGrade" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="name" name="name" value="${user.name}" placeholder="이름">
				</div>
			</div>
			
			<div class="form-group">
				<label for="studyThumbnail">썸네일</label>
				<img  id="userImage" src="/resources/upload_files/user_images/${user.userImage}">
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
			</div>
			
			<div class="form-group">
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="gender" id="gender" value="남성">
				  <label class="control-label" for="inlineRadio1">남성</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="gender" id="gender" value="여성">
				  <label class="control-label" for="inlineRadio2">여성</label>
				</div>
			</div>
			
			<div class="form-group">
				<label for="groupStudyInfo" class="col-sm-offset-1 col-sm-3 control-label">목표와 각오</label>
				<div class="col-sm-4">
					<textarea style="height: 100px; resize: none;" class="form-control"
						id="goal" name="goal" placeholder="목표와 각오">${user.goal}</textarea>
				</div>
			</div>

			<div class="form-group" style="display:flex;">
				<label for="interest" class="col-sm-offset-1 col-sm-1 control-label">관심사</label>

				<select class="form-control col-sm-2" name="studyInterest1">
						<option>${user.studyInterest1}</option>
						<option value="어학">어학</option>
						<option value="공무원">공무원</option>
						<option value="자격증">자격증</option>
						<option value="취업">취업</option>
						<option value="자기계발">자기계발</option>
						<option value="독서">독서</option>
						<option value="임용">임용</option>
						<option value="기타">기타</option>
						<option value="">없음</option>
				</select>
				<select class="form-control col-sm-2" name="studyInterest2">
						<option>${user.studyInterest2}</option>
						<option value="어학">어학</option>
						<option value="공무원">공무원</option>
						<option value="자격증">자격증</option>
						<option value="취업">취업</option>
						<option value="자기계발">자기계발</option>
						<option value="독서">독서</option>
						<option value="임용">임용</option>
						<option value="기타">기타</option>
						<option value="">없음</option>
				</select>
				<select class="form-control col-sm-2" name="studyInterest3">
						<option>${user.studyInterest3}</option>
						<option value="어학">어학</option>
						<option value="공무원">공무원</option>
						<option value="자격증">자격증</option>
						<option value="취업">취업</option>
						<option value="자기계발">자기계발</option>
						<option value="독서">독서</option>
						<option value="임용">임용</option>
						<option value="기타">기타</option>
						<option value="">없음</option>
				</select>
			</div>
			<br>
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" id="btn1" class="btn" style="background-color:#88b3fa;">프로필
						수정</button>
					<a class="btn" id="calcel" role="button" style="background-color:#88b3fa;">취&nbsp;소</a>
				</div>
			</div>
		</form>
	</div>

</body>
</html>