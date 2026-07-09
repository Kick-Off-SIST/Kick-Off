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
		<h4 class="mb-4 fw-bold text-dark border-bottom pb-3">
			<i class="bi bi-shield-shaded text-success me-2"></i>K리그 구단 목록
		</h4>
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