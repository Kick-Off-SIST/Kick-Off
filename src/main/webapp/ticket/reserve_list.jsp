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
<div class="container my-5">
	<div class="row">
    	<div class="col">
    	 	<div class="row justify-content-center" style="background-color: white">
    	 	  <div class="col">
    	 		<img src="${vo.emblem }" height="300px" class="rounded mx-auto d-block p-3">
    	 	  </div>
    	 	</div>
    		
    	</div>
    </div>
    <div class="row" style="margin-top: 40px">
    <div class="row">
    	<h4>예매 일정</h4>
    </div>
    <div class="row" style="margin-top: 20px">
    <c:if test="${mList==null || mList.size()==0 }">
    	<div class="py-5 text-center">
      		<p class="fs-5">경기 일정이 없습니다.</p>
    	</div>
    </c:if>
    <c:if test="${mList!=null }">
    	<c:forEach var="mvo" items="${mList }">
    		<div class="card p-4 border border-light-subtle">
    			<div class="d-flex flex-column flex-md-row align-items-center justify-content-between gap-4">
    				<div class="text-center text-md-start">
    					<h3 class="fw-bold mb-1 text-dark">${mvo.dbday } ${mvo.game_time }</h3>
    				</div>
    				<div class="d-flex align-items-center justify-content-center flex-grow-1 gap-3">
        				<div class="d-flex align-items-center gap-2">
          					<span class="badge rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 12px;">H</span>
          					<span class="fw-bold fs-5">${vo.team_name }</span>
          					<img src="${vo.emblem }" class="object-fit-contain" style="width: 50px; height: 50px;">
        				</div>
        				
        				<div class="text-black-50 fs-3 px-2">/</div>
        				
        				<div class="d-flex align-items-center gap-2">
          					<img src="${mvo.awayVo.emblem }" class="object-fit-contain" style="width: 50px; height: 50px;">
          					<span class="fw-bold fs-5">${mvo.awayVo.team_name }</span>
          					<span class="badge rounded-circle bg-secondary-subtle text-secondary d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 12px;">A</span>
        				</div>
      				</div>
      				<div class="text-center text-md-end">
        				<a href="../ticket/reserve_ticket.do" class="btn btn-outline-primary fw-bold px-5 py-2.5 rounded-pill fs-5" style="border-width: 2px;">
          					예매하기
        				</a>
      				</div>
    			</div>
    		</div>
    	</c:forEach>
    </c:if>
    </div>
    </div>
    <div class="row" style="margin-top: 50px">
    	<h4>관람 안내</h4>
    	<div class="col" style="margin-top: 20px">
    		<img class="rounded mx-auto d-block" src="${ticketImage }" width="1000px">
    	</div>
    </div>
</div>
</body>
</html>