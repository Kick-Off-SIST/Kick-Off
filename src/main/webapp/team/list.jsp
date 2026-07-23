<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</body>
<style type="text/css">
body{
	background: #f8f9fa
}
.team-hero{
	background:#111827;
	border-radius:18px;
	padding:45px 50px;
	margin-bottom:40px;
	color:white;
	position:relative;
	overflow:hidden;
	cursor:default;
	background-image:linear-gradient(rgba(17, 24, 39, 0.4), rgba(17, 24, 39, 0.4)), 
        url("../team/team1.jpg");
}
.team-hero:after{
	content:"";
	position:absolute;
	right:-80px;
	top:-80px;
	width:280px;
	height:280px;
	border-radius:50%;
	background:rgba(34,197,94,.15);
}
.team-eyebrow{
	color:#22c55e;
	font-size:13px;
	font-weight:800;
	letter-spacing:2px;
	margin-bottom:15px;
}
.team-hero h1{
	font-size:42px;
	font-weight:800;
	line-height:1.25;
	position:relative;
	z-index:1;
}
.team-hero p{
	color:#d1d5db;
	font-size:16px;
	position:relative;
	z-index:1;
}

.team-card{
	background: #ffffff;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	transition: transform 0.2s ease, border-color 0.2s ease;
	text-decoration: none;
	display: block
}
.team-card:hover{
	transform: translateY(-5px);
	border-color: #198754;
	box-shadow: 0 4px 12px rgba(0,0,0,0.05)
}
.emblem-wrapper{
	height: 180px;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 20px;
	background: #ffffff;
	border-bottom: 1px solid #f0f0f0;
	border-radius: 8px 8px 0 0
}
.emblem-img{
	max-width: 100%;
	max-height: 100%;
	object-fit: contain
}
.team-info{
	padding: 20px;
	text-align: center
}
.team-name{
	font-size: 18px;
	font-weight: bold;
	color: #212529;
	margin-bottom: 5px
}
.team-stadium{
	font-size: 13px;
	color: #6c757d
}
</style>
</head>
<body>
	<div class="container my-5">
		<div class="team-hero">
			<div class="team-eyebrow">
				KICK-OFF
			</div>
			<h1>
				KLeague<br>
				<span style="color:#22c55e">
					구단목록
				</span>
			</h1>
			<p>
				서울에서 부산까지<br>
				K-리그 참가 구단들을 만나보세요.
			</p>
		</div>
		<div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4">
			<c:forEach var="vo" items="${list }">
			<div class="col">
				<a href="../team/detail.do?team_id=${vo.team_id }" class="team-card h-100">
					<div class="emblem-wrapper">
						<img src="${vo.emblem }" class="emblem-img">
					</div>
					<div class="team-info">
						<div class="team-name">${vo.team_name }</div>
						<div class="team-stadium"><i class="bi bi-geo-alt-fill me-1"></i>${vo.svo.name }</div>
					</div>
				</a>
			</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>