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
.team-filter-wrapper {
    display: flex;
    align-items: center;
    gap: 10px;
}
.team-scroll-btn {
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    transition: all 0.2s;
    flex-shrink: 0;
    color: #495057;
}
.team-scroll-btn:hover {
    background-color: #f8f9fa;
    border-color: #adb5bd;
    color: #212529;
}
.scroll-filter-container {
    display: flex;
    overflow-x: auto;
    white-space: nowrap;
    gap: 12px;
    padding: 15px 7px;
    -ms-overflow-style: none;
    scrollbar-width: none;
    flex: 1;
    scroll-behavior: smooth;
}
.scroll-filter-container::-webkit-scrollbar {
    display: none;
}
.team-logo-label {
    width: 65px;
    height: 65px;
    border-radius: 50%;
    border: 2px solid #dee2e6;
    background-color: #fff;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease-in-out;
    padding: 5px;
    flex-shrink: 0;
}
.team-logo-label img {
    width: 100%;
    height: 100%;
    object-fit: contain;
}
.team-logo-label:hover {
    border-color: #adb5bd;
    transform: scale(1.05);
}
.btn-check:checked + .team-logo-label {
    border-color: rgb(0, 128, 0)255, 0);
    box-shadow: 0 0 10px rgb(0, 128, 0);
    transform: scale(1.1);
}
.team-all-text {
    font-size: 13px;
    font-weight: 800;
    color: #495057;
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
					    
					    <div class="team-filter-wrapper mb-4">
							<button type="button" class="team-scroll-btn" @click="scrollTrack(-250)">
								<i class="bi bi-chevron-left"></i>
							</button>
						    <div class="scroll-filter-container" ref="teamTrack">
							    <input type="radio" class="btn-check" name="teamFilter" id="team_all" v-model="team_id" value="" @change="filterChange">
							    <label class="team-logo-label" for="team_all" title="전체 팀">
							        <span class="team-all-text">ALL</span>
							    </label>
								
								<template v-for="team in teamList" :key="team.team_id">
								    <input type="radio" class="btn-check" name="teamFilter" :id='"team_"+team.team_id' v-model="team_id" :value="team.team_id" @change="filterChange">
								    <label class="team-logo-label" :for='"team_"+team.team_id' :title="team.team_name">
								        <img :src="team.emblem">
								    </label>
							    </template>
							</div>
							<button type="button" class="team-scroll-btn" @click="scrollTrack(250)">
								<i class="bi bi-chevron-right"></i>
							</button>
						</div>
					   
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
				if(track) {
					track.scrollLeft+=amount;
				}
			}
		}
	}).mount('#playerListApp')
</script>