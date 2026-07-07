<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="/main.do">
                <i class="bi bi-trophy-fill text-success me-2"></i>Kick-Off
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
				    <li class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="matchDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				            경기
				        </a>
				        <ul class="dropdown-menu" aria-labelledby="matchDropdown">
				            <li><a class="dropdown-item" href="#">빠른예매</a></li>
				            <li><hr class="dropdown-divider"></li> 
				            <li><a class="dropdown-item" href="#">경기목록</a></li>
				        </ul>
				    </li>
				    
				    <li class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="newsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				            뉴스
				        </a>
				        <ul class="dropdown-menu" aria-labelledby="newsDropdown">
				            <li><a class="dropdown-item" href="#">공지사항</a></li>
				            <li><hr class="dropdown-divider"></li> 
				            <li><a class="dropdown-item" href="#">리그</a></li>
				        </ul>
				    </li>
				    
				    <li class="nav-item">
				        <a class="nav-link dropdown-toggle" href="#" id="videoDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				            영상
				        </a>
				        <ul class="dropdown-menu" aria-labelledby="videoDropdown">
				            <li><a class="dropdown-item" href="#">하이라이트</a></li>
				            <li><hr class="dropdown-divider"></li> 
				            <li><a class="dropdown-item" href="#">골</a></li>
				        </ul>
				    </li>
				    
				    <li class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="listDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				            선수/팀
				        </a>
				        <ul class="dropdown-menu" aria-labelledby="listDropdown">
				            <li><a class="dropdown-item" href="#">선수목록</a></li>
				            <li><hr class="dropdown-divider"></li> 
				            <li><a class="dropdown-item" href="#">팀목록</a></li>
				        </ul>
				    </li>
				</ul>
                
                <div class="d-flex">
                	<c:if test="${sessionScope.user.member_id==null }">
	                    <a class="btn btn-outline-light me-2" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</a>
	                    <a href="../member/join.do" class="btn btn-success">회원가입</a>
                    </c:if>
                    <c:if test="${sessionScope.user.member_id!=null }">
                    	<div class="d-inline-flex align-items-center gap-3">
	                    	<span style="color:white;">${sessionScope.user.name } (${sessionScope.user.isAdmin=='Y'?'관리자':'유저' })님 </span>
	                    	<button class="btn btn-success" id="logout">로그아웃</button>
                    	</div>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>
    <div id="loginApp">
  		<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel">
    		<div class="modal-dialog modal-sm" role="document">
      			<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title">KICK-OFF 로그인</h5>
          				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        			</div>
        			<div class="modal-body">
          				<form @submit.prevent="login">
            				<div class="mb-3">
              					<label class="form-label">아이디</label>
              					<input type="text" class="form-control" id="login_id" v-model="loginId" @input="InitError" placeholder="아이디를 입력하세요" autofocus>
            				</div>
            				<div class="mb-3">
              					<label class="form-label">비밀번호</label>
              					<input type="password" class="form-control" id="pwd" v-model="pwd" @input="InitError" placeholder="비밀번호를 입력하세요">
            				</div>
            
            				<div v-if="errorMsg" class="text-danger text-center">{{ errorMsg }}</div>
          				</form>
        			</div>
        			<div class="modal-footer">
          				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
          				<button type="button" class="btn btn-success" @click="login">로그인</button>
        			</div>
      			</div>
    		</div>
  		</div>
	</div>
<script>
	const loginApp=Vue.createApp({
		data(){
			return{
				loginId:'',
				pwd:'',
				errorMsg:''
			}
		},
		methods:{
			InitError(){
				this.errorMsg=''
			},
			async login(){
				if (this.loginId.trim()==='') {
			          this.errorMsg="아이디를 입력해주세요."
			          return
			        }
			        if (this.pwd.trim()==='') {
			          this.errorMsg="비밀번호를 입력해주세요."
			          return
			        }
			    try{
			    	const params=new URLSearchParams()
			    	params.append('id',this.loginId)
			    	params.append('pwd',this.pwd)
			    	
			    	const response=await axios.post('../member/login.do',params)
			    	const msg=response.data.trim()
			    	
			    	if(msg==='OK'){
			    		location.reload()
			    	}
			    	else if(msg==='NOID'||msg==='DIS'){
			    		this.errorMsg='존재하지 않는 아이디입니다'
			    		this.loginId=''
			    		this.pwd=''
			    	}
			    	else if(msg==='NOPWD'){
			    		this.errorMsg='비밀번호가 일치하지 않습니다'
			    		this.pwd=''
			    	}else{
			    		this.errorMsg='알수없는 오류가 발생했습니다'
			    	}
			    }catch(error){
			    	console.error(error)
			    	this.errorMsg='서버와의 통신에 실패했습니다'
			    }
			},
			logout(){
				const params=new URLSearchParams()
				params.append('member_id',this.memberId)
				
				const response=axios.post('../member/logout.do',params)
			}
		}
	}).mount('#loginApp')
	
	$((e)=>{
		$('#logout').on('click',async (e)=>{
			await axios.post('../member/logout.do')
			location.reload()
		})
	})
</script>
</body>
</html>