<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<style>
:root {
    --bg: #eef1f4;
    --surface: #ffffff;
    --line: #e2e5ea;
    --ink: #1f2328;
    --muted: #6b7280;
    --green: #0f9d58;
    --green-soft: #e6f4ec;
}

body {
    background-color: var(--bg);
    color: var(--ink);
    font-family: 'Noto Sans KR', sans-serif;
}
.news-widget {
    max-width: 800px;
    margin: 40px auto;
    border-radius: 14px;
    background-color: var(--surface);
    border: 1px solid var(--line) !important;
}

.news-widget h2 {
    font-family: 'Black Han Sans', sans-serif;
    font-size: 26px;
    margin: 0;
    color: var(--ink);
}

#newsList {
    list-style: none;
    padding: 0;
    margin: 0;
}
.news-item {
    padding: 16px 20px;
    border-bottom: 1px solid var(--line);
    border-radius: 8px;
    transition: all 0.2s ease;
    background: var(--surface);
}
.news-item:last-child {
    border-bottom: none;
}
.news-item:hover {
    background-color: var(--green-soft);
    transform: translateX(6px);
}

.news-link {
    display: block;
    text-decoration: none;
    color: var(--ink);
    font-size: 16px;
    font-weight: 500;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.news-item:hover .news-link {
    color: var(--green);
    font-weight: 700;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
    const ws = new WebSocket("ws://" + window.location.host + "/Kick-Off/news");
    const $newsList = $('#newsList');
    const $updateTime = $('#updateTime');

    ws.onopen = () => console.log("서버 연결 완료");
    ws.onclose = () => console.log("서버 연결 종료");
    ws.onerror = (e) => console.error("에러:", e);
    
    ws.onmessage = (event) => {
        try {
            const data = JSON.parse(event.data);
            let html = "";
            
            data.forEach(news => {
                html += '<li class="news-item">' +
                        '<a href="' + news.link + '" target="_blank" class="news-link">' + 
                        news.title + 
                        '</a></li>';
            });
            
            $newsList.html(html);
            
            const now = new Date();
            $updateTime.text('마지막 업데이트 : ' + now.toLocaleTimeString());
            
        } catch(err) {
            console.error("JSON 파싱 실패:", err, event.data);
        }
    };
});
</script>
</head>
<body>
	<div class="news-widget card">
		<div class="card-body p-4 p-md-5"> 
			<div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
				<div>
					<div class="kickoff-hero-eyebrow"><span class="pulse"></span> Live</div>
					<h2>실시간 K리그 뉴스</h2>
				</div>
				<div class="text-muted small fw-medium" id="updateTime">
					마지막 업데이트 : --:--:--
				</div>
			</div>
			<ul id="newsList">
				<li class="news-item text-center text-muted py-4">
					실시간 뉴스를 불러오는 중입니다...
				</li>
			</ul>
		</div>
	</div>
</body>
</html>