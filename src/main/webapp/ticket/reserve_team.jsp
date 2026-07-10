<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		method:'get',
		data:{'col':'team_id'},
		url:'../ticket/reserve_team_vue.do',
		successs:function(result){
			
		}
	})
})
</script>
</head>
<body>
	<div class="container my-5">
		<div class="row">
			<div class="col-11">
        	<h4 class="mb-4 fw-bold text-dark">구단별 예매</h4>
        	</div>
        	<div class="col-1">
        	<select class="form-select w-auto">
        		<option value="team_id">기본순</option>
        		<option value="team_name">이름순</option>
        	</select>
        	</div>
		</div>
    	<div class="row">
        	<div class="col">
            	<div class="row row-cols-4 g-3">
                <c:forEach var="vo" items="${list }">
                    <div class="col">
                    	<div class="card"">
                    		<img src="${vo.emblem }" class="rounded mx-auto d-block" style="width: 200px; margin-top: 20px">
                    		<div class="card-body d-flex flex-column">
                    			<h5 class="card-title fw-bold text-center">${vo.team_name }</h5>
                    			<p class="text-center" style="color: gray">${vo.svo.name }</p>
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