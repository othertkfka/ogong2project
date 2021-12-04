<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<!DOCTYPE html>
<html>
<head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        
    	<!-- Custom fonts for this template-->
   	 	<link href="/resources/css/hanjee/all.min.css" rel="stylesheet" type="text/css">
    	<link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    	<!-- Custom styles for this template-->
    	<link href="/resources/css/hanjee/sb-admin-2.min.css" rel="stylesheet">        

		<!--   jQuery , Bootstrap CDN  -->
		<link rel="stylesheet" href="/resources/css/hanjee/listReport.css" >
		
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>

        #layoutSidenav_content{
        width:1000px;
		height:400px;
		float:left;
		margin:6px;
        }
        
        #hard{
		width:300px;
		height:500px;
		float:right;
		margin:30px;
		margin-top:5.5%;
		}
   	</style>
	<style>
        body {
            padding-top : 5px;
        }       
   	</style>  	
   	<style>
 		@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
		
		body, 
		table, 
		div, 
		p, 
		th, 
		td{
		font-family: 'Do Hyeon', sans-serif;
		}   	
   	</style>
   
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	function fncGetList(currentPage) {
		
		if(${listType == 1}){
			$("#currentPage").val(currentPage)
			$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/admin/listTotalUser?listType=1").submit();
		}
		else if(${listType == 2}){
			$("#currentPage").val(currentPage)
			$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/admin/listTotalUser?listType=2").submit();
		}
		else if(${listType == 3}){
			$("#currentPage").val(currentPage)
			$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/admin/listTotalUser?listType=3").submit();
		}
		else if(${listType == 4}){
			$("#currentPage").val(currentPage)
			$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/admin/listTotalUser?listType=4").submit();
		}
	}
	
	function fncupdateRestoreUser(){
		$('form').attr("method", "POST").attr("action", "admin/updateRestoreUser").submit();
	}
	
	$(function(){
		// 검색
		$("button[name='search']").on("click", function(){
			fncGetList(1);
		});	
		
		//정지한 회원 목록에서만 가능한 회원 복구 기능
		$( "td:contains('복구')").on("click",function(){
				var email = $(this).find('input').val()
				/* alert(email); */
				//fncupdateRestoreUser();
				$.ajax({
				
					url : "/admin/json/updateUserRestore/"+email,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData, status){
						
					}
				})
				alert("복구가 완료되었습니다.")
				$("#trRemove").remove();
				$("#ohmy").remove();
			
			
		})
		
 	 	$("td:nth-child(2)").on("click",function(){
	 		
	 		
	 		var email = $(this).find("input").val();
	 		
	 		
				$.ajax({
				
					url : "/admin/json/adminGetUser/"+email,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					
					success : function(JSONData, status){
						
						
						var display = "<div id='userEmail' style='height: 80px; width: 200px; font-size: 16px;' class='getUser'>"
									+ "<div class='text-center'>"
									+ "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<img  src='/resources/images/"+JSONData.userImage+"'alt='User profile picture'>"
									+ "</div>"
									+ "<div>&nbsp&nbsp&nbsp</div>"
									+ "<div class='text-center'>"+JSONData.email+" 님의 회원 정보입니다.</div>"
									+ "<div>&nbsp&nbsp&nbsp</div>"
									+ "<div> 닉네임   : "+JSONData.nickname+"</div>"
									+ "<div>&nbsp&nbsp&nbsp</div>"
									+ "<div> 가입일자 : "+JSONData.regDate+"</div>"
									+ "<div>&nbsp&nbsp&nbsp</div>";
					    if(JSONData.role == '1'){
							display += "<div> 현재 활동중인 회원 </div>"
							+ "<div>&nbsp&nbsp&nbsp</div>";
						}else if(JSONData.role == '2'){
							display += "<div> 현재 정지중인 회원 </div>"
							+ "<div>&nbsp&nbsp&nbsp</div>";
						}
					    if(JSONData.goal != null){
					    	display += "<div> 목표 : "+JSONData.goal+" </div>"
					    	+ "<div>&nbsp&nbsp&nbsp</div>";
					    }
					    if(JSONData.gender != null){
					    	display += "<div> 성별 : "+JSONData.gender+" </div>"
					    	+ "<div>&nbsp&nbsp&nbsp</div>";
					    }					    
					    	display += "<div> 바나나 수 : "+JSONData.bananaCount+" 바나나</div>";
					    	+ "<div>&nbsp&nbsp&nbsp</div>"
							display += "</div>";
						$('#userEmail').remove();
						$("#ohmy").append(display);
					}
					
				})
	 	});
	 	
	})
	

 
	</script>   	
</head>
<body>

      

      <div>
			<jsp:include page="../common/adminSideBar.jsp" />
			
			
                        <div id="hard" class="col-xl-6 col-lg-5">
                            <div class="card shadow mb-8">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">회원 정보 보기</h6>                                    
                                </div>
                                <!-- Card Body -->
                                <div class="card-body" style="height: 600px; width: 200px;">
                                    <div class="chart-pie pt-4">
										<div id="ohmy">
										</div>                                    
                                    </div>
                                </div>
                            </div>
                        </div>                        
              
            
            
            <div id="layoutSidenav_content"  class="col-xl-7 col-lg-12" >
                    <div class="container-fluid px-1">
			       		<c:if test="${listType == 1}">
			       				<h2 class="mt-5">&nbsp&nbsp모든 회원</h2>
			       		</c:if>
			       		<c:if test="${listType == 2}">
			       				<h2 class="mt-5">&nbsp&nbsp탈퇴한 회원</h2>
			       		</c:if>
			       		<c:if test="${listType == 3}">
			       				<h2 class="mt-5">&nbsp&nbsp복구한 회원</h2>
			       		</c:if>         
			       		<c:if test="${listType == 4}">
			       				<h2 class="mt-5">&nbsp&nbsp정지된 회원</h2>
			       		</c:if> 			       		           	

                        <div class="card mb-3">
			       		<c:if test="${listType == 1}">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                &nbsp&nbsp&nbsp모든 목록을 출력합니다.
                            </div>
			       		</c:if>
			       		<c:if test="${listType == 2}">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                &nbsp&nbsp&nbsp탈퇴한 회원 목록을 출력합니다.
                            </div>
			       		</c:if>
			       		<c:if test="${listType == 3}">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                &nbsp&nbsp&nbsp복구한 회원 목록을 출력합니다.
                            </div>
			       		</c:if>    
			       		<c:if test="${listType == 4}">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                &nbsp&nbsp&nbsp정지된 회원의 목록을 출력합니다.
                            </div>
			       		</c:if>			       		                    

                            
                            
						    <div class="row">
						    
						    	<div class="col-md-6 text-left">
							    	<p class="text-primary">
							    		&nbsp&nbsp전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
							    	</p>
							    </div>
							    
							    <div class="col-md-6 text-right">
								    <form class="form-inline" name="detailForm">
								    
									  <div class="form-group">
									    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									  
									    <select class="form-control" name="searchCondition" >
													<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>이메일</option>
													<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>닉네임</option>
										</select>
									  </div>
									  
									  <div class="form-group">
									    <label class="sr-only" for="searchKeyword">검색어</label>
									    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
									    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
									  </div>
									  
									  <button type="button" name="search" class="btn btn-default">검색</button>
									  
									  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
									  <input type="hidden" id="currentPage" name="currentPage" value=""/>
									  
									</form>
						    	</div>		    
						    	
						    </div>                         
                            
                         
								<table class="table table-bordered">
									<form>
									<thead>
										<tr>
											<th align="center">No</th>
											<th align="center">이메일</th>
											<th align="center">닉네임</th>
											<c:if test="${listType == 1}">
												<th align="left">가입 일자</th>
											</c:if>
											<c:if test="${listType == 2}">
												<th align="left">가입 일자</th>
												<th align="left">탈퇴 일자</th>
												<th align="left">탈퇴 사유</th>
											</c:if>
											<c:if test="${listType == 3}">
												<th align="left">가입 일자</th>
												<th align="left">가입 일자</th>
												<th align="left">복구 일자</th>
											</c:if>
											<c:if test="${listType == 4}">
												<th align="left">정지시작일자</th>
												<th align="left">정지종료일자</th>
												<th align="left">상태</th>
											</c:if>
										</tr>
									</thead>
						
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="user" items="${list}">
											<c:set var="i" value="${ i+1 }" />
											<tr id="trRemove">
												<td align="center">${ i }</td>
												<td align="left">
													<div class="user" name="getUserCheck" value="${user.email}" >
													<input type="hidden" name="email2" value="${user.email}" />
														${user.email}
													</div>
													
												</td>
												<td align="left">
													<div class="user">${user.nickname}</div>
												</td>
												<c:if test="${listType == 1}">
													<td align="left">${user.regDate}</td>
												</c:if>
												<c:if test="${listType == 2}">
													<td align="left">${user.regDate}</td>
													<td align="left">${user.withdrawDate}</td>
													<td align="left">${user.withdrawReason}</td>
												</c:if>
												<c:if test="${listType == 3}">
													<td align="left">${user.regDate}</td>
													<td align="left">${user.restoreDate}</td>
												</c:if>
												<c:if test="${listType == 4}">
													<td align="left">${user.suspendStartDate}</td>
													<td align="left">${user.suspendEndDate}</td>
													<td align="left">복구
														<input type="hidden" name="email" value="${user.email}" />
													</td>
												</c:if>
											</tr>
										</c:forEach>
									</tbody>
									</form>
								</table>
                          
                        </div>

                        <jsp:include page="../common/pageNavigator_new.jsp"/>
                    </div>
                    
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Ogong &copy; Main Project 2021</div>
                            <div>
                                <a href="#">Group Name</a>
                                &middot;
                                <a href="#">Bo Ram Sam Jo</a>
                            </div>
                        </div>
                    </div>
                </footer> 
            </div>
        </div>    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/javascript/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="/resources/javascript/datatables-simple-demo.js"></script>
    </body>
</html>