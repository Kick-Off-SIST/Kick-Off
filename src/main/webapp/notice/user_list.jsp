<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

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


.notice-hero p{
	color:#9ca3af;
}



/* 리스트 카드 */
.notice-card{

	background:white;
	border-radius:18px;
	padding:35px;
	box-shadow:0 10px 25px rgba(0,0,0,.06);

}



.notice-table{

	border-collapse:separate;
	border-spacing:0;
	overflow:hidden;
	border-radius:15px;

}



.notice-table thead th{

	background:#111827;
	color:white;
	padding:15px;
	border:none;

}



.notice-table tbody td{

	padding:18px 12px;
	vertical-align:middle;
	border-bottom:1px solid #eee;

}


.notice-table tbody tr:hover{

	background:#f8fafc;

}



/* 제목 링크 */

.notice-title{

	color:#111827;
	font-weight:600;
	text-decoration:none;

}


.notice-title:hover{

	color:#16a34a;

}



/* 카테고리 */

.notice-category {

	display:inline-block;
	padding:5px 14px;
	border-radius:20px;
	font-size:13px;
	font-weight:700;
	color:white;

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



/* 페이징 */

.notice-page a{

	border-radius:20px;
	margin:0 3px;

}


</style>


</head>


<body>



<section class="notice-hero">

<div class="container">

<h1>
공지사항
</h1>

<p>
KICK-OFF 서비스 새로운 소식과 안내사항을 확인하세요.
</p>


</div>

</section>




<div class="container mb-5">


<div class="notice-card">



<table class="table notice-table mb-0">


<thead>

<tr>

<th width="10%" class="text-center">
번호
</th>

<th width="45%">
제목
</th>

<th width="15%" class="text-center">
작성자
</th>

<th width="20%" class="text-center">
작성일
</th>

<th width="10%" class="text-center">
조회수
</th>


</tr>

</thead>




<tbody>


<c:forEach var="vo" items="${nlist}">


<tr>


<td class="text-center fw-bold">

${vo.no}

</td>



<td>


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



<a class="notice-title ms-2"
href="../notice/detail.do?no=${vo.no}">

${vo.title}

</a>


</td>



<td class="text-center">

${vo.name}

</td>


<td class="text-center text-muted">

${vo.dbday}

</td>


<td class="text-center">

${vo.hit}

</td>



</tr>


</c:forEach>



</tbody>


</table>



<!-- 페이지 영역 -->
<div class="notice-page text-center mt-4">


<c:if test="${curpage>1}">

<a href="../notice/user_list.do?page=${curpage-1}"
class="btn btn-outline-success btn-sm">

이전

</a>

</c:if>



<span class="mx-3 fw-bold">

${curpage} page / ${totalpage} pages

</span>



<c:if test="${curpage<totalpage}">

<a href="../notice/user_list.do?page=${curpage+1}"
class="btn btn-outline-success btn-sm">

다음

</a>

</c:if>


</div>



</div>


</div>



</body>
</html>