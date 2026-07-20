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
    <h4>장바구니</h4>
    <div class="mt-4">
    	<table class="table table-hover w-100">
    	  <thead>
    		<tr>
    			<th width="5%" class="text-center">no</th>
    			<th width="10%" class="text-center">상품번호</th>
    			<th width="15%" class="text-center"></th>
    			<th width="20%" class="text-center">상품명</th>
    			<th width="15%" class="text-center">가격</th>
    			<th width="5%" class="text-center">수량</th>
    			<th width="15%" class="text-center">합계</th>
    			<th width="10%"></th>
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
                                    <span class="text-dark fw-medium small">
                                        ${vo.gvo.goodsName}
                                    </span>
                                </div>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">${vo.gvo.price}원</span>
	    			</td>
	    			<td width="5%" class="text-center">
	    			<span class="fw-bold text-dark">${vo.count}</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">${vo.gvo.price*vo.count}원</span>
	    			</td>
	    			<td width="10%" class="text-center">
	    				<a class="delBtn btn btn-outline-success btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				data-mid="" data-rid=""
	    				>구매하기</a>
	    				<a class="delBtn btn btn-outline-danger btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px; margin-top: 4px"
	    				data-mid="" data-rid=""
	    				>삭제하기</a>
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