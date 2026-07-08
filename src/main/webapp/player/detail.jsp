<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
body {
	background-color: #f8f9fa;
}
.player-header {
	background-color: #212529;
	color: #ffffff;
	padding: 40px 0;
	margin-bottom: 40px;
}
.player-img {
	width: 180px;
	height: 180px;
	border-radius: 50%;
	border: 4px solid #ffffff;
	background-color: #ffffff;
	object-fit: cover;
}
.info-card {
	background-color: #ffffff;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	padding: 30px;
	margin-bottom: 20px;
}
.stat-box {
	background-color: #f8f9fa;
	border: 1px solid #eeeeee;
	border-radius: 6px;
	padding: 20px 10px;
	text-align: center;
}
.stat-title {
	font-size: 14px;
	color: #666666;
	margin-bottom: 5px;
}
.stat-value {
	font-size: 18px;
	font-weight: bold;
	color: #333333;
}
.side-panel {
	position: sticky;
	top: 80px;
}
</style>
</head>
<body>
<div class="player-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-3 text-center">
                <img src="${vo.img_url!=null?vo.img_url:'../player/no_image.png' }" class="player-img" onerror="this.src='../player/no_image.png'">
            </div>
            <div class="col-md-9 mt-3 mt-md-0">
                <span class="badge bg-success mb-2 px-2 py-1" style="font-size: 14px;">${vo.back_number } | ${vo.position }</span>
                <h2 class="fw-bold" style="font-size: 32px; margin-bottom: 5px;">
                    ${vo.name }
                    <span style="font-size: 20px; color: #aaaaaa; font-weight: normal; margin-left: 10px;">${vo.name_eng }</span>
                </h2>
                <div style="font-size: 18px; color: #cccccc; margin-top: 15px;">
                    <img src="${vo.tvo.emblem }" style="width: 25px; margin-right: 5px; vertical-align: middle;"> 
                    ${vo.tvo.team_name }
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="info-card">
                <h5 class="fw-bold mb-4" style="border-bottom: 2px solid #212529; padding-bottom: 10px;">
                    신체 및 기본 정보
                </h5>
                
                <div class="row g-3">
                    <div class="col-6 col-md-3">
                        <div class="stat-box">
                            <div class="stat-title">국적</div>
                            <div class="stat-value text-success">${vo.nationality }</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="stat-box">
                            <div class="stat-title">생년월일</div>
                            <div class="stat-value">${vo.dbday }</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="stat-box">
                            <div class="stat-title">신장</div>
                            <div class="stat-value">${vo.height } cm</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="stat-box">
                            <div class="stat-title">체중</div>
                            <div class="stat-value">${vo.weight } kg</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="info-card side-panel" id="likeApp">
                <h6 class="fw-bold mb-3 text-center">선수 응원하기</h6>
                <button type="button" class="btn btn-outline-danger w-100 mb-4" id="btnLike" style="font-weight: bold; font-size: 16px;">
                    <i class="bi bi-heart" id="likeIcon"></i> <span id="likeCount">${vo.likecount }</span>
                </button>
                
                <hr style="border-color: #dddddd; margin: 20px 0;">

                <div class="text-center">
                    <img src="${vo.tvo.emblem }" style="width: 50px; margin-bottom: 15px;">
                    <h6 class="fw-bold mb-3">소속팀 굿즈 스토어</h6>
                    <a href="../goods/list.do?${vo.team_id }" class="btn btn-dark w-100" style="font-weight: bold;">
                        구단 스토어 바로가기
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
$((e)=>{
    let currentCount=parseInt($('#likeCount').text().replace(/,/g,''))
    
    $('#btnLike').on('click',(e)=>{
    	let playerId = ${vo.player_id}
    	$.ajax({
    		type: 'post',
            url: '../player/like.do',
            data: { "player_id": playerId },
            success:(res)=>{
            	if(res.trim() === 'OK') {
                    currentCount++;
                    $('#likeCount').text(currentCount.toLocaleString())
                    $('#likeIcon').removeClass('bi-heart').addClass('bi-heart-fill text-danger')
                } else {
                    alert('처리 중 오류가 발생했습니다.')
                }
            }
    	})
    })
})

</script>
</body>
</html>