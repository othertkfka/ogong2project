<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디룸 메인</title>

<!-- dd -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.css"  />


<!-- css cdn -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.js"></script>


<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
font-size: 15px;
}
hr {
    margin-top: 1rem;
    margin-bottom: 1rem;
    border: 0;
    border-top: 1px solid rgba(0,0,0,.1);
}
hr {
    box-sizing: content-box;
    height: 0;
    overflow: visible;
}
#calendar{
	float:center;
	width: 900px;
	margin: auto;
}
.fc-toolbar-chunk {
  display: flex; /* 일렬로 나란히 */
  align-items: center;/*  수직 가운데 정렬 */
}
#edit-desc{
	margin: 0px;
	width: 570px;
	height: 160px;
}

.fc .fc-button-primary:disabled {
    color: black;
    background-color: #eee;
    background-color: var(--fc-button-bg-color, #eee;);
    border-color: #333;
    border-color: var(--fc-button-border-color, #eee;);
}
.fc .fc-button:disabled {
    opacity: 0.65;
}
.fc .fc-button-primary {
	background-color: #eee;
	color: black;
	/* border: 1px solid #fff; */
} 
.fc .fc-button-primary:not(:disabled):active, .fc .fc-button-primary:not(:disabled).fc-button-active{
	background-color: #eee;
	/* border: 1px solid #fff; */
	color: black;
}
.swal-button {
  padding: 7px 19px;
  border-radius: 2px;
  background-color: #7cd1f9;
  font-size: 12px;
  text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.3);
}
.fc .fc-col-header-cell-cushion {
    color: black;
    display: inline-block;
    padding: 2px 4px;
    font-size: large;
}
.border-head {
	text-align:right;
}
element.style {
    position: relative;
    top: 17px;
    float: right;
    width: 6px;
    height: 415px;
    background-color: black;
    background-clip: padding-box;
    border-radius: 10px;
}
.fc .fc-daygrid-day-number {
    position: relative;
    z-index: 4;
    padding: 4px;
    color: black;
}
.panel-heading1 {
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading span {
	margin-top: -20px;
	font-size: 15px;
}
.glyphicon-chevron-up:before {
    content: "\e113";
    color: antiquewhite;
}
</style>
</head>

<script type="text/javascript">
$(function () {
	
	$('#start').datetimepicker({
	    format: 'YYYY-MM-DD HH:mm',
	    minDate: moment()
	});
	
	$('#end').datetimepicker({
		format: 'YYYY-MM-DD HH:mm',
		minDate: moment()
	});

});
$(function () {
	$('#sroomInfo').on('click', function(){
		$("#roomModal").modal("show");
	});
	
	$('#camstudy').on("click", function (){
		popWin = window.open("https://ogong-cam-study.herokuapp.com/"+`${study.studyNo}`+"/"+`${user.email}`,
                "CamStudy",
                "height=" + screen.height + ",width=" + screen.width + "fullscreen=yes");
	});
	
	
	$('.panel-title').on('click', function(e){
	    var $this = $(this);
		if(!$this.hasClass('panel-collapsed')) {
			$this.parents('.panel').find('.panel-body').slideUp();
			$this.addClass('panel-collapsed');
		} else {
			$this.parents('.panel').find('.panel-body').slideDown();
			$this.removeClass('panel-collapsed');
		}
	});
	
	$('#addNoticeBtn').on('click', function(){
		$("#noticeModal").modal("show");
	});
	
	$('#addNotice').one('click', function(){
		studyNo = ${study.studyNo};
		groupStudyNotice = $('#groupStudyNotice').val();
		$.ajax({
			type: 'post',
			url: '/studyroom/json/updateNotice',
			data : JSON.stringify({
				studyNo:studyNo,
				groupStudyNotice:groupStudyNotice
			}),
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			datatype : 'json',
			success : function(data) {
				$("#noticeModal").modal("hide");
				$('.panel-body').empty();
				$('.panel-body').append(data);
			},
			error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}		
		});	
		
	});
	
});

</script>

<body>

	
      <jsp:include page="../layout/sidebar.jsp" />
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
              <div class="row">
                  <div class="col-lg-9 main-chart">			
                      <!--CUSTOM CHART START -->
                      <div class="border-head" id="room-head">
                          <button id="sroomInfo">
                           <h5> 스터디 정보 조회 </h5> 
                          </button>
                          <button class="float-right"id="chat">
                           <h5> 채팅 접속 </h5> 
                          </button>
                          <button class="float-right"id="camstudy">
                           <h5> 화상 스터디 </h5> 
                          </button>
                      </div>
					<hr>
					
                    <div class="row mt">
                      <!-- SERVER STATUS PANELS -->
                      	<div id='calendar'></div>

					</div><!-- /row -->
					
					
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  
                  <div class="col-lg-3 ds">
                    <!--COMPLETED ACTIONS DONUTS CHART-->
	                    <div class="panel panel-default">
							<div class="panel-heading1">
								<h3 class="panel-title">공 지 사 항 : CLICK</h3>
								<span class="pull-right clickable"></span>
							</div>
							<div class="panel-body"><span>${study.groupStudyNotice}</span>
								<c:if test="${study.studyMaker.email == user.email}">
									<div class="col-2" style='text-align: right;'>
										<button id="addNoticeBtn">등록/저장</button>
									</div>
								</c:if>
							</div>
						</div>
                    
						<a id=attendance href="#">
							<h3>출석 체크</h3>
							<input type="hidden" id="email" value="${email}">
						</a>
						<div id = "attList">
		                    <c:forEach var="aList" items="${result}">                      
		                      <!-- First Action -->
		                      <div class="desc">
		                      	<div class="thumb">
		                      		<img class="img-circle" src="/resources/images/ogg.png" width="35px" height="35px" align="">
		                      	</div>
		                      	<div class="details">
		                      		<muted >출석일자 : ${aList.get("ATTENDANCE_DATE")}</muted><!-- <br/> -->
		                      		   <a href="#"></a> 출석. <br/>
		                      		
		                      	</div>
		                      </div>
		                    </c:forEach>
	                    </div>
           

                       <!-- USERS ONLINE SECTION -->
						<h3>스터디 멤버</h3>
						<c:forEach var="gMember" items="${list}">
                      <!-- First Member -->
	                     <div class="desc" id="studyMember">
	                      	<div class="thumb">
	                      		<img class="img-circle" src="/resources/images/ogg.png" width="35px" height="35px" align="">
	                      	</div>
	                      	<div class="details">
	                      		<p>
	                      			<a href="#">
	                      				${gMember.member.nickname}
	                      			</a> / 
	                      			<span>
										<c:if test="${gMember.studyRole =='1'}">
											스터디리더
										</c:if>
										<c:if test="${gMember.studyRole =='2'}">
											스터디원
										</c:if>
								   </span>
	                      		</p>
	                      		<muted>
	                      			각오 : ${gMember.determination}
	                      		</muted>
	                      	</div>
	                      </div>
	                  </c:forEach>
	                     
                      </div>
             
                  </div>
   				
          </section>
      </section>

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <div class="text-center">
              2021 - Ogong
              <a href="#" class="go-top">
                  <i class="fa fa-angle-up"></i>
              </a>
          </div>
      </footer>
      <!--footer end-->
	

	<!-- 모달창 -->
	 <div class="modal fade" tabindex="-1" role="dialog" id="myModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">일정 등록</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input type="hidden" id="studyNo" value="${studyNo}">
                                <input class="inputModal" type="text" name="calendarTitle" id="title"
                                    required="required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">시작</label>
                                <input class="inputModal" type="text" name="calendarStartDate" id="start" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">끝</label>
                                <input class="inputModal" type="text" name="calendarEndDate" id="end" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="inputModal" name="calendarColor" id="color">
                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
                                    <option value="#495057" style="color:#495057;">검정색</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">일정 내용</label>
                                <textarea class="inputModal" name="calendarContents"
                                    id="contents"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-info" id="save">저장</button>
                    </div>
                </div>
            </div>
        </div>
        
        
        
        <!-- 스터디룸 정보 조회 modal -->
		<div class="modal fade" tabindex="-1" role="dialog" id="roomModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"> 그룹스터디 정보 조회</h4>
                    </div>
                    <div class="modal-body">
						<label for="studyName">스터디명</label> 
							<div class="col-xs-8 col-md-12">${study.studyName}</div><hr/>
							
							<label for="studyInterest">관심주제</label> 	
							<div class="col-xs-8 col-md-12">${study.studyInterest}</div><hr/>
							
							<label for="groupStudyInfo">스터디 소개</label>
							<div class="col-xs-8 col-md-12">${study.groupStudyInfo}</div><hr/>
							
							<label for="groupStudyPlan">스터디 계획</label>
							<div class="col-xs-8 col-md-12">${study.groupStudyPlan}</div><hr/>
							
							<label for="groupStudyCondition">스터디 참가조건</label>
							<div class="col-xs-8 col-md-12">${study.groupStudyCondition}</div><hr/>
							
							<div class="hashTag_area">
								<label for="studyHashtag">해시태그</label>
								<div class="col-xs-8 col-md-12">${study.studyHashtag}</div>
							</div><hr/>
							
							<label for="studyThumbnail">스터디 썸네일</label>
							<div class="input-group mb-3">
								<div class="studyThumbnail">
									<img class="img-fluid img-thumbnail rounded" src="/resources/upload_files/study/${study.studyThumbnail}">
								</div>
							</div><hr/>

							<label>모집 기간 </label>
							<div class="col-xs-8 col-md-12">${study.recruitmentStartDate} ~ ${study.recruitmentEndDate}</div><hr/>
							
							<label>시작 기간 </label>
							<div class="col-xs-8 col-md-12">${study.studyStartDate} ~ ${study.studyEndDate}</div><hr/>
							
							<label>인 원</label>
							<div class="col-xs-8 col-md-12">${study.currentMember}명 / ${study.maxMember}명</div><hr/>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-info" data-dismiss="modal">확인</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 공지사항 등록 모달 -->
        <div class="modal fade" tabindex="-1" role="dialog" id="noticeModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"> 공지사항 등록 </h4>
                    </div>
                    <div class="modal-body">
						<label for="groupStudyNoice">공지사항</label> 
						 <div>
						 	<input type="hidden" name="studyNo" value="${study.studyNo}">
						 	<textarea class="inputModal" id="groupStudyNotice" name="groupStudyNotice" style="width:570px; height:150px;"></textarea>
						 </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                       <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-info" id="addNotice">저장</button>
                    </div>
                </div>
            </div>
        </div>
	

  <!-- js placed at the end of the document so the pages load faster -->
<script class="include" type="text/javascript" src="/resources/javascript/sroomjs/jquery.dcjqaccordion.2.7.js"></script>
<script src="/resources/javascript/sroomjs/jquery.scrollTo.min.js"></script>
<script src="/resources/javascript/sroomjs/jquery.nicescroll.js" type="text/javascript"></script>
<script src="/resources/javascript/sroomjs/jquery.sparkline.js"></script>

<!--common script for all pages-->
<script src="/resources/javascript/sroomjs/common-scripts.js"></script>

<script type="text/javascript" src="/resources/javascript/sroomjs/jquery.gritter.js"></script>
<script type="text/javascript" src="/resources/javascript/sroomjs/gritter-conf.js"></script>
 		
<script type="text/javascript">

	
	 function update(info){
		console.log(info);
		var id = info.event.id;
		var start = info.event.startStr;
		var end = info.event.endStr;
		var title = info.event.title;
		var color = info.event.backgroundcolor;
		
		
		var msg;
		$.ajax({
			type : 'post',
			data : JSON.stringify({
				calendarNo : id,
				calendarTitle : title,
				calendarStartDate : start,
				
				calendarEndDate : end,
				calendarColor : color
			}),
			datatype : 'json',
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			async : false,
			url : "/studyroom/json/updateCalendar",
			success : function(result) {
				if (result == true){
					msg = "수정되었습니다.";
				} else {
					msg = '수정에 실패했습니다';
				}
			},
			error : function(xhr, status, error){
				msg = error; 
			}
		});
		return msg;
	}
	

	document.addEventListener('DOMContentLoaded', function() {
		
		var calendarEl = document.getElementById('calendar');
		var calendar;
		calendar = new FullCalendar.Calendar(calendarEl, { 
			locale : 'ko', 
			timeZone : 'UTC',
			handleWindowResize: true,
			dayMaxEventRows: true,
			views : { 
				  timeGrid: {
				      dayMaxEventRows: 5 // 날짜당 최대 보여줄수 있는 일정 갯수  5개 이상은 +more로 보임
				    }
			},
			headerToolbar: { 
				left: 'today addButton', 
				center: 'prev title next', 
				right: 'dayGridMonth,timeGridWeek,timeGridDay' 
			},
			customButtons: {
			    addButton: {
			    	text: 'add Calendar',
			    	click: function() {
			     		$("#myModal").modal("show");
			     		
			     		$("#save").one("click", function(){
			     			
			     			var title = $('#title').val();
			     			var startDate = $('#start').val();
			     			var endDate = $('#end').val();
			     			var contents = $('#contents').val();
			     			var studyNo = $('#studyNo').val();
			     			var calendarColor = $('#color').val();
			     			
			     			var calendar1 = {calendarTitle:title,	
			     					calendarStartDate:startDate,
			     					calendarEndDate:endDate,
			     					calendarContents:contents,
			     					calendarColor:calendarColor
			     					};
			     			var study = {studyNo:studyNo};
			     			
			     			var list = [calendar1,study];
			     			if(title == null || title == ""){
			     				swal("제목을 입력하세요");
			     			} else if (startDate == "" || endDate == ""  ){
			     				swal("날짜를 입력하세요.");
			     			} else {
			     				
			     				$.ajax({
				     				type: 'post',
				     				url: '/studyroom/json/addCalendar',
				     				data : JSON.stringify(list),
				     				headers : {
				     					"Accept" : "application/json",
				     					"Content-Type" : "application/json"
				     				},
				     				datatype : 'json',
				     				success : function(data) {
				     					calendar.addEvent({
				     						title: title,
				     						start: startDate,
				     						end: endDate,
				     						backgroundColor:calendarColor
				     					});
				     					$("#myModal").modal("hide");
				     				},
				     				error:function(request, status, error){
										
										alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
									}		
				     			});	
			     			}	
			     		});	     		
			     	}
			    }
			},
			buttonText:{
				list : '주간 일정표'
			},
			navLinks: true,
			selectable: true, 
			selectMirror: true, 
			select: function(arg) { 
				console.log(arg); 
				
				var title = prompt('입력할 일정:'); 
			calendar.unselect() 
			},
			eventDrop : function(info){
				swal({
					  title: "수정 하시겠습니까?",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((confirm) => {
					  if (confirm) {
						update(info);  
					    swal("수정 되었습니다.", {      
					    icon: "success" 
					    });
					  } else {
					    info.revert();
					  }
				});
			},
			eventResize : function(info){
				swal({
					  title: "수정 하시겠습니까?",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((confirm) => {
					  if (confirm) {
						update(info);  
					    swal("수정 되었습니다.", {
					    icon: "success" 
					    });
					  } else {
					    info.revert();
					  }
				});
			},
			eventClick: function(arg) {
				console.log("#등록된 일정 클릭#");
				swal({
					  title: "삭제 하시겠습니까?",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((willDelete) => {
					  if (willDelete) {
						  $.ajax({
								type : 'get',
								url : "/studyroom/json/deleteCalendar/"+arg.event.id,
								datatype : 'text',
								success : function (result){
									if(result == true) {
										arg.event.remove(); 
									}
								},
								error:function(request, status, error){
									
									alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
								}
							});  
					    swal("삭제 되었습니다..", {
					    icon: "success" 
					    });
					  } else {
					    info.revert();
					  }
				});
			
			},
			editable: true, 
			dayMaxEvents: true, 
			events: function(info, successCallback, failureCallback){
				
				$.ajax({
					type:"get",
					url:"/studyroom/json/getCalendarList/"+${studyNo},
					dataType:"json",
					success : function(data) {
						var events = [];
						$.each(data, function(index, data){
	
							events.push({
								id : data.calendarNo,
								title: data.calendarTitle,
								start: data.calendarStartDate,
								end: data.calendarEndDate,
								backgroundColor:data.calendarColor,
								textColor:"white" 
							});
						});
						
						successCallback(events);
					}
				
				});
			},
			eventTimeFormat: {
				hour: '2-digit',
				minute: '2-digit',
				hour12: false
			}
				
		}); 
			calendar.render();
		});
	
	///////////////////////채팅 과 출석체크//////////////////////////

	$(function (){
    	
		
    	var studyNo= $("#studyNo").val();
    	var email= $("#email").val();
    	
    	
    	$("#chat").on("click", function (){
    		popWin = window.open("https://ogong-chat.herokuapp.com/?studyNo="+studyNo+"&email="+email,
					"popWin",
					"left=600, top=700, width=770, height=600, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
    	
    	});
    	
    	$('#attendance').on("click", function(){

    		$.ajax({
    			url: "/studyroom/json/addAttendance/"+studyNo,
    			method : "GET" ,
    			dataType : "json",
     			headers : {
 					"Accept" : "application/json",
 					"Content-Type" : "application/json"
 				}, 
    			success: function (data, status){
    				if(data != ""){
    					swal({
      					  title: "출석체크 완료",
      					  icon: "success",
      					  button: "확 인",
      					});
    					var display ='';
    					$('#attList').empty();
    					$.each(data, function(index, data){
    						display = '<div class="desc">'
    								+'<div class="thumb">'
    								+'<img class="img-circle" src="/resources/images/ogg.png" width="35px" height="35px">'
    								+'</div>'
    								+ '<div class="details">'
    								+'<muted> 출석일자 : '+data.ATTENDANCE_DATE+'</muted>'
    								+'<a href="#"></a> 출석. <br>'
    								+'</div>'
    								+'</div>';
    								
    						$('#attList').append(display);
    					});
    					
    						
    				}else if (data == ""){
        				swal({
          					title: "이미 출석체크 하셨습니다.",
          					icon: "warning",
          					button: "확 인"
        				});
    				}
    			}
    		});
    		
    	});
    	
    	 
    }); 

</script>
</body>
</html>