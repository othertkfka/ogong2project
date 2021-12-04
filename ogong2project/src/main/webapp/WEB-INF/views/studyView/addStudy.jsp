<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디 개설하기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://kit.fontawesome.com/e3409dba93.js"></script>
<!-- <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->

<script type="text/javascript">
	$(function(){
		var studyType = "${studyType}";
		var userBanana = "${user.bananaCount}";
		
		bsCustomFileInput.init();
		
		$("#create").on("click", function(){
			
			if($("#studyName").val() == ""){
				swal("스터디명을 입력해주세요.","","error");
				return;
			}
			if(($("#recruitmentStartDate").val() == "") || ($("#recruitmentEndDate").val() == "")){
				swal("스터디 모집일자를 선택해주세요.","","error");
				return;
			}
			if($("#studyStartDate").val() == ""){
				swal("스터디 시작일자를 선택해주세요.","","error");
				return;
			}
			if($("#studyEndDate").val() == ""){
				swal("스터디 종료일자를 선택해주세요.","","error");
				return;
			}
			
			if($("#maxMember").val() == 4 || $("#maxMember").val() == 5){
				if(userBanana < 20){
					swal("20바나나가 필요합니다..","","error");	
					return
				}
			}else{
				if(userBanana < 50){
					swal("50바나나가 필요합니다..","","error");	
					return
				}
			}
			
			$("form").attr("method","POST").attr("action","/study/addStudy").submit();
			
		});
		
		$("#check").on("change", function(){
			if($(this).is(":checked")){
				$("#selfStudyPassword").removeAttr("disabled");
			}else{
				$("#selfStudyPassword").attr("disabled",true);
			}
		})
		
		$("#customRadio1").on("change", function(){
			if($(this).is(":checked")){
				if(studyType == 'self'){
					$("#maxMember").val("4");
				}else{
					$("#maxMember").val("5");
				}
			}
		})
		$("#customRadio2").on("change", function(){
			if($(this).is(":checked")){
				if(studyType == 'self'){
					$("#maxMember").val("8");
				}else{
					$("#maxMember").val("10");
				}
			}
		})
		
		$("#cancel").on("click", function(){
			history.back();
		})
	});
	
	function fncAddStudy() {
		
		$("form").attr("method","POST").attr("action","/study/addStudy?studyType="+`${studyType}`).submit();
	}

	
	$( function() {
		$('#recruitmentStartDate, #studyStartDate').datepicker();
		
		$('#recruitmentStartDate').datepicker("option", "maxDate", $("#edate").val());
		
		$('#studyStartDate').datepicker("option", "maxDate", $("#edate1").val());
		
		$('#recruitmentStartDate').datepicker("option", "onClose", function ( selectedDate ) {
			$("#recruitmentEndDate").datepicker( "option", "minDate", selectedDate );
		});
		
		$('#studyStartDate').datepicker("option", "onClose", function ( selectedDate ) {
			$("#studyEndDate").datepicker( "option", "minDate", selectedDate );
		});
		$('#recruitmentEndDate, #studyEndDate').datepicker();
		
		$('#recruitmentEndDate').datepicker("option", "minDate", $("#sdate").val());
		
		$('#studyEndDate').datepicker("option", "minDate", $("#sdate1").val());
		
		$('#recruitmentEndDate').datepicker("option", "onClose", function ( selectedDate ) {
			$("#recruitmentStartDate").datepicker( "option", "maxDate", selectedDate );
		});
		
		$('#studyEndDate').datepicker("option", "onClose", function ( selectedDate ) {
			$("#studyStartDate").datepicker( "option", "maxDate", selectedDate );
		});
		
		
	
	});
	$.datepicker.regional['ko'] = {
	        closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
	        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일','월','화','수','목','금','토'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        dayNamesMin: ['일','월','화','수','목','금','토'],
	        weekHeader: 'Wk',
	        dateFormat: 'yy-mm-dd',
	        firstDay: 0,
	        isRTL: false,
	        showMonthAfterYear: true,
	        yearSuffix: '',
	        changeMonth: true,
	        changeYear: true,
	        yearRange: 'c-99:c+99',
	};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	
	
	
    $(function () {
        var tag = {};
        var counter = 0;

        // 입력한 값을 태그로 생성한다.
        function addTag (value) {
            tag[counter] = value;
            counter++; // del-btn 의 고유 id 가 된다.
        }

        // tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
        function marginTag () {
            return Object.values(tag).filter(function (word) {
                return word !== "";
            });
        }
    

        $("#tag").on("keypress", function (e) {
            var self = $(this);

            //엔터나 스페이스바 눌렀을때 실행
            if (e.key === "Enter" || e.keyCode == 32 || e.keyCode == 44) {

                var tagValue = self.val(); // 값 가져오기

                // 해시태그 값 없으면 실행X
                if (tagValue !== "") {

                    // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
                    var result = Object.values(tag).filter(function (word) {
                        return word === tagValue;
                    })
                    var size = Object.values(tag).length;
                  	
                    //3개까지만 입력
                    // 해시태그가 중복되었는지 확인
                    if(size <= 2){ 
                    	if (result.length == 0) { 
                            $("#tag-list").append("<li class='tag-item'>"+tagValue+"<span class='del-btn' idx='"+counter+"'>x</span></li>");
                            addTag(tagValue);
                            self.val("");
                        } else {
                            alert("태그값이 중복됩니다.");
                        }
                    } else {
                    	alert("태그는 3개까지만 입력 가능합니다.")
                    	self.val("");
                    }
                }
                e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
                
                var value = marginTag();
                $("#studyHashtag").val(value); 
            }
        });

        // 삭제 버튼 
        // 인덱스 검사 후 삭제
        $(document).on("click", ".del-btn", function (e) {
            var index = $(this).attr("idx");
            tag[index] = "";
            $(this).parent().remove();
        });
	})
	
	
	
	var sel_file;
 
    $(function() {
        $("#file").on("change", handleImgFileSelect);
    }); 

    function handleImgFileSelect(e) {
        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);

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
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap')
	;

body, table, div, p, th, td {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}

* {
	margin: 0;
	padding: 0;
	list-style: none;
}

body {
	padding-bottom: 50px;
}

ul {
	padding: 16px 0;
}

ul li.tag-item {
	display: inline-block;
	margin: 0 5px;
	font-size: 14px;
	letter-spacing: -.5px;
	padding: 4px 8px;
	background-color: #FFED21;
	color: #000;
}

.tag-item:hover {
	background-color: #262626;
	color: #fff;
}

.del-btn {
	font-size: 15px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 8px;
}

div#container {
	margin-top: 50px;
}

div.col-12 {
	display: flex;
	justify-content: center;
}

div.card-header{
	background-color: #7dbcff;
}

.img_wrap {
	width: 300px;
	margin-top: 50px;
}

.img_wrap img {
	max-width: 100%;
}

#create{
	background-color: #88b3fa;
	border: none;
}
#create:hover{
	color:white;
}
</style>
</head>
<body>
	<jsp:include page="../common/toolbar.jsp" />

	<div class="container" id="container">

		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
						<c:if test="${studyType == 'self'}">
							<h3 class="card-title">자율스터디</h3>
						</c:if>	
						<c:if test="${studyType == 'group'}">
							<h3 class="card-title">그룹스터디</h3>
						</c:if>	
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" title="Collapse">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body container">
							<form class="form-horizontal" enctype="multipart/form-data">
								<div class="form-group">
									<label for="studyName">스터디명</label> 
									<input type="text" id="studyName" name="studyName" class="form-control col-sm-4" placeholder="스터디명을 적어주세요." maxlength="15">
								</div><hr/>
								<div class="form-group">
									<label for="studyInterest">관심주제</label> 
									<div>
										<select id="studyInterest" name="studyInterest" class="form-control col-sm-2 custom-select">
											<option>기타공부</option>
											<option>독서</option>
											<option>어학</option>
											<option>임용</option>
											<option>취업</option>
											<option>공무원</option>
											<option>자격증</option>
											<option>자기계발</option>
										</select>
									</div>
								</div><hr/>
								<c:if test="${studyType == 'group'}">
									<div class="form-group">
										<label for="groupStudyInfo">스터디 소개</label>
										<textarea id="groupStudyInfo" name="groupStudyInfo" class="form-control col-sm-6" rows="4"
										placeholder="스터디에 대한 소개를 자유롭게 적어주세요." maxlength="200"></textarea>
									</div><hr/>
									<div class="form-group">
										<label for="groupStudyPlan">스터디 계획</label>
										<textarea id="groupStudyPlan" name="groupStudyPlan" class="form-control col-sm-6" rows="4"
										placeholder="스터디 계획이 있다면 자유롭게 적어주세요." maxlength="200"></textarea>
									</div><hr/>
									<div class="form-group">
										<label for="groupStudyCondition">스터디 참가조건</label>
										<textarea id="groupStudyCondition" name="groupStudyCondition" class="form-control col-sm-6" rows="4"
										placeholder="스터디 참가조건이 있다면 자유롭게 적어주세요." maxlength="50"></textarea>
									</div><hr/>
								</c:if>
								<div class="hashTag_area">
									<div class="form-group">
										<input type="hidden" value="" name="studyHashtag" id="studyHashtag" />
									</div>
									<div class="form-group">
										<label for="studyHashtag">해시태그</label>
										<input type="text" class="form-control col-sm-4" id="tag" size="7" placeholder="엔터로 해시태그를 등록해주세요." />
										<ul class="col-sm-offset-4 col-sm-4" id="tag-list"></ul>
									</div>
								</div><hr/>

								<div class="form-group">
									<label for="studyThumbnail">스터디 썸네일</label>
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
								<c:if test="${studyType == 'group'}">
									<div class="form-group">
										<div class="form-group">
											<label>모집시작일자 :</label>
											<input type="text" class="form-control col-sm-4" id="recruitmentStartDate" name="recruitmentStartDate" placeholder="스터디 모집시작일자">
										</div>
										<div class="form-group">
											<label>모집종료일자 :</label>
											<input type="text" class="form-control col-sm-4" id="recruitmentEndDate" name="recruitmentEndDate" placeholder="스터디 모집종료일자">
										</div>
									</div><hr/>
								</c:if>
								<div class="form-group">
									<c:if test="${studyType == 'group'}">
										<div class="form-group">
											<label>시작일자 :</label>
											<input type="text" class="form-control col-sm-4" id="studyStartDate" name="studyStartDate" placeholder="스터디 시작일자">
										</div>
									</c:if>
									<div class="form-group">
										<label>종료일자 :</label>
										<input type="text" class="form-control col-sm-4" id="studyEndDate" name="studyEndDate" placeholder="스터디 종료일자">
									</div>
								</div><hr/>
								<c:if test="${studyType == 'self'}">
									<div class="form-group">
										<label for="selfStudyRule">규칙 및 공지사항</label>
										<textarea id="selfStudyRule" name="selfStudyRule" class="form-control col-sm-6" rows="4" placeholder="지켜야할 규칙 및 공지사항을 자유롭게 적어주세요." maxlength="200"></textarea>
									</div><hr/>
								</c:if>
								<div class="form-group">
									<label for="inputRadio">인원</label>
									<c:if test="${studyType == 'self'}">
										<div class="custom-control custom-radio">
				                          <input class="custom-control-input custom-control-input-warning" type="radio" id="customRadio1" name="studyRoomGrade" value="basic" checked>
				                          <label for="customRadio1" class="custom-control-label">Basic (최대인원 : 4명)</label>
				                        </div>
				                        <div class="custom-control custom-radio">
				                          <input class="custom-control-input custom-control-input-warning" type="radio" id="customRadio2" name="studyRoomGrade" value="premium">
				                          <label for="customRadio2" class="custom-control-label">Premium (최대인원 : 8명)</label>
				                        </div>
				                        <input type="hidden" id="maxMember" name="maxMember" value="4"/>
									</c:if>
			                        <c:if test="${studyType == 'group'}">
										<div class="custom-control custom-radio">
				                          <input class="custom-control-input custom-control-input-warning" type="radio" id="customRadio1" name="studyRoomGrade" value="basic" checked>
				                          <label for="customRadio1" class="custom-control-label">Basic (최대인원 : 5명)</label>
				                        </div>
				                        <div class="custom-control custom-radio">
				                          <input class="custom-control-input custom-control-input-warning" type="radio" id="customRadio2" name="studyRoomGrade" value="premium">
				                          <label for="customRadio2" class="custom-control-label">Premium (최대인원 : 10명)</label>
				                        </div>
				                        <input type="hidden" id="maxMember" name="maxMember" value="5"/>
									</c:if>
			                    </div><hr/>
			                    <c:if test="${studyType == 'self'}">
			                    	<div class="form-group">
										<label for="selfStudyPassword">비밀번호</label>
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> 
													<input type="checkbox" id="check">
												</span>
											</div>
											<input type="text" id="selfStudyPassword" name="selfStudyPassword" 
											maxlength="4" class="form-control col-sm-1" disabled>
										</div>
									</div>
			                    </c:if>
			                    <input type="hidden" id="studyType" name="studyType" value="${studyType}"/>
							</form>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<button id="create" class="btn-lg vertical-center">개설하기</button>&nbsp;&nbsp; 
					<button id="cancel" class="btn-lg btn-default float-center">취소</button>
				</div>
			</div>
		</section>

	</div>

</body>

</html>