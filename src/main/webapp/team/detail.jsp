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
	cursor: default;
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
					<!-- 지도 타이틀 및 맛집 마커 토글 버튼 -->
					<div class="d-flex justify-content-between align-items-center mb-2 w-100">
						<div style="font-size: 14px; font-weight: bold; color: #6c757d;">
							<i class="bi bi-geo-alt-fill text-success"></i> 경기장 위치 & 반경 5km 맛집
						</div>
						<button type="button" id="toggleRestBtn" class="btn btn-sm btn-outline-danger" onclick="toggleRestaurants()" style="font-weight: bold;">
							<i class="bi bi-eye-slash"></i> 맛집 숨기기
						</button>
					</div>
					<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoAPI}&libraries=services&autoload=false"></script>
					<script>
					let map
					let restaurantMarkers=[]
					let isRestVisible=true 
					
					// 1. 경기장 좌표 세팅
					let stadiumLat = ${vo.svo.latitude}
					let stadiumLng = ${vo.svo.longitude}
					kakao.maps.load(function() {
					    let mapContainer = document.getElementById('map');
					    let stadiumPos = new kakao.maps.LatLng(stadiumLat, stadiumLng)
					    
					    let mapOption = {
					        center:stadiumPos, 
					        level:4 
					    }

					    // 지도 생성
					    map = new kakao.maps.Map(mapContainer, mapOption);

					    // 경기장 기본 마커 및 인포윈도우 생성
					    let stadiumMarker = new kakao.maps.Marker({
					        map: map,
					        position: stadiumPos
					    })

					    let stadiumInfoWindow = new kakao.maps.InfoWindow({
					        content: '<div style="width:150px;text-align:center;padding:6px 0;font-weight:bold;color:#198754;">${vo.svo.name}</div>'
					    })
					    stadiumInfoWindow.open(map, stadiumMarker)

					    // 반경 5km 음식점 검색 로직
					    let ps = new kakao.maps.services.Places()
					    let searchOptions = {
					        location: stadiumPos,
					        radius: 5000,
					        sort: kakao.maps.services.SortBy.DISTANCE,
					        category_group_code: 'FD6' 
					    }
					    kakao.maps.event.addListener(map, 'click', function() {
					        if (window.currentRestInfoWindow) {
					            window.currentRestInfoWindow.close()
					        }
					    })

					    ps.keywordSearch('맛집', function(data, status, pagination) {
					        if (status === kakao.maps.services.Status.OK) {
					            let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
					            let imageSize = new kakao.maps.Size(24, 35);
					            let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize)
					            let restInfoWindow = new kakao.maps.InfoWindow({
					                zIndex: 1
					            })
					            window.currentRestInfoWindow = restInfoWindow;

					            for (let i = 0; i < data.length; i++) {
					                let placePos = new kakao.maps.LatLng(data[i].y, data[i].x)
					                
					                let marker = new kakao.maps.Marker({
					                    map: map,
					                    position: placePos,
					                    image: markerImage 
					                });

					                (function(marker, placeName, placeUrl, distance) {
					                    kakao.maps.event.addListener(marker, 'click', function() {
					                        let content = '<div style="padding:5px;font-size:12px;width:150px;text-align:center;">' +
					                                      '<strong>' + placeName + '</strong><br>' +
					                                      '<span style="color:#666;">거리: ' + distance + 'm</span><br>' +
					                                      '<a href="' + placeUrl + '" target="_blank" style="color:blue;">상세보기</a>' +
					                                      '</div>';
					                        restInfoWindow.setContent(content)
					                        restInfoWindow.open(map, marker)
					                    });
					                })(marker, data[i].place_name, data[i].place_url, data[i].distance);

					                restaurantMarkers.push(marker)
					            }
					        }
					    }, searchOptions);
					});
					
					// 4. 음식점 마커 토글
					function toggleRestaurants() {
						let btn = document.getElementById('toggleRestBtn')
						isRestVisible = !isRestVisible
					    
						if (isRestVisible) {
							// 마커 표시
							for (let i = 0; i < restaurantMarkers.length; i++) {
								restaurantMarkers[i].setMap(map);
							}
							btn.innerHTML = '<i class="bi bi-eye-slash"></i> 맛집 숨기기'
							btn.classList.remove('btn-outline-primary')
							btn.classList.add('btn-outline-danger')
						} else {
							// 마커 제거
							for (let j = 0; j < restaurantMarkers.length; j++) {
								restaurantMarkers[j].setMap(null);
							}
							btn.innerHTML = '<i class="bi bi-eye"></i> 맛집 보기'
							btn.classList.remove('btn-outline-danger')
							btn.classList.add('btn-outline-primary')
						}
					}
					</script>
					<!-- 지도 영역 -->
					<div id="map" class="map-area"></div>
	
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
						<a href="../goods/find.do" class="btn btn-dark w-100" style="font-weight: bold;">
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