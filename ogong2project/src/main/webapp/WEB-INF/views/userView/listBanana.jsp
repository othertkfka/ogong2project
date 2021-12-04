<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
 
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://kit.fontawesome.com/e3409dba93.js" crossorigin="anonymous"></script>

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap')
	;

body, table, div, p, th, td {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}
</style>

<script type="text/javascript">
   		$(function(){
  			
		/* var email = ${banana.bananaEmail.email}; */
		}); 	  		
   		
 	var page = 1;
		
	$(window).scroll(function() {
	  	if(((window.innerHeight + window.scrollY) >= document.body.offsetHeight)){
	    	console.log(++page);   	
	  
	
			 $.ajax({
				url : "/banana/json/getlistBanana/",
				type : "POST",
				data : JSON.stringify({currentPage: page}),
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(result) {
				
				var list = result.list;
				var display = "";
				
				if(list.length > 0){
					
					$.each(list, function(index, list){

						if(list.bananaCategory == '1'){
							display += '<div class="card row col-md-10 "style="margin:20px; height:170px;" id="divRemove">'
									+ '<div class="card-body row" style="text-align: center;">'
									+ '<div class="col-4   justify-content-center" >'
									+ '<div class="text-center">'
									+ '<img  src="/resources/images/add.png" alt="User profile picture">'
									+ '</div>'
									+ '</div>'
									+ '<div class="col-8" style="">'
									+ '<div class="form-group" id="deleteBanana" style="text-align: right; margin-bottom: 0.5rem; ">'
									+ '<a>삭제<input type="hidden" value="${banana.bananaNo}" name="bananaNo"/></a>'
									+ '</div>'
									+ '<div class="form-group" style="text-align: left; ">'
									+ list.bananaHistory
									+ '</div>'
									+ '<div class="form-group" style="text-align: left; float:right; display:inline-block; font-size:30px">+'+list.bananaAmount+'</div>'
									+ '<div class="form-group" style="text-align: left; ">'
									+ list.bananaHistoryDate
									+ '</div>'
									+ '</div>'
									+ '</div>'
									+ '</div>';										
						}else if(list.bananaCategory == '2'){
							display += '<div class="card row col-md-10" style="margin:20px; height:170px;" id="divRemove">'
									+ '<div class="card-body row" style="text-align: center;">'
									+ '<div class="col-4   justify-content-center" >'
									+ '<div class="text-center">'
									+ '<img  src="/resources/images/use.png" alt="User profile picture">'
									+ '</div>'
									+ '</div>'
									+ '<div class="col-8" style="">'
									+ '<br>'
									+ '<div class="form-group" style="text-align: left; ">'
									+ list.bananaHistory
									+ '</div>'
							 		+ '<div class="form-group" style="text-align: left; float:right; display:inline-block; font-size:30px">'+list.bananaAmount+'</div>'
									+ '<div class="form-group" style="text-align: left; ">'
									+ list.bananaHistoryDate
									+ '</div>'
									+ '</div>'
									+ '</div>'
									+ '</div>';									
						}
			        <c:if test="${banana.bananaCategory == '1'}">
			            <div class="form-group" style="text-align: left; float:right; display:inline-block; font-size:30px">+${banana.bananaAmount}</div>
		            </c:if>
		            <c:if test="${banana.bananaCategory == '2'}">
			            <div class="form-group" style="text-align: left; float:right; display:inline-block; font-size:30px">${banana.bananaAmount}</div>
		            </c:if>						
						
						
					});
					
					$("#listBanana").append(display);
							
				}
			},
			error:function(request, status, error){
				
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			}); 
			 
		}	 
	});
  	  		

  	</script>

  
</head>
<body class="hold-transition sidebar-mini">

<jsp:include page="../common/toolbar.jsp" />
<div class="wrapper" style="margin-top:20px;">

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Main content -->
    <section class="content container">
        <div class="row" >
          <div class="col-md-4">

            <!-- Profile Image -->
            <div class="card card-primary card-outline" style="margin:20px; border-top:#FFF">
              <div class="card-body box-profile">
              <c:if test="${empty user.userImage}">
                <div class="text-center">                	
                	  <img class="profile-user-img img-fluid img-circle" src="/resources/images/basic.jpg" alt="User profile picture">
                </div>
              </c:if>
              <c:if test="${user.userImage}">
                <div class="text-center">                	
                	  <img class="profile-user-img img-fluid img-circle" src="/resources/images/${user.userImage}" alt="User profile picture">
                </div>
              </c:if>              
		<!-- <img class="profile-user-img img-fluid img-circle" src="/resources/image/basic.jpg" alt="User profile picture"> -->
                <h3 class="profile-username text-center">${banana.bananaEmail.email}</h3>

                <p class="text-muted text-center"></p>

                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item" align="center">
                    <b>일반회원</b>
                  </li>
                  <li class="list-group-item">
                    <b>닉네임</b> <a class="float-right">${user.nickname}</a>
                  </li>                  
                  <li class="list-group-item">
                    <b>바나나포인트</b> <a class="float-right">${user.bananaCount} 바나나</a>
                  </li>
                </ul>
                <a href="#" class="btn btn-primary btn-block" style="background-color:#FFDC3C; border-color:#FFF">
                	<b id="myprofile">
                		내프로필
                	</b>
                </a>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
			    <!-- Main content -->
          <!-- /.col -->
        </div>
    

	<div class="col-md-8" id="listBanana">
	<c:forEach var="banana" items="${list}">
      <div class="card row col-md-10 " style="margin:20px; height:170px;" id="divRemove">
        <div class="card-body row" style="text-align: center;">
          <div class="col-4   justify-content-center" >
          	<c:if test="${banana.bananaCategory == '1'}">
               <div class="text-center">                	
               	  <img  src="/resources/images/add.png" alt="User profile picture">
               </div>
            </c:if>
          	<c:if test="${banana.bananaCategory == '2'}">
               <div class="text-center">                	
               	  <img  src="/resources/images/use.png" alt="User profile picture">
               </div>
            </c:if>            
          </div>
          <div class="col-8" style="">
            <br>
                     
            <div class="form-group" style="text-align: left; ">
              ${banana.bananaHistory} 
            </div>
            
            <c:if test="${banana.bananaCategory == '1'}">
	            <div class="form-group" style="text-align: left; float:right; display:inline-block; font-size:30px">+${banana.bananaAmount}</div>
            </c:if>
            <c:if test="${banana.bananaCategory == '2'}">
	            <div class="form-group" style="text-align: left; float:right; display:inline-block; font-size:30px">${banana.bananaAmount}</div>
            </c:if>
                        
            <div class="form-group" style="text-align: left; ">
              ${banana.bananaHistoryDate}
            </div>
          </div>
        </div>
      </div>
    </c:forEach>  
	</div>

                    <form class="form-inline" name="detailForm">
					  	<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					  <input type="hidden" id="currentPage" name="currentPage" value=""/>
					</form>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>

</div>
<!-- ./wrapper -->




</body>
</html>

