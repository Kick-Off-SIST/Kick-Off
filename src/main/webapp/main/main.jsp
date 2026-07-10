<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>K-리그 포털 | Kick-Off</title>

<!-- Bootstrap 5 (네비게이션 드롭다운/모달/토글에 필요) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<!-- 브랜드 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<!-- 프로젝트 공통 CSS (부트스트랩 리스킨 포함) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

<!-- 라이브러리: jQuery -> Bootstrap JS -> Vue -> axios 순서로 로드 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>

<jsp:include page="header.jsp" />

<%-- 컨트롤러가 request.setAttribute("main_jsp", "../goods/find.jsp") 처럼 넘겨주면
     그 화면을, 아무 값도 없으면(최초 진입) home.jsp를 보여줍니다. --%>
<c:choose>
    <c:when test="${not empty main_jsp}">
        <jsp:include page="${main_jsp}" />
    </c:when>
    <c:otherwise>
        <jsp:include page="home.jsp" />
    </c:otherwise>
</c:choose>

<jsp:include page="footer.jsp" />

</body>
</html>
