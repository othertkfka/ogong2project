<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/css/adminlte.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="/resources/javascript/bootstrap.bundle.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
	<link rel="stylesheet" href="/resources/css/join.css">

<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet" href="/resources/css/log.css">


<html>
    	<script type="text/javascript">
		//============= "로그인"  Event 연결 =============
		$( function() {
	
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#login").on("click" , function() {
				var email=$("input:text").val();
				var pw=$("input:password").val();
				
				
				if(email == null || email.length <1) {
					swal('ID를 입력해주세요.','','warning');
					$("#email").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					swal('패스워드를 입력해주세요.','','warning');
					$("#password").focus();
					return;
				}
				
				$("#login_form").attr("method","POST").attr("action","loginView").attr("target","_parent").submit();
			}); 
		});	
		
		
		
	</script>	
    
    
<head>
<title>My Awesome Login Page</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap');
body, table, div, p, th, td{
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}
#mail_check_button:hover,#addBtn:hover,#cancelBtn:hover {
	color:white;
}
</style>	
</head>
<!--Coded with love by Mutiullah Samim-->
<body>
	<div class="container h-100">
	
		<div class="d-flex justify-content-center h-100">
			<div class="user_card">
				<div class="d-flex justify-content-center">
					<div class="brand_logo_container">
						<img src="/resources/images/oglogo.png" class="brand_logo" alt="Logo">
					</div>
				</div>
				<div class="d-flex justify-content-center form_container">
					<!-- 로그인 form -->
					<form id="login_form">
						<div class="input-group mb-3">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
							<input type="text" name="email" id="email"
								class="form-control input_user" value="" placeholder="email">
						</div>
						<div class="input-group mb-2">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input type="password" name="password" id="password"
								class="form-control input_pass" value="" placeholder="password">
						</div>

						<div class="d-flex justify-content-center mt-3 login_container">
							<button type="button" name="button" id="login"
								class="btn login_btn">Login</button>
						</div>
					</form>
				</div>

				<div class="mt-4">
					<div class="d-flex justify-content-center links">
						Don't have an account? 
						<a href="#" class="ml-2" data-toggle="modal" data-target="#myModal">회원가입</a>
					</div>
					<div class="d-flex justify-content-center links">
						<a href="getPassword">Forgot your password?</a>
					</div>
				</div>
				
			</div>
			<!-- user_card End -->
		</div>
		
		
		<!-- 회원가입 modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header" style="background-color:#5bafff;">
						<h4 class="modal-title">회원가입</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    </div>
					
					<div class="modal-body">
						<!-- 회원가입 form -->
						<form id="join_form" method="post">
							<div class="wrap">
								<div class="mail_wrap">
									<label for="inputEmail" class="col-lg-2 control-label">이메일</label>
					                <div class="col-lg-5">
										<div class="form-control">
											<input class="mail_input" name="email">
										</div>
										<span class="mail_input_re_1">사용 가능한 이메일입니다.</span>
										<span class="mail_input_re_2">이메일이 이미 존재합니다.</span>	
										<span class="final_mail_ck">이메일을 입력해주세요.</span>
										<span class="mail_input_box_warn"></span>
										<!-- <div class="mail_check_wrap"> //이메일 인증용
											<input class="mail_check_input_box" id="mail_check_input_box_false" style="height:40px;">
												
											<div class="mail_check_button" style="width:100px;">
												<span><input type="button" id="mail_check_button" class="btn" value="인증번호 전송" style="background-color:#88b3fa;"></span>
											</div>
											<div class="clearfix"></div>
											<span id="mail_check_input_box_warn"></span>
										</div> -->
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
							        <label for="inputPassword" class="col-lg-2 control-label">비밀번호</label>
					                <div class="col-lg-5">
										<div class="form-control">
											<input class="pw_input" type="password" name="password">
										</div>
										<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
									</div>
								</div>
								<div class="pwck_wrap">
									<label for="inputPasswordCheck" class="col-lg-2 control-label">비밀번호 확인</label>
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
				                    <div class="col-lg-offset-2 col-lg-10 text-left">	
										<input type="button" id="addBtn" class="btn" value="가입하기" style="background-color:#88b3fa;">
										<input type="button" id="cancelBtn" class="btn" value="취소" data-dismiss="modal" style="background-color:#88b3fa;">
									</div>
								</div>
							</div>
						</form>	
					</div>
					<!-- modal-body End -->
				</div>
				<!-- modal content End -->
			</div>
		</div>
		<!-- 회원가입 modal End -->
		
	</div>
	<!--  container End -->
</body>

<script>

	 var code = "";				//이메일전송 인증번호 저장위한 코드
	
	 /* 유효성 검사 통과유무 변수 */
	 var idCheck = false;			// 아이디
	 var idckCheck = false;			// 아이디 중복 검사
	 var pwCheck = false;			// 비번
	 var pwckCheck = false;			// 비번 확인
	 var pwckcorCheck = false;		// 비번 확인 일치 확인
	 var mailCheck = false;			// 이메일
	 var mailckCheck = false;       // 이메일 중복 검사
	 //var mailnumCheck = false;		// 이메일 인증번호 확인
	
	$(document).ready(function(){
		//회원가입 버튼(회원가입 기능 작동)
		$("#addBtn").click(function(){
	
			/* 입력값 변수 */
			var mail = $('.mail_input').val();			// 이메일 입력란
			var id = $('.id_input').val(); 				// id 입력란
			var pw = $('.pw_input').val();				// 비밀번호 입력란
			var pwck = $('.pwck_input').val();			// 비밀번호 확인 입력란
			
			
			/* 이메일 유효성 검사 */
			if(mail == ""){
				$('.final_mail_ck').css('display','block');
				mailCheck = false;
			}else{
				$('.final_mail_ck').css('display', 'none');
				mailCheck = true;
			}
			
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
	
			
			/* 최종 유효성 검사 */
			if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&mailCheck ){
				$("#join_form").attr("action", "/user/addUser");
				$("#join_form").submit();		
			}else{
				swal("필수 정보를 입력해주세요","","warning");
				return false;
			}	

		});
	});
	
	//이메일 중복검사
	$('.mail_input').on("propertychange change keyup paste input", function(){
	
		/* console.log("keyup 테스트"); */
		
		var email = $('.mail_input').val();			// .id_input에 입력되는 값
		var data = {email : email}				// '컨트롤에 넘길 데이터 이름' : '데이터(.mail_input에 입력되는 값)'
		var warnMsg = $(".mail_input_box_warn");	// 이메일 입력 경고글
		
		// 이메일 형식 유효성 검사
		if(mailFormCheck(email)){
			//warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
			warnMsg.css("display", "none");
		} else {
			warnMsg.html("올바르지 못한 이메일 형식입니다.");
			warnMsg.css("display", "inline-block");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "/user/mailCheck",
			data : data,
			success : function(result){
				// console.log("성공 여부" + result);
				if(result != 'fail'){
					$('.mail_input_re_1').css("display","inline-block");
					$('.mail_input_re_2').css("display", "none")	;	
					mailckCheck = true;
				} else {
					$('.mail_input_re_2').css("display","inline-block");
					$('.mail_input_re_1').css("display", "none");
					mailckCheck = false;
				}	
			}// success 종료
		}); // ajax 종료	
	
	});// function 종료
	 
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
	/* $("#mail_check_button").click(function(){
		
		var email = $(".mail_input").val();			// 입력한 이메일
		var cehckBox = $(".mail_check_input_box");		// 인증번호 입력란
		var boxWrap = $(".mail_check_input_box");	// 인증번호 입력란 박스
		var warnMsg = $(".mail_input_box_warn");	// 이메일 입력 경고글
		
		// 이메일 형식 유효성 검사
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
		
	}); */
	
	/* 인증번호 비교 */
	/* $(".mail_check_input_box").blur(function(){
		
		var inputCode = $(".mail_check_input_box").val();		// 입력코드	
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
		
	}); */
	
	
	/* 비밀번호 확인 일치 유효성 검사 */
	
	$('.pwck_input').on("propertychange change keyup paste input", function(){
		
		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		$('.final_pwck_ck').css('display', 'none');
		
		if(pw == pwck){
			$('.pwck_input_re_1').css('display','block'); //보임
			$('.pwck_input_re_2').css('display','none');  //안보임
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

</html> 
