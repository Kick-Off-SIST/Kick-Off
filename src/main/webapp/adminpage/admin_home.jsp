<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 🔹 메인 콘텐츠 -->
  <main class="admin-main">
    <h2>📊 대시보드</h2>

    <div class="card-container">
      <div class="card">
        <h3>총 회원 수</h3>
        <p>${mTotal }명</p>
      </div>
      <div class="card">
        <h3>오늘 주문 수</h3>
        <p>58건</p>
      </div>
      <div class="card">
        <h3>신규 리뷰</h3>
        <p>32개</p>
      </div>
      <div class="card">
        <h3>예매 수</h3>
        <p>${rTotal }건</p>
      </div>
    </div>

    <section class="recent-section">
      <h3>📅 최근 등록된 회원</h3>
      <table>
        <tr><th>이름</th><th>성별</th><th>이메일</th><th>주소</th><th>연락처</th><th>가입일</th></tr>
        <c:forEach var="vo" items="${rList }">
        <tr><td>${vo.name }</td><td>${vo.sex }</td><td>${vo.email }</td><td>${vo.addr1 } ${vo.addr2 }</td><td>${vo.phone }</td><td>${vo.dbday }</td></tr>
        </c:forEach>
      </table>
    </section>

  </main>
</body>
</html>