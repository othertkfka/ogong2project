<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!-- 쪽지 보내기 JSP 시작 -->

	<script type="text/javascript">

	
	function fncAddSendMessage2(){
		//Form 유효성 검증

		var sender = $("#sender").val();
		var receiver = $("#receiver").val();
		var messageContents = $("#messageContents2").val();
		

		
		if(receiver == null || receiver.length<1){
			alert("수신자 이메일은 반드시 입력해야 합니다.");
			return;
		}
		
		if(messageContents == null || messageContents.length<1){
			alert("보낼 내용은 반드시 입력해야 합니다.");
			return;
		} 
		
		swal("쪽지를 성공적으로 보냈습니다.","");
		
		$("form[name='addSendMessage2']").attr("method", "POST").attr("action", "/integration/addSendMessage").submit();
		
	}
	
	
	
	$(function(){
		
		// 쪽지 전송
		$( "#btn2" ).on("click" , function() {
			fncAddSendMessage2();
		});
		


	})
	
	
	</script>   	

	

	
	
	
	


<div class="contatiner">
	<!-- Modal 쪽지 보내기-->
	<form name="addSendMessage2" style="text-align='';">
		<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">쪽지 보내기</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form>
						
							<div class="form-group">
								<label>발신자 이메일</label> 
								  <!-- 쪽지목록에서 쪽지를 보낼 때 -->
								  <c:if test="${! empty message.sender.email}">	
									<label type="hidden" class="form-control" id="sender" name="sender.email" 
									maxLength="512" style="height: 30px"> ${message.sender.email} </label>
								  </c:if>
								  <!-- 게시글 상세보기에서 쪽지를 보낼 때 -->
								  <c:if test="${! empty board.writer.email}">	
									<label type="hidden" class="form-control" id="sender" name="sender.email" 
									maxLength="512" style="height: 30px"> ${user.email} </label>
								  </c:if>								  
							</div>
							
							<div class="form-group">
								<label>수신자 이메일</label>
								  <c:if test="${! empty message.sender.email}">
									<input type="text" class="form-control" id="receiver" name="receiver.email" 
									maxLength="512" style="height: 30px" value="" readonly></input> 
								  </c:if>
								  
								  <c:if test="${! empty board.writer.email}">
									<input type="text" class="form-control" id="receiver" name="receiver.email" 
									maxLength="512" style="height: 30px" value="${board.writer.email}" readonly></input>									  		
								  </c:if>								  
							</div>
							
							<div class="form-group">
								<label>내용</label>
								<textarea type="text" class="form-control" id="messageContents2" name="messageContents" maxLength="2048" style="height: 180px" placeholder="내용을 입력해 주세요."></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button id="btn2" class="btn btn-default">전송하기</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>



<!-- 쪽지 보내기 JSP 끝 -->
