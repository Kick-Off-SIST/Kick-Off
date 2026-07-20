<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background-color: #f8f9fa;
}
.mypage .nav-link {
	color: black;
	font-weight: 500;
	padding: 0.6rem 0;
	font-size: 1.05rem;
}
.mypage .nav-link:hover {
	background-color: #e7f1ff;
    color: #0d6efd;
}
.mypage .nav-link.active {
	color: #0d6efd;
    font-weight: 1000;
    background-color: #e7f1ff;
}
</style>
</head>
<body>
<div class="container my-5">
    <div class="row">
        <div class="col-12 col-md-2 mypage">
            <div class="pb-2 mb-3 border-bottom border-dark border-3">
                <h2 class="fw-bold m-0" style="font-size: 1.8rem;">MY PAGE</h2>
            </div>
            
            <nav class="nav flex-column">
                <a class="nav-link ${menu==1?'active':'' }" href="../mypage/mypage.do">회원정보 관리</a>
                <a class="nav-link ${menu==2?'active':'' }" href="#">구매/배송 조회</a>
                <a class="nav-link ${menu==3?'active':'' }" href="../mypage/mypage_cart.do">장바구니</a>
                <a class="nav-link ${menu==4?'active':'' }" href="../mypage/mypage_reserve.do">티켓 내역</a>
                <a class="nav-link ${menu==5?'active':'' }" href="#">문의 내역</a>
            </nav>
            
        </div>
        
        <div class="col-12 col-md-10">
        	<jsp:include page="${mypage_jsp }"/>
        </div>
    </div>
</div>
</body>
</html>