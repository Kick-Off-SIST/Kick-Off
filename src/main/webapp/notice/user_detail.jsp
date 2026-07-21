<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f8f9fa;
}


/* 상단 배너 */
.notice-hero{
    background:#111827;
    color:white;
    padding:60px 0;
    margin-bottom:40px;
}

.notice-hero h1{
    font-size:40px;
    font-weight:800;
}

.notice-card{
    background:white;
    border-radius:18px;
    padding:40px;
    box-shadow:0 10px 25px rgba(0,0,0,.06);
}


.notice-title{
    font-size:28px;
    font-weight:800;
    margin-bottom:25px;
}


.notice-info{
    display:grid;
    grid-template-columns:120px 1fr 120px 1fr;
    border-top:1px solid #eee;
    border-bottom:1px solid #eee;
}


.notice-info div{
    padding:15px;
    border-bottom:1px solid #eee;
}


.notice-label{
    font-weight:700;
    background:#f3f4f6;
    text-align:center;
}


.notice-content{
    min-height:250px;
    padding:30px 10px;
    font-size:16px;
    line-height:1.8;
}


/* 카테고리 */
.notice-category{
    display:inline-block;
    padding:5px 14px;
    border-radius:20px;
    color:white;
    font-size:13px;
    font-weight:700;
}


.service{
    background:#2563eb;
}

.event{
    background:#ec4899;
}

.policy{
    background:#f59e0b;
}

.operation{
    background:#10b981;
}

.schedule{
    background:#8b5cf6;
}


</style>

</head>


<body>


<section class="notice-hero">
    <div class="container">
        <h1>
            공지사항
        </h1>
        <p class="text-secondary">
            KICK-OFF 서비스 안내 및 새로운 소식을 확인하세요.
        </p>
    </div>
</section>



<div class="container mb-5">

<div class="notice-card">


<div class="notice-title">
    ${vo.title}
</div>



<div class="notice-info">


<div class="notice-label">
    공지종류
</div>

<div>

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

</div>



<div class="notice-label">
작성일
</div>


<div>
${vo.dbday}
</div>



<div class="notice-label">
작성자
</div>


<div>
${vo.name}
</div>


<div class="notice-label">
조회수
</div>


<div>
${vo.hit}
</div>


</div>



<div class="notice-content">

${vo.content}

</div>



<div class="text-end">

<a href="../notice/user_list.do"
class="btn btn-success px-4">
목록
</a>

</div>


</div>

</div>


</body>
</html>