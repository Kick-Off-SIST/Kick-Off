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
    <h4>문의 내역</h4>
    <div class="mt-4">
    	<table class="table table-hover w-100">
    	  <thead>
    		<tr>
    			<th width="10%" class="text-center">번호</th>
    			<th width="60%" class="text-center">문의 제목</th>
    			<th width="15%" class="text-center">문의 날짜</th>
    			<th width="15%" class="text-center">상태</th>
    		</tr>
    	  </thead>
    	  <tbody>
    	   <c:if test="${count>0 }">
    	  	<c:set var="no" value="1"/>
    		<c:forEach var="vo" items="${list }">
    			<tr class="border-bottom-custom">
    				<td width="10%" class="text-muted small text-center">${no }</td>
	    			<td width="60%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
	    				  <a href="../qna/detail.do?no=${vo.no }">
                        	<span class="text-dark fw-medium small">
                            	${vo.title}
                            </span>
                          </a>
                        </div>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-dark small">${vo.dbday}</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<c:choose>
                    	<c:when test="${vo.state==1 }">
                        	<span class="badge bg-success">답변완료</span>
                        </c:when>
                        <c:otherwise>
                        	<span class="badge bg-warning">답변대기</span>
                        </c:otherwise>
                    </c:choose>
	    			</td>
    			</tr>
    			
    	  	<c:set var="no" value="${no+1 }"/>
    		</c:forEach>
    	   </c:if>
    	  </tbody>
    	</table>
    </div>
</main>
</body>
</html>