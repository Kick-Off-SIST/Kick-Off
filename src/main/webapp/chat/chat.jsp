<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.chat-wrapper {
    height: 700px;
    display: flex;
    flex-direction: column;
}
.chat-body {
    flex: 1;
    overflow-y: auto;
    background-color: var(--bg);
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}
.chat-body::-webkit-scrollbar { 
	width: 6px; 
}
.chat-body::-webkit-scrollbar-thumb { 
	background: var(--line); 
	border-radius: 4px; 
}
.message-row { 
	display: flex; 
	width: 100%; 
}
.message {
    padding: 10px 16px;
    border-radius: 18px;
    max-width: 75%;
    font-size: 14.5px;
    line-height: 1.4;
    word-break: break-word;
    box-shadow: none;
}
.my-message-row { 
	justify-content: flex-end; 
}
.my-message { 
    background-color: var(--green); 
    color: #ffffff; 
    border-bottom-right-radius: 4px;
}
.other-message-row { 
	justify-content: flex-start; 
}
.other-message { 
    background-color: var(--surface); 
    color: var(--ink); 
    border: 1px solid var(--line);
    border-bottom-left-radius: 4px; 
}
.system-message { 
    align-self: center;
    background: var(--line);
    color: var(--muted); 
    font-size: 12px; 
    font-weight: 500;
    padding: 4px 12px;
    border-radius: 12px;
}
</style>
</head>
<body>
	<main class="container main-content">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card news-card chat-wrapper">
					<div class="card-header bg-dark text-white d-flex align-items-center p-3 border-0">
						<div class="kickoff-hero-eyebrow mb-0 me-3" style="padding: 4px 10px;">
							<span class="pulse"></span>실시간 채팅
						</div>
						<h5 class="mb-0 fw-bold" style="font-family: 'Black Han Sans', sans-serif; font-size: 22px;">팬 라운지</h5>
					</div>
					<div id="chatBox" class="chat-body">
						<div class="system-message">채팅 서버에 연결 중입니다...</div>
					</div>
					<div class="card-footer bg-white p-3" style="border-top: 1px solid var(--line);">
						<div class="d-flex gap-2">
							<input type="text" id="messageInput" class="form-control focus-ring focus-ring-success" placeholder="메세지를 입력하세요.." style="border-radius: 20px; padding: 10px 20px;">
							<button id="sendBtn" class="btn btn-success fw-bold px-4" style="border-radius: 20px;">전송</button>
						</div>
					</div>
				</div>
	        </div>
	    </div>
	</main>
</body>
<script>
	let websocket
	$(()=>{
		connection()
		$('#sendBtn').on('click',(e)=>{
		send()
		})
		$('#messageInput').on('keydown',function(key){
			if(key.keyCode===13){
				send()
			}
		})
	})
	
	const connection=()=>{
		const host=window.location.host
		websocket=new WebSocket('ws://'+host+'/Kick-Off/chat')
		websocket.onopen=onOpen
		websocket.onmessage=onMessage
		websocket.onclose=onClose
	}
	const onOpen=(event)=>{
		$('#chatBox').html('')
		appendMsgMessage('채팅 서버와 연결되었습니다')
	}
	const onClose=(event)=>{
		appendMsgMessage('채팅 서버와 연결이 해제되었습니다')
	}
	const onMessage=(event)=>{
		let data=event.data
		if(data.substring(0,3)==="my:"){
			appendMyMessage(data.substring(3))
		}
		if(data.substring(0,4)==="you:"){
			appendYouMessage(data.substring(4))
		}
		if(data.substring(0,4)==="msg:"){
			appendMsgMessage(data.substring(4))
		}
	}
	const disConnection=()=>{
		websocket.close
	}
	const scrollToBottom=()=>{
		const $chatBox=$('#chatBox')
		$chatBox.scrollTop($chatBox[0].scrollHeight)
	}
	const appendMyMessage=(msg)=>{
	    $('#chatBox').append(
	        '<div class="message-row my-message-row">'+
	        '<div class="message my-message">'+msg +'</div>'+
	        '</div>'
	    )
	    scrollToBottom()
	}
	const appendYouMessage=(msg)=>{
	    $('#chatBox').append(
	        '<div class="message-row other-message-row">'+
	        '<div class="message other-message">'+msg+'</div>'+
	        '</div>'
	    );
	    scrollToBottom()
	}
	const appendMsgMessage=(msg)=>{
	    $('#chatBox').append('<div class="system-message">'+msg+'</div>');
	    scrollToBottom()
	}
	const send=()=>{
		let $input=$('#messageInput')
		let msg=$input.val()
		if(msg.trim()===''){
			$input.focus()
			return
		}
		websocket.send(msg)
		$input.val('').focus()
	}
</script>
</html>