<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.table-link {
	color: black;
	text-decoration: none
}
.table-link:hover {
	font-weight: bold;
}
</style> 
</head>
<body>
<main class="mb-4" id="qna">
    <h4>문의 내역</h4>
      <div class="mt-4 d-flex flex-column justify-content-between" style="height: 600px">
    	<div v-if="count>0">
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
    			<tr class="border-bottom-custom" v-for="(vo,index) in list" key="index">
    				<td width="10%" class="text-muted small text-center">{{count-index }}</td>
	    			<td width="60%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
	    				  <a class="table-link" :href="'../qna/detail.do?no='+vo.no">
                            {{vo.title}}
                          </a>
                        </div>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-dark small">{{vo.dbday}}</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<%-- <c:choose>
                    	<c:when test="${vo.state==1 }">
                        	<span class="badge bg-success">답변완료</span>
                        </c:when>
                        <c:otherwise>
                        	<span class="badge bg-warning">답변대기</span>
                        </c:otherwise>
                    </c:choose> --%>
                    <span v-if="vo.state==1" class="badge bg-success">
                    	답변완료
                    </span>
                    <span v-else class="badge bg-warning">
                    	답변대기
                    </span>
	    			</td>
    			</tr>
    	   <%-- <c:if test="${count>0 }">
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
    	   </c:if> --%>
    	  </tbody>
    	</table>
    	<div class="text-center py-3">
			<button class="btn btn-sm btn-primary" type="button" @click="prev()">이전</button>
				{{curPage}} page / {{totalPage}} pages
			<button class="btn btn-sm btn-primary" type="button" @click="next()">다음</button>
		</div>
		</div>
	  <div v-if="count==0" class="py-5 text-center">
      	<p class="fs-5">문의한 게시글이 없습니다.</p>
	  </div>
    </div>
</main>
<script>
let qna=Vue.createApp({
	data() {
		return {
			curPage:1,
			totalPage:0,
            count:null,
			list:[]
		}
	},
	mounted(){
		this.dataRecv()
	},
	methods:{
		async dataRecv(){
			await axios.get('../mypage/mypage_qna_vue.do',{
				params:{
					page:this.curPage
				}
			}).then(response=>{
				console.log(response.data)
				this.list=response.data.list
				this.curPage=response.data.curPage
				this.totalPage=response.data.totalPage
				this.count=response.data.count
			})
		},
		prev(){
			this.curPage=this.curPage>1?this.curPage-1:this.curPage
			this.dataRecv()
		},
		next(){
			this.curPage=this.curPage<this.totalPage?this.curPage+1:this.curPage
			this.dataRecv()
		}
	}
}).mount('#qna')
</script>
</body>
</html>