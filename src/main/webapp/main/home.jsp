<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<main class="container main-content">

  <!-- 히어로: 블랙 카드 -->
  <div class="kickoff-hero">
    <div class="kickoff-hero-eyebrow"><span class="pulse"></span>D-3 · 이번 주말 라운드</div>
    <h1>그라운드의 열기를<br>가장 가까이, <span class="accent">K-리그 포털</span></h1>
    <p>실시간 경기 결과부터 순위, 굿즈, 티켓 예매까지 — 팬을 위한 모든 것을 한 곳에서.</p>
    <div class="d-flex gap-2 mt-4">
      <a href="../ticket/reserve_team.do" class="btn btn-success">티켓 예매하기</a>
      <a href="../match/list.do" class="btn btn-outline-light">이번 달 일정 보기</a>
    </div>
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
      <div class="card shadow-sm border-0 h-100">
        <div class="card-body p-4">
          <div class="kickoff-section-head">
            <div><div class="eyebrow">STANDINGS</div><h2>리그 순위</h2></div>
          </div>
          <table class="table table-borderless align-middle mb-0">
            <thead>
              <tr class="text-muted small">
                <th class="text-center">순위</th>
                <th>팀</th>
                <th class="text-center">승수</th>
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
                  <td class="text-center">${rvo.wins} 승</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="col-lg-5">
      <div class="card shadow-sm border-0 h-100">
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
  <div class="kickoff-ticket-banner mb-5">
    <div>
      <h3>다음 홈경기, 자리가 채워지고 있어요</h3>
      <p>${nextHomeMatch.matchDate} ${nextHomeMatch.matchTime} · ${nextHomeMatch.homeTeamName} vs ${nextHomeMatch.awayTeamName} · 잔여석 약 ${nextHomeMatch.remainRate}%</p>
    </div>
    <a href="../ticket/reserve_team.do" class="btn btn-success">티켓 예매하기</a>
  </div>

  <!-- 뉴스 -->
  <section class="mb-5">
    <div class="kickoff-section-head">
      <div><div class="eyebrow">NEWS</div><h2>최신 뉴스</h2></div>
      <a href="#" class="small text-muted text-decoration-none">전체보기</a>
    </div>
    <div class="row row-cols-1 row-cols-md-3 g-4">
      <c:forEach var="n" items="${newsList}">
        <div class="col">
          <div class="card h-100 shadow-sm border-0">
            <div class="card-body">
              <span class="badge text-bg-success bg-opacity-10 text-success mb-2">${n.category}</span>
              <h6 class="card-title fw-bold">${n.title}</h6>
              <div class="text-muted small">${n.regDate}</div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </section>

  <!-- 영상 -->
  <section class="mb-5">
    <div class="kickoff-section-head">
      <div><div class="eyebrow">VIDEO</div><h2>하이라이트 영상</h2></div>
      <a href="#" class="small text-muted text-decoration-none">전체보기</a>
    </div>
    <div class="row row-cols-2 row-cols-md-4 g-3">
      <c:forEach var="v" items="${videoList}">
        <div class="col">
          <div class="kickoff-video-thumb">
            <div class="play-btn"></div>
            <div class="dur">${v.duration}</div>
          </div>
        </div>
      </c:forEach>
    </div>
  </section>

  <!-- 참가 구단 -->
  <section class="mb-5">
    <div class="kickoff-section-head">
      <div><div class="eyebrow">TEAMS</div><h2>참가 구단</h2></div>
      <a href="../team/list.do" class="small text-muted text-decoration-none">전체보기</a>
    </div>
    <div class="row row-cols-3 row-cols-md-6 g-3">
      <c:forEach var="t" items="${teamList}">
        <div class="col">
          <a href="../team/detail.do?team_id=${t.teamId}" class="card shadow-sm border-0 text-center text-decoration-none text-dark p-3 h-100">
            <span class="kickoff-crest mx-auto mb-2"></span>
            <span class="small fw-medium">${t.teamName}</span>
          </a>
        </div>
      </c:forEach>
    </div>
  </section>

  <!-- 인기 굿즈 -->
  <section class="mb-3">
    <div class="kickoff-section-head">
      <div><div class="eyebrow">GOODS SHOP</div><h2>인기 굿즈</h2></div>
      <a href="../goods/find.do" class="small text-muted text-decoration-none">굿즈샵 바로가기</a>
    </div>
    <div class="row row-cols-2 row-cols-md-4 g-4">
      <c:forEach var="g" items="${goodsList}">
        <div class="col">
          <a href="../goods/detail.do?no=${g.goodsId}" class="card h-100 shadow-sm border-0 text-decoration-none text-dark">
            <div class="kickoff-goods-thumb"></div>
            <div class="card-body">
              <div class="small fw-medium mb-1">${g.goodsName}</div>
              <div class="fw-bold text-success"><fmt:formatNumber value="${g.price}" pattern="#,###"/>원</div>
            </div>
          </a>
        </div>
      </c:forEach>
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
})
</script>