<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<main class="mb-4" id="order">
    <h4>구매 내역</h4>
    <div class="mt-4 d-flex flex-column justify-content-between" style="height: 600px">
      <div v-if="count>0">
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
    	  	<tr class="border-bottom-custom" v-for="(vo,index) in list" key="index">
    				<td width="5%" class="text-muted small text-center">{{count-index}}</td>
	    			<td width="10%" class="text-muted small text-center">{{vo.goods_no }}</td>
	    			<td width="15%" class="text-center">
	    				<img :src="vo.gvo.imageUrl" style="width: 100px">
	    			</td>
	    			<td width="20%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
	    				  <a class="table-link" :href="'../goods/detail.do?no='+vo.goods_no">
                        	{{vo.goods_name}}
                          </a>
                        </div>
	    			</td>
	    			<%-- <td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">${vo.price}원</span>
	    			</td> --%>
	    			<td width="5%" class="text-center">
	    			<span class="fw-bold text-dark">{{vo.count}}</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">{{vo.total}}원</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-dark small">{{vo.ovo.dbday}}</span>
	    			</td>
	    			<td width="10%" class="text-center">
	    			<span v-if="vo.ovo.status==1" class="badge bg-success-subtle fw-bold text-success">결제완료</span>
	    			<span v-if="vo.ovo.status==2" class="badge bg-secondary-subtle fw-bold text-secondary">배송중</span>
	    			<span v-if="vo.ovo.status==3" class="badge bg-primary-subtle fw-bold text-primary">배송완료</span>
	    			
	    			</td>
    			</tr>
    	  	<%-- <c:set var="no" value="1"/>
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
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">${vo.price}원</span>
	    			</td>
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
	    			<c:if test="${vo.ovo.status==1 }">
	    			<span class="badge bg-success-subtle fw-bold text-success">결제완료</span>
	    			</c:if>
	    			<c:if test="${vo.ovo.status==2 }">
	    			<span class="badge bg-secondary-subtle fw-bold text-secondary">배송중</span>
	    			</c:if>
	    			<c:if test="${vo.ovo.status==3 }">
	    			<span class="badge bg-primary-subtle fw-bold text-primary">배송완료</span>
	    			</c:if>
	    			</td>
    			</tr>
    			
    	  	<c:set var="no" value="${no+1 }"/>
    		</c:forEach> --%>
    	  </tbody>
    	</table>
	    <div class="text-center py-3">
			<button class="btn btn-sm btn-primary" type="button" @click="prev()">이전</button>
				{{curPage}} page / {{totalPage}} pages
			<button class="btn btn-sm btn-primary" type="button" @click="next()">다음</button>
		</div>
	  </div>
	  <div v-if="count==0" class="py-5 text-center">
      	<p class="fs-5">구매한 상품이 없습니다.</p>
	  </div>
    </div>
</main>
<script>
let order=Vue.createApp({
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
			await axios.get('../mypage/mypage_order_vue.do',{
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
}).mount('#order')
</script>
</body>
</html>