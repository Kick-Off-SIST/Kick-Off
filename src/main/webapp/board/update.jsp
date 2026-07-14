<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
.board-card{
    border:none;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,.08);
}
.write-table th{
    width:15%;
    background:#198754;
    color:#fff;
    text-align:center;
    vertical-align:middle;
}
.write-table td{
    vertical-align:middle;
}
</style>

<script>
$(function(){

    $('#updateBtn').click(function(){

        let no=$("#no").val()
        let title=$("#title").val().trim()
        let content=$("#content").val().trim()
        let pwd=$("#updatepwd").val().trim()

        if(title===""){
            $("#title").focus()
            return
        }

        if(content===""){
            $("#content").focus()
            return
        }

        if(pwd===""){
            $("#updatepwd").focus()
            return
        }

        $.ajax({
            type:'post',
            url:'../board/update_ok.do',
            data:{
                no:no,
                title:title,
                content:content,
                pwd:pwd
            },
            success:function(res){

                res=res.trim()

                if(res==="yes")
                {
                    location.href="../board/detail.do?no="+no
                }
                else
                {
                    alert("비밀번호가 일치하지 않습니다.")
                    $("#updatepwd").val("").focus()
                }

            },
            error:function(){
                alert("수정 중 오류가 발생했습니다.")
            }
        })

    })

})
</script>

<main class="container main-content">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold mb-0">게시글 수정</h2>
    </div>

    <div class="card board-card">

        <div class="card-body p-4">

            <input type="hidden" id="no" value="${vo.no}">

            <table class="table write-table">

                <tr>
                    <th>제목</th>
                    <td>
                        <input
                            type="text"
                            id="title"
                            class="form-control"
                            value="${vo.title}">
                    </td>
                </tr>

                <tr>
                    <th>내용</th>
                    <td>
                        <textarea
                            id="content"
                            rows="12"
                            class="form-control"
                            style="resize:none;">${vo.content}</textarea>
                    </td>
                </tr>

                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input
                            type="password"
                            id="updatepwd"
                            class="form-control"
                            style="width:220px;"
                            placeholder="게시글 비밀번호">
                    </td>
                </tr>

                <tr>
                    <td colspan="2" class="text-end">

                        <button
                            type="button"
                            class="btn btn-success"
                            id="updateBtn">
                            수정하기
                        </button>

                        <button
                            type="button"
                            class="btn btn-secondary"
                            onclick="history.back()">
                            취소
                        </button>

                    </td>
                </tr>

            </table>

        </div>

    </div>

</main>