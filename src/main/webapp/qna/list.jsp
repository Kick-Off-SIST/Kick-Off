<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
.community-hero {
    background: #111827;
    border-radius: 18px;
    padding: 45px 50px;
    margin-bottom: 40px;
    color: white;
    position: relative;
    overflow: hidden;
}
.community-hero:after {
    content: "";
    position: absolute;
    right: -80px;
    top: -80px;
    width: 280px;
    height: 280px;
    border-radius: 50%;
    background: rgba(34,197,94,.15);
}
.community-eyebrow {
    font-size: 13px;
    font-weight: 800;
    letter-spacing: 2px;
    color: #22c55e;
    margin-bottom: 15px;
}
.community-hero h1 {
    font-size: 42px;
    font-weight: 800;
    line-height: 1.25;
    margin-bottom: 18px;
    position: relative;
    z-index: 1;
}
.community-hero p {
    color: #d1d5db;
    font-size: 16px;
    line-height: 1.7;
    position: relative;
    z-index: 1;
}
.board-title { font-size: 28px; font-weight: 800; }
.board-sub { color: #6b7280; font-size: 14px; }
.board-card { border: none; border-radius: 16px; box-shadow: 0 6px 18px rgba(0,0,0,.08); overflow: hidden; }
.board-table th { background: #f8fafc; text-align: center; font-size: 14px; font-weight: 700; }
.dataTr td { font-size: 14px; vertical-align: middle; }
.dataTr:hover { background: #f0fdf4; }
.board-link { text-decoration: none; color: #111827; font-weight: 600; }
.board-link:hover { color: #198754; }
.board-actions .btn { border-radius: 22px; padding: 8px 22px; font-weight: 700; }
.pagination .page-link { color: #198754; }
.pagination .active .page-link { background: #198754; border-color: #198754; color: white; }
</style>

<main class="container main-content">

    <!-- Community Hero -->
    <div class="community-hero">
        <div class="community-eyebrow">COMMUNITY</div>
        <h1>팬들과 함께 만드는<br><span style="color:#22c55e;">KICK-OFF QnA게시판</span></h1>
        <p>궁금한 모든걸 물어보고<br>경기 이야기와 다양한 의견을 나누는 공간입니다.</p>
    </div>

    <!-- 게시판 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <div class="eyebrow" style="color:#198754;">FREE BOARD</div>
            <h2 class="board-title mb-1">QnA게시판</h2>
            <p class="board-sub mb-0">뭐든지 문의하세요!.</p>
        </div>
        <div class="board-actions">
            <a href="#" class="btn btn-success" onclick="goWrite()">
                <i class="bi bi-pencil-fill me-1"></i>글쓰기
            </a>
        </div>
    </div>

    <!-- 게시글 리스트 -->
    <div class="card board-card">
        <div class="table-responsive">
            <table class="table board-table align-middle mb-0">
                <thead>
                    <tr>
                        <th width="10%">번호</th>
                        <th width="40%">제목</th>
                        <th width="10%">아이디</th>
                        <th width="15%">작성일</th>
                        <th width="10%">조회수</th>
                        <th width="10%">상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="count" value="${count}"/>
                    <c:forEach var="vo" items="${list}">
                        <tr class="dataTr">
                            <td class="text-center fw-bold">${count}</td>
                            <td>
                                <a href="../qna/detail.do?no=${vo.no}" class="board-link">${vo.title}</a>
                                <c:if test="${vo.dbday==today}">
                                    <span class="badge text-bg-success ms-1" style="font-size:10px;">NEW</span>
                                </c:if>
                            </td>
                            <td class="text-center text-muted">${vo.login_id}</td>
                            <td class="text-center text-muted">${vo.dbday}</td>
                            <td class="text-center text-muted">${vo.hit}</td>
                            <td class="text-center text-muted">
                              <c:choose>
                                <c:when test="${vo.state==1 }">
                                  <span class="badge bg-success">답변완료</span>
                                </c:when>
                                <c:otherwise>
                                  <span class="badge bg-warning">답변대기</span>
                                </c:otherwise>
                              </c:choose>
                            </td>
                        </tr>
                        <c:set var="count" value="${count-1}"/>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">등록된 게시글이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 페이지네이션 -->
    <nav class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item ${curpage<=1?'disabled':''}">
                <a class="page-link" href="../qna/list.do?page=${curpage>1?curpage-1:curpage}">이전</a>
            </li>
            <li class="page-item active">
                <span class="page-link">${curpage} / ${totalpage} pages</span>
            </li>
            <li class="page-item ${curpage>=totalpage?'disabled':''}">
                <a class="page-link" href="../qna/list.do?page=${curpage<totalpage?curpage+1:curpage}">다음</a>
            </li>
        </ul>
    </nav>

</main>

<script>
function goWrite() {
    const login = '${sessionScope.user.member_id}';
    if (login === '') {
        const modal = new bootstrap.Modal(document.getElementById('loginModal'));
        modal.show();
        return;
    }
    location.href = '../qna/insert.do';
}
</script>
