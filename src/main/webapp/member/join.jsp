<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
    body{
        background-color: #f8f9fa;
        font-family: 'Noto Sans KR', sans-serif;
    }
    .join-wrapper {
        max-width: 480px;
        margin: 6rem auto;
        padding: 2.5rem;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
    }
    .form-label {
        font-size: 14px;
    }
    .feedback-msg {
        font-size: 12px;
        margin-top: 5px;
        font-weight: bold;
    }
</style>
<script type="text/javascript">
$((e)=>{
	let isIdValid=false
	
	const showGlobalError=(msg)=>{
		$('#errorText').text(msg)
		$('#globalError').slideDown(200)
	}
	const clearGlobalError=()=>{
		$('#globalError').slideUp(200)
	}
    $('#loginId').on('input',(e)=>{
        $('#idMsg').text('').removeClass('text-success text-danger')
        clearGlobalError()
        isIdValid=false
    })
    $('#joinpwd, #pwdConfirm, #name, input[name="phone2"]').on('input', (e)=>{
        clearGlobalError()
    })
    $('#postBtn').on('click',(e)=>{
		new daum.Postcode({
			oncomplete(data){
				$('#post').val(data.zonecode)
				$('#addr1').val(data.address)
				$('#addr2').focus()
			}
		}).open()
	})
	$('#joinpwd, #pwdConfirm').on('input',(e)=>{
		let pwd=$('#joinpwd').val()
		let pwdConfirm=$('#pwdConfirm').val()
//		console.log("현재 입력값 ➡️ 비밀번호: [" + pwd + "] / 확인: [" + pwdConfirm + "]")
		
        if (!pwd && !pwdConfirm) {
            $('#pwdMsg').text('').removeClass('text-success text-danger')
            return
        }
        
        if (pwd && !pwdConfirm) {
            $('#pwdMsg').text('비밀번호 확인을 입력해주세요.').removeClass('text-success').addClass('text-danger')
            return
        }
        
        if (pwd && pwdConfirm) {
            if (pwd!==pwdConfirm) {
                $('#pwdMsg').text('비밀번호가 일치하지 않습니다.').removeClass('text-success').addClass('text-danger')
            } else {
                $('#pwdMsg').text('비밀번호가 일치합니다.').removeClass('text-danger').addClass('text-success')
            }
        }
    })
    $('#btnIdCheck').on('click',(e)=>{
        let id=$('#loginId').val().trim();
        
        if (id==='') {
            $('#idMsg').text('아이디를 입력해주세요.').removeClass('text-success').addClass('text-danger')
            $('#loginId').focus()
            return
        }

        $.ajax({
            method:'get',
            url:'../member/idCheck.do',
            data:{id},
            success:(response)=>{
                const res=response.trim()
                console.log(res)
                if (res==='OK') {
                    $('#idMsg').text('사용 가능한 아이디입니다.').removeClass('text-danger').addClass('text-success')
                    isIdValid=true
                } else {
                    $('#idMsg').text('이미 사용 중인 아이디입니다.').removeClass('text-success').addClass('text-danger')
                    isIdValid=false
                }
            },
            error:(err)=>{
            	console.log(err)
                $('#idMsg').text('서버 통신 오류가 발생했습니다.').removeClass('text-success').addClass('text-danger')
                isIdValid = false
            }
        })
    })
    $('#joinForm').on('submit',(e)=>{
    	if(!isIdValid){
    		e.preventDefault()
    		showGlobalError('아이디 중복확인을 완료해주세요')
    		$('#loginId').focus()
    		return false
    	}
    	let pwd=$('#joinpwd').val()
    	let pwdConfirm=$('#pwdConfirm').val()
    	if(pwd!==pwdConfirm){
    		e.preventDefault()
    		showGlobalError('비밀번호가 일치하지 않습니다')
    		$('#pwdConfirm').focus()
    		return false
    	}
    	
    })
})
</script>
</head>
<%--INSERT INTO Member (login_id,pwd,name,sex,birthday,email,addr1,addr2,content,phone)VALUES(
			#{login_id},#{pwd},#{name},#{sex},#{birthday},#{email},#{addr1},#{addr2},#{content},#{phone}
		)--%>
<body>
	<div class="container">
    <div class="join-wrapper">
        <h3 class="text-center fw-bold mb-4">
            <i class="bi bi-trophy-fill text-success me-2"></i>KICK-OFF 회원가입
        </h3>

        <form id="joinForm" name="joinForm" method="post" action="../member/join_ok.do">
            <div class="mb-3">
                <label for="loginId" class="form-label fw-bold text-secondary">아이디</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="loginId" name="id" placeholder="아이디를 입력하세요" autofocus required>
                    <button class="btn btn-outline-success fw-bold" type="button" id="btnIdCheck">중복확인</button>
                </div>
                <div id="idMsg" class="feedback-msg"></div>
            </div>

            <div class="mb-3">
                <label for="pwd" class="form-label fw-bold text-secondary">비밀번호</label>
                <input type="password" class="form-control" id="joinpwd" name="pwd" placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="mb-3">
                <label for="pwdConfirm" class="form-label fw-bold text-secondary">비밀번호 확인</label>
                <input type="password" class="form-control" id="pwdConfirm" placeholder="비밀번호를 다시 한번 입력하세요" required>
                <div id="pwdMsg" class="feedback-msg"></div>
            </div>

            <div class="mb-3">
                <label for="name" class="form-label fw-bold text-secondary">이름</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요" required>
            </div>
            
            <div class="mb-3">
            	<label for="sex" class="form-label fw-bold text-secondary">성별</label><br>
            	<input type="radio" name="sex" value="M" checked>남자
			    <input type="radio" name="sex" value="F">여자
            </div>
            
            <div class="mb-3">
                <label for="birthday" class="form-label fw-bold text-secondary">생년월일</label>
                <input type="date" name="birthday"  id="birthday" class="form-control input-sm" required>
            </div>
            
            <div class="mb-3">
                <label for="email" class="form-label fw-bold text-secondary">이메일</label>
                <input type="text" class="form-control" id="email" name="email" placeholder="example@email.com" required>
            </div>
            
            <div class="mb-4">
                <label for="post" class="form-label fw-bold text-secondary">우편번호</label>
                <input type="text" id="post" name="post" class="form-control input-sm" readonly>
			    <button type="button" id="postBtn" class="btn btn-outline-primary" style="margin-top: 5px;">우편번호검색</button>
            </div>
            
            <div class="mb-3">
                <label for="addr1" class="form-label fw-bold text-secondary">주소</label>
                <input type="text" id="addr1" name="addr1" class="form-control input-sm" readonly>
            </div>
            
            <div class="mb-3">
                <label for="addr2" class="form-label fw-bold text-secondary">상세주소</label>
                <input type="text" name="addr2" class="form-control input-sm">
            </div>
            
            <div class="mb-3">
                <label for="phone" class="form-label fw-bold text-secondary">연락처</label>
                <div class="d-flex align-items-center gap-2">
	                <select name="phone1" class="form-select form-select-sm w-auto">
				    	<option>010</option>
				    	<option>011</option>
				    	<option>016</option>
				    </select>
				    <span class="text-secondary">-</span>
	                <input type="text" name="phone2" class="form-control form-control-sm flex-grow-1" placeholder="####-####" required>
            	</div>
            </div>
            
            <div class="mb-3">
                <label for="content" class="form-label fw-bold text-secondary">소개</label>
                <textarea draggable="false" rows="10" class="form-control" id="content" name="content" placeholder="desc" required></textarea>
            </div>

            <div id="globalError" class="alert alert-danger text-center fw-bold py-2 mt-3 mb-0" style="font-size: 13px; display: none;">
                <i class="bi bi-exclamation-triangle-fill me-1"></i> <span id="errorText"></span>
            </div>

            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-success btn-lg fw-bold fs-6" id="submitBtn">가입하기</button>
                <a href="../main/main.do" class="btn btn-light fw-bold text-secondary fs-6">취소</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>