<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>스터디 목록</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/e3409dba93.js"></script>

<script type="text/javascript">
	

	function fncGetList() {
		$('form').attr('action', '/study/listStudy?studyType=${studyType}')
				.attr('method', 'POST').submit();
	}
	
	function getInterestList(num) {
		$('#studyInterest').val(num);
		
		fncGetList();
	}
	
	function getStudyList(page) {
		$.ajax({
			type : 'post',
			url : "/study/listStudy",
			data : JSON.stringify({currentPage: page,
									searchKeyword: $("#searchKeyword").val(),
									studyType: "${studyType}",
									studyInterest: $("#studyInterest").val(),
									searchSort: $('#searchSort').val() }),
			dataType: "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(result) {			
				var list = result.list;
				$("#totalCount").html("총 "+result.totalCount+"개의 스터디");
				var addListHtml ="";
				if(list.length > 0) {
					$.each(list, function(index, study){
						addListHtml += '<div class="col-xs-12 col-md-3">';
						addListHtml += '<img class="img-fluid img-thumbnail rounded" src="/resources/upload_files/study/'+study.studyThumbnail+'" alt="None" onclick="entranceStudy('+study.studyNo+')">';
						addListHtml += '<p class="text-center">';
						if(study.studyRoomGrade == "premium"){
							addListHtml += '<i class="fa fa-product-hunt"></i>&nbsp;';
						}
						addListHtml += study.studyName+' &nbsp;&nbsp;&nbsp;';
						addListHtml += study.currentMember+'/'+study.maxMember;
						if(study.selfStudyPassword != null){
							addListHtml += '&nbsp;<i class="fas fa-lock"></i>';
						}
						addListHtml += '</p>';
						addListHtml += '<p class="text-center">'+study.studyHashtag+'</p>';
						if(study.studyType == "group"){
							addListHtml += '<p class="text-center">모집기간:'+study.recruitmentStartDate+'~'+study.recruitmentEndDate+'</p>';
						}
						addListHtml += '</div>';
					});
				}else {
					if(page == 1){
						addListHtml += '<div class="col-md-12 text-center" id="notfound">'
						addListHtml += '<i class="fas fa-exclamation-triangle"></i>';
						addListHtml += ' 스터디가 없습니다';
						addListHtml += '</div>'
					}
				}
				$("#list").append(addListHtml);
			},
			error:function(request, status, error){
				
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	function entranceStudy(studyNo) {
		location.href = "/study/getStudy?studyNo=" + studyNo;
	}
	
	$(function() {

		$('#addBtn').on('click', function(){
			location.href = "/study/addStudy?studyType=${studyType}";
		});

		$('button:contains("검색")').on('click', function() {

			fncGetList();
		});
		
		$("#searchKeyword").keydown(function(key) {

			if (key.keyCode == 13) {//키가 13이면 실행 (엔터는 13)
				fncGetList();
			}
		});
		
		$('#searchSort').on('change', function(){
			$('#list').empty();
			page = 1;
			getStudyList(page);
		})
		
		$('#studyInterest').on('change', function(){
			$('#list').empty();
			page = 1;
			getStudyList(page);
		})
		
		$('#popover').popover({
			container : 'body'
		})
		

	});

	var page = 1;
	$(window).scroll(function() {
		if (((window.innerHeight + window.scrollY) >= document.body.offsetHeight)) {
			++page;
			getStudyList(page);
		}
	});
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

#detailForm {
	display: flex;
    justify-content: flex-end;
}

#notfound {
	margin: 80px 0px 80px 0px;
}

#list {
	margin-bottom: 200px;
}

#addBtn {
	background-color: #88b3fa;
}
#addBtn:hover {
	color: #fff;
}

#interest {
	color: #007bff;
}

div.callout {
	margin : 50px 0px 0px 0px;
}
div.jumbotron {
	background-color: #fff;
	margin-top: 30px;
}
li.breadcrumb-item {
	
}
.breadcrumb-item+.breadcrumb-item::before { content: "ㅣ"; }
</style>
</head>

<body>

	<jsp:include page="../common/toolbar.jsp" />

	<div class="container">
		<div class="jumbotron">
			<c:if test="${studyType == 'self'}">
				<h1 class="display-4">자율스터디</h1>
				<p class="lead">누구나 자유롭게 참여할 수 있는 자율스터디입니다.</p>
				<p class="lead">원하는 스터디를 찾아보고 참가해보세요.</p>
				<hr class="my-4">
				<p>스터디를 직접 개설해보세요.
					<a type="button" id="popover"  data-container="body" 
					data-toggle="popover" data-placement="right" data-content="개설 시에는 바나나가 사용됩니다.(일반:20 , 프리미엄:50)">
					<i class="fas fa-info-circle"></i></a>
				</p>
				<div id="addBtn" class="btn btn-lg btn-flat">
                  <i class="far fas fa-plus-square fa-lg mr-2"></i>
                  개설하기
                </div>
			</c:if>
			<c:if test="${studyType == 'group'}">
				<h1 class="display-4">그룹스터디</h1>
				<p class="lead">멤버를 모집하여 정해진 기간 동안 스터디를 진행하는 그룹스터디 입니다.</p>
				<p class="lead">원하는 주제의 그룹스터디를 찾아보고 참가해보세요.</p>
				<hr class="my-4">
				<p>스터디를 직접 개설해보세요.
					<a type="button" id="popover" data-container="body" 
					data-toggle="popover" data-placement="right" data-content="개설 시에는 바나나가 사용됩니다.(일반:20 , 프리미엄:50)">
					<i class="fas fa-info-circle"></i></a>
				</p>
				<div id="addBtn" class="btn btn-lg btn-flat">
                  <i class="far fas fa-plus-square fa-lg mr-2"></i>
                  개설하기
                </div>
			</c:if>
		</div>
		<hr/>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<div class="row">

			

			<div class="col-md-12">
				<form class="form-inline">
					<c:if test="${studyType == 'group'}">
						<div class="col-sm-12" id="groupInterest">
							<input type="hidden" id="studyInterest" name="studyInterest" value="${search.studyInterest}" />
				            <ol class="breadcrumb float-sm-center" >
				              <li class='breadcrumb-item' value="0">
				              	${! empty search.studyInterest && search.studyInterest== 0 ? "전체" : '<a id="interest" href="javascript:void(0)" 
				              		onclick="getInterestList(0)">전체</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="1">
				              	${! empty search.studyInterest && search.studyInterest== 1 ? "독서" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(1)">독서</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="2">
				              	${! empty search.studyInterest && search.studyInterest== 2 ? "어학" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(2)">어학</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="3">
				              	${! empty search.studyInterest && search.studyInterest== 3 ? "임용" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(3)">임용</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="4">
				              	${! empty search.studyInterest && search.studyInterest== 4 ? "취업" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(4)">취업</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="5">
				              	${! empty search.studyInterest && search.studyInterest== 5 ? "공무원" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(5)">공무원</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="6">
				              	${! empty search.studyInterest && search.studyInterest== 6 ? "자격증" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(6)">자격증</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="7">
				              	${! empty search.studyInterest && search.studyInterest== 7 ? "자기계발" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(7)">자기계발</a>'  }
				              </li>
				              <li class='breadcrumb-item' value="8">
				              	${! empty search.studyInterest && search.studyInterest== 8 ? "기타공부" : '<a id="interest" href="javascript:void(0)"
				              		onclick="getInterestList(8)">기타공부</a>'  }
				              </li>
				            </ol>
				        </div>
			        </c:if>
					
					<div class="col-md-6 text-left">
						<p class="text-default" id="totalCount">총 ${totalCount} 개의 스터디</p>
					</div>
					
					<div class="col-md-6" id="detailForm">
						<c:if test="${studyType == 'self'}">
								<select class="form-control" id="studyInterest" name="studyInterest" data-width="120px">
									<option value="0">전체</option>
									<option value="1"
										${! empty search.studyInterest && search.studyInterest== 1 ? "selected" : ""  }>독서</option>
									<option value="2"
										${! empty search.studyInterest && search.studyInterest== 2 ? "selected" : ""  }>어학</option>
									<option value="3"
										${! empty search.studyInterest && search.studyInterest== 3 ? "selected" : ""  }>임용</option>
									<option value="4"
										${! empty search.studyInterest && search.studyInterest== 4 ? "selected" : ""  }>취업</option>
									<option value="5"
										${! empty search.studyInterest && search.studyInterest== 5 ? "selected" : ""  }>공무원</option>
									<option value="6"
										${! empty search.studyInterest && search.studyInterest== 6 ? "selected" : ""  }>자격증</option>
									<option value="7"
										${! empty search.studyInterest && search.studyInterest== 7 ? "selected" : ""  }>자기계발</option>
									<option value="8"
										${! empty search.studyInterest && search.studyInterest== 8 ? "selected" : ""  }>기타공부</option>
								</select>
								&nbsp;
						</c:if>
						
						<select class="form-control" id="searchSort" name="searchSort" data-width="120px">
							<option value="0"
								${! empty search.searchSort && search.searchSort== 0 ? "selected" : ""  }>최신순</option>
							<option value="1"
								${! empty search.searchSort && search.searchSort== 1 ? "selected" : ""  }>오래된순</option>
							<option value="2"
								${! empty search.searchSort && search.searchSort== 2 ? "selected" : ""  }>인원많은순</option>
							<option value="3"
								${! empty search.searchSort && search.searchSort== 3 ? "selected" : ""  }>인원적은순</option>
						</select>
						&nbsp;
	
						<div class="form-group">
							<label class="sr-only" for="searchKeyword">검색어</label> <input
								type="text" class="form-control" id="searchKeyword"
								name="searchKeyword" placeholder="검색어"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
						</div>&nbsp;
						<button type="button" class="btn btn-default">검색</button>
						<input type="hidden" id="currentPage" name="currentPage" value="1" />
					</div>
					
				</form>
			</div>
			
			<br/>
		</div>
		<div class="row" id="list">
			<c:forEach var="study" items="${list}">
				<div class="col-xs-12 col-md-3">
					<img class="img-fluid img-thumbnail rounded" src="/resources/upload_files/study/${study.studyThumbnail}" alt="None"
					onclick="entranceStudy(${study.studyNo})">
					<c:if test="${studyType == 'group'}">
						<p class="text-center text-md">모집기간 : ${study.recruitmentStartDate}~${study.recruitmentEndDate}</p>
					</c:if>
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
			<c:if test="${totalCount == 0}">
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