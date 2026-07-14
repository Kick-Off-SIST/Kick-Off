<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<style type="text/css">
.board-card{
	border:none;
	border-radius:12px;
	box-shadow:0 4px 12px rgba(0,0,0,.08);
	overflow:hidden;
}
.dataTr td{
	font-size: 13px;
	vertical-align: middle;
}
.dataTr:hover{
	background-color: var(--green-soft, #e6f4ec);
}
.board-actions .btn{
	border-radius:20px;
	padding:6px 18px;
	font-weight:600;
	font-size:13.5px;
}
</style>

<main class="container main-content">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="fw-bold mb-0">자유게시판</h2>
    <div class="board-actions">
      <a href="#" class="btn btn-success btn-sm" onclick="goWrite()">글쓰기</a>
    </div>
  </div>

  <div class="card board-card">
    <div class="table-responsive">
      <table class="table align-middle mb-0">
        <thead>
          <tr class="table-success text-center">
            <th style="width:10%">번호</th>
            <th style="width:40%">제목</th>
            <th style="width:10%">아이디</th>
            <th style="width:15%">작성일</th>
            <th style="width:10%">조회수</th>
            <th style="width:10%">댓글</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="count" value="${count }"/>
          <c:forEach var="vo" items="${list }">
          <tr class="dataTr">
            <td class="text-center">${count}</td>
            <td>
              <a href="../board/detail.do?no=${vo.no }" class="text-decoration-none text-dark">${vo.title }</a>
              <c:if test="${vo.dbday==today }">
                <span class="badge text-bg-success" style="font-size:10px; vertical-align:middle;">NEW</span>
              </c:if>
            </td>
            <td class="text-center text-muted">${vo.loginId }</td>
            <td class="text-center text-muted">${vo.dbday }</td>
            <td class="text-center text-muted">${vo.hit }</td>
            <td class="text-center text-muted">${vo.replycount }</td>
          </tr>
          <c:set var="count" value="${count-1 }"/>
          </c:forEach>
          <c:if test="${empty list}">
          <tr><td colspan="5" class="text-center text-muted py-5">등록된 게시글이 없습니다.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

  <nav class="mt-3">
    <ul class="pagination justify-content-center">
      <li class="page-item ${curpage<=1 ? 'disabled' : '' }">
        <a class="page-link" href="../board/list.do?page=${curpage>1?curpage-1:curpage }">이전</a>
      </li>
      <li class="page-item disabled">
        <span class="page-link">${curpage } / ${totalpage } pages</span>
      </li>
      <li class="page-item ${curpage>=totalpage ? 'disabled' : '' }">
        <a class="page-link" href="../board/list.do?page=${curpage<totalpage?curpage+1:curpage }">다음</a>
      </li>
    </ul>
  </nav>

</main>

<script>
function goWrite(){
    const login='${sessionScope.user.member_id}';

    if(login===''){
        const modal=new bootstrap.Modal(document.getElementById('loginModal'));
        modal.show();
        return;
    }

    location.href='../board/insert.do';
}
</script>
