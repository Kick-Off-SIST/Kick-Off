<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background-color: #f8f9fa;
}
.kickoff-card {
	background-color: #ffffff;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	margin-bottom: 20px;
}
.month-navigator {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 30px 20px;
}
.month-nav-btn {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	border: 1px solid #dee2e6;
	background-color: #ffffff;
	color: #212529;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	cursor: pointer;
	transition: all 0.2s;
}
.month-nav-btn:hover {
	background-color: #f8f9fa;
	border-color: #198754;
	color: #198754;
}
.month-display {
	font-size: 28px;
	font-weight: 900;
	color: #212529;
	margin: 0 30px;
	min-width: 150px;
	text-align: center;
}
.team-filter-bar {
	background-color: #f8f9fa;
	border-top: 1px solid #e0e0e0;
	padding: 15px 25px;
	border-radius: 0 0 8px 8px;
}
.match-card {
	padding: 25px;
	transition: border-color 0.2s ease, box-shadow 0.2s ease;
}
.match-card:hover {
	border-color: #198754;
	box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}
.team-logo { 
	width: 70px; 
	height: 70px; 
	object-fit: contain; 
	margin-bottom: 10px; 
}
.team-link{
	text-decoration: none;
}
.vs-text { 
	font-size: 24px; 
	font-weight: 900; 
	color: #dee2e6;  
}
.match-info-text { 
	font-size: 15px; 
	color: #6c757d; 
}
.team-name { 
	font-size: 18px; 
	font-weight: bold; 
	color: #212529; 
}
.score-text{
	font-size: 32px;
	font-weight: 900;
	color: #212529;
}
#matchApp {
	flex: 1; 
}
</style>
</head>
<body>
	<div class="container my-5" id="matchApp">
		<h4 class="mb-4 fw-bold text-dark">
			<i class="bi bi-calendar-check text-success me-2"></i>경기 일정 및 예매
		</h4>
		<div class="kickoff-card mb-4">
			<div class="position-relative d-flex justify-content-center align-items-center" style="padding: 30px 20px;">
				<div class="position-absolute start-0 ms-3 ms-md-4">
					<select class="form-select fw-bold shadow-sm" style="width: 150px; cursor: pointer;" 
								@change="selectMonth" :value="searchDate">
						<option v-for="opt in monthOptions" :key="opt.value" :value="opt.value">
							{{ opt.label }}
						</option>
					</select>
				</div>
				
				<button type="button" class="month-nav-btn" @click="prevMonth">
					<i class="bi bi-chevron-left"></i>
				</button>
				<div class="month-display">
					{{dYear}}. {{dMonth}}
				</div>
				<button type="button" class="month-nav-btn" @click="nextMonth">
					<i class="bi bi-chevron-right"></i>
				</button>
			</div>
	
			<div class="team-filter-bar d-flex justify-content-between align-items-center">
			<%-- 
				<div class="d-flex align-items-center gap-2">
				<span class="fw-bold" style="font-size: 14px; color: #495057;">구단 필터</span>
					<select class="form-select form-select-sm" style="width: 180px;" v-model="team_id">
						<option value="">전체 구단</option>
						<option value="K01">울산 HD FC</option>
						<option value="K09">FC서울</option>
					</select>
					<button class="btn btn-sm btn-dark fw-bold px-3">조회</button>
				</div>
			--%>
				<div style="font-size: 14px; color: #666;">
					선택하신 날짜에 총 <strong class="text-success">{{count}}</strong>건의 경기가 있습니다.
				</div>
			</div>
		</div>
	
		<div class="kickoff-card match-card" v-for="(vo,index) in list" :key="index">
			<div class="row align-items-center text-center text-md-start">
				<div class="col-md-3 mb-3 mb-md-0 border-md-end">
					<div class="badge bg-dark mb-2">{{vo.game_status=='A'?'경기 종료':'경기 예정'}}</div>
					<div class="fw-bold mb-1" style="font-size: 18px;">{{vo.dbday}} {{vo.game_time}}</div>
					<div class="match-info-text"><i class="bi bi-geo-alt-fill me-1"></i>{{vo.svo.name}}</div>
				</div>
	
				<div class="col-md-6 mb-4 mb-md-0">
					<div class="d-flex justify-content-center align-items-center">
						<div class="text-center" style="width: 120px;">
							<a :href="'../team/detail.do?team_id='+vo.homeVo.team_id" class="team-link">
								<img :src="vo.homeVo.emblem" class="team-logo">
								<div class="team-name">{{vo.homeVo.team_name}}</div>
							</a>
						</div>
						
						<div class="d-flex align-items-center mx-3">
							<div v-if="vo.game_status=='A'" class="score-text me-4" :style="vo.home_goal>vo.away_goal?'color:#198754':''">{{vo.home_goal}}</div>
							<div class="vs-text">{{vo.game_status=='B'?'VS':':'}}</div>
							<div v-if="vo.game_status=='A'" class="score-text ms-4" :style="vo.home_goal<vo.away_goal?'color:#198754':''">{{vo.away_goal}}</div>
						</div>
						
						
						<div class="text-center" style="width: 120px;">
							<a :href="'../team/detail.do?team_id='+vo.awayVo.team_id" class="team-link">
								<img :src="vo.awayVo.emblem" class="team-logo">
								<div class="team-name">{{vo.awayVo.team_name}}</div>
							</a>
						</div>
					</div>
				</div>
	
				<div class="col-md-3 text-md-end">
					<a v-if="vo.game_status!='A'" :href="'../ticket/reserve_ticket.do?sid='+vo.schedule_id" class="btn btn-success fw-bold px-4 py-2 w-100">
						티켓 예매 <i class="bi bi-ticket-perforated ms-1"></i>
					</a>
					<button v-else type="button" class="btn btn-secondary fw-bold px-4 py-2 w-100" disabled>
						경기 종료
					</button>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
const matchApp=Vue.createApp({
	data(){
		return{
			sDate:new Date(),
			list:[],
			count:0,
			monthOptions:[]
		}
	},
	mounted(){
		this.monthOption()
		this.dataRecv()
	},
	computed:{
		dYear(){
			return this.sDate.getFullYear()
		},
		dMonth(){
			return String(this.sDate.getMonth()+1).padStart(2,'0')
		},
		searchDate(){
			return this.dYear+'-'+this.dMonth+'-01'
		}
	},
	methods:{
		async dataRecv(){
			await axios.get('../match/list_vue.do',{
				params:{
					searchDate:this.searchDate
				}
			})
			.then(response=>{
//				console.log(response)
				this.list=response.data
				this.count=response.data.length>0?response.data[0].count:0
			})
		},
		prevMonth(){
			this.sDate=new Date(this.sDate.setMonth(this.sDate.getMonth()-1))
			this.dataRecv()
		},
		nextMonth(){
			this.sDate=new Date(this.sDate.setMonth(this.sDate.getMonth()+1))
			this.dataRecv()
		},
		monthOption() {
			const currentYear=new Date().getFullYear()
			let opts=[]
			for (let y=currentYear-1;y<=currentYear+1;y++) {
				for (let m=1;m<=12;m++) {
					let mm=String(m).padStart(2,'0')
					opts.push({
						value:y+'-'+mm+'-01',
						label:y+'년 '+mm+'월'
					})
				}
			}
			this.monthOptions = opts;
		},
		selectMonth(e) {
			this.sDate=new Date(e.target.value); 
			this.dataRecv();
		}
	}
}).mount('#matchApp')
</script>
</body>
</html>