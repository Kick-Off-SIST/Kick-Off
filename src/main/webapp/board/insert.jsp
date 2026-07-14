<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.board-card{
    border:none;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,.08);
}
.write-table th{
    width:15%;
    background:#198754;
    color:white;
    text-align:center;
    vertical-align:middle;
}
.write-table td{
    vertical-align:middle;
}
</style>

<main class="container main-content">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold mb-0">게시글 작성</h2>
    </div>

    <div class="card board-card">

        <div class="card-body p-4">

            <form method="post" action="../board/insert_ok.do">

                <input type="hidden"
                       name="member_id"
                       value="${sessionScope.user.member_id}">

                <table class="table write-table">

                    <tr>
                        <th>제목</th>
                        <td>
                            <input type="text"
                                   name="title"
                                   class="form-control"
                                   placeholder="제목을 입력하세요."
                                   required>
                        </td>
                    </tr>

                    <tr>
                        <th>내용</th>
                        <td>
                            <textarea name="content"
                                      rows="12"
                                      class="form-control"
                                      placeholder="내용을 입력하세요."
                                      style="resize:none;"
                                      required></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th>비밀번호</th>
                        <td>
                            <input type="password"
                                   name="pwd"
                                   class="form-control"
                                   style="width:220px;"
                                   placeholder="게시글 비밀번호"
                                   required>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2" class="text-end">

                            <button type="submit"
                                    class="btn btn-success">
                                글쓰기
                            </button>

                            <button type="button"
                                    class="btn btn-secondary"
                                    onclick="history.back()">
                                취소
                            </button>

                        </td>
                    </tr>

                </table>

            </form>

        </div>

    </div>

</main>