<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<main class="container main-content home">
  <!-- 풀너비 캐러셀 히어로 -->
<div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4000"
     style="width:100vw; margin-left:calc(-50vw + 50%); margin-bottom:40px;">

    <div class="carousel-indicators">
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
    </div>

    <div class="carousel-inner">

        <!-- 슬라이드 1 -->
        <div class="carousel-item active">
            <div style="background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)),
            url('../image/banner3.jpg') center/cover no-repeat;
            height:550px; padding:80px 100px;">
            <div style="width:500px; margin-left: 150px; margin-top: 50px;">
                <div style="font-size:13px; font-weight:800; letter-spacing:2px; color:#22c55e; margin-bottom:15px;">
                    <span class="pulse"></span> D-1 · 이번 주말 라운드
                </div>
                <h1 style="font-size:42px; font-weight:800; line-height:1.3; margin-bottom:20px;">
                    그라운드의 열기를<br>가장 가까이, <span style="color:#22c55e;">K-리그 포털</span>
                </h1>
                <p style="color:#d1d5db; font-size:16px; margin-bottom:30px;">
                    실시간 경기 결과부터 순위, 굿즈, 티켓 예매까지 — 팬을 위한 모든 것을 한 곳에서.
                </p>
                <div class="d-flex gap-2">
                    <a href="../ticket/reserve_team.do" class="btn btn-success">티켓 예매하기</a>
                    <a href="../match/list.do" class="btn btn-outline-light">이번 달 일정 보기</a>
                </div>
            </div>
        </div>
</div>
        <!-- 슬라이드 2 -->
        <div class="carousel-item">
           <div style="background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)),
            url('../image/banner1.jpg') center/cover no-repeat;
            height:550px; padding:80px 100px; ">
              <div style="width:500px; margin-left: 150px; margin-top: 50px;">
                <div style="font-size:13px; font-weight:800; letter-spacing:2px; color:#3b82f6; margin-bottom:15px;">
                    OFFICIAL GOODS
                </div>
                <h1 style="font-size:42px; font-weight:800; line-height:1.3; margin-bottom:20px;">
                    나만의 응원 아이템을<br><span style="color:#3b82f6;">지금 바로 구매하세요</span>
                </h1>
                <p style="color:#d1d5db; font-size:16px; margin-bottom:30px;">
                    각 팀의 공식 유니폼, 머플러, 응원용품을 한 곳에서.
                </p>
                <div class="d-flex gap-2" >
                    <a href="../goods/find.do" class="btn btn-primary">굿즈 보러가기</a>
                </div>
            </div>
        </div>
	</div>
        <!-- 슬라이드 3 -->
        <div class="carousel-item">
            <div style="background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)),
            url('../image/banner8.jpg') center/cover no-repeat;
            height:550px; padding:80px 100px;">
              <div style="width:500px; margin-left: 150px; margin-top: 50px;" >
                <div style="font-size:13px; font-weight:800; letter-spacing:2px; color:#ed3030; margin-bottom:15px;">
                    COMMUNITY
                </div>
                <h1 style="font-size:42px; font-weight:800; line-height:1.3; margin-bottom:20px;">
                    팬들과 함께<br><span style="color:#ed3030;">소통하고 응원해요</span>
                </h1>
                <p style="color:#fcfcfc; font-size:16px; margin-bottom:30px;">
                    자유게시판, QnA, 공지사항까지 팬 커뮤니티의 모든 것.
                </p>
                <div class="d-flex gap-2">
                    <a href="../board/list.do" class="btn btn-danger text-dark">커뮤니티 가기</a>
                </div>
            </div>
        </div>
  </div>
    </div>

    <!-- 좌우 화살표 -->
    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>

</div>

  <!-- 최근 경기 스코어보드: 블랙 카드 -->
	<div class="kickoff-score-controls">
		<button type="button" class="kickoff-scroll-btn" id="btnScrollLeft">
			<i class="bi bi-chevron-left"></i>
		</button>
		<button type="button" class="kickoff-scroll-btn" id="btnScrollRight">
			<i class="bi bi-chevron-right"></i>
		</button>
	</div>
	<div class="kickoff-scoreboard">
		<div class="kickoff-scoreboard-label">최근 경기<br>결과</div>
		<div class="kickoff-score-wrapper" style="flex: 1; min-width: 0;">
			<div class="kickoff-score-track" id="scoreTrack">
				<c:forEach var="mvo" items="${mList}" begin="0" end="4">
				<div class="kickoff-score-card">
					<a href="../team/detail.do?team_id=${mvo.homeVo.team_id}" class="k-board-link">
						<span>${mvo.homeVo.team_name}</span>
						<img src="${mvo.homeVo.emblem}">
					</a>
					<div class="d-flex align-items-center mx-3">
						<span class="num">${mvo.home_goal}</span> 
						<span class="mx-2" style="color: #6b7280;">:</span> 
						<span class="num">${mvo.away_goal}</span>
					</div>
					<a href="../team/detail.do?team_id=${mvo.awayVo.team_id}" class="k-board-link">
						<img src="${mvo.awayVo.emblem}">
						<span>${mvo.awayVo.team_name}</span>
					</a>
					<span class="status ms-4">종료</span> 
				</div>
		      </c:forEach>
			<c:if test="${empty mList}">
				<div class="kickoff-score-card"><span class="status">최근 경기 데이터가 없습니다</span></div>
			</c:if>
			</div>
		</div>
	</div>
  

  <!-- 리그 순위 / 최근 경기: 화이트 카드 -->
  <div class="row g-4 mb-4">
    <div class="col-lg-7">
      <div class="card h-100">
        <div class="card-body p-4">
          <div class="kickoff-section-head">
            <div><div class="eyebrow">STANDINGS</div><h2>리그 순위</h2></div>
          </div>
          <table class="table table-borderless align-middle mb-0">
            <thead>
              <tr class="text-muted small">
                <th class="text-center">순위</th>
                <th>팀</th>
                <th class="text-center">승점</th>
                <th class="text-center">총득점</th>
                <th class="text-center">득실차</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="rvo" items="${rList}">
                <tr>
                  <td class="text-center fw-bold ${rvo.rank==1?'kickoff-rank-gold':''}">${rvo.rank }</td>
                  <td>
                    <div class="d-flex align-items-center gap-2">
                      	<span class="kickoff-crest sm"><a href="../team/detail.do?team_id=${rvo.team_id }"><img src="${rvo.emblem }"></a></span>
                      	<a href="../team/detail.do?team_id=${rvo.team_id }"  class="k-team-name">${rvo.team_name}</a>
                    </div>
                  </td>
                  <td class="text-center">${rvo.points}</td>
                  <td class="text-center">${rvo.goals}</td>
                  <td class="text-center">${rvo.goal_diff}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="col-lg-5">
      <div class="card h-100">
        <div class="card-body p-4">
          <div class="kickoff-section-head">
            <div><div class="eyebrow">RESULTS</div><h2>최근 경기</h2></div>
            <a href="../match/list.do" class="small text-muted text-decoration-none">전체보기</a>
          </div>
          	<c:forEach var="r" items="${mList}">
				<div class="kickoff-recent-match">
					<div class="k-match-team home">
						<a href="../team/detail.do?team_id=${r.homeVo.team_id}" class="k-team-name">
							${r.homeVo.team_name}
						</a>
						<a href="../team/detail.do?team_id=${r.homeVo.team_id}" class="kickoff-crest sm">
							<img src="${r.homeVo.emblem}">
						</a>
					</div>
				
					<div class="k-match-score">
						${r.home_goal} : ${r.away_goal}
					</div>
				
					<div class="k-match-team away">
						<a href="../team/detail.do?team_id=${r.awayVo.team_id}" class="kickoff-crest sm">
						<img src="${r.awayVo.emblem}">
						</a>
						<a href="../team/detail.do?team_id=${r.awayVo.team_id}" class="k-team-name">
							${r.awayVo.team_name}
						</a>
					</div>
				
					<div class="k-match-date">
						${r.dbday}<br>${r.game_time}
					</div>
				</div>
          	</c:forEach>
        </div>
      </div>
    </div>
  </div>

  <!-- 티켓 예매 배너 -->
	<div class="kickoff-ticket-banner mb-5 d-flex justify-content-between align-items-center p-4 border rounded">
		<div>
			<h3 class="mb-3">다음 경기, 자리가 채워지고 있어요</h3>
			<div class="match-info d-flex align-items-center fs-5">
				<span class="match-time me-4 text-muted">${cvo.dbday} ${cvo.game_time}</span>
				
				<div class="team home-team d-flex align-items-center">
					<a href="../team/detail.do?team_id=${mvo.homeVo.team_id}" class="k-team-name">
						<img src="${cvo.homeVo.emblem }" alt="${cvo.homeVo.team_name}" class="emblem-img me-2" style="width: 32px; height: 32px; object-fit: contain;">
						<span class="fw-bold">${cvo.homeVo.team_name}</span>
					</a>
				</div>
	      
				<span class="vs-text mx-3 text-muted fw-bold">VS</span>
	      
				<div class="team away-team d-flex align-items-center">
					<a href="../team/detail.do?team_id=${mvo.awayVo.team_id}" class="k-team-name">
						<img src="${cvo.awayVo.emblem }" alt="${cvo.awayVo.team_name}" class="emblem-img me-2" style="width: 32px; height: 32px; object-fit: contain;">
						<span class="fw-bold">${cvo.awayVo.team_name}</span>
					</a>
				</div>
			</div>
		</div>
	<c:if test="${sessionScope.user!=null }">
		<a href="../ticket/reserve_ticket.do?sid=${cvo.schedule_id }" class="btn btn-success btn-lg flex-shrink-0 ml-3">티켓 예매하기</a>
	</c:if>
	<c:if test="${sessionScope.user==null }">
		<button class="btn btn-success btn-lg flex-shrink-0 ml-3" disabled>로그인이 필요한 서비스입니다</button>
	</c:if>
</div>
	<section class="mb-5">
		<div class="kickoff-section-head">
			<div>
				<div class="eyebrow" style="color: var(--green)">
					NOTICE
				</div>
				<h2>공지 사항</h2>
			</div>
			<div class="text-end">
				<a href="../notice/user_list.do" class="small text-muted text-decoration-none text-right">전체보기</a>
			</div>
		</div>
		<div class="notice-card p-4">
			<div class="table-responsive">
				<table class="notice-table table align-middle mb-0">
					<thead>
						<tr>
							<th class="text-center" style="width: 10%">번호</th>
							<th style="width: 50%">제목</th>
							<th class="text-center" style="width: 15%">작성자</th>
							<th class="text-center" style="width: 15%">등록일</th>
							<th class="text-center" style="width: 10%">조회수</th>
						</tr>
					</thead>
					<c:forEach var="vo" items="${nList}">
						<tr>
							<td class="text-center fw-bold">${vo.no}</td>
							<td>
								<c:choose>
									<c:when test="${vo.type==1}">
										<span class="notice-category service">
											서비스/점검
										</span>
									</c:when>
									<c:when test="${vo.type==2}">
										<span class="notice-category event">
											이벤트
										</span>
									</c:when>
									<c:when test="${vo.type==3}">
										<span class="notice-category policy">
											정책변경
										</span>
									</c:when>
									<c:when test="${vo.type==4}">
										<span class="notice-category operation">
											영업/운영
										</span>
									</c:when>
									<c:when test="${vo.type==5}">
										<span class="notice-category schedule">
											행사/일정
										</span>
									</c:when>
								</c:choose>
								<a class="notice-title ms-2" href="../notice/detail.do?no=${vo.no}">${vo.title}</a>
							</td>
							<td class="text-center">${vo.name}</td>
							<td class="text-center text-muted">${vo.dbday}</td>
							<td class="text-center">${vo.hit}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</section>
  <!-- 뉴스 -->
	<section class="mb-5">
		<div class="kickoff-section-head">
			<div>
				<div class="eyebrow" style="color: var(--green);">
					LIVE NEWS
				</div>
				<h2>최신 뉴스</h2>
			</div>
			<div class="text-end">
				<a href="../news/find.do" class="small text-muted text-decoration-none text-right">전체보기</a>
				<div class="small fw-medium" style="color: var(--green);" id="newsUpdateTime">업데이트 대기 중...</div>
			</div>
		</div> 
		<div class="row row-cols-1 row-cols-md-3 g-4" id="realtimeNewsContainer">
			<div class="col w-100 text-center py-5 text-muted">
				실시간 뉴스를 불러오는 중입니다...
			</div>
		</div>
	</section>

  <!-- 영상 -->
	<section class="mb-5">
		<div class="kickoff-section-head">
			<div><div class="eyebrow">VIDEO</div><h2>하이라이트 영상</h2></div>
			<a href="../video/highlights.do" class="small text-muted text-decoration-none">전체보기</a>
		</div>
		<div class="row row-cols-2 row-cols-md-4 g-3" id="youtubeApp">
			<div v-if="isLoading" class="col w-100 text-center py-5 text-muted">
				영상을 불러오는 중입니다...
			</div>
			<div v-else-if="isError" class="col w-100 text-center py-4 text-danger">
				영상을 불러올 수 없습니다.
			</div>
			<div v-else v-for="video in videos" :key="video.id.videoId" class="col">
				<a :href="'https://www.youtube.com/watch?v='+video.id.videoId" target="_blank" class="text-decoration-none text-dark">
					<div class="kickoff-video-thumb" :style="{ backgroundImage: 'url('+video.snippet.thumbnails.medium.url+')',backgroundSize:'cover',backgroundPosition:'center' }">
						<div class="play-btn"></div>
					</div>
					<div class="mt-2 fw-medium text-truncate" style="font-size: 14px;" :title="video.snippet.title">
						{{ video.snippet.title }}
					</div>    
				</a>
			</div>
		</div>
	</section>

  <!-- 인기 굿즈 -->
  <section class="mb-3">
  <div class="kickoff-section-head">
    <div>
      <div class="eyebrow">GOODS SHOP</div>
      <h2>인기 굿즈</h2>
    </div>
    <a href="../goods/find.do" class="small text-muted text-decoration-none">굿즈샵 바로가기</a>
  </div>
  <div id="goodsCarousel"
     class="carousel slide goods-carousel"
     data-bs-ride="carousel"
     data-bs-interval="3500">

    <div class="carousel-inner">
      <c:forEach var="g" items="${gList}" varStatus="st">
        <c:if test="${st.index % 4 == 0}">
          <div class="carousel-item ${st.index == 0 ? 'active' : ''}">
            <div class="row row-cols-2 row-cols-md-4 g-4">
        </c:if>
        <div class="col">
          <a href="../goods/detail.do?no=${g.goodsNo}"
             class="card h-100 shadow-sm border-0 text-decoration-none text-dark">
            <div class="kickoff-goods-thumb"
                 style="background:url('${g.imageUrl}') center/cover no-repeat;">
            </div>
            <div class="card-body">
              <div class="small fw-medium mb-1 text-truncate">
                ${g.goodsName}
              </div>
              <div class="fw-bold text-success">
                <fmt:formatNumber value="${g.price}" pattern="#,###"/>원
              </div>
            </div>

          </a>
        </div>
        <c:if test="${st.index % 4 == 3 || st.last}">
            </div>
          </div>
        </c:if>
      </c:forEach>
    </div>
    
    <button class="carousel-control-prev"
            type="button"
            data-bs-target="#goodsCarousel"
            data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next"
            type="button"
            data-bs-target="#goodsCarousel"
            data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button> 
    </div>
 
 
</section>

</main>
<script>
$((e)=>{
	const track=document.getElementById('scoreTrack')
	const scrollAmount=300
	$('#btnScrollLeft').on('click',(e)=>{
		track.scrollLeft-=scrollAmount
	})
	$('#btnScrollRight').on('click',(e)=>{
		track.scrollLeft+=scrollAmount
	})
	
	const ws = new WebSocket("ws://"+window.location.host+"/Kick-Off/news")
    const $newsContainer = $('#realtimeNewsContainer')
    const $updateTime = $('#newsUpdateTime')

    ws.onopen=()=>console.log("뉴스 서버 연결 완료")
    ws.onclose=()=>console.log("뉴스 서버 연결 종료")
    ws.onerror=(e)=>console.error("뉴스 소켓 에러:",e)
    
    ws.onmessage=(event)=>{
        try {
            const data=JSON.parse(event.data)
            let html=""
            
            data.slice(0,6).forEach(news =>{
                html+='<div class="col">'+
                          '<a href="'+news.link+'" target="_blank" class="text-decoration-none">'+
                            '<div class="card h-100 news-card">'+
                              '<div class="card-body">'+
                                '<span class="badge text-bg-success bg-opacity-10 text-success mb-2">실시간</span>'+
                                '<h6 class="card-title fw-bold text-dark">'+news.title+'</h6>'+
                              '</div>'+
                            '</div>'+
                          '</a>'+
                        '</div>'
            })
            $newsContainer.html(html)
            const now = new Date()
            $updateTime.text(now.toLocaleTimeString()+'기준')
        } catch(err) {
            console.error("뉴스 데이터 파싱 실패:",err)
        }
    }
})
const youtubeApp=Vue.createApp({
	data(){
		return{
			videos:[],
			isLoading:true,
			isError:false,
		}
	},
	mounted(){
		this.dataRecv()
	},
	methods:{
		async dataRecv(){
			const url='../youtubeProxy?keyword='+encodeURIComponent('K리그 하이라이트')+'&max=4'
			try{
				const response=await axios.get(url)
				this.videos=response.data.items
				if(response.data={}){
					this.isError=true
				}
			}catch(error){
				console.error(error)
				this.isError=true
			}finally{
				this.isLoading=false
			}
		}
	}
}).mount('#youtubeApp')
</script>