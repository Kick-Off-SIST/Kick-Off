<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	background-color: #f8f9fa;
}
.seat-grade {
	cursor: pointer; 	
}
.community-hero {
	background: #111827;
	border-radius: 18px;
	padding: 20px 50px; 
	margin-bottom: 30px;
	color: white;
}


.community-eyebrow{
	font-size:13px;
	font-weight:800;
	letter-spacing:2px;
	color:#22c55e;
	margin-bottom:15px;
}


.community-hero h1{
	font-size:42px;
	font-weight:800;
	line-height:1.25;
	margin-bottom:18px;
	position:relative;
	z-index:1;
}


.community-hero p{
	color:#d1d5db;
	font-size:16px;
	line-height:1.7;
	position:relative;
	z-index:1;
}
</style>
<script type="text/javascript">
$(function(){
	$('.seat-grade').on('click',function(){
 		let gid=$(this).attr('data-gid')
 		let sid="${sid}"
		$.ajax({
			type:'get',
			url:'../ticket/seat.do',
			data:{"gid":gid,"sid":sid},
			success:function(result){
				$('#reserve_seat').html(result)
			}
		})
	})
	$('#insertBtn').on('click',function(){
		let tamount=$('#tamount').val()
		let msid=$('#msid').val()
		let srow=$('#srow').val()
		let scol=$('#scol').val()
		let damount=$('#damount').val()
		let gname=$('#gname').val()
		let sid="${sid}"
		
		if(msid===''){
			alert('좌석을 선택해주세요!!')
			return
		}
		
		$.ajax({
			type:'post',
			url:'../ticket/reserve_insert.do',
			data:{"total_amount":tamount, "match_seat_id":msid,
				"seat_row":srow, "seat_col":scol,
				"amount":damount,"grade_name":gname,
				"schedule_id":sid},
			success:function(result){
				location.href="../mypage/mypage_reserve.do"
			}
		})
		
	})
})
</script>
</head>
<body>
<div class="container my-5">
	<div class="row">
		<div class="community-hero">


	<div class="community-eyebrow">
		TICKET
	</div>


	<h1>
		울산 VS 수원<br>
		
	</h1>
	<h2>
		<span style="color:#22c55e;">
			울산 경기장
		</span>
	</h2>


	<p>
		2026년 7월 21일 19시 30분
	</p>


</div>
	</div>
	<div class="row">
	  <div class="col-12 col-md-8"> 
		<div class="card bg-white" style="height: 600px" id="reserve_seat">       

		 </div>
	  </div>
	  <div class="col-12 col-md-4">
	  	<div class="card bg-white" style="height: 400px">
	  		<div class="card-body p-0">
            	<table class="table table-hover align-middle">
					<tbody>
					  <c:forEach var="vo" items="${list }">
						<tr class="seat-grade" data-gid="${vo.svo.grade_id }">
							<td width="10%">
								<div style="background-color:#B5D692; width: 15px; height: 15px;"></div>
							</td>
							<td width="70%">
								<strong>${vo.svo.gvo.grade_name }</strong>
								&nbsp;<span>|</span>&nbsp;
								<strong style="color: red">${vo.remain }석</strong>	
							</td>
							<td width="20%" class="text-end">
								<span class="small text-secondary"><fmt:formatNumber value="${vo.svo.gvo.amount}" type="number" />원</span>
							</td>
						</tr>
					  </c:forEach>
					</tbody>
				</table>

        </div>
	  	</div>
	  	<div class="card bg-white" id="reserve_info" style="height: 100px; margin-top: 20px">
	  		
	  	</div>
	  	<div class="col-12 d-flex gap-2" style="margin-top: 20px">
    		<a href="javascript:history.back()" class="btn btn-primary w-100">목록</a>
   	 		<!-- <form id="insertBtn" method="post" action="../ticket/reserve_insert.do"> -->
   	 		<input type="hidden" name="total_amount" id="tamount">
			<input type="hidden" name="match_seat_id" id="msid">
			<input type="hidden" name="seat_row" id="srow">
			<input type="hidden" name="seat_col" id="scol">
			<input type="hidden" name="amount" id="damount">
			<input type="hidden" name="grade_name" id="gname">
			<button id="insertBtn" type="button" class="btn btn-secondary w-100">
				예약하기
			</button>	
   	 		<!-- </form> -->
		</div>
	  </div> 
	</div>
	<div class="row">
		<!--  -->
	</div>
</div>
</body>
</html>