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
            	<h4 class="mb-4 fw-bold text-dark">구단별 예매</h4>
            	<div class="row row-cols-4 g-3">
                <c:forEach var="vo" items="${list }">
                    <div class="col">
                    	<div class="card">
                    		<img src="${vo.emblem }">
                    		<div class="card-body d-flex flex-column">
                    			<h5 class="card-title fw-bold text-center">${vo.team_name }</h5>
                    			<a href="../ticket/reserve_list.do?id=${vo.team_id }" class="btn btn-sm btn-primary">예매하기</a>
                    		</div>
                    	</div>
                    </div>
                </c:forEach>    
                </div>        
        	</div>
    	</div>
    	<!-- <div class="row" style="margin-top: 20px">
    		<ul class="pagination justify-content-center">
				<li v-if="startPage>1" class="page-item"><a class="page-link" @click="pageChange(startPage-1)">&laquo;</a></li>
				<li v-for="i in range(startPage,endPage)" :key="i" class="page-item" :class="i===curpage?'active':''"><a class="page-link" @click="pageChange(i)">{{i}}</a></li>
				<li v-if="endPage<totalpage" class="page-item"><a class="page-link" @click="pageChange(endPage+1)">&raquo;</a></li>
			</ul>
    	</div> -->
	</div>
</body>
</html>