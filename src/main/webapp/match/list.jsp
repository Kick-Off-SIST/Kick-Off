<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
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
.date-filter-wrapper {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 25px 20px;
	gap: 10px;
}
.date-arrow-btn {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	border: 1px solid #dee2e6;
	background-color: #ffffff;
	color: #495057;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: all 0.2s;
}
.date-arrow-btn:hover {
	background-color: #f8f9fa;
	border-color: #adb5bd;
}
.date-btn {
	width: 80px;
	padding: 12px 0;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	background-color: #ffffff;
	color: #495057;
	text-align: center;
	cursor: pointer;
	transition: all 0.2s ease;
	user-select: none;
}
.date-btn:hover {
	background-color: #f8f9fa;
	border-color: #adb5bd;
}
.date-btn .num {
	font-size: 18px;
	font-weight: bold;
	display: block;
	margin-bottom: 2px;
}
.date-btn .day {
	font-size: 13px;
	color: #868e96;
}
.btn-check:checked + .date-btn {
	background-color: #198754;
	border-color: #198754;
	color: #ffffff;
	box-shadow: 0 4px 10px rgba(25, 135, 84, 0.2);
}
.btn-check:checked + .date-btn .day {
	color: rgba(255, 255, 255, 0.8);
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
.vs-text { 
	font-size: 24px; 
	font-weight: 900; 
	color: #dee2e6; 
	font-style: italic; 
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
</style>
</head>
<body>
	<div class="container my-5" id="matchApp">
		<h4 class="mb-4 fw-bold text-dark">
			<i class="bi bi-calendar-check text-success me-2"></i>경기 일정 및 예매
		</h4>
		<div class="kickoff-card mb-4">
			<div class="date-filter-wrapper">
				<button type="button" class="date-arrow-btn me-2">
					<i class="bi bi-chevron-left"></i>
				</button> 
				<input type="radio" class="btn-check" name="matchDate" id="date_16" value="2026-07-16">
				<label class="date-btn" for="date_16">
					<span class="num">16</span>
					<span class="day">목요일</span>
				</label>
				<input type="radio" class="btn-check" name="matchDate" id="date_17" value="2026-07-17">
				<label class="date-btn" for="date_17">
					<span class="num">17</span>
					<span class="day">금요일</span>
				</label>
				<input type="radio" class="btn-check" name="matchDate" id="date_18" value="2026-07-18" checked>
				<label class="date-btn" for="date_18">
					<span class="num">18</span>
					<span class="day">토요일</span>
				</label>
				<input type="radio" class="btn-check" name="matchDate" id="date_19" value="2026-07-19">
				<label class="date-btn" for="date_19">
					<span class="num">19</span>
					<span class="day">일요일</span>
				</label>
				<input type="radio" class="btn-check" name="matchDate" id="date_20" value="2026-07-20">
				<label class="date-btn" for="date_20">
					<span class="num">20</span>
					<span class="day">월요일</span>
				</label>
	
				<button type="button" class="date-arrow-btn ms-2">
					<i class="bi bi-chevron-right"></i>
				</button>
			</div>
	
			<div class="team-filter-bar d-flex justify-content-between align-items-center">
				<div class="d-flex align-items-center gap-2">
				<span class="fw-bold" style="font-size: 14px; color: #495057;">구단 필터</span>
					<select class="form-select form-select-sm" style="width: 180px;">
						<option value="">전체 구단</option>
						<option value="K01">울산 HD FC</option>
						<option value="K09">FC서울</option>
					</select>
					<button class="btn btn-sm btn-dark fw-bold px-3">조회</button>
				</div>
				<div style="font-size: 14px; color: #666;">
					선택하신 날짜에 총 <strong class="text-success">2</strong>건의 경기가 있습니다.
				</div>
			</div>
		</div>
	
		<div class="kickoff-card match-card">
			<div class="row align-items-center text-center text-md-start">
				<div class="col-md-3 mb-3 mb-md-0 border-md-end">
					<div class="badge bg-dark mb-2">K리그1 15라운드</div>
					<div class="fw-bold mb-1" style="font-size: 18px;">07. 18 (토) 19:00</div>
					<div class="match-info-text"><i class="bi bi-geo-alt-fill me-1"></i>울산 문수 축구경기장</div>
				</div>
	
				<div class="col-md-6 mb-4 mb-md-0">
					<div class="d-flex justify-content-center align-items-center">
						<div class="text-center" style="width: 120px;">
							<img src="https://www.kleague.com/assets/images/emblem/emblem_K01@2x.png" class="team-logo" alt="울산">
							<div class="team-name">울산 HD FC</div>
						</div>
						<div class="mx-4 vs-text">VS</div>
						<div class="text-center" style="width: 120px;">
							<img src="https://www.kleague.com/assets/images/emblem/emblem_K09@2x.png" class="team-logo" alt="서울">
							<div class="team-name">FC서울</div>
						</div>
					</div>
				</div>
	
				<div class="col-md-3 text-md-end">
					<a href="../ticket/detail.do?match_id=101" class="btn btn-success fw-bold px-4 py-2 w-100">
						티켓 예매 <i class="bi bi-ticket-perforated ms-1"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
const matchApp=Vue.createApp({
	data(){
		return{
			searchDate:''
		}
	},
	mounted(){
		this.dataRecv()
	},
	methods:{
		async dataRecv(){
			await axios.get('../match/list_vue.do',{
				params:{
					
				}
			})
			.then(response=>{
				console.log(response.data)
			})
		}
	}
}).mount('#matchApp')
</script>
</body>
</html>