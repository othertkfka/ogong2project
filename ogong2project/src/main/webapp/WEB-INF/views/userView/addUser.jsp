<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<!-- Bootstrap -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="/resources/css/adminlte.min.css">
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Respond.js 으로 IE8 에서 반응형 기능을 활성화하세요 (https://github.com/scottjehl/Respond) -->
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="/resources/css/join.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
body, table, div, p, th, td{
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}    
div.mail_wrap,div.id_wrap,div.pw_wrap,div.pwck_wrap{
	
	display:flex;
	justify-content: center;
}
#addBtn:hover {
	color:white;
}

</style>
</head>
<body>

	<br/><br/>

	<div class="wrapper">
		<form id="join_form" method="post">
			<div class="wrap">
				<img id="logo" class="mx-auto d-block" alt="..." src="/resources/images/ogong2.png">
				<div class="mail_wrap">
					<label for="inputEmail" class="col-lg-2 control-label">이메일</label>
	                <div class="col-lg-5">
						<div class="form-control">
							<input class="mail_input" name="email">
						</div>
						<span class="final_mail_ck">이메일을 입력해주세요.</span>
						<span class="mail_input_box_warn"></span>
						<div class="mail_check_wrap">
							<div class="mail_check_input_box" id="mail_check_input_box_false" style="height:50px;">
								<input class="mail_check_input" disabled="disabled" style="height:30px;">
							</div>
							<div class="mail_check_button">
								<span>인증번호 전송</span>
							</div>
							<div class="clearfix"></div>
							<span id="mail_check_input_box_warn"></span>
						</div>
					</div>
				</div>
	 			<div class="id_wrap">
	                <label for="inputNickname" class="col-lg-2 control-label">닉네임</label>
	                <div class="col-lg-5">
						<div class="form-control">
							<input class="id_input"  name="nickname">
						</div>
						<span class="id_input_re_1">사용 가능한 닉네임입니다.</span>
						<span class="id_input_re_2">닉네임이 이미 존재합니다.</span>	
						<span class="final_id_ck">닉네임를 입력해주세요.</span>			
					</div>
				</div>
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
                    <div class="col-lg-offset-2 col-lg-10 text-center">	
						<input type="button" id="addBtn" class="join_button btn-lg" value="가입하기" style="background-color:#fd7e14;">
					</div>
				</div>
			</div>
		</form>
	</div> 
	
<script>

	var code = "";				//이메일전송 인증번호 저장위한 코드
	
	 /* 유효성 검사 통과유무 변수 */
	 var idCheck = false;			// 아이디
	 var idckCheck = false;			// 아이디 중복 검사
	 var pwCheck = false;			// 비번
	 var pwckCheck = false;			// 비번 확인
	 var pwckcorCheck = false;		// 비번 확인 일치 확인
	 var mailCheck = false;			// 이메일
	 var mailnumCheck = false;		// 이메일 인증번호 확인
	
	$(document).ready(function(){
		//회원가입 버튼(회원가입 기능 작동)
		$(".join_button").click(function(){
	
			/* 입력값 변수 */
			var id = $('.id_input').val(); 				// id 입력란
			var pw = $('.pw_input').val();				// 비밀번호 입력란
			var pwck = $('.pwck_input').val();			// 비밀번호 확인 입력란
			var mail = $('.mail_input').val();			// 이메일 입력란
			
			/* 아이디 유효성검사 */
			if(id == ""){
				$('.final_id_ck').css('display','block');
				idCheck = false;
			}else{
				$('.final_id_ck').css('display', 'none');
				idCheck = true;
			}
			
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
	
			/* 이메일 유효성 검사 */
			if(mail == ""){
				$('.final_mail_ck').css('display','block');
				mailCheck = false;
			}else{
				$('.final_mail_ck').css('display', 'none');
				mailCheck = true;
			}		
			
			/* 최종 유효성 검사 */
			if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&mailCheck&&mailnumCheck ){
	
				$("#join_form").attr("action", "/user/addUser");
				$("#join_form").submit();		
				
			}else{
				swal("필수 정보를 입력해주세요","","warning");
				return false;
			}	

			
	
		});
	});
	
	//닉네임 중복검사
	$('.id_input').on("propertychange change keyup paste input", function(){
	
		/* console.log("keyup 테스트"); */
		
		var nickname = $('.id_input').val();			// .id_input에 입력되는 값
		var data = {nickname : nickname}				// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
		
		$.ajax({
			type : "post",
			url : "/user/idCheck",
			data : data,
			success : function(result){
				// console.log("성공 여부" + result);
				if(result != 'fail'){
					$('.id_input_re_1').css("display","inline-block");
					$('.id_input_re_2').css("display", "none");	
					idckCheck = true;
				} else {
					$('.id_input_re_2').css("display","inline-block");
					$('.id_input_re_1').css("display", "none");
					idckCheck = false;
				}	
			}// success 종료
		}); // ajax 종료	
	
	});// function 종료
	
	/* 인증번호 이메일 전송 */
	$(".mail_check_button").click(function(){
		
		var email = $(".mail_input").val();			// 입력한 이메일
		var cehckBox = $(".mail_check_input");		// 인증번호 입력란
		var boxWrap = $(".mail_check_input_box");	// 인증번호 입력란 박스
		var warnMsg = $(".mail_input_box_warn");	// 이메일 입력 경고글
		
		/* 이메일 형식 유효성 검사 */
		if(mailFormCheck(email)){
			warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
			warnMsg.css("display", "inline-block");
		} else {
			warnMsg.html("올바르지 못한 이메일 형식입니다.");
			warnMsg.css("display", "inline-block");
			return false;
		}	
		
		$.ajax({
			
			type:"GET",
			url:"mailCheck?email=" + email,
			success:function(data){
				
				//console.log("data : " + data);
				cehckBox.attr("disabled",false);
				boxWrap.attr("id", "mail_check_input_box_true");
				code = data;
				
			}
					
		});
		
	});
	
	/* 인증번호 비교 */
	$(".mail_check_input").blur(function(){
		
		var inputCode = $(".mail_check_input").val();		// 입력코드	
		var checkResult = $("#mail_check_input_box_warn");	// 비교 결과 	
		
		if(inputCode == code){							// 일치할 경우
			checkResult.html("인증번호가 일치합니다.");
			checkResult.attr("class", "correct");		
			mailnumCheck = true;
		} else {											// 일치하지 않을 경우
			checkResult.html("인증번호를 다시 확인해주세요.");
			checkResult.attr("class", "incorrect");
			mailnumCheck = false;
		}	
		
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
		
		
	});
	
	
	
	
	
	 /* 입력 이메일 형식 유효성 검사 */
	 function mailFormCheck(email){
		var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return form.test(email);
	}

</script>
</body>

</html>