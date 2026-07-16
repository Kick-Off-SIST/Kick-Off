<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
body {
	background-color: #f8f9fa;
}
.team-header {
	background-color: #212529;
	color: #ffffff;
	padding: 40px 0;
	margin-bottom: 40px;
}
.team-emblem {
	width: 150px;
	height: 150px;
	object-fit: contain;
	background-color: rgba(255, 255, 255, 0.9);
	border-radius: 50%;
	padding: 15px;
	border: 4px solid #198754;
}
.info-card {
	background-color: #ffffff;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	padding: 30px;
	margin-bottom: 20px;
}
.map-area {
	width: 100%;
	height: 400px;
	background-color: #e9ecef;
	border: 1px solid #cccccc;
	border-radius: 4px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #6c757d;
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 20px;
}
.stadium-stat {
	background-color: #f8f9fa;
	border: 1px solid #eeeeee;
	border-radius: 6px;
	padding: 15px;
	text-align: center;
}
.stat-title {
	font-size: 14px;
	color: #666666;
	margin-bottom: 5px;
}
.stat-value {
	font-size: 16px;
	font-weight: bold;
	color: #333333;
}
.side-panel {
	position: sticky;
	top: 80px;
}
.stadium-img {
	width: 100%;
	height: 350px;
	object-fit: cover;
	border-radius: 6px;
	border: 1px solid #eeeeee;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<div class="team-header">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-3 text-center mb-3 mb-md-0">
					<img src="${vo.emblem }" class="team-emblem">
				</div>
	            
				<div class="col-md-9 text-center text-md-start">
					<h1 class="fw-bold mb-2" style="font-size: 36px;">${vo.team_name }</h1>
					<p style="font-size: 18px; color: #cccccc; margin: 0;">
						<i class="bi bi-geo-alt-fill text-success me-1"></i> 홈구장: ${vo.svo.name }
					</p>
				</div>
			</div>
		</div>
	</div>
	<div class="container mb-5">
		<div class="row">
			<div class="col-lg-8">
				<div class="info-card">
					<h4 class="fw-bold mb-4" style="border-bottom: 2px solid #212529; padding-bottom: 10px;">
						홈구장 정보 및 오시는 길
					</h4>
	                
	                <img src="${vo.svo.image }" class="stadium-img">
	                
					<div class="row g-3 mb-4">
						<div class="col-md-6">
							<div class="stadium-stat">
								<div class="stat-title"><i class="bi bi-geo-alt me-1"></i>주소</div>
								<div class="stat-value">${vo.svo.address }</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="stadium-stat">
								<div class="stat-title"><i class="bi bi-people me-1"></i>수용 인원</div>
								<div class="stat-value text-success">${vo.svo.capacity } 명</div>
							</div>
						</div>
					</div>
					<div id="map" class="map-area">
	                    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoAPI }&libraries=services"></script>
						<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						    mapOption = {
						        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
						        level: 3 // 지도의 확대 레벨
						    };  
						
						// 지도를 생성합니다    
						var map = new kakao.maps.Map(mapContainer, mapOption); 
						
						// 주소-좌표 변환 객체를 생성합니다
						var geocoder = new kakao.maps.services.Geocoder();
						
						// 주소로 좌표를 검색합니다
						geocoder.addressSearch('${vo.svo.address}', function(result, status) {
						
						    // 정상적으로 검색이 완료됐으면 
						     if (status === kakao.maps.services.Status.OK) {
						
						        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						
						        // 결과값으로 받은 위치를 마커로 표시합니다
						        var marker = new kakao.maps.Marker({
						            map: map,
						            position: coords
						        });
						
						        // 인포윈도우로 장소에 대한 설명을 표시합니다
						        var infowindow = new kakao.maps.InfoWindow({
						            content: '<div style="width:150px;text-align:center;padding:6px 0;">${vo.svo.name}</div>'
						        });
						        infowindow.open(map, marker);
						
						        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						        map.setCenter(coords);
						    } 
						});    
						</script>
					</div>
	
					<div class="mt-4">
						<h6 class="fw-bold mb-3"><i class="bi bi-train-front text-secondary me-2"></i>대중교통 이용 안내</h6>
						<ul class="list-group list-group-flush" style="font-size: 15px;">
							<li class="list-group-item px-0 py-3">
								<strong class="text-primary">대중교통:</strong> 
								<button type="button" class="btn btn-sm btn-primary" onclick="openDirection('traffic')"><i class="bi bi-map me-1"></i></button>
							</li>
							<li class="list-group-item px-0 py-3">
								<strong class="text-success">자가용:</strong> 
								<button type="button" class="btn btn-sm btn-primary" onclick="openDirection('car')"><i class="bi bi-map me-1"></i></button>
							</li>
							<li class="list-group-item px-0 py-3">
								<strong class="text-danger">도보:</strong> 
								<button type="button" class="btn btn-sm btn-primary" onclick="openDirection('walk')"><i class="bi bi-map me-1"></i></button>
							</li>
						</ul>
					</div>
				</div>
			</div>
	
			<div class="col-lg-4">
				<div class="info-card side-panel">
					<h5 class="fw-bold mb-4 text-center">팀 액션</h5>
	                
					<div class="mb-4 text-center">
						<div style="font-size: 14px; color: #666666; margin-bottom: 5px;">다음 홈 경기 예매</div>
						<a href="../ticket/reserve_list.do?id=${vo.team_id }" class="btn btn-success w-100" style="font-weight: bold; font-size: 16px;">
							<i class="bi bi-ticket-perforated me-2"></i>예매 페이지로 이동
						</a>
					</div>
					<hr style="border-color: #dddddd; margin: 20px 0;">
					<div class="mb-4 text-center">
						<div style="font-size: 14px; color: #666666; margin-bottom: 5px;">소속 선수 확인</div>
						<a href="../player/list.do?team_id=${vo.team_id }" class="btn btn-outline-dark w-100" style="font-weight: bold;">
							<i class="bi bi-person-lines-fill me-2"></i>선수단 스쿼드 보기
						</a>
					</div>
	
					<hr style="border-color: #dddddd; margin: 20px 0;">
	
					<div class="text-center">
						<div style="font-size: 14px; color: #666666; margin-bottom: 5px;">공식 유니폼 & 굿즈</div>
						<a href="../goods/list.do?team_id=${vo.team_id }" class="btn btn-dark w-100" style="font-weight: bold;">
							<i class="bi bi-shop me-2"></i>구단 스토어 바로가기
						</a>
					</div>
					<div class="mt-4 pt-3" style="border-top: 1px dashed #e0e0e0;">
			            <a href="../team/list.do" class="btn btn-light w-100 text-muted" style="border: 1px solid #ced4da; font-weight: 500;">
			                <i class="bi bi-list me-2"></i>팀 목록으로 돌아가기
			            </a>
			        </div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
const openDirection=(type)=>{
	let startName='${vo.svo.near_station_name}'
	let startLat=${vo.svo.near_station_lat}
	let startLng=${vo.svo.near_station_lng}
	
	let endName='${vo.svo.name}'
	let endLat=${vo.svo.latitude}
	let endLng=${vo.svo.longitude}
	
	let url='https://map.kakao.com/link/by/'
		+type+'/'+startName+','+startLat+','
		+startLng+'/'+endName+','+endLat+','+ endLng
    
    let option='width=1000,height=700,scrollbars=yes,resizable=yes,top=100,left=100'
    window.open(url,'길찾기',option)
}
</script>
</html>