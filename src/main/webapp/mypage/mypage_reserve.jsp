<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$('.delBtn').on('click',function(){
		let mid=$(this).attr('data-mid')
		let rid=$(this).attr('data-rid')
		console.log("hi")
		$.ajax({
			type:'post',
			url:'../mypage/reserve_delete.do',
			data:{"match_seat_id":mid,"reserve_id":rid},
			success:function(result){
				location.href="../mypage/mypage_reserve.do"
			}
		})
	})
})
</script>
</head>
<body>
<main class="mb-4">
    <h4>티켓 예약 정보</h4>
    <div class="mt-4">
    	<table class="table table-hover w-100">
    	  <thead>
    		<tr>
    			<th width="10%" class="text-center">예약번호</th>
    			<th width="25%" class="text-center">경기정보</th>
    			<th width="25%" class="text-center">좌석</th>
    			<th width="15%" class="text-center">예매일</th>
    			<th width="15%" class="text-center">가격</th>
    			<th width="10%"></th>
    		</tr>
    	  </thead>
    	  <tbody>
    		<c:forEach var="vo" items="${list }">
    			<tr class="border-bottom-custom">
	    			<td width="10%" class="text-muted small text-center">${vo.reserve_id }</td>
	    			<td width="25%" class="text-center">
	    				<%-- ${vo.rvo.mmvo.dbday }&nbsp;
	    				${vo.rvo.mmvo.game_time } --%>
	    				${vo.rvo.schedule_id }
	    			</td>
	    			<td width="25%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-secondary-subtle text-secondary rounded-pill px-2.5 py-1" style="font-size: 0.7rem; font-weight: 600;">
                                        ${vo.grade_name}
                                    </span>
                                    <span class="text-dark fw-medium small">
                                        ${vo.seat_row}열 ${vo.seat_col}번
                                    </span>
                                </div>
	    			</td>
	    			<td width="15%" class="text-center text-secondary small">${vo.rvo.dbday }</td>
	    			<td width="15%" class="text-center">
	    			&#8361; <span class="fw-bold text-primary">${vo.amount}</span>
	    			</td>
	    			<td width="10%" class="text-center">
	    				<a class="delBtn btn btn-outline-danger btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				data-mid="${vo.match_seat_id }" data-rid="${vo.reserve_id }"
	    				>예약취소</a>
	    			</td>
    			</tr>
    		</c:forEach>
    	  </tbody>
    	</table>
    </div>
</main>
</body>
</html>