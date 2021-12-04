<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="/resources/css/join.css">

<style >
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
body, table, div, p, th, td{
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}
div.pw_wrap,div.pwck_wrap,div.form-group{
	
	display:flex;
	justify-content: center;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/toolbar.jsp" />
	<div class="container">
		<br>
		<br/>

		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">

			<h1 class="text-center" style="background-color:#7ec6ff;">회원 탈퇴</h1>
			<br>

			<input type="hidden" name="email" value="${user.email}" />
			<!--  히든값 -->

			<div class="pw_wrap">
		        <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-5">
					<div class="form-control">
						<input class="pw_input" type="password" name="password">
					</div>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
				</div>
			</div>

			<div class="pwck_wrap">
				<label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
                <div class="col-lg-5">
					<div class="form-control">
						<input class="pwck_input" type="password">
					</div>
					<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
					<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
					<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</div>
			</div>
			<br>
			<div class="form-group">
				<label for="password2" class="col-sm-offset-1 col-sm-3 control-label">탈퇴 사유</label>
				<div class="col-sm-4">
					<select class="form-control" name="withdrawreason">
						<option value="이용가능한 서비스 부족">이용가능한 서비스 부족</option>
						<option value="불편한 인터페이스">불편한 인터페이스</option>
						<option value="적은 사용자">적은 사용자</option>
						<option value="접근성 부족">접근성 부족</option>
						<option value="기타">기타</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-2 text-center">
					<button type="button" id="btn1" class="btn btn-info" style="background-color:#88b3fa;">회원탈퇴</button>
					<a class="btn btn-info btn" href="/" role="button" style="background-color:#88b3fa;">취&nbsp;소</a>
				</div>
			</div>
		</form>
	</div>

</body>
<script type="text/javascript">

	var pwCheck = false;			// 비번
	var pwckCheck = false;			// 비번 확인

	$(function(){
		$ ( "#btn1").on("click", function(){
			
			var pw = $('.pw_input').val();				// 비밀번호 입력란
			var pwck = $('.pwck_input').val();			// 비밀번호 확인 입력란
			
			/* 비밀번호 유효성 검사 */
			if(pw == ""){
				$('.final_pw_ck').css('display','block');
				pwCheck = false;
			}else{
				$('.final_pw_ck').css('display', 'none');
				pwCheck = true;
			}
			
			/* 비밀번호 확인 유효성 검사 */
			if(pwck == ""){
				$('.final_pwck_ck').css('display','block');
				pwckCheck = false;
			}else{
				$('.final_pwck_ck').css('display', 'none');
				pwckCheck = true;
			}
			
			
			/* 최종 유효성 검사 */
			if(pwCheck&&pwckCheck){
				
				if(pwck == ${user.password}){
					$("form").attr("method","POST").attr("action","/user/withdrawreason").submit();	
				}else{
					swal("비밀번호가 틀렸습니다.","","error");
					return false;
				}
		
			}else{
				swal("비밀번호를 입력해주세요.","","warning");
				return false;
			}
			
		});
		
	});
	
	
/* 비밀번호 확인 일치 유효성 검사 */
	
	$('.pwck_input').on("propertychange change keyup paste input", function(){
		
		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		$('.final_pwck_ck').css('display', 'none');
		
		if(pw == pwck){
			$('.pwck_input_re_1').css('display','block');
			$('.pwck_input_re_2').css('display','none');
			pwckcorCheck = true;
		}else{
			$('.pwck_input_re_1').css('display','none');
			$('.pwck_input_re_2').css('display','block');
			pwckcorCheck = false;
		}
		
		
	});/* 비밀번호 확인 일치 유효성 검사 */
	
	$('.pwck_input').on("propertychange change keyup paste input", function(){
		
		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		$('.final_pwck_ck').css('display', 'none');
		
		if(pw == pwck){
			$('.pwck_input_re_1').css('display','block');
			$('.pwck_input_re_2').css('display','none');
			pwckcorCheck = true;
		}else{
			$('.pwck_input_re_1').css('display','none');
			$('.pwck_input_re_2').css('display','block');
			pwckcorCheck = false;
		}
		
		
	});
	
</script>
</html>