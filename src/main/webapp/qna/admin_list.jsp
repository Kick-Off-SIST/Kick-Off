<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
.admin-content{
    background:#fff;
    border-radius:14px;
    padding:30px;
    box-shadow:0 4px 15px rgba(0,0,0,.05);
}

/* 테이블 */
.board-table{
    background:#fff;
    border-radius:12px;
    overflow:hidden;
    margin-bottom:0;
    border:1px solid #edf1f5;
}

.board-table thead th{
    background:#f8fafc;
    color:#495057;
    text-align:center;
    font-size:14px;
    font-weight:700;
    border-bottom:2px solid #e9ecef;
    padding:16px 12px;
}

.board-table tbody td{
    padding:18px 12px;
    vertical-align:middle;
    border-color:#f1f3f5;
    font-size:14px;
}

.dataTr{
    transition:all .2s ease;
}

.dataTr:hover{
    background:#f8fffb;
}

.dataTr td:first-child{
    font-weight:600;
    color:#6c757d;
}

.dataTr a{
    color:#212529;
    font-weight:600;
    text-decoration:none;
    transition:.2s;
}

.dataTr a:hover{
    color:#16a34a;
}

/* 상태 */
.badge-wait{
    display:inline-block;
    min-width:85px;
    padding:6px 14px;
    border-radius:30px;
    background:#fff7ed;
    color:#ea580c;
    border:1px solid #fed7aa;
    font-size:12px;
    font-weight:600;
}

.badge-done{
    display:inline-block;
    min-width:85px;
    padding:6px 14px;
    border-radius:30px;
    background:#dcfce7;
    color:#15803d;
    border:1px solid #bbf7d0;
    font-size:12px;
    font-weight:600;
}

/* 페이지네이션 */
.pagination{
    margin-top:30px;
}

.pagination .page-link{
    border:none;
    border-radius:10px;
    margin:0 4px;
    padding:8px 16px;
    background:#f8fafc;
    color:#495057;
    transition:.2s;
}

.pagination .page-link:hover{
    background:#16a34a;
    color:#fff;
}

.pagination .page-item.active .page-link{
    background:#16a34a;
    color:#fff;
}

.pagination .page-item.disabled .page-link{
    background:#f3f4f6;
    color:#adb5bd;
}

.empty-row{
    color:#868e96;
    padding:40px 0 !important;
}
</style>

<div class="admin-content">

   
    <!-- 테이블 -->
    <table class="table board-table align-middle">
        <thead>
            <tr>
                <th width="8%">번호</th>
                <th width="42%">제목</th>
                <th width="15%">작성자</th>
                <th width="15%">작성일</th>
                <th width="10%">조회수</th>
                <th width="10%">상태</th>
            </tr>
        </thead>

        <tbody>
        	<c:set var="count" value="${count }"/>
            <c:forEach var="vo" items="${list}">
                <tr class="dataTr">
                    <td class="text-center">${count}</td>

                    <td>
                        <a href="../adminpage/qna_detail.do?no=${vo.no}">
                            <i class="bi bi-chat-left-text me-2 text-success"></i>
                            ${vo.title}
                        </a>
                    </td>

                    <td class="text-center">${vo.login_id}</td>

                    <td class="text-center text-muted">
                        ${vo.dbday}
                    </td>

                    <td class="text-center">
                        ${vo.hit}
                    </td>

                    <td class="text-center">
                        <c:choose>
                            <c:when test="${vo.state==0}">
                                <span class="badge-wait">
                                    답변대기
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge-done">
                                    답변완료
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <c:set var="count" value="${count-1 }"/> 
            </c:forEach>

            <c:if test="${empty list}">
                <tr>
                    <td colspan="6" class="text-center empty-row">
                        등록된 문의가 없습니다.
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <!-- 페이지 -->
    <nav>
        <ul class="pagination justify-content-center">

            <li class="page-item ${curpage<=1?'disabled':''}">
                <a class="page-link"
                   href="../adminpage/qna_list.do?page=${curpage>1?curpage-1:curpage}">
                    ◀ 이전
                </a>
            </li>

            <li class="page-item active">
                <span class="page-link">
                    ${curpage} / ${totalpage}
                </span>
            </li>

            <li class="page-item ${curpage>=totalpage?'disabled':''}">
                <a class="page-link"
                   href="../adminpage/qna_list.do?page=${curpage<totalpage?curpage+1:curpage}">
                    다음 ▶
                </a>
            </li>

        </ul>
    </nav>

</div>