<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fn" uri="jakarta.tags.functions" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
.board-card{
    border:none;
    border-radius:12px;
    box-shadow:none;
    border: 1px solid #e5e7eb
}
.info-table{
    margin-bottom:0;
}
.info-table th{
    width:15%;
    background:#198754;
    color:white;
    text-align:center;
    vertical-align:middle;
    font-weight:600;
    font-size:14px;
}
.info-table td{
    vertical-align:middle;
    font-size:14px;
}
.info-table th:not(:last-child){
    border-right:1px solid rgba(255,255,255,.3);
}
.info-table td:not(:last-child){
    border-right:1px solid var(--line, #e2e5ea);
}
.info-table tr:first-child th,
.info-table tr:first-child td{
    border-top:none;
}

.content-box{
    min-height:280px;
    white-space:pre-wrap;
    background: var(--bg, #eef1f4);
    border:none;
    border-radius:8px;
    padding:20px;
    font-size:15px;
    line-height:1.8;
    color:#1f2328;
}

.board-actions .btn{
    border-radius:20px;
    padding:6px 18px;
    font-weight:600;
    font-size:13.5px;
}
.board-actions .btn-success{
    background:#198754;
    border-color:#198754;
}

/* ===== 댓글 영역 ===== */
.reply-area{
    width:100%;
}
.reply-area h3{
    font-size:18px;
}
.reply-count{
    color:#198754;
    font-weight:700;
}
.reply-box{
    background:#f8f9fa;
    border-radius:12px;
    padding:16px 18px;
    border:1px solid #eceff1;
    transition: box-shadow .15s ease;
}
.reply-box:hover{
    box-shadow:0 2px 8px rgba(0,0,0,.05);
}
.reply-header{
    font-size:14px;
}
.reply-avatar{
    width:28px; height:28px; border-radius:50%;
    background:#198754; color:#fff;
    display:inline-flex; align-items:center; justify-content:center;
    font-size:12px; font-weight:700; margin-right:6px; flex-shrink:0;
}
.reply-content{
    background:white;
    border-radius:8px;
    padding:14px 16px;
    min-height:44px;
    white-space:pre-wrap;
    line-height:1.6;
    font-size:14px;
    border:1px solid #f0f1f3;
}
.reply-write textarea,
.ups textarea{
    resize:none;
    height:110px;
    border-radius:10px;
}
.reply-write textarea:focus,
.ups textarea:focus{
    border-color:#198754;
    box-shadow:0 0 0 .2rem rgba(25,135,84,.15);
}
.ups{
    background:#fff;
    border:1px dashed #ced4da;
    border-radius:10px;
    padding:12px;
}
.updateBtns{
    cursor:pointer;
}
</style>

<script>
let i=0;

$(function(){

    $('#delSpan').click(function(){

        if(i==0){
            $('#delText').text("취소");
            $('#delTr').slideDown();
            i=1;
        }
        else{
            $('#delText').text("삭제");
            $('#delTr').slideUp();
            i=0;
        }

    });

    $('#delBtn').click(function(){

        let pwd=$('#delPwd').val().trim();

        if(pwd=="")
        {
            $('#delPwd').focus();
            return;
        }

        let no=$('#no').text().trim();

        $.ajax({
            type:'post',
            url:'../board/delete.do',
            data:{
                no:no,
                pwd:pwd
            },
            success:function(res){

                res=res.trim();

                if(res==="yes")
                {
                    location.href="../board/list.do";
                }
                else
                {
                    alert("비밀번호가 일치하지 않습니다.");
                    $('#delPwd').val("");
                    $('#delPwd').focus();
                }
            },
            error:function(xhr){
                alert("삭제 실패 ("+xhr.status+")");
            }
        })

    });

    // 댓글 수정 버튼 -> 해당 댓글의 수정 폼(#up + no) 토글
    // (이 부분이 빠져있어서 지금까지 '수정' 버튼을 눌러도 폼이 안 열렸어요)
    $('.updateBtns').click(function(){
        let no = $(this).data('no');
        $('#up'+no).slideToggle();
    });

});
</script>

<main class="container main-content">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold mb-0">게시글 상세보기</h2>
        <a href="../board/list.do" class="text-muted text-decoration-none small">
            <i class="fa fa-list"></i> 목록으로
        </a>
    </div>

    <div class="card board-card">

        <div class="card-body p-4">

            <table class="table info-table">

                <tr>
                    <th>번호</th>
                    <td id="no">${vo.no}</td>

                    <th>작성일</th>
                    <td>${vo.dbday}</td>
                </tr>

                <tr>
                    <th>작성자</th>
                    <td>${vo.loginId}</td>

                    <th>조회수</th>
                    <td>${vo.hit}</td>
                </tr>

                <tr>
                    <th>제목</th>
                    <td colspan="3">
                        <strong style="font-size:16px;">${vo.title}</strong>
                    </td>
                </tr>

            </table>

            <pre class="content-box mt-3">${vo.content}</pre>

            <div class="board-actions d-flex justify-content-end gap-2 mt-4">

                <a href="../board/update.do?no=${vo.no}"
                   class="btn btn-outline-secondary">
                    수정
                </a>

                <button class="btn btn-outline-danger"
                        id="delSpan" type="button">
                    <span id="delText">삭제</span>
                </button>

                <a href="../board/list.do"
                   class="btn btn-success">
                    목록
                </a>

            </div>

            <div id="delTr" style="display:none;" class="mt-3 pt-3 border-top">

                <div class="d-flex justify-content-end align-items-center gap-2">

                    <span class="text-muted small">비밀번호</span>

                    <input type="password"
                           id="delPwd"
                           class="form-control form-control-sm"
                           style="width:180px;">

                    <button
                        class="btn btn-outline-danger btn-sm"
                        id="delBtn" type="button">
                        삭제
                    </button>

                </div>

            </div>

            <!-- 댓글 영역: card-body 패딩 안쪽으로 이동 (잘림 방지) -->
            <hr class="my-4">

            <div class="reply-area">

                <h3 class="fw-bold mb-3">
                    댓글 <span class="reply-count">${rcount}</span>
                </h3>

                <c:if test="${rcount<1}">
                    <div class="alert alert-light text-center border">
                        댓글이 없습니다.
                    </div>
                </c:if>

                <c:if test="${rcount>0}">

                    <c:forEach var="rvo" items="${rList}">

                        <div class="reply-box mb-3">

                            <div class="reply-header d-flex justify-content-between align-items-center">

                                <div class="d-flex align-items-center">
                                    <span class="reply-avatar">${fn:substring(rvo.name,0,1)}</span>
                                    <b>${rvo.name}</b>
                                    <span class="text-muted ms-2">
                                        (${rvo.dbday})
                                    </span>
                                </div>

                                <c:if test="${rvo.id==sessionScope.user.login_id}">
                                    <div>
                                        <button
                                         class="btn btn-sm btn-outline-success updateBtns"
                                         data-no="${rvo.no}">
                                            수정
                                        </button>

                                        <a href="../reply/delete.do?no=${rvo.no}&bno=${vo.no}"
                                           class="btn btn-sm btn-outline-danger">
                                            삭제
                                        </a>
                                    </div>
                                </c:if>

                            </div>

                            <div class="reply-content mt-2">
                                ${rvo.msg}
                            </div>

                            <div class="ups mt-2"
                                 id="up${rvo.no}"
                                 style="display:none;">

                                <form method="post"
                                      action="../reply/update.do">

                                    <input type="hidden"
                                           name="bno"
                                           value="${vo.no}">

                                    <input type="hidden"
                                           name="no"
                                           value="${rvo.no}">

                                    <textarea class="form-control mb-2"
                                              name="msg">${rvo.msg}</textarea>

                                    <div class="text-end">
                                        <button class="btn btn-success btn-sm">
                                            수정하기
                                        </button>
                                    </div>

                                </form>

                            </div>

                        </div>

                    </c:forEach>

                </c:if>

                <c:if test="${sessionScope.user.login_id!=null}">

                    <div class="reply-write mt-4">

                        <form method="post"
                              action="../reply/insert.do">

                            <input type="hidden"
                                   name="bno"
                                   value="${vo.no}">

                            <textarea class="form-control mb-3"
                                      name="msg"
                                      placeholder="댓글을 입력하세요"></textarea>

                            <div class="text-end">

                                <button class="btn btn-success px-4">
                                    댓글쓰기
                                </button>

                            </div>

                        </form>

                    </div>

                </c:if>

            </div>

        </div>

    </div>

</main>
