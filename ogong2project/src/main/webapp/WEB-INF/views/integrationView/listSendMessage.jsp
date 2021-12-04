<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
	

  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/css/hanjee/adminlte.min.css">
  
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    
  
  <script src="https://kit.fontawesome.com/e3409dba93.js" crossorigin="anonymous"></script>
  
	<style>
 
		
 		@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
		
		body, 
		table, 
		div, 
		p, 
		th, 
		td{
		font-family: 'Do Hyeon', sans-serif;
		font-size: 16px;
		}
		
				
   	</style>  
	<script type="text/javascript">
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/integration/listSendMessage").submit();
	}

	$(function(){
		
		$("ul li:nth-child(2)").on("click", function(){
			$("#myModal2").find('#receiver').val($(this).find('input').val());
		});

		$("ul li:nth-child(3)").on("click", function(){
			$("#myModalReport").find('#receiveReporter').val($(this).find('input').val());
		});		
	
	});	
	
	
	$(function(){
		
			
	 	$( "a:contains('보낸쪽지함')" ).on("click" , function() {
	 		location.href = "/integration/listSendMessage";
		});
	 	$( "a:contains('받은쪽지함')" ).on("click" , function() {
	 		location.href = "/integration/listReceiveMessage";
		});
	 	
 	
	})
	
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
					alert(JSONData.nickname);
					$("#profile").html(JSONData.nickname+" 의 프로필");
					$("#email").html(JSONData.email);
					$("#email2").html(JSONData.email);
					$("#asd").html(JSONData.nickname);
					$("#userNickname").html(JSONData.name);
					$("#birth").html(JSONData.birth);
					$("#goal").html(JSONData.goal);
					if(JSONData.userImage != null){
						$("#image").html("<img  src='/resources/images/"+JSONData.userImage+"' alt='User profile picture'>")	
					}else{
						$("#image").html("<img  src='/resources/images/basic.jpg' alt='User profile picture'>");
					}
					$("#interest1").html(JSONData.studyInterest1);
					$("#interest2").html(JSONData.studyInterest2);
					$("#interest3").html(JSONData.studyInterest3);
					
				}

				
				
			}) 
		
		
		})
	}) 
	
	
	
	$(function(){
				
		
		
		
 		$("#deletebtn").on("click" , function() {

 		 	
  			
 			  var messageArr = new Array();
   				
 		 	 $("input[class='messageNo']:checked").each(function(){
 		 		messageArr.push($(this).val());
 			 });
 		 	 
 		  		$.ajax({
		  			 	 url : "/integration/deleteTest",
			  		  	 type : "POST",
		  		  	 	 data : { messageNo : messageArr },
		    		 	 success : function(result){
		   		   	 	 	if(result == 1){
		    		 		 	location.href = "/integration/listSendMessage";
		   		   	 	 	} else {
		   		   	 	 		alert("삭제 실패")
		   		   	 	 	}
		   		   	 		
		  		  	 	}
		  		  	 	 
  		  		});
 		  		alert("삭제가 완료되었습니다.")
 		  		$("input[class='messageNo']:checked").parent().parent().parent().remove();
 		});
 		
 		
 		$("#deletebtn2").on("click" , function() {
 			
 			var messageDelete = $(".deleteMessage").val()
			
			
 			
			$.ajax({
				
				url : "/integration/json/deleteMessage/"+messageDelete,
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status){
					
				}
			});
			alert("삭제가 완료되었습니다.")
			$("#trRemove").remove();
 			
 		});
 		
 		
 		$("button[name='refresh']").on("click", function(){
 			location.href = "/integration/listSendMessage";
 		});
 		

 		
	})
	</script>       	
  
</head>
<body class="hold-transition sidebar-mini">

	<jsp:include page="../common/toolbar.jsp" />
	<jsp:include page="../integrationView/addSendMessage.jsp" />
	<jsp:include page="../integrationView/addSendMessage2.jsp" />
	<jsp:include page="../integrationView/getMyProfile.jsp" />
	<jsp:include page="../adminView/addReport.jsp" />	

<div class="wrapper">


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
      <div class="row" style="padding-top:7px">
        <div class="col-md-3">
          <a href="compose.html" class="btn btn-primary btn-block mb-3" style="background-color:#af945f; border-color:#fff;" data-toggle="modal" data-target="#myModal">쪽지보내기</a>

          <div class="card">
            <div class="card-header">
              <h3 class="card-title">쪽지함</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body p-0">
              <ul class="nav nav-pills flex-column">
                <li class="nav-item active">
                  <a href="#" class="nav-link">
                    <i class="fas fa-inbox" id="receiveMessage"></i> 받은쪽지함
                  </a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link">
                    <i class="far fa-envelope" id="sendMessage"></i> 보낸쪽지함
                  </a>
                </li>
              </ul>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
          
        </div>
        <!-- /.col -->
        <div class="col-md-9" >
          <div class="card card-primary card-outline" style="border-top:#FFF">
            <div class="card-header">
              <h3 class="card-title">보낸 쪽지</h3>

            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              <div class="mailbox-controls">
                <!-- Check all button -->                
                <div class="btn-group float-left">
       					&nbsp&nbsp&nbsp<div class="btn-group" role="group" >				
       						<div class="allCheck">
								<input style="zoom:2.0;  " type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label>
									<script>
										$("#allCheck").click(function() {
											var chk = $("#allCheck").prop("checked");
											if (chk) {
												$('.messageNo').prop("checked", true);
											} else {
												$('.messageNo').prop("checked", false);
											}
										});
									</script>
							</div>
						</div>                
                  <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#exampleModal">
                    <i class="far fa-trash-alt"></i>
                  </button>
                  <button type="button" class="btn btn-default btn-sm" name="refresh">
                    <i class="fas fa-redo"></i>
                  </button>

                </div>
                
                
                <!-- /.btn-group -->
                <div class="float-right">
                  전체 ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage} 페이지

	                  
                  <div class="btn-group">
                  <a href="javascript:fncGetList('${ resultPage.currentPage-1}')">
                    <button type="button" class="btn btn-default btn-sm">
                      <i class="fas fa-chevron-left"></i>
                    </button>
                  </a>
                    <a href="javascript:fncGetList('${resultPage.currentPage+1}')">
                    <button type="button" class="btn btn-default btn-sm">
                      <i class="fas fa-chevron-right"></i>
                    </button>
                    </a>
                  </div>
                  <!-- /.btn-group -->
                </div>
                <!-- /.float-right -->
              </div>
              <div class="table-responsive mailbox-messages">
                <table class="table table-hover table-striped">
                  <tbody>
                  <input type="hidden" value="${message.messageCategory}"/>
	    	  <c:if test="${ ! empty list}">
		 	 	<c:set var="i" value="0" />
		  		<c:forEach var="message" items="${list}">                                   
                  <tr id="trRemove">
			  			<td align="left">
			  				<div class="checkBox">
			  					&nbsp<input style="zoom:1.5;" type="checkbox" class="messageNo" name="messageNo"  value="${message.messageNo}"/>
									<script>
										$(".messageNo").click(function() {
											$("#allCheck").prop("checked", false);
										});
									</script>		  					
							</div>
						</td>
						<td align="left">
							<div class="dropdown">
								<a id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
									${message.receiver.email}
								</a>
								  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
								    <li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#myModal">프로필보기
								    <input type="hidden" value="${message.receiver.email}" /></a></li>
								    <li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#myModal2">쪽지보내기
								    <input type="hidden" value="${message.receiver.email}" /></a></li>
								    <li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#myModalReport">신고하기
								    <input type="hidden" value="${message.receiver.email}" /></a></li>
								  </ul>									
							</div>
						</td>	
			  			<td align="left">${message.messageContents}</td>
			  			<td align="left">${message.sendDate}</td>
						<td align="left">
							<div class="delete">
	    						<button type="button" class="deleteMessage" name="deleteMessage"  value="${message.messageNo}" data-toggle="modal" data-target="#exampleModal2">삭제</button>
	   						</div>
			  			</td>
                  </tr>
		  		</c:forEach>
		  	  </c:if>                  
				  <c:if test="${empty list }">
				  	<tr>
				  		<td align="center">	</td>
				  		<td align="center"></td>
				  		<td align="center"> 쪽지가 없습니다. </td>
				  	</tr>
				  </c:if>                  
                  </tbody>
                </table>
                <!-- /.table -->
              </div>
              <!-- /.mail-box-messages -->
            </div>
            <!-- /.card-body -->
            <div class="card-footer p-0">
              <div class="mailbox-controls">
                <!-- Check all button -->
                <div class="btn-group float-left">
       					&nbsp&nbsp&nbsp<div class="btn-group" role="group" >				
       						<div class="allCheck">
								<input style="zoom:2.0;  " type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label>
									<script>
										$("#allCheck").click(function() {
											var chk = $("#allCheck").prop("checked");
											if (chk) {
												$('.messageNo').prop("checked", true);
											} else {
												$('.messageNo').prop("checked", false);
											}
										});
									</script>
							</div>
						</div>                
                  <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">
                    <i class="far fa-trash-alt"></i>
                  </button>
                  <button type="button" class="btn btn-default btn-sm" name="refresh">
                    <i class="fas fa-redo"></i>
                  </button>

                </div>

                <!-- /.btn-group -->
                <div class="float-right">
                  전체 ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage} 페이지
                  <div class="btn-group">
                  <a href="javascript:fncGetList('${ resultPage.currentPage-1}')">
                    <button type="button" class="btn btn-default btn-sm">
                      <i class="fas fa-chevron-left"></i>
                    </button>
                  </a>
                    <a href="javascript:fncGetList('${resultPage.currentPage+1}')">
                    <button type="button" class="btn btn-default btn-sm">
                      <i class="fas fa-chevron-right"></i>
                    </button>
                    </a>
                    
					    <form class="form-inline" name="detailForm">
					      
						  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						  <input type="hidden" id="currentPage" name="currentPage" value=""/>
						  
						</form>
                  </div>
                  <!-- /.btn-group -->
                </div>
                <!-- /.float-right -->
              </div>
            </div>
            
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->



		 <!-- Modal 쪽지 선택삭제-->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">선택삭제</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        선택한 쪽지을 정말 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			      	<button type="button" id="deletebtn" class="btn btn-primary" data-dismiss="modal">삭제하기</button>
			       	<button type="button" class="btn btn-primary" data-dismiss="modal">취소하기</button>
			      </div>
			    </div>
			  </div>
			</div>	
			
		 <!-- Modal 쪽지 삭제-->
			<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel2">삭제</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        쪽지을 정말 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			      	<button type="button" id="deletebtn2" class="btn btn-primary" data-dismiss="modal">삭제하기</button>
			       	<button type="button" class="btn btn-primary" data-dismiss="modal">취소하기</button>
			      </div>
			    </div>
			  </div>
			</div>            
            
        

<!-- AdminLTE App -->
<script src="/resources/javascript/adminlte.min.js"></script>


</body>
</html>
