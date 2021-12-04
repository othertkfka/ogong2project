<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="en">
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

	<script type="text/javascript">
	function fncGetList(currentPage) {
		/* alert($("#searchCondition").val()); */
		$("#currentPage").val(currentPage)
		$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/admin/listUserReport").submit();
	}
	
	
	function fncupdateUserSuspend(email){
		
		
		$("form[name='updateSuspendUser']").attr("method", "POST").attr("action", "/admin/updateSuspendUser").submit();
		}
		
		$('.radio-value').on('click', function() {
		    var suspendType = $('.radio-value:checked').val(); // 체크된 Radio 버튼의 값을 가져옵니다.
		    
		    if ( suspendType == '1' ) {
		        $('.radio-value-detail').attr('suspendType', 1);
		        $('.radio-value-detail').focus(); 
		    } else if ( suspendType == '2' ) {
		        $('.radio-value-detail').attr('suspendType', 2); 
		        $('.radio-value-detail').focus();
		    } else if ( suspendType == '3' ) {
		        $('.radio-value-detail').attr('suspendType', 3);
		        $('.radio-value-detail').focus(); 
		    }
		});	

	
	$(function(){
	
		// 정지 
 		$( "#btn1" ).on("click" , function() {
			var email = $('#email2').val()
			/* alert(email);	 */		
			fncupdateUserSuspend(email)
			alert("정지가 완료되었습니다.")
		}); 
		
		// 기억해_
	    $('tr td:nth-child(6)').on("click", function(){
	    	$('#email').val($(this).find('input').val());	    	
	    })
		
		
 		$('#modal').modal("hide"); //닫기 
		 
		$('#modal').modal("show"); //열기 
		
		
		$("button[name='search']").on("click", function(){
			fncGetList(1);
		});	
		
		
	/*$("td:contains('정지')").on("click", function(){
			 fncupdateUserSuspend() 
			var email = $(this).find('input').val()
			alert(email);
			location.href = "/admin/updateSuspendUser?receiveReporter="+$(this).attr('email');
		});*/ 
		
	})
		
	
	</script>        
        
    </head>
    
<body class="contatiner">

      

            
			<jsp:include page="../common/adminSideBar.jsp" />
			
         	
              
            
            
            <div id="layoutSidenav_content" >
                    <div class="container-fluid px-1">
                        <h2 class="mt-5">&nbsp&nbsp신고된 사용자</h2>

                        <div class="card mb-3">
                            <div class="card-header">
                                &nbsp&nbsp&nbsp<i class="fas fa-table me-1"></i>
                                신고된 사용자의 목록을 출력합니다.
                            </div>
                            
						    <div class="row">
						    
						    	<div class="col-md-6 text-left">
							    	<p class="text-primary">
							    		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
							    	</p>
							    </div>
							    
							    <div class="col-md-6 text-right">
								    <form class="form-inline" name="detailForm">
									  <div class="form-group" id="search">
									    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp

									    <select class="form-control" name="searchCondition" align="right">
													<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>이메일</option>
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
                            
                         
						    <table class="table table-bordered"  >
						    
						    	<thead>
						    		<tr>	       		
						       					<th align="center">No</th>
						       					<th align="center">신고한 유저 이메일</th>
						       					<th align="left">신고사유</th>
						       					<th align="left">신고당한 유저 이메일</th>
						       					<th align="left">신고일자</th>
						       					<th align="left">정지</th>
						    		</tr>
						    	</thead>
						    	<tbody class="ct_list_pop">
							 	 	<c:set var="i" value="0" />
							  		<c:forEach var="report" items="${list}">
							  			<c:set var="i" value="${ i+1 }" />
							  			<tr>
							  			<td align="center">${ i }</td>
							  			<td align="left">${report.sendReporter.email}</td>
							  			<td align="left">${report.reportReason}</td>
							  			<td align="left">${report.receiveReporter.email}</td>
							  			<td align="left">${report.reportDate}</td>
							  			<td align="left" email="${report.receiveReporter.email}">
							  			<c:if test="${report.receiveReporter.condition eq '1'}">
											<button class="btn btn-primary" data-toggle="modal" data-target="#myModal">
											  <input type="hidden" name="email2" id="email2" value="${report.receiveReporter.email}"/>
											   정지
											</button>
							  			</c:if>
							  			<c:if test="${report.receiveReporter.condition eq '2'}">
							  				정지완료
							  			</c:if>
							  			</td>
							  			</tr>
							  		</c:forEach>
						    	</tbody>
						    	
						    </table>
                          
                        </div>
                        <jsp:include page="../common/pageNavigator_new.jsp"/>
                    </div>
                    
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2021</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer> 
            </div>
            
	    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
		        <h4 class="modal-title" id="myModalLabel">사용자 정지</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal" method="post" name="updateSuspendUser">
		        	<input type="hidden" id="email" name="email" value="${report.receiveReporter.email}"/>   
		        	<div class = "form-group">
					  <fieldset align="center">
			   				 <legend>정지 일자 선택 </legend>
			   				 <label for="radio-1">&nbsp7일</label>
			    			 <input type="radio" class="radio-value" name="suspendType" id="suspendType" value="1">
			   				 <label for="radio-2">&nbsp30일</label>
			   				 <input type="radio" class="radio-value" name="suspendType" id="suspendType" value="2">
			   				 <label for="radio-3">&nbsp영구정지</label>
			    			 <input type="radio" class="radio-value" name="suspendType" id="suspendType" value="3">
			  			</fieldset>
		        	</div>
		        </form>
		      </div>
		      <div class="modal-footer">
		      	<button id="btn1" class="btn btn-default" >정 지</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫 기</button>
		      </div>
		    </div>
		  </div>
		 </div>     .
		        
        
        
        
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/javascript/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="/resources/javascript/datatables-simple-demo.js"></script>
    </body>
</html>