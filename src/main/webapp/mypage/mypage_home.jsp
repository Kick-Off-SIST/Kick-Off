<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	$('#postBtn').on('click',function(){
		new daum.Postcode({
			oncomplete(data){
				//$('#postcode').val(data.zonecode)
				//$('#addr1').val(data.address)
				home.postcode=data.zonecode
				home.addr1=data.address
			}
		}).open()
	})
})
</script>
</head>
<body>
<div class="container py-5" id="home">
        
        <div class="card border-0 p-4 mb-4" style="box-shadow: none;">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between gap-4">
                <div class="d-flex flex-column flex-md-row align-items-center gap-4 text-center text-md-start">
                    <div class="position-relative border border-3 border-primary rounded-circle p-1" style="width: 100px; height: 100px;">
                        <img src="../mypage/profile.png" class="w-100 h-100 rounded-circle object-fit-cover">
                    </div>
                    <div>
                        <div class="d-flex align-items-center justify-content-center justify-content-md-start gap-2 mb-1">
                            <h2 class="h4 mb-0 text-dark fw-bold">${vo.name }</h2>
                            <span class="badge bg-primary-subtle text-primary rounded-pill px-2.5 py-1" style="font-size: 0.75rem;">${vo.sgrade }</span>
                        </div>
                        <p class="text-secondary mb-1 small">이메일
                        	<span class="text-secondary mb-1 small">|</span>
                        	<span class="text-dark">${vo.email }</span>
                        </p>
                        <p class="text-muted mb-0" style="font-size: 0.75rem;">가입일
                        	<span class="text-secondary mb-1 small">|</span>
                        	<span class="text-dark">${vo.dbday }</span>
                        </p>
                    </div>
                </div>
                <button @click="toggle" id="toggleBtn" class="btn btn-dark btn-md px-4 rounded-3 fw-semibold" style="width: 130px">
                    {{isshow?'닫기':'프로필 편집'}}
                </button>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-4">
                <div class="card border-0 p-3 text-center">
                    <span class="text-muted d-block mb-1" style="font-size: 1rem">구매 목록(예시)</span>
                    <span class="fs-5 fw-bold text-dark">12 개</span>
                </div>
            </div>
            <div class="col-4">
                <div class="card border-0 p-3 text-center">
                    <span class="text-muted d-block mb-1" style="font-size: 1rem">내 글</span>
                    <span class="fs-5 fw-bold text-dark">${bcount } 개</span>
                </div>
            </div>
            <div class="col-4">
                <div class="card border-0 p-3 text-center">
                    <span class="text-muted d-block mb-1" style="font-size: 1rem">티켓 예매 목록</span>
                    <span class="fs-5 fw-bold text-dark">${rcount } 개</span>
                </div>
            </div>
        </div>
		<div id="updateForm" v-show="isshow">
		<div class="card border-0 shadow-sm p-4 mb-4">
		
    <div class="border-bottom pb-3 mb-4 d-flex align-items-center justify-content-between">
        <div>
            <h2 class="h4 mb-1 text-dark fw-bold">프로필 편집</h2>
        </div>
    </div>

    <!-- <form id="profile-edit-form" action="#" method="post" enctype="multipart/form-data"> -->
        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label fw-semibold text-dark small">아이디</label>
                <input type="text" class="form-control bg-light rounded-start-3 text-secondary" v-model=login_id readonly>
            </div>
            
            <div class="col-md-6">
                <label for="name" class="form-label fw-semibold text-dark small">이름</label>
                <input type="text" class="form-control input-sm" ref="nameRef" v-model=name>
            </div>
            
            <div class="col-md-6">
                <label for="pwd" class="form-label fw-semibold text-dark small">새 비밀번호</label>
                <input type="password" class="form-control input-sm" ref="pwdRef" v-model=pwd  placeholder="새로운 비밀번호 입력">
            </div>

            <div class="col-md-6">
                <label for="pwd-check" class="form-label fw-semibold text-dark small">새 비밀번호 확인</label>
                <input type="password" class="form-control input-sm" ref="pwdCRef" v-model=pwdcheck placeholder="비밀번호 재입력">
            </div>
            
            <div class="col-md-12">
                <label for="sex" class="form-label fw-semibold text-dark small">성별</label>
                <div class="d-flex align-items-center gap-4 pt-1">
        			<div class="form-check">
            			<input class="form-check-input" type="radio" name="sex" value="M" v-model="sex">
            			남자
        			</div>
        			<div class="form-check">
            			<input class="form-check-input" type="radio" name="sex" value="F" v-model="sex">
            			여자
        			</div>
    			</div>
            </div>
            
            <div class="col-md-12">
                <label for="email" class="form-label fw-semibold text-dark small">이메일 주소</label>
                <input type="email" class="form-control input-sm" ref="emailRef" v-model=email>
            </div>
            
            <div class="col-md-7">
            	<label for="phone" class="form-label fw-semibold text-dark small">우편번호</label>
                <div class="row">
                	<div class="col-sm-8">
                		<input type="text" class="form-control bg-light text-secondary" id="postcode" name="postcode" v-model=postcode readonly>
                	</div>
                	<div class="col-sm-4">
                		<button type="button" id="postBtn" class="btn btn-outline-primary">우편번호 검색</button>
                	</div>
            	</div>
            </div>
            
            <div class="col-md-6">
                <label for="phone" class="form-label fw-semibold text-dark small">주소</label>
                <input type="text" class="form-control bg-light text-secondary" id="addr1" name="addr1" v-model=addr1 readonly>
            </div>
            
            <div class="col-md-6">
                <label for="phone" class="form-label fw-semibold text-dark small">상세주소</label>
                <input type="text" class="form-control input-sm" ref="addr2Ref" v-model=addr2>
            </div>
            
            <div class="col-md-6">
                <label for="phone" class="form-label fw-semibold text-dark small">전화번호</label>
                <input type="text" class="form-control input-sm" ref="phoneRef" v-model=phone>
            </div>
            
            <div class="col-md-6">
                <label for="birthday" class="form-label fw-semibold text-dark small">생년월일</label>
                <input type="date" ref="birthdayRef"  class="form-control input-sm" v-model=birthday>
            </div>

			<div class="col-md-12">
                <label for="birthday" class="form-label fw-semibold text-dark small">소개</label>
				<textarea draggable="false" rows="10" class="form-control" ref="contentRef" v-model=content></textarea>
            </div>
        </div>

        <!-- 하단 제출 버튼 영역 -->
        <div class="d-flex align-items-center justify-content-end gap-2 mt-4 pt-3 border-top">
            <button type="button" @click="update" class="btn btn-dark px-4 fw-semibold">수정하기</button>
        </div>
    <!-- </form> -->
</div>
		</div>

</div>
<script>
	let home=Vue.createApp({
		data(){
			return {
				isshow:false,
				login_id:'',
				name:'',
				pwd:'',
				pwdcheck:'',
				email:'',
				postcode:'',
				addr1:'',
				addr2:'',
				phone:'',
				content:'',
				birthday:'',
				sex:'',
			}
		},
		methods:{
			toggle(){
				this.isshow=!this.isshow
				if(this.isshow===true){
					axios.post('../mypage/update.do',{},{
						params:{
							
						}
					}).then(response=>{
						console.log(response.data)
						this.login_id=response.data.login_id
						this.name=response.data.name
						this.email=response.data.email
						this.postcode=response.data.post
						this.addr1=response.data.addr1
						this.addr2=response.data.addr2
						this.phone=response.data.phone
						this.birthday=response.data.birthday
						this.content=response.data.content
						this.sex=response.data.sex
					})
				}
			},
			update(){
				if(this.name.trim()==='') {
					this.$refs.nameRef.focus()
					return
				}
				else if(this.pwd.trim()==='') {
					this.$refs.pwdRef.focus()
					return
				}
				else if(this.pwdcheck.trim()==='' || this.pwd!==this.pwdcheck) {
					this.pwdcheck=''
					this.$refs.pwdCRef.focus()
					return
				}
				else if(this.email.trim()==='') {
					this.$refs.emailRef.focus()
					return
				}
				else if(this.addr2.trim()==='') {
					this.$refs.addr2Ref.focus()
					return
				}
				else if(this.phone.trim()==='') {
					this.$refs.phoneRef.focus()
					return
				}
				else if(this.birthday.trim()==='') {
					this.$refs.birthdayRef.focus()
					return
				}
				else if(this.content.trim()==='') {
					this.$refs.contentRef.focus()
					return
				}
				
				axios.post('../mypage/update_ok.do',{},{
					params:{
						name:this.name,
						pwd:this.pwd,
						sex:this.sex,
						email:this.email,
						post:this.postcode,
						addr1:this.addr1,
						addr2:this.addr2,
						phone:this.phone,
						birthday:this.birthday,
						content:this.content
					}
				}).then(response=>{
					alert("수정 완료!!")
					window.location.href="../mypage/mypage.do"
				})
			}
		}
	}).mount('#home')
</script>
</body>
</html> 