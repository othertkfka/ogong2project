<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>그룹스터디 정보</title>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
font-size: 20px;
}
img {
	width: 500px;
	height: 500px;
}
#studyThumbnail {
	float:center;
}
div#container {
	margin-top: 50px;
}
</style>

<script type="text/javascript">
	$( function(){
		
		$("#cancel").on("click", function(){
			history.back();
		});
		
		$("#apply").on("click", function(){
			
			var studyNo =${study.studyNo};	
			
			$.ajax({
				
				url: "/studyroom/json/checkDuplication",
				method: "POST",
				data: JSON.stringify({studyNo: studyNo}),
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success: function(data, status){
					
					if(data == false){
						
						$('#myModal').modal("show"); //열기
						
					
					}else if(data == true){
						swal("이미 참가신청 하셨습니다.","","warning");
					}
				},
				error:function(request, status, error){
					
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});
			
			
			
		});
		
		$("#submit").on("click", function(){
			
			alert("참가 신청 되었습니다.");
			fncAddParticipation();
			
		});
		
		
		function fncAddParticipation() {
			$("form").attr("method","POST").attr("action","/study/addParticipation").submit();
		}
	});
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/toolbar.jsp" />

	<div class="container" id="container">
	
	
		<div class="card card-solid">
	        <div class="card-body">
	          <div class="row">
	            <div class="col-12 col-sm-6">
	              <div class="col-12">
	                <img src="/resources/upload_files/study/${study.studyThumbnail}" class="product-image" alt="Study Image">

					<div class="row mt-4">
						<nav class="w-100">
							<div class="nav nav-tabs" id="product-tab" role="tablist">
								<a class="nav-item nav-link active" id="product-desc-tab"
									data-toggle="tab" href="#product-desc" role="tab"
									aria-controls="product-desc" aria-selected="true">소개</a>
								<a class="nav-item nav-link" id="product-comments-tab"
									data-toggle="tab" href="#product-comments" role="tab"
									aria-controls="product-comments" aria-selected="false">계획</a>
								<a class="nav-item nav-link" id="product-rating-tab"
									data-toggle="tab" href="#product-rating" role="tab"
									aria-controls="product-rating" aria-selected="false">참가조건</a>
							</div>
						</nav>
						<div class="tab-content p-3" id="nav-tabContent">
							<div class="tab-pane fade show active" id="product-desc"
								role="tabpanel" aria-labelledby="product-desc-tab">
								${study.groupStudyInfo}
							</div>
							<div class="tab-pane fade" id="product-comments"
								role="tabpanel" aria-labelledby="product-comments-tab">
								${study.groupStudyPlan}
							</div>
							<div class="tab-pane fade" id="product-rating" role="tabpanel"
								aria-labelledby="product-rating-tab">
								${study.groupStudyCondition}
							</div>
						</div>
					</div>
				</div>
	            </div>
	            <div class="col-12 col-sm-6">
	              <h3 class="my-3">${study.studyName}</h3>
	              <hr/>
	              <h4 class="my-3">스터디리더</h4>
	              <p>${study.studyMaker.email}</p>
	              <hr/>
	              <h4 class="my-3">관심주제</h4>
	              <p>${study.studyInterest}</p>
	              <hr/>
	              <h4 class="my-3">해시태그</h4>
	              <p>${study.studyHashtag}</p>
	              <hr/>
	              <h4 class="my-3">최대인원</h4>
	              <p>${study.maxMember}명</p>
	              <hr/>
	              <h4 class="my-3">모집기간</h4>
	              <p>${study.recruitmentStartDate} ~ ${study.recruitmentEndDate}</p>
	              <hr/>
	              <h4 class="my-3">진행기간</h4>
	              <p>${study.studyStartDate} ~ ${study.studyEndDate}</p>
	              <hr/>
	              <div class="mt-4">
	                <div id="apply" class="btn btn-primary btn-lg btn-flat">
	                  <i class="fas fa-cart-plus fa-lg mr-2"></i>
	                  참가신청
	                </div>
	
	                <div id="cancel" class="btn btn-default btn-lg btn-flat">
	                  취소
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	        <!-- /.card-body -->
	     </div>
		
		<br/>
				
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<h4 class="modal-title" id="myModalLabel">그룹스터디 참가신청</h4>
		      	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		      </div>
		      <div class="modal-body">
		        <form>
		        	<input type="hidden" name="studyNo" value="${study.studyNo}">     
		        	<div class = "form-group">
		        		<label>참가신청 동기</label>
		        		<textarea name = "participationReason" class="form-control" maxLength="2048" style="height:180px"></textarea>
		        	</div>
		        	
		        	<div class = "form-group">
		        		<label>각 오</label>
		        		<textarea name = "determination" class="form-control" maxLength="2048" style="height:180px"></textarea>
		        	</div>
		        </form>
		      </div>
		      <div class="modal-footer">
		      	<button id="submit" class="btn btn-default" >신 청</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫 기</button>
		      </div>
		    </div>
		  </div>
		 </div>
		
 	</div>

</body>
</html>