<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<!-- ==============================================신고 function Start=============================================== -->
<script type="text/javascript">


	function fncAddReport2(){
		
		var receiveReporter = $("#receiveReporter2").val();			
		var reportReason = $("#reportReason2").val();
		var commentContents = $("input[name='reportComment.commentContents']").val();
		var reportComment = $("input[name='reportComment.commentNo']").val();
		
		
		

		
		if(reportReason == null || reportReason.length<1){
			alert("신고 사유는 반드시 입력해야 합니다.");
			return;
		} 
		
		alert("신고가 완료되었습니다.");
		
		$("form[name='addReport']").attr("method", "POST").attr("action", "/admin/addReport").submit();
		
	}
	
	$(function(){
		// 신고
		$( "#btn5" ).on("click" , function() {
			fncAddReport2();
		});
		
	})
	
	
	</script>
<!-- ==============================================신고 function END=============================================== -->	
	
	
<!-- ==================================================Modal 신고 하기 Start===================================================-->
<div class="contatiner">
	
	<form name="addReport">
	  	 
		<%-- <input type="hidden" class="receiveReporter" name="receiveReporter" value="${report.receiveReporter.email}"/> --%>
		<div class="modal fade" id="myModalReport2" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">신고 하기</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form>
						
		<!-- 필수) 작성자 이메일은 기본적으로 나옴 신고 받는 사람의 이메일 -->
						<div class="form-group" >
							<label>댓글 작성자 이메일</label>
							<input type="text" class="form-control" id="receiveReporter2" name="receiveReporter.email" 
							maxLength="512" style="height: 30px" value="" ></input>						
						</div>
						<input type="hidden" id="commentNo" name="reportComment.commentNo" val="">	
		<!-- 댓글 입력 -->				
						<div class="form-group" >
							<label>댓글 내용</label>
							<input type="text" class="form-control" id="commentContents2" name="reportComment.commentContents" 
							maxLength="512" style="height: 30px" value="" readonly></input>					
						</div>						
		<!-- 구분 END -->	
		<!-- 필수) 신고사유 -->															
						<div class="form-group">
							<label>신고사유</label>
							<textarea type="text" class="form-control" id="reportReason2" name="reportReason" maxLength="2048" style="height: 180px" placeholder="신고사유를 입력해 주세요."></textarea>
						</div>
		<!-- 신고사유 END -->
					</form>
				</div>
					<div class="modal-footer">
						<button id="btn5" class="btn btn-default">신고하기</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- ==================================================Modal 신고 하기 END===================================================-->


