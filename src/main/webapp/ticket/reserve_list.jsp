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
    	 	<div class="" style="background-color: gray">
    	 		<img src="" height="100px">
    	 	</div>
    		<c:if test="${list==null }">
    			<h4 class="mb-4 fw-bold text-dark">경기 일정이 없습니다</h4>
    		</c:if>
    	</div>
    </div>
</div>
</body>
</html>