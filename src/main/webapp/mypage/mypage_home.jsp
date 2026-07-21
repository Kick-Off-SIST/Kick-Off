<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- <div class="container py-5" style="max-width: 850px;"> -->
        
        <div class="card border-0 p-4 mb-4" style="box-shadow: none;">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between gap-4">
                <div class="d-flex flex-column flex-md-row align-items-center gap-4 text-center text-md-start">
                    <div class="position-relative border border-3 border-primary rounded-circle p-1" style="width: 100px; height: 100px;">
                        <img src="../mypage/profile.png" class="w-100 h-100 rounded-circle object-fit-cover">
                    </div>
                    <div>
                        <div class="d-flex align-items-center justify-content-center justify-content-md-start gap-2 mb-1">
                            <h2 class="h4 mb-0 text-dark fw-bold">${vo.name }</h2>
                            <span class="badge bg-primary-subtle text-primary rounded-pill px-2.5 py-1" style="font-size: 0.75rem;">${vo.sgrade }</span>
                        </div>
                        <p class="text-secondary mb-1 small">이메일
                        	<span class="text-secondary mb-1 small">|</span>
                        	<span class="text-dark">${vo.email }</span>
                        </p>
                        <p class="text-muted mb-0" style="font-size: 0.75rem;">가입일
                        	<span class="text-secondary mb-1 small">|</span>
                        	<span class="text-dark">${vo.dbday }</span>
                        </p>
                    </div>
                </div>
                <button id="btn-edit-profile" class="btn btn-dark btn-md px-4 rounded-3 fw-semibold w-md-auto">
                    프로필 편집
                </button>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-4">
                <div class="card border-0 p-3 text-center">
                    <span class="text-muted d-block mb-1" style="font-size: 1rem; box-shadow: none;border: 1px solid var(--line)">구매 목록(예시)</span>
                    <span class="fs-5 fw-bold text-dark">12 개</span>
                </div>
            </div>
            <div class="col-4">
                <div class="card border-0 p-3 text-center">
                    <span class="text-muted d-block mb-1" style="font-size: 1rem; box-shadow: none;border: 1px solid var(--line)">내 글(예시)</span>
                    <span class="fs-5 fw-bold text-dark">42 개</span>
                </div>
            </div>
            <div class="col-4">
                <div class="card border-0 p-3 text-center">
                    <span class="text-muted d-block mb-1" style="font-size: 1rem; box-shadow: none;border: 1px solid var(--line)">티켓 예매 목록</span>
                    <span class="fs-5 fw-bold text-dark">${rcount } 개</span>
                </div>
            </div>
        </div>


<!--     </div> -->
</body>
</html> 