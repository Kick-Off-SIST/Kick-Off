<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
.board-card{
    border:none;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,.08);
}
.info-table th{
    width:15%;
    background:#198754;
    color:white;
    text-align:center;
    vertical-align:middle;
}
.info-table td{
    vertical-align:middle;
}
.content-box{
    min-height:300px;
    white-space:pre-wrap;
    background:#fff;
    border:none;
    font-size:15px;
    line-height:1.8;
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

});
</script>

<main class="container main-content">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold">게시글 상세보기</h2>
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
                        <strong>${vo.title}</strong>
                    </td>
                </tr>

                <tr>
                    <td colspan="4">

<pre class="content-box">${vo.content}</pre>

                    </td>
                </tr>

                <tr>
                    <td colspan="4" class="text-end">

                        <a href="../board/update.do?no=${vo.no}"
                           class="btn btn-warning">
                            수정
                        </a>

                        <button class="btn btn-danger"
                                id="delSpan">
                            <span id="delText">삭제</span>
                        </button>

                        <a href="../board/list.do"
                           class="btn btn-success">
                            목록
                        </a>

                    </td>
                </tr>

                <tr id="delTr" style="display:none;">
                    <td colspan="4">

                        <div class="d-flex justify-content-end align-items-center gap-2">

                            <span>비밀번호</span>

                            <input type="password"
                                   id="delPwd"
                                   class="form-control"
                                   style="width:180px;">

                            <button
                                class="btn btn-outline-danger"
                                id="delBtn">
                                삭제
                            </button>

                        </div>

                    </td>
                </tr>

            </table>

        </div>

    </div>

</main>