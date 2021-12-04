<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script src="https://code.jquery.com/jquery-3.2.1.js"></script> 

<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');

body, table, div, p, th, td{
font-family: 'Do Hyeon', sans-serif;
font-size: 15px;
}
</style>
<script type="text/javascript">


</script>
</head>
<body>
     
     <jsp:include page="../layout/sidebar.jsp"/>
     
      <section id="main-content">
          <section class="wrapper">
		     <div class="container"> 
		     <input type="hidden" value="${studyNo}"></intput>
		  
		     	<div class="page-header text-default">
		        	<h3 align="left">그룹스터디 회원 목록</h3>
		      	</div>
		
				<div class="row">
						<div class="col-md-9 text-left">
					<table class="table table-hover table-striped">
		             	<thead>
		             		<tr>
		                    	<th align="center">닉네임</th>
		                    	<th align="left">역 할
		                        <th align="left">출석률</th>  
		                        <th align="left">각 오</th>
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
			                  <td align="left">
								<c:if test="${gMember.studyRole =='1'}">
									스터디리더
								</c:if>
								<c:if test="${gMember.studyRole =='2'}">
									스터디원
								</c:if>
							  </td>
			                  <td align="left">
			                  	${gMember.attendanceRate} %
			                  	<progress value="${gMember.attendanceRate}" max="100"></progress>
			                  </td>
			                  
			                  <td align="left">${gMember.determination}</td>
			               </tr>
			            </c:forEach>
		        	</tbody>
		            </table>
		            
		      		</div>	
		          </div>
		        </div> 
        </section>
     </section>
</body>
</html>