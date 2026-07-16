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
<table class="table table-hover align-middle">
					<tbody>
					  <%-- <c:forEach var="vo" items="${list }"> --%>
						<%-- <tr class="seat-grade" data-gid="${vo.grade_id }"> --%>
						<tr>
							<!-- <td width="10%">
								<div class="" style="background-color:#B5D692; width: 15px; height: 15px;"></div>
							</td> -->
							<td>
								<span class="lg"><strong>${grade_name } ${row }열 ${col }번</strong> 좌석</span>
								&nbsp;&nbsp;<span>|</span>&nbsp;&nbsp;
								<strong>${amount} 원</strong>
							</td>
						</tr>
					  <%-- </c:forEach> --%>
					  	
					</tbody>
				</table>
<table class="table">
	<tr>
		<td class="text-end">
			<span class="h5 font-weight-bold align-middle">총가격</span>
    		<span class="h5 align-middle">&nbsp;&nbsp;|&nbsp;&nbsp;</span>
    		<strong class="h5 text-danger align-middle">${amount} 원</strong>
		</td>
	</tr>
</table>
</body>
</html>