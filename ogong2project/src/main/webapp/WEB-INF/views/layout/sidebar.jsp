<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/ >

<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'/>
<!--external css-->
<link rel="stylesheet" type="text/css" href="/resources/css/sroomcss/zabuto_calendar.css"/>
<link rel="stylesheet" type="text/css" href="/resources/css/sroomcss/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link href="/resources/css/sroomcss/style.css" rel="stylesheet">
<link href="/resources/css/sroomcss/style-responsive.css" rel="stylesheet">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script src="https://unpkg.com/popper.js/dist/umd/popper.min.js"></script>
<script src="https://unpkg.com/tooltip.js/dist/umd/tooltip.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>



<style type="text/css">
body {
    padding-top : 100px;
    align:left;
}
.fa-bars:before {
    content: "\f0c9";
    color: white;
}

</style>
<script type="text/javascript">

   $(function (){
      
      
      $("#roomMain").on("click", function(){
         self.location = "/studyroom/getStudyRoom?studyNo="+${studyNo}
      });
      
      $("#updateInfo").on("click", function(){
         self.location = "/studyroom/updateStudy?studyNo="+${studyNo}
      });
      
      $("#applyMemberList").on("click", function(){
         self.location = "/studyroom/listParticipation?studyNo="+${studyNo}
      });
      
      $("#MemberList").on("click", function(){
         self.location = "/studyroom/listGSMember?studyNo="+${studyNo}
      });
      
      
      $(".logo").on("click", function(){
         self.location = "/studyroom/getStudyRoom?studyNo="+${studyNo}
      })
      
      $(".logout").on("click", function(){
         self.location = "/integration/mainPage"
      })
   });

</script>


<body>

      <!--header start-->
      <header class="header black-bg">
              <div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
              </div>
            <!--logo start-->
            <a href="#" class="logo"><b>STUDY ROOM</b></a>
            <!--logo end-->
            <div class="top-menu">
               <ul class="nav pull-right top-menu">
                    <li><a class="logout" href="#">메인 화면 이동</a></li>
               </ul>
            </div>
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
              
                   <p class="centered"><img src="/resources/images/ogong2.png" class="img-circle" width="150"></p>
                      <!-- class="active" -->
                  <li class="mt">
                      <a  id="roomMain" href="#">
                          <span>스터디룸 홈</span>
                          <input type="hidden" id="studyNo" value="${studyNo}">
                          <input type="hidden" id="email" value="${user.email}">
                      </a>
                  </li>
            
            <c:if test="${study.studyMaker.email == user.email}"> 
                 
                   <li class="sub-menu">
                      <a href="#" id="updateInfo" >
                          <span>스터디룸 정보 수정</span>
                      </a>
                  </li>
             
                  <li class="sub-menu">
                      <a href="#" id="applyMemberList">
                          <span>스터디룸 참가신청 회원 목록</span>
                      </a>
                  </li>
                  
                  </c:if>
                
                  <li class="sub-menu" >
                      <a href="#" id="MemberList">
                          <span>스터디원 목록</span>
                      </a>
                  </li>
              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->



</body>
</html>