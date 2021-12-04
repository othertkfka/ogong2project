<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
font-size: 15px;
}
body {
    padding-top : 50px;
    padding-left : 50px;
}
#aplabel {
    /* display: inline; */
    padding: .2em .6em .3em;
    font-size: 100%;
    font-weight: 700;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: .25em;
}
</style>
<script type="text/javascript">

	$(function (){
		$("tbody td:nth-child(4)").find('button:contains("승인")').on("click", function(){
			
			email = $(this).val();
			studyNo = ${studyNo};
			$.ajax({
				type: 'GET',
				url: "/studyroom/json/applyParticipation/"+email+"/"+studyNo,
				dataType : "text",
				success: function(data, status){
					
					if(data != null){
						swal("승인 되었습니다.", {      
						    icon: "success" 
						});
					}
				}
			});
			
			$(this).closest("td").html('<span class="label label-info" id="aplabel">승인됨</span>');

			$(this).closest("td").find("button").remove();
			
		}); 
		
		
		$("tbody td:nth-child(4)").find('button:contains("거절")').on("click", function(){
			
			email = $(this).val();
			$(this).closest("tr").remove();
			
			$.ajax({
				type: 'GET',
				url: "/studyroom/json/rejectParticipation/"+email,
				dataType : "text",
				success: function(data, status){
					if(data != null){
						swal("거절 완료.", {      
						    icon: "success" 
						});
	
					}
					
				}
			}); 
		})
			
	});

</script>
</head>
<body>
	 <jsp:include page="../layout/sidebar.jsp" />
	<section id="main-content">
       <section class="wrapper">
	     <form name="detailForm">
	     <div class="container"> 
	     <input type="hidden" value="${studyNo}"/>
	  
	     	<div class="page-header text-default">
	        	<h3 align="left">그룹스터디 참가신청 회원 목록</h3>
	      	</div>
	
			<div class="row">
				
					<div class="col-md-9 text-left">
	            <p class="text-default">전체 ${totalCount} </p>
				<table class="table table-hover table-striped">
	             	<thead>
	             		<tr>
	                    	<th align="center">닉네임</th>
	                        <th align="center">신청동기</th>
	                        <th align="center">각오</th>
	                        <th align="center">승인여부</th>
	                        
	                    </tr>
	                </thead>
	            <tbody>
	            	
	                <c:forEach var="gMember" items="${list}">
		               <tr>
		               	  <td align="left">
		               	  <img class="img-circle" src="/resources/images/ogg.png" width="30px" height="30px" align="">
		               	  ${gMember.member.nickname}
		               	  <input type="hidden"
		                     value="${gMember.member.email}" /></td>
		                  <td align="left">${gMember.participationReason}</td>
		                  <td align="left">${gMember.determination}</td>
		                  <td align="left">
		                  	<c:choose>
		                  		<c:when test="${gMember.approvalFlag == 1}">
		                  			<span class="label label-info" id="aplabel">승인됨</span>
		                  		</c:when>
		                  		<c:when test="${gMember.approvalFlag != 1}">
		                  			<button type="button"  value="${gMember.member.email}" >승인</button>
		                  			<button type="button"  value="${gMember.member.email}">거절</button>
		                  		</c:when>
		                  	</c:choose>
		                 </td>
		               </tr>
		            </c:forEach>
	        				</tbody>
	                  </table>
	            
	      		 </div>	
	 
	                </div>
	          </div> 
	          
	          </form>
	     </section>
	   </section>
</body>

<script class="include" type="text/javascript" src="/resources/javascript/sroomjs/jquery.dcjqaccordion.2.7.js"></script>
<script src="/resources/javascript/sroomjs/jquery.scrollTo.min.js"></script>
<script src="/resources/javascript/sroomjs/jquery.nicescroll.js" type="text/javascript"></script>
<script src="/resources/javascript/sroomjs/jquery.sparkline.js"></script>

<!--common script for all pages-->
<script src="/resources/javascript/sroomjs/common-scripts.js"></script>

<script type="text/javascript" src="/resources/javascript/sroomjs/jquery.gritter.js"></script>
<script type="text/javascript" src="/resources/javascript/sroomjs/gritter-conf.js"></script>


</html>









