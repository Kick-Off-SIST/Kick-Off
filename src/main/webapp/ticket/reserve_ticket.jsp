<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
</style>
<script type="text/javascript">
$(function(){
	$('.seat-grade').on('click',function(){
 		let gid=$(this).attr('data-gid')
		$.ajax({
			type:'get',
			url:'../ticket/seat.do',
			data:{"gid":gid},
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
		let sid=1199
		
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
						<tr class="seat-grade" data-gid="${vo.grade_id }">
							<td width="10%">
								<div class="" style="background-color:#B5D692; width: 15px; height: 15px;"></div>
							</td>
							<td>
								<strong>${vo.grade_name }</strong>
								&nbsp;&nbsp;<span>|</span>&nbsp;&nbsp;
								<strong style="color: red">${vo.totalseat }석</strong>
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