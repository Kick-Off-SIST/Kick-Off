<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
.admin-content{
	background:#fff;
	border-radius:14px;
	padding:30px;
	box-shadow:0 4px 15px rgba(0,0,0,.05);
}

.board-table{
	background:#fff;
	border-radius:12px;
	overflow:hidden;
	margin-bottom:0;
	border:1px solid #edf1f5;
}

.board-table thead th{
	background:#f8fafc;
	color:#495057;
	text-align:center;
	font-size:14px;
	font-weight:700;
	border-bottom:2px solid #e9ecef;
	padding:16px 12px;
}

.board-table tbody td{
	padding:18px 12px;
	vertical-align:middle;
	border-color:#f1f3f5;
	font-size:14px;
}

.dataTr{
	transition:all .2s ease;
}

.dataTr:hover{
	background:#f8fffb;
}

.dataTr td:first-child{
	font-weight:600;
	color:#6c757d;
}

.empty-row{
	color:#868e96;
	padding:40px 0 !important;
}

.pagination{
	margin-top:30px;
}

.pagination .page-link{
	border:none;
	border-radius:10px;
	margin:0 4px;
	padding:8px 16px;
	background:#f8fafc;
	color:#495057;
	transition:.2s;
}

.pagination .page-link:hover{
	background:#16a34a;
	color:#fff;
}

.pagination .page-item.active .page-link{
	background:#16a34a;
	color:#fff;
}

.pagination .page-item.disabled .page-link{
	background:#f3f4f6;
	color:#adb5bd;
}
</style>

<div class="admin-content">

	<table class="table board-table align-middle">
		<thead>
			<tr>
				<th width="10%">예약번호</th>
				<th width="25%">경기</th>
				<th width="15%">회원</th>
				<th width="15%">좌석</th>
				<th width="10%">금액</th>
				<th width="15%">예약일</th>
				<th width="10%">관리</th>
			</tr>
		</thead>

		<tbody>

			<c:forEach var="vo" items="${rList}">
				<tr class="dataTr">

					<td class="text-center">
						${vo.rvo.reserve_id}
					</td>

					<td>
						${vo.rvo.mmvo.homeVo.team_name}
						<br>
						VS
						<br>
						${vo.rvo.mmvo.awayVo.team_name}
					</td>

					<td class="text-center">
						${vo.rvo.member_id}
						<br>
						${vo.rvo.mvo.name}
					</td>

					<td class="text-center">
						${vo.grade_name}
						<br>
						${vo.seat_row}-${vo.seat_col}
					</td>

					<td class="text-center">
						${vo.rvo.total_amount}원
					</td>

					<td class="text-center text-muted">
						${vo.rvo.dbday}
					</td>
					<td class="text-center">
						<a href="../adminpage/reserve_cancel.do?reserve_id=${vo.rvo.reserve_id}&match_seat_id=${vo.match_seat_id}"
						   class="btn btn-danger btn-sm"
						   onclick="return confirm('예약을 취소하시겠습니까?')">
							취소
						</a>
					</td>
				</tr>
			</c:forEach>

			<c:if test="${empty rList}">
				<tr>
					<td colspan="7" class="text-center empty-row">
						등록된 예약이 없습니다.
					</td>
				</tr>
			</c:if>

		</tbody>
	</table>


	<nav>
		<ul class="pagination justify-content-center">

			<li class="page-item ${curpage<=1?'disabled':''}">
				<a class="page-link"
				   href="../adminpage/admin_reserve.do?page=${curpage>1?curpage-1:curpage}">
					◀ 이전
				</a>
			</li>

			<li class="page-item active">
				<span class="page-link">
					${curpage} / ${totalpage}
				</span>
			</li>

			<li class="page-item ${curpage>=totalpage?'disabled':''}">
				<a class="page-link"
				   href="../adminpage/admin_reserve.do?page=${curpage<totalpage?curpage+1:curpage}">
					다음 ▶
				</a>
			</li>

		</ul>
	</nav>

</div>