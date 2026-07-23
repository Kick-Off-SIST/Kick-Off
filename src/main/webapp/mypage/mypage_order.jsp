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
<main class="mb-4">
    <h4>구매 내역</h4>
    <div class="mt-4">
    	<table class="table table-hover w-100">
    	  <thead>
    		<tr>
    			<th width="5%" class="text-center">no</th>
    			<th width="10%" class="text-center">상품번호</th>
    			<th width="15%" class="text-center"></th>
    			<th width="20%" class="text-center">상품명</th>
    			<th width="5%" class="text-center">수량</th>
    			<th width="15%" class="text-center">결제금액</th>
    			<th width="15%" class="text-center">결제일시</th>
    			<th width="10%" class="text-center">배송조회</th>
    		</tr>
    	  </thead>
    	  <tbody>
    	  	<c:set var="no" value="1"/>
    		<c:forEach var="vo" items="${list }">
    			<tr class="border-bottom-custom">
    				<td width="5%" class="text-muted small text-center">${no }</td>
	    			<td width="10%" class="text-muted small text-center">${vo.goods_no }</td>
	    			<td width="15%" class="text-center">
	    				<img src="${vo.gvo.imageUrl }" style="width: 100px">
	    			</td>
	    			<td width="20%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
	    				  <a href="../goods/detail.do?no=${vo.goods_no }">
                        	<span class="text-dark fw-medium small">
                        		${vo.goods_name}
                        	</span>
                          </a>
                        </div>
	    			</td>
	    			<%-- <td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">${vo.price}원</span>
	    			</td> --%>
	    			<td width="5%" class="text-center">
	    			<span class="fw-bold text-dark">${vo.count}</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">${vo.total}원</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-dark small">${vo.ovo.dbday}</span>
	    			</td>
	    			<td width="10%" class="text-center">
	    			<span class="badge bg-secondary-subtle fw-bold text-secondary">배송중</span>
	    			</td>
    			</tr>
    			
    	  	<c:set var="no" value="${no+1 }"/>
    		</c:forEach>
    	  </tbody>
    	</table>
    </div>
</main>
</body>
</html>