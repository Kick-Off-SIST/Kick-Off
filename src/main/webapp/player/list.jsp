<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.player-hero{
	background:#111827;
	border-radius:18px;
	padding:45px 50px;
	margin-bottom:40px;
	color:white;
	position:relative;
	overflow:hidden;
	cursor:default;
}
.player-hero:after{
	content:"";
	position:absolute;
	right:-80px;
	top:-80px;
	width:280px;
	height:280px;
	border-radius:50%;
	background:rgba(34,197,94,.15);
}
.player-eyebrow{
	color:#22c55e;
	font-size:13px;
	font-weight:800;
	letter-spacing:2px;
	margin-bottom:15px;
}
.player-hero h1{
	font-size:42px;
	font-weight:800;
	line-height:1.25;
	position:relative;
	z-index:1;
}
.player-hero p{
	color:#d1d5db;
	font-size:16px;
	position:relative;
	z-index:1;
}
.grid-img-container {
    width: 100%;
    aspect-ratio: 4 / 3; 
    overflow: hidden;
    background-color: #eaeaea;
}
.grid-card .card-img-top {
    width: 100%;
    height: 100%;
    object-fit: cover; 
    transition: transform 0.3s ease;
}
.grid-card:hover .card-img-top {
    transform: scale(1.05);
}
.grid-card .card-title {
    font-size: 14px;
    font-weight: 700;
    color: #212529;
}
.grid-card .card-text {
    font-size: 12px;
    color: #6c757d;
}
.page-item:hover{
	cursor: pointer;
}
#name-link{
	text-decoration: none;
	color:black
}
#name-link:hover{
	color:gray
}
#team-link{
	text-decoration: none;
	color:black
}
#team-link:hover{
	color:gray
}
.team-filter-wrapper{
    display:flex;
    align-items:center;
    gap:10px;
}


.team-scroll-btn{
    width:38px;
    height:38px;
    border-radius:50%;
    border:1px solid #dee2e6;
    background:white;

    display:flex;
    align-items:center;
    justify-content:center;

    color:#6b7280;
    cursor:pointer;

    flex-shrink:0;
    transition:.2s;
}


.team-scroll-btn:hover{
    background:#22c55e;
    color:white;
    border-color:#22c55e;
}


.team-filter-container-simple{
    flex:1;
    display:flex;
    align-items:center;
    gap:15px;

    overflow-x:auto;
    overflow-y:hidden;

    padding:30px 5px;

    scrollbar-width:none;
    white-space:nowrap;
}

.team-filter-container-simple::-webkit-scrollbar {
    display: none;
}

.team-filter-container-simple.active {
    cursor: grabbing;
}
.team-filter-container-simple::-webkit-scrollbar {
    display: none;
}

/* 로고 아이템 기본 스타일 */
.team-logo-only {
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink:0;
}

/* 로고 이미지 크기 */
.team-logo-only img {
    width: 60px;
    height: 60px;
    object-fit: contain;
}

/* '전체(ALL)' 텍스트 스타일 */
.team-logo-only {
    font-size:25px;
    font-weight:800;
    color:#4b5563;

    width:65px;
    height:65px;

    display:flex;
    align-items:center;
    justify-content:center;

    padding:0;
    background:transparent;
    border:none;

    transition:all .2s ease;	
}
.all-text{
	font-size:25px;
    font-weight:800;
    color:#4b5563;

    width:65px;
    height:65px;

    display:flex;
    align-items:center;
    justify-content:center;

    padding:0;
    background:transparent;
    border:none;

    transition:all .2s ease;	
}

/* 마우스 호버 시 */
.team-logo-only:hover {
    opacity: 0.8;
    filter: grayscale(50%);
    transform: scale(1.1);
}

/*선택되었을 때 (컬러 복구 + 크기 강조) */
.btn-check:checked + .team-logo-only {

    
    transform: scale(1.2);
}

.btn-check:checked + .team-logo-only.all-text {
    color: #22c55e; /* 전체 선택 시 포인트 컬러 */
}

/* 반응형: 화면이 작아지면 로고 크기 살짝 조절 */
@media (max-width: 768px) {
    .team-filter-container-simple {
        justify-content: flex-start;
        padding: 20px 10px;
        gap: 12px;
    }
    .team-logo-only img {
        width: 38px;
        height: 38px;
    }
}
</style>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>


	<div class="container my-5" id="playerListApp">
		<div class="player-hero">
			<div class="player-eyebrow">
				KICK-OFF
			</div>
			<h1>
				KLeague<br>
				<span style="color:#22c55e">
					선수목록
				</span>
			</h1>
			<p>
				<br>
				K-리그 소속 선수들을 만나보세요.
			</p>
		</div>
    	<div class="row">
        	<div class="col-12">
            		<div class="row mb-4">
					    <div class="col-6 col-md-3 mb-2">
					        <select class="form-select form-select-sm" v-model="column" @change="filterChange">
					            <option value="name">정렬: 이름순</option>
					            <option value="back_number">정렬: 등번호순</option>
					            <option value="t.team_name">정렬: 팀명순</option>
					        </select>
					    </div>
					    
					    <div class="col-6 col-md-3 mb-2">
					        <select class="form-select form-select-sm" v-model="position" @change="filterChange">
					            <option value="">필터: 전 포지션</option>
					            <option value="FW">공격수 (FW)</option>
					            <option value="MF">미드필더 (MF)</option>
					            <option value="DF">수비수 (DF)</option>
					            <option value="GK">골키퍼 (GK)</option>
					        </select>
					    </div>
					    <div class="team-filter-wrapper">

						    <button type="button"
						            class="team-scroll-btn"
						            @click="scrollTrack(-250)">
						        <i class="bi bi-chevron-left"></i>
						    </button>
					    <div class="team-filter-container-simple" ref="teamTrack">
					    <!-- 전체 -->
					    <input type="radio" class="btn-check" name="teamFilter" id="team_all" 
					           v-model="team_id" value="" @change="filterChange">
					    <label class="team-logo-only all-text" for="team_all">ALL</label>
					
					    <!-- 팀 리스트 (한 줄 노출) -->
					    <template v-for="team in teamList" :key="team.team_id">
					        <input type="radio" class="btn-check" name="teamFilter" :id="'team_'+team.team_id" 
					               v-model="team_id" :value="team.team_id" @change="filterChange">
					        <label class="team-logo-only" :for="'team_'+team.team_id">
					            <img :src="team.emblem" :alt="team.team_name" :title="team.team_name">
					        </label>
					    </template>
					</div>
					<button type="button"
				            class="team-scroll-btn"
				            @click="scrollTrack(250)">
				        <i class="bi bi-chevron-right"></i>
				    </button>
					   
					</div>

            	<div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-6 g-3">
                    <div class="col" v-for="vo in list" :key="vo.player_id">
                        <div class="card h-100 shadow-sm border-0 grid-card">
                            
                            <div class="position-relative grid-img-container">
                                <a :href="'../player/detail.do?player_id='+vo.player_id">
                                	<img :src="vo.img_url?vo.img_url:'../player/no_image.png'" class="card-img-top" alt="">
                                </a>
                            </div>
                            
                            <div class="card-body p-2 d-flex justify-content-between align-items-center">
                                <div style="min-width: 0;">
                                    <h6 class="card-title text-truncate mb-1"><a :href="'../player/detail.do?player_id='+vo.player_id" id="name-link">{{vo.name}}</a></h6>
                                    <p class="card-text text-truncate mb-0"><a :href="'../team/detail.do?team_id='+vo.team_id" id="team-link">{{vo.tvo.team_name}}</a></p>
                                    <p class="card-text text-truncate mb-0">{{vo.back_number}}&nbsp;&nbsp;{{vo.position}}</p>
                                </div>
                                <div class="flex-shrink-0 ms-2">
                                	<a :href="'../team/detail.do?team_id='+vo.team_id" id="team-link">
	                                	<img :src="vo.tvo.emblem?vo.tvo.emblem :''"
	                                		alt="" style="width: 35px; height: 35px; object-fit: contain;">
                                	</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>            
        	</div>
    	</div>
    	<div class="row" style="margin-top: 20px">
    		<ul class="pagination justify-content-center">
				<li v-if="startPage>1" class="page-item"><a class="page-link" @click="pageChange(startPage-1)">&laquo;</a></li>
				<li v-for="i in range(startPage,endPage)" :key="i" class="page-item" :class="i===curpage?'active':''"><a class="page-link" @click="pageChange(i)">{{i}}</a></li>
				<li v-if="endPage<totalpage" class="page-item"><a class="page-link" @click="pageChange(endPage+1)">&raquo;</a></li>
			</ul>
    	</div>
	</div>
<script>
	const playerList=Vue.createApp({
		data(){
			return{
				list:[],
				teamList:[],
				curpage:1,
				totalpage:0,
				startPage:0,
				endPage:0,
				column:'name',
				team_id:'',
				position:''
			}
		},
		mounted(){
			const params=new URLSearchParams(window.location.search)
			if(params.has('team_id')){
				this.team_id=params.get('team_id')
			}
			this.dataRecv()
			this.teamDataRecv()
			
		},
		methods:{
			async dataRecv(){
				await axios.get('../player/list_vue.do',{
					params:{
						page:this.curpage,
						column:this.column,
						team_id:this.team_id,
						position:this.position
					}
				}).then(response=>{
//					console.log(response.data)
					this.list=response.data.list
					this.curpage=response.data.curpage
					this.totalpage=response.data.totalpage
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
				})
			},
			range(start,end){
				let arr=[]
				let len=end-start
				for(let i=0;i<=len;i++){
					arr[i]=start
					start++
				}
				return arr
			},
			pageChange(page){
				this.curpage=page
				this.dataRecv()
			},
			async teamDataRecv(){
				await axios.get('../team/emblem_vue.do')
				.then(response=>{
					this.teamList=response.data
				})
			},
			filterChange(){
				this.curpage=1
				this.dataRecv()
			},
			scrollTrack(amount) {
				const track=this.$refs.teamTrack;

			    if(track){
			        track.scrollBy({
			            left: amount,
			            behavior:'smooth'
			        });
			    }

			}
		}
	}).mount('#playerListApp')
</script>