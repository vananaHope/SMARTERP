<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="${path}/erpBt/css/footer.css" rel="stylesheet">
<!-- Footer -->
          <footer class="sticky-footer bg-ghostwhite">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; ABC Mart 2023</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->
    
    
    
    <!-- Chatting -->
	<div class="chat-button" id="chatButton">
		<i class="fa-solid fa-comments fa-beat"></i>
		
	</div>
	<div class="chat-box" id="chatBox">
		<div class="chat-header">
			실시간 채팅(<span id="userCnt">0</span>)
			<button class="close-button" id="closeButton">&times;</button>
		</div>
		<div class="chat-messages" id="chatMessages">
			<!-- 채팅 메시지들이 여기에 추가됨 -->
		</div>
		<input type="text" id="chatInput" placeholder="메시지를 입력하세요...">
	</div>
	
	
	
	
	
	<!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" href="/loginForm/logout">로그아웃</a>
                </div>
            </div>
        </div>
    </div>
    <script>
    var wsocket;
    var members = []
    var idVal;
    var alignOpt = "left";
    $(document).ready(function(){
    	$(".chat-button").click(function(){
    		var option = 'width=800,height=520,menubar=no,scrollbars=no,'
    		option += 'resizeable=no,location=no,directories=no,titlebar=no,'
    		option += 'top=1000,left=2000'
    		window.open("chatting","chat",option)
    		//conn();
    	})
    	$("#chatInput").keyup(function(){
    		if(event.keyCode==13){
    			sendMsg();
    		}
    	})
    	$("#closeButton").click(function(){
			if(idVal!=""){
				if(confirm("채팅이 종료됩니다.")){
					// 
					//alert("종료처리 프로세스진행..~~")
					wsocket.send(idVal+":연결을 종료하였습니다.")
					wsocket.close() // afterConnectionClosed 핸들러에 연동
					// 대화내용 삭제
					clearMessages();
					toggleChat();
				}
			}
	    })
    })
    function conn(){
    	// (@@점)이름
    	idVal = '(${employee.store_name})${employee.employee_name}'
    	console.log(idVal)
    	
    	wsocket = new WebSocket("ws://"+location.host+"/chat-ws");
    	//wsocket = new WebSocket("ws:122.99.163.86:5077/chat-ws");
    	wsocket.onopen = function(evt){
    		console.log(evt)
    		wsocket.send(idVal+":접속하셨습니다.")
    	}
    	wsocket.onmessage=function(evt){
    		console.log("conn: "+evt.data)
    		revMsg(evt.data)
    	}
    	return true;
    	
    }
    function sendMsg(){
    	wsocket.send(idVal+":"+$("#chatInput").val());
    	$("#chatInput").val("")
    }
    var mx = 0
    function revMsg(msg){
		// 보내는 메시지는 오른쪽
		// 받는 메시지 왼쪽 정렬 처리..
		// 사용자아이디:메시지내용
		var msgArr = msg.split(":")
		var sndId = msgArr[0]
		if(msgArr[1]=="접속하셨습니다."||
		   msgArr[1]=="연결을 종료하였습니다."		
		   ){
			// push방식으로 메시지가 올 때..
			conUsers();
		}
		console.log('# 속성 부여 전 #')
		console.log(msg)
		console.log(idVal+":"+sndId)
		console.log(alignOpt)
		if(idVal==sndId){
			alignOpt = "right"
			fontColor = "black"
			msg =msgArr[1]
		}
		if(idVal!=sndId){
			alignOpt = "left"
			fontColor = "gray"
		}
		console.log('# 메세지 받을 때 #')
		console.log(alignOpt)
		
		addMessage(msg)
		
		
		var height = parseInt($("#chatMessages").height())
		console.log(height)
		mx+=height+20
		$("#chatMessages").scrollTop(mx)
	}
    function conUsers(){
		// 접속자들 ajax로 확인
		$.ajax({
			url:"${path}/getChatMem",
			dataType:"json",
			success:function(data){
				$("#userCnt").text(data)
				
			},
			error:function(err){
				console.log(err)
			}
		})
	}
    
    
   /*  var chatButton = document.getElementById('chatButton');
    var chatBox = document.getElementById('chatBox');
    var chatInput = document.getElementById('chatInput');
    var closeButton = document.getElementById('closeButton');

    let isChatOpen = false;

    chatButton.addEventListener('click', toggleChat);
    


    function toggleChat() {
        chatBox.style.display = isChatOpen ? 'none' : 'flex';
        if (!isChatOpen) {
            chatInput.focus();
        }
        isChatOpen = !isChatOpen;
    }

    function addMessage(message) {
        var chatMessages = document.getElementById('chatMessages');
        var messageDiv = document.createElement('div');
        messageDiv.setAttribute("align",alignOpt)
        messageDiv.setAttribute("style",'color:'+fontColor)
        messageDiv.textContent = message;
        chatMessages.appendChild(messageDiv);
    }
    function clearMessages() {
        var chatMessages = document.getElementById('chatMessages');
        while (chatMessages.firstChild) {
            chatMessages.removeChild(chatMessages.firstChild);
        }
    }
    function leavingPageWarning() {
        return "채팅이 종료됩니다.";
    } */
    </script>
   
    <!-- End of Main Content -->

	

    <!-- Bootstrap core JavaScript-->

    <!-- <script src="${path}/erpBt/vendor/jquery/jquery.min.js"></script> -->

    <script src="${path}/erpBt/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Core plugin JavaScript-->
    <script src="${path}/erpBt/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${path}/erpBt/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <!-- <script src="${path}/erpBt/vendor/chart.js/Chart.min.js"></script> -->

    <!-- Page level custom scripts -->
    <!-- <script src="${path}/erpBt/js/demo/chart-area-demo.js"></script> -->
    <!-- <script src="${path}/erpBt/js/demo/chart-pie-demo.js"></script> -->
	
</body>