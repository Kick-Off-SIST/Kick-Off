<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.seat-able {
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function(){
	// 선택할 수 있는 최대 좌석 수
	const maxCount=1
	let count=0
	$('.seat-able').on('click',function(){
 		//const rowArray = ['', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];	
		//let row=rowArray[parseInt(nrow)];
		let selected=$(this).attr('data-select')
		if(count===0) {
			
		}
		if(count<maxCount && selected==='n') {
			count++
			$(this).attr('data-select','y')
			$(this).css('border','3px solid black')
			
			let row=$(this).attr('data-row')
	 		let col=$(this).attr('data-col')
	 		let id=$(this).attr('data-id')
	 		let gname=$(this).attr('data-gname')
	 		let amount=$(this).attr('data-amount')
	 		console.log("id: "+id+", row: "+row+", col: "+col+", gname: "+gname)
	 		
	 		// 총합 구하는 로직 필요
			$('#tamount').val(amount)
			
			$('#msid').val(id)
			$('#srow').val(row)
			$('#scol').val(col)
			$('#damount').val(amount)
			$('#gname').val(gname)
	 		
			$.ajax({
				type:'get',
				url:'../ticket/info.do',
				data:{"row":row,"col":col,"match_seat_id":id,"grade_name":gname,"amount":amount},
				success:function(result){
					$('#reserve_info').html(result)
				}
			})
		}
		else if(selected==='y') {
			count--
			$(this).attr('data-select','n')
			$(this).css('border','none')
			
			$('#tamount').val('')
			$('#msid').val('')
			$('#srow').val('')
			$('#scol').val('')
			$('#damount').val('')
			$('#gname').val('')
			$('#reserve_info').html('')
		}
		else {
			alert("최대 좌석을 초과했습니다!!!")
		}
		
		//console.log("count: "+count)
	})
	
	
})
</script>
</head>
<body>
<div class="flex-grow-1 d-flex flex-column justify-content-center px-4 my-4">          
		       	<div class="mx-auto" 
         style="display: grid; 
                grid-template-columns: repeat(${max_col}, 15px); 
                gap: 6px;">
		       		<c:forEach var="seat" items="${list}" varStatus="status">
		       			<c:if test="${seat.seat_status=='Y' }">
		       				<div class="seat-able" data-select="n"
		       					data-id="${seat.match_seat_id }" data-row="${seat.svo.seat_row }"
		       					data-col="${seat.svo.seat_col }" data-gname="${seat.svo.gvo.grade_name}"
		       					data-amount="${seat.svo.gvo.amount}"
		       					style="background-color:${gid==1?'#B5D692':'#EBE7F5'};
		       					width: 15px; height: 15px;"></div>
		       			</c:if>
		       			<c:if test="${seat.seat_status=='N' }">
		       				<div class="seat-unable" data-row=${seat.svo.seat_row } data-col=${seat.svo.seat_col }
		       					style="background-color: gray;
		       					width: 15px; height: 15px;"></div>
		       			</c:if>
		       		</c:forEach>
		       			
		       	</div>
		    </div>
</body>
</html>