<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>

.qna-detail-box{
    background:#fff;
    border:1px solid #e5e7eb;
    border-radius:12px;
    padding:30px;
}


.qna-title{
    font-size:22px;
    font-weight:800;
    margin-bottom:25px;
}


.qna-info{
    width:100%;
    border-collapse:collapse;
    margin-bottom:25px;
}


.qna-info th{
    width:120px;
    background:#f8fafc;
    border:1px solid #e5e7eb;
    padding:14px;
    text-align:center;
    font-weight:700;
}


.qna-info td{
    border:1px solid #e5e7eb;
    padding:14px;
}


.qna-content{
    border:1px solid #e5e7eb;
    background:#fafafa;
    border-radius:8px;
    padding:20px;
    min-height:180px;
    white-space:pre-wrap;
    line-height:1.7;
}


.reply-box{
    margin-top:30px;
    background:#f0fdf4;
    border:1px solid #bbf7d0;
    border-radius:10px;
    padding:25px;
}


.reply-title{
    font-size:18px;
    font-weight:700;
    margin-bottom:15px;
}


.reply-textarea{
    width:100%;
    min-height:150px;
    resize:none;
    border:1px solid #ddd;
    border-radius:8px;
    padding:15px;
}


.bottom-btn{
    margin-top:30px;
    text-align:right;
}

</style>


<div class="admin-content">


    <div class="qna-detail-box">


        <div class="qna-title">
            문의 상세
        </div>


        <table class="qna-info">

            <tr>
                <th>번호</th>
                <td>${vo.no}</td>

                <th>작성일</th>
                <td>${vo.dbday}</td>
            </tr>


            <tr>
                <th>작성자</th>
                <td>${vo.login_id}</td>

                <th>상태</th>
                <td>
                    <c:choose>

                        <c:when test="${vo.state==0}">
                            <span class="badge bg-warning">
                                답변대기
                            </span>
                        </c:when>


                        <c:otherwise>
                            <span class="badge bg-success">
                                답변완료
                            </span>
                        </c:otherwise>


                    </c:choose>
                </td>

            </tr>


            <tr>
                <th>제목</th>
                <td colspan="3">
                    <b>${vo.title}</b>
                </td>
            </tr>


        </table>



        <div class="qna-content">
            ${vo.content}
        </div>




        <c:if test="${vo.state==0}">

            <div class="reply-box">

                <div class="reply-title">
                    답변 작성
                </div>


                <form method="post" action="../adminpage/qna_reply_ok.do">

                    <input type="hidden" name="no" value="${vo.no}">
                    <input type="hidden" name="group_id" value="${vo.group_id}">


                    <textarea 
                        class="reply-textarea"
                        name="content"
                        placeholder="답변 내용을 입력하세요."
                        required></textarea>


                    <div class="bottom-btn">

                        <a href="../adminpage/qna_list.do"
                           class="btn btn-outline-secondary">
                            목록으로
                        </a>


                        <button type="submit"
                                class="btn btn-success">
                            답변 등록
                        </button>

                    </div>


                </form>


            </div>


        </c:if>




        <c:if test="${vo.state==1}">

            <div class="reply-box">

                <div class="reply-title">
                    답변 완료
                </div>

                <div>
                    이미 답변이 등록된 문의입니다.
                </div>

            </div>


            <div class="bottom-btn">

                <a href="../adminpage/qna_list.do"
                   class="btn btn-outline-secondary">
                    목록으로
                </a>

            </div>


        </c:if>



    </div>


</div>