<%@ page contentType="text/html; charset=EUC-KR" 
	pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ToolBar Start /////////////////////////////////////-->
<style>
.Ogong {
	width: 120px;
	height: 50px;
}
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap')
	;

body, table, div, p, th, td {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}
	
#hard {
  width: 160px;
  height: 80px;
  object-fit: cover;
  left: 50%;
  margin-right: 3.5rem !important;
  text-align : right;
}

#detail{
	text-align: center; 
}

.btn:hover {
	background-color: #3395ff;
	color: white;
	font-weight: bold;
}
#userImage {
	width: 300px;
	height: 300px;
	margin-top: 10px;
	object-fit: cover;
  	left: 50%;
  	border-radius: 3.0rem !important;
  	max-width: 100%;
}
</style>

<!-- Theme style -->
<link rel="stylesheet" href="/resources/css/adminlte.min.css">
<!-- Bootstrap 4 -->
<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
<script src="/resources/javascript/bootstrap.bundle.min.js"></script>

<script src="https://kit.fontawesome.com/e3409dba93.js"></script>


<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> -->

<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand-md navbar-light navbar-white" style="background-color:#ecf1f7; color:#FFDC3C;">
        &nbsp&nbsp&nbsp&nbsp&nbsp<a class="navbar-brand">
        <img src="/resources/images/ogong2.png" align="left" class="Ogong" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      </a>
    <div class="container">


      <button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse order-3" id="navbarCollapse">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
          <li class="nav-item dropdown">
            <a id="dropdownSubMenu1" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle">자율스터디</a>
            <ul aria-labelledby="dropdownSubMenu1" class="dropdown-menu border-0 shadow">
              <li><a href="#" class="dropdown-item" id="free">자율스터디</a></li>
              <li><a href="#" class="dropdown-item">모집게시판</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a  class="nav-link">그룹스터디</a>
          </li>
          <li class="nav-item">
            <a  class="nav-link">공부기록</a>
          </li>      
          <li class="nav-item dropdown">
            <a id="dropdownSubMenu1" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle">게시판</a>
            <ul aria-labelledby="dropdownSubMenu1" class="dropdown-menu border-0 shadow">
              <li><a href="#" class="dropdown-item">정보공유게시판 </a></li>
              <li><a href="#" class="dropdown-item">Q&A게시판</a></li>

              <li class="dropdown-divider"></li>

              <!-- Level two dropdown-->
              <li class="dropdown-submenu dropdown-hover">
                <a id="dropdownSubMenu2" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="dropdown-item dropdown-toggle">쉼터게시판</a>
                <ul aria-labelledby="dropdownSubMenu2" class="dropdown-menu border-0 shadow">
                  <li>
                    <a tabindex="-1" href="#" class="dropdown-item">자유게시판</a>
                  </li>
                  <li>
                    <a tabindex="-1" href="#" class="dropdown-item">합격후기게시판</a>
                  </li>                  
                  
                </ul>
              </li>
              <!-- End Level two -->
            </ul>
          </li>    
          <c:if test="${user.role == 2}">
          	<li class="nav-item">
	           <a class="nav-link">관리자</a>
	        </li>  
          </c:if>                                                           
        </ul>

      </div>

      <!-- Right navbar links -->
      <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
        <!-- Messages Dropdown Menu -->
        <li class="nav-item dropdown" id="noticeCount">
        
          <a class="nav-link" data-toggle="dropdown" href="#">            
            <i class="far fa-bell"></i>	
          </a>
                   
          <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
            <a href="#" class="dropdown-item">
              <!-- Message Start -->
              <div class="media">
                <div class="media-body" id="noticeList">
                
<!--                   <h3 class="dropdown-item-title">
                    Brad Diesel
                    <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
                  </h3>
                  <p class="text-sm">Call me whenever you can...</p>
                  <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p> -->
                  
                </div>
              </div>
              <!-- Message End -->
            </a>
            <div class="dropdown-divider"></div>
            <a href="javascript:deleteNoticeAll()" class="dropdown-item dropdown-footer">전 체 삭 제</a>
          </div>
        </li>
        
	      <li class="dropdown">
	          <a id="dropdownSubMenu1" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle">
	          	<i class="fas fa-th-large"></i>
	          </a>
	
	        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
	          <a href="#" class="dropdown-item">
	            <!-- Message Start -->
	            <div class="media" id="media">
	              <!-- <img src="/resources/images/jjang.jpg" alt="User Avatar" class="img-size-60 mr-4 img-circle"> -->
	              <div class="media-body">
	              	<h3 class="dropdown-item-title">&nbsp&nbsp</h3>
	                <h3 class="dropdown-item-title" id="nickname"></h3>
	                <h3 class="dropdown-item-title" id="email"></h3>
	              </div>
	            </div>
	            <span id="detail">
	              <a class="btn  btn-sm">&nbsp</a>
	              <a class="btn  btn-sm" data-toggle="modal" data-target="#getProfile">프로필</a>
	              <a class="btn  btn-sm">쪽지</a>
	              <a class="btn  btn-sm">로그아웃</a>
	              <a class="btn  btn-sm">바나나조회</a>
	              <a class="btn  btn-sm">&nbsp</a>
	              <a class="btn  btn-sm">&nbsp</a>
	              <a class="btn  btn-sm">나의게시글</a>
	              <a class="btn  btn-sm">나의스터디</a>
	              <a class="btn  btn-sm">회원탈퇴</a>
	            </span>
	          </a>
	        </div>
	      </li>        
      
      </ul>
    </div>
  </nav>
  <!-- /.navbar -->
  </div>
  <!-- /.content-wrapper -->
<!-- ./wrapper -->



		<!-- ToolBar End /////////////////////////////////////-->
 	  	<script type="text/javascript">
   		
   	
	   	var email = "${user.email}";
	   	
	   	
	   	function noticeCount() {

	   			$.ajax(
	   					{
 					url : "/integration/json/getNoticeCount/"+email ,
 					method : "GET" ,
 					dataType : "json" ,
 					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"	 						
 					} ,
	   				success : function(JSONData, status){
	   					
   						if (JSONData != 0){
							let display = "<span class='badge badge-danger navbar-badge' id='test'>"+JSONData+"</span>";
							$('#noticeCount > a > i').append(display); 
   						}
	   				}
	   			});	   		
	   	
	   	};
	   	
	   	$('#noticeCount').on('click', function(){
	   		$.ajax(
	   				{
	   			url : "/integration/json/updateNotice/"+email ,
	   			method : "GET" ,
	   			dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				success : function(JSONData, status){
					
				}
	   		})
	   		$('#test').remove();
	   	})
	   	
	   	
	   	function deleteNotice(noticeNo)	{
	   		
	   		$.ajax(
	   				{
	   				  url : "/integration/json/deleteNotice/"+noticeNo ,
	   				  method : "GET" ,
	   				  dataType : "json" ,
	 				  headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"	 						
	 				  } ,
	 				  
	 				  success : function(JSONData, status){
	 					
	 				  }
	 			
	   		});
	   	 $('.notice'+noticeNo).remove();
	   	}
	   	
	   	
	   	function deleteNoticeAll(){
	   		
	   		$.ajax(
	   				{
	   				  url : "/integration/json/deleteNoticeAll/"+email ,
	   				  method : "GET" ,
	   				  dataType : "json" ,
	 				  headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"	 						
	 				  } ,
	 				  
	 				  success : function(JSONData, status){
	 					 
	 				  }	
	   			});
	   		$('#noticeList').remove();
	   	}
   		
	 	
	 		
	 	
	 	
	 if( email != ''){
	 		
	 		
	 		$.ajax(
	 				{
	 					url : "/integration/json/getlistNotice/"+email ,
	 					method : "GET" ,
	 					dataType : "json" ,
	 					headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"	 						
	 					} ,
	 					
	 					
	 					success : function(JSONData, status){
	 						
	 						var display = '';
	 						if(JSONData.length > 0){
	 							for(var i = 0; i < JSONData.length; i++){
	 		 						
	 		 						if(JSONData[i].noticeCategory == '1'){
	 			 						display = "<h3 class='dropdown-item-title'>"
	 			 								+ "<a href='/board/getBoard?boardNo="+JSONData[i].noticeBoard.boardNo+"'>"+JSONData[i].noticeBoard.boardTitle+"의 게시글에</a>"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"
	 			 								+ "<p class='text-sm'>댓글이 달렸습니다.</p>"
	 			 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
	 			 					}
	 		 						else if (JSONData[i].noticeCategory == '2'){
		 		 						display = "<h3 class='dropdown-item-title'>"
		 		 								+ "<a href='/board/getBoard?boardNo="+JSONData[i].noticeBoard.boardNo+"'>"+JSONData[i].noticeBoard.boardTitle+"의 게시글에</a>"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"		 		 								
		 		 								+ "<p class='text-sm'>답변이 달렸습니다.</p>"
		 		 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
		 		 					}
	 		 						else if (JSONData[i].noticeCategory == '3'){
		 		 						display = "<h3 class='dropdown-item-title'>"
		 		 								+ "<a href='/board/getBoard?boardNo="+JSONData[i].noticeBoard.boardNo+"'>"+JSONData[i].noticeBoard.boardTitle+"의 게시글에</a>"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"		 		 								
		 		 								+ "<p class='text-sm'>답변이 채택되었습니다.</p>"
		 		 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
		 		 					}
	 		 						else if (JSONData[i].noticeCategory == '4'){
		 		 						display = "<h3 class='dropdown-item-title'>"
		 		 								+ "<a href='/study/getStudy?studyNo="+JSONData[i].noticeStudy.studyNo+"'>"+JSONData[i].noticeStudy.studyName+"의 스터디에"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"
		 		 								+ "<p class='text-sm'>참가신청이 도착하였습니다.</p>"
		 		 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
		 		 					}
	 		 						else if (JSONData[i].noticeCategory == '5' && JSONData[i].noticeGroupMember.approvalFlag == '1'){
		 		 						display = "<h3 class='dropdown-item-title'>"
		 		 								+ JSONData[i].noticeStudy.studyName+"의 스터디에"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"
		 		 								+ "<p class='text-sm'>참가신청이 승인 되었습니다.</p>"
		 		 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
		 		 					}
	 		 						else if (JSONData[i].noticeCategory == '5' && JSONData[i].noticeGroupMember.approvalFlag == '2'){
		 		 						display = "<h3 class='dropdown-item-title'>"
		 		 								+ JSONData[i].noticeStudy.studyName+"의 스터디에"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"
		 		 								+ "<p class='text-sm'>참가신청이 거절 되었습니다.</p>"
		 		 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
		 		 					}
	 		 						else if (JSONData[i].noticeCategory == '6'){
		 		 						display = "<h3 class='dropdown-item-title'>"
		 		 								+ "사용자님의"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"
		 		 								+ "<p class='text-sm'>목표시간이 완료되었습니다.</p>"
		 		 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
		 		 					}
	 		 						else if (JSONData[i].noticeCategory == '7'){
		 		 						display = "<h3 class='dropdown-item-title' id='notice'>"
		 		 								+ "<a href=/integration/listSendMessage style=' font-weight:0;'>"+JSONData[i].sender.email+" 님에게</a>"
		 		 								+ "<span class='float-right text-sm text-danger'>"
		 		 								+ "<a href='javascript:deleteNotice("+JSONData[i].noticeNo+")'><i class='fas fa-star' style='color:red;'></i></a>"
		 		 								+ "</span>"
		 		 								+ "</h>"
		 		 								+ "<p class='text-sm'>쪽지가 도착하였습니다.</p>"
		 		 								+ "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>"+JSONData[i].noticeDate+"</p>";
	 		 						}
	 		 						 /* alert(display); */
	 		 						$('#noticeList').append(display); 
	 							}
	 							
	 						} else {
	 							display = "<li style='height: 40px'>도착한 알림이 없습니다..</li>";
	 							$('#noticeList').append(display);
	 						}
	 						noticeCount();	
	 					}
	 		})
	 		
		 
	 	
	 };
	 
 		$.ajax({
			
			url : "/admin/json/adminGetUser/"+email,
			method : "GET" ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			
			success : function(JSONData, status){
				
				
				
				var display2 = JSONData.email;
				var display3 = JSONData.nickname;
				if(JSONData.userImage == null){
					var display = "&nbsp&nbsp&nbsp&nbsp<img src='/resources/upload_files/user_images/basic.jpg' alt='User Avatar' id='hard' class='img-circle'>";
					$('#media').append(display);	
				}else if(JSONData.userImage != null){
					var display = "&nbsp&nbsp&nbsp&nbsp<img src='/resources/upload_files/user_images/"+JSONData.userImage+"' alt='User Avatar' id='hard' class='img-circle'>";
					$('#media').append(display);
				}
				$('#email').html(display2);
				$('#nickname').html(display3);
			}
			
		})	  
	 	
   	</script>
   	
   	<script type="text/javascript">
		//=============  오공 Event  처리 =============
		$(".Ogong").on("click", function(){
			location.href = "/integration/mainPage";
		}) ;   	
   	   	
		//=============  자율스터디목록 Event  처리 =============
	 	$( "#free" ).on("click" , function() {
	 		location.href = "/study/listStudy?studyType=self";
		});
		
	 	//=============  모집게시판 Event  처리 =============
	 	$( "a:contains('모집게시판')").on("click", function(){
	 		//location.href = "/board/listBoard?boardCategory="+'5';
	 		location.href = "/board/listBoard?boardCategory=5";
	 	});
	 	//=============  그룹스터디 Event  처리 =============
	 	$( "a:contains('그룹스터디')").on("click", function(){
	 		location.href = "/study/listStudy?studyType=group";
	 	});		 	
	 	
	 	//=============  정보공유게시판 Event  처리 =============
	 	$( "a:contains('정보공유게시판')").on("click", function(){
	 		location.href = "/board/listBoard?boardCategory="+'1';
	 	});	
	 	
	 	//=============  Q&A게시판 Event  처리 =============
	 	$( "a:contains('Q&A게시판')").on("click", function(){
	 		location.href = "/board/listBoard?boardCategory="+'2';
	 	});	 	 	
		
	 	//=============  자유게시판 Event  처리 =============
	 	$( "a:contains('자유게시판')").on("click", function(){
	 		location.href = "/board/listBoard?boardCategory="+'4';
	 	});	
	 	
	 	//=============  합격후기게시판 Event  처리 =============
	 	$( "a:contains('합격후기게시판')").on("click", function(){
	 		location.href = "/board/listBoard?boardCategory="+'3';
	 	});	 
	 	
	 	//=============  파일공유 게시판 Event  처리 =============
	 	$( "a:contains('파일공유게시판')").on("click", function(){
	 		location.href = "/board/listBoard?boardCategory="+'6';
	 		
	 	});	 	 	
	 	
	 	//=============  관리자 Event  처리 =============
	 	$( "a:contains('관리자')").on("click", function(){
	 		location.href = "/admin/listTotalUser?listType="+'1';
	 	});	 
	 	
	 	//=============  프로필 Event  처리 =============
 	 	$( "a:contains('프로필')").on("click", function(){
	 		//location.href = "/user/getProfile/#myModal";
	 	});	  
	 	
	 	//=============  로그아웃 Event  처리 =============
	 	$( "a:contains('로그아웃')").on("click", function(){
	 		location.href = "/user/logout";
	 	});	 
	 	
	 	//=============  쪽지 Event  처리 =============
	 	$( "a:contains('쪽지')").on("click", function(){
	 		location.href = "/integration/listSendMessage";
	 	});	
	 	
	 	//=============  공부기록 Event  처리 =============
	 	$( "a:contains('공부기록')").on("click", function(){
	 		location.href = "/learningHistory/learningHistoryPage";
	 	});	 
	 	
	 	//=============  나의 스터디 Event  처리 =============
	 	$( "a:contains('나의스터디')").on("click", function(){
	 		location.href = "/study/getMyStudy";
	 	});	 
	 	
	 	//=============  나의 게시글 Event  처리 =============
	 	$( "a:contains('나의게시글')").on("click", function(){
	 		location.href = "/user/list";
	 	});	 
	 	
	 	//=============  바나나 조회 Event  처리 =============
	 	$( "a:contains('바나나조회')").on("click", function(){
	 		location.href = "/banana/listBanana";
	 	});
	 	//=============  비밀번호변경 Event  처리 =============
	 	$( "a:contains('비밀번호 변경')").on("click", function(){
	 		location.href = "/user/Changedpassword";
	 	});	
	 	//=============  회원탈퇴 Event  처리 =============
	 	$( "a:contains('회원탈퇴')").on("click", function(){
	 		location.href = "/user/withdrawreason";
	 	});	 	 	
	
	</script>
	
	<jsp:include page="../userView/getProfile.jsp" />
