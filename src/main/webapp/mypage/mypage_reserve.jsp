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
<main class="">
    <h2>티켓 예약 정보</h2>
    <div class="">
    	<table class="table w-100">
    		<tr>
    			<th width="10%">번호</th>
    			<th width="20%">경기정보</th>
    			<th width="30%">좌석</th>
    			<th width="20%">예매일</th>
    			<th width="10%">가격</th>
    			<th width="10%"></th>
    		</tr>
    		<c:forEach var="vo" items="${list }">
    			<tr>
	    			<td width="10%">${vo.reserve_id }</td>
	    			<td width="20%">
	    				<%-- ${vo.rvo.mmvo.dbday }&nbsp;
	    				${vo.rvo.mmvo.game_time } --%>
	    				${vo.rvo.schedule_id }
	    			</td>
	    			<td width="20%">
	    				${vo.grade_name }&nbsp;
	    				${vo.seat_row }열&nbsp;
	    				${vo.seat_col }번&nbsp;
	    				좌석
	    			</td>
	    			<td width="20%">${vo.rvo.dbday }</td>
	    			<td width="10%">${vo.amount }</td>
	    			<td width="10%">
	    				<a href="#" class="btn btn-xs btn-warning">예약취소</a>
	    			</td>
    			</tr>
    		</c:forEach>
    	</table>
    </div>
</main>
</body>
</html>