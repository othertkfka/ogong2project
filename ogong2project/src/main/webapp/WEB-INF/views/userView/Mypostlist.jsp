<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>


	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 50px;
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
				$("#trRemove").remove();
			
			
		})
		
	 	$( "a:contains('모든 회원 목록')" ).on("click" , function() {
	 		location.href = "/admin/listTotalUser?listType=1";
		});
		
	 	$( "a:contains('탈퇴한 회원 목록')" ).on("click" , function() {
	 		location.href = "/admin/listTotalUser?listType=2";
		});
	 	
	 	$( "a:contains('복귀한 회원 목록')" ).on("click" , function() {
	 		location.href = "/admin/listTotalUser?listType=3";
		});
	 	
	 	$( "a:contains('정지된 회원 목록')" ).on("click" , function() {
	 		location.href = "/admin/listTotalUser?listType=4";
		});	 
	 	
	})
	
	function updateUserRestore(){
		
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
		});
		
		
	}
	
	</script>   	
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../common/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	<div class="contatiner">
	
	<!-- 각 목록에 타입을 지정하여 해당하는 목록을 출력 -->
		<div class="page-header text-info">
				<c:if test="${listType == 1}">
	       				<h3>모든 회원 목록</h3>
	       		</c:if>						
	       		<c:if test="${listType == 2}">
	       				<h3>탈퇴한 회원 목록</h3>
	       		</c:if>
	       		<c:if test="${listType == 3}">
	       				<h3>복귀한 회원 목록</h3>
	       		</c:if>
	       		<c:if test="${listType == 4}">
	       				<h3>정지된 회원 목록</h3>
	       		</c:if>
	    </div>

	    <ul class="nav nav-tabs">
  			<li role="presentation"><a href="#">모든 회원 목록</a></li>
  			<li role="presentation"><a href="#">탈퇴한 회원 목록</a></li>
  			<li role="presentation"><a href="#">복귀한 회원 목록</a></li>
  			<li role="presentation"><a href="#">정지된 회원 목록</a></li>
		</ul>

	    
	    <div class="row">
	    
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
								<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>닉네임</option>
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

		<table class="table table-hover table-striped">
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
							<div class="user">${user.email}</div>
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
	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>
