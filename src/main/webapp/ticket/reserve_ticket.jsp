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
		<div class="card bg-white">        
			<div class="flex-grow-1 d-flex flex-column justify-content-center px-4 my-4">          
		       	<div class="d-flex flex-column overflow-auto" style="gap: 6px">
		       		<c:forEach var="i" begin="1" end="20">
		           		<div class="d-flex justify-content-center" style="gap: 6px">
		           			<c:forEach var="j" begin="1" end="20">
		           				<div class="" style="background-color:#B5D692; width: 15px; height: 15px;"></div>
		           			</c:forEach>
		           		</div>
		       		</c:forEach>
		       	</div>
		    </div>
		</div>
	</div>
</div>
</body>
</html>