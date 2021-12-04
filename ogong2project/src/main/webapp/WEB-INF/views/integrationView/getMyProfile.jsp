<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>          
    
<!-- 프로필 보기 jsp 시작 -->
	<!-- 프로필 보기 모달 영역 -->
	<div class="modal fade" id="getMyProfile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					</button>
				</div>
				<div class="modal-body">
					<div class="container">

						<div class="page-header text-center">
							<h1 id="profile" ></h1>
						</div>

						<input type="hidden" id="email" value="" />
						<!--  히든값 -->
						<hr />
						<div class='text-center'>
							<a id="image">
							
							</a>
						</div>		
						<div class="row">
							<div class="col-xs-4 col-md-2 " style="width:200px;">
								<strong>이메일</strong>
							</div>
							<div class="col-xs-8 col-md-4" id="email2"></div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>닉네임</strong>
							</div>
							<div class="col-xs-8 col-md-4" id="userNickname"></div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>이름</strong>
							</div>
							<div class="col-xs-8 col-md-4" id="name"></div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>생년월일</strong>
							</div>
							<div class="col-xs-8 col-md-4" id="birth"></div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2" >
								<strong>목표와각오</strong>
							</div>
							<div class="col-xs-8 col-md-4" id="goal"></div>

						</div>
						
						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2" >
								<strong>관심사1</strong>
							</div>
							<div class="col-xs-4 col-md-2" id="interest1"></div>
							<div class="col-xs-4 col-md-2" >
								<strong>관심사2</strong>
							</div>							
							<div class="col-xs-4 col-md-2" id="interest2"></div>
							<div class="col-xs-4 col-md-2" >
								<strong>관심사3</strong>
							</div>							
							<div class="col-xs-4 col-md-2" id="interest3"></div>
						</div>


					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
			</div>
		</div>
	</div>
</div>
<!-- 프로필 보기 jsp 끝 -->    