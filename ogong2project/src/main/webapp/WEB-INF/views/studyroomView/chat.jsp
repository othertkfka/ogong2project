<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<style type="text/css">
button,button:hover{border:none;color:#fff;padding:10px}.chat__messages,.chat__sidebar ul{list-style-type:none}*{box-sizing:border-box;margin:0;padding:0;font-family:HelveticaNeue-Light,"Helvetica Neue Light","Helvetica Neue",Helvetica,Arial,"Lucida Grande",sans-serif;font-weight:300;font-size:.95rem}li,ul{list-style-position:inside}h3{font-weight:600;text-align:center;font-size:1.5rem}button{background:#265f82;cursor:pointer;transition:background .3s ease}button:hover{background:#1F4C69}button:disabled{cursor:default;background:#698ea5}.centered-form{display:flex;align-items:center;height:100vh;width:100vw;justify-content:center;background:-moz-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:-webkit-gradient(linear,left top,right bottom,color-stop(0,rgba(49,84,129,1)),color-stop(100%,rgba(39,107,130,1)));background:-webkit-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:-o-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:-ms-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:linear-gradient(325deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%)}.centered-form__form{background:rgba(250,250,250,.9);border:1px solid #e1e1e1;border-radius:5px;padding:0 20px;margin:20px;width:230px}.form-field{margin:20px 0}.form-field>*{width:100%}.form-field label{display:block;margin-bottom:7px}.form-field input,.form-field select{border:1px solid #e1e1e1;padding:10px}.chat{display:flex}.chat__sidebar{overflow-y:scroll;width:260px;height:100vh;background:-moz-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:-webkit-gradient(linear,left top,right bottom,color-stop(0,rgba(49,84,129,1)),color-stop(100%,rgba(39,107,130,1)));background:-webkit-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:-o-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:-ms-linear-gradient(125deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%);background:linear-gradient(325deg,rgba(39,107,130,1) 0,rgba(49,84,129,1) 100%)}.chat__footer,.chat__sidebar li{background:#e6eaee;padding:10px}.chat__sidebar h3{color:#e6eaee;margin:10px 20px;text-align:left}.chat__sidebar li{border:1px solid #e1e1e1;border-radius:5px;margin:10px}.chat__main{display:flex;flex-direction:column;height:100vh;width:100%}.chat__messages{flex-grow:1;overflow-y:scroll;-webkit-overflow-scrolling:touch;padding:10px}.chat__footer{display:flex;flex-shrink:0}.chat__footer form{flex-grow:1;display:flex}.chat__footer form *{margin-right:10px}.chat__footer input{border:none;padding:10px;flex-grow:1}.message{padding:10px}.message__title{display:flex;margin-bottom:5px}.message__title h4{font-weight:600;margin-right:10px}.message__title span{color:#999}@media (max-width:600px){*{font-size:1rem}.chat__sidebar{display:none}.chat__footer{flex-direction:column}.chat__footer form{margin-bottom:10px}.chat__footer button{margin-right:0}}
   	</style>
    <title>chat</title>
</head>
<body>
    <body class="chat">

    <div class="chat__sidebar">
      <h3>유저목록</h3>
      <div id="users"></div>
    </div>

    <div class="chat__main">
      <ol id="messages" class="chat__messages"></ol>

      <div class="chat__footer">
        <form id="message-form">
          <input type="hidden" id="studyNo" value="${studyNo}">
          <input type="hidden" id="email" value="${user.email}">
          <input id="messageInput" name="message" type="text" placeholder="Message" autofocus autocomplete="off"/>
          <button id="submit-btn">전송</button>
        </form>
      </div>
    </div>



  </body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="https://ogong-chat.herokuapp.com/socket.io-client/socket.io.js"></script>
<script type="text/javascript">
	

	
	var socket = io("https://ogong-chat.herokuapp.com/");
	var studyNo= $("#studyNo").val();
	var email = $("#email").val();
	
	
	function scrollToBottom() {
		let messages = document.querySelector('#messages').lastElementChild;
		messages.scrollIntoView();
	}
	
	socket.on('connect', function() {
		let data = {studyNo :studyNo,
					email :email};
		socket.emit('join', data, function(err) {
			if(err){
				alert(err);
			    window.location.href = '/';
			}else {
			    console.log('No Error');
			}
		})
	});

	
	
	socket.on('disconnect', function() {
		console.log('disconnected from server.');
		
		
	});

	socket.on('updateUsersList', function (users) {
		
		$('#users ol').remove();
		let ol = document.createElement('ol');
		
		users.forEach(function (user) {
			let li = document.createElement('li');
		    li.innerHTML = user;
		    ol.appendChild(li);
		});

		let usersList = $('#users');
		usersList.innerHTML = "";
		usersList.append(ol);
		})
		

		socket.on('newMessage', function(message) {
			const formattedTime = moment(message.createdAt).format('LT');
		  	const html = 
		  	'<li class="message"><div class="message__title"><h4>'
		  	+message.from+
		  	'</h4><span>'
		  	+formattedTime+
		  	'</span></div><div class="message__body"><p>'
		  	+message.text+
		  	'</p></div></li>';
		

		const div = document.createElement('div');
		div.innerHTML = html;

		$('#messages').append(div);
		scrollToBottom();
		
	});
		
		
	$('#submit-btn').on('click', function(e) {
		e.preventDefault();
		socket.emit("createMessage", {
		text: $('#messageInput').val()
		}, function() {
			$('#messageInput').val('').focus();
			
		});
	});
</script>  
</body>
</html>