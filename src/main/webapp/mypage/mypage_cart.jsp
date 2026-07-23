<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
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
<main class="mb-4">
    <h4>장바구니</h4>
    <div id="cart" v-cloak class="mt-4 d-flex flex-column justify-content-between" style="height: 600px">
      <div v-if="count>0">
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
    			<tr class="border-bottom-custom" v-for="(vo,index) in list" key="index">
    				<td width="5%" class="text-muted small text-center">{{count-index }}</td>
	    			<td width="10%" class="text-muted small text-center">{{vo.goods_no }}</td>
	    			<td width="15%" class="text-center">
	    				<img :src="vo.gvo.imageUrl" style="width: 100px">
	    			</td>
	    			<td width="20%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
	    				  <a class="table-link" :href="'../goods/detail.do?no='+vo.goods_no">
                        	{{vo.gvo.goodsName}}
                          </a>
                        </div>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">{{vo.gvo.price}}원</span>
	    			</td>
	    			<td width="5%" class="text-center">
	    			<span class="fw-bold text-dark">{{vo.count}}</span>
	    			</td>
	    			<td width="15%" class="text-center">
	    			<span class="fw-bold text-primary">{{vo.gvo.price*vo.count}}원</span>
	    			</td>
	    			<td width="10%" class="text-center">
	    				<a class="btn btn-outline-success btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				@click="buyBtn(vo)"
	    				>구매하기</a>
	    				<a class="delBtn btn btn-outline-danger btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px; margin-top: 4px"
	    				@click="removeBtn(vo.cart_id)"
	    				>삭제하기</a>
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
                        		${vo.gvo.goodsName}
                        	</span>
                          </a>
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
	    				<a class="btn btn-outline-success btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				@click="buyBtn('${vo.gvo.goodsName}',${vo.goods_no },${vo.count },${vo.gvo.price },${vo.cart_id })"
	    				>구매하기</a>
	    				<a class="delBtn btn btn-outline-danger btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px; margin-top: 4px"
	    				@click="removeBtn(${vo.cart_id })"
	    				>삭제하기</a>
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
      	<p class="fs-5">장바구니에 상품이 없습니다.</p>
	  </div>
    </div>
</main>
<script>
let IMP = window.IMP; 
IMP.init("${portoneAPI}");
let cart=Vue.createApp({
	data(){
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
		buyBtn(vo) {
			this.requestPay(vo)
		},
		requestPay(vo) {
			//let IMP = window.IMP; 
			//IMP.init(this.api)
		    IMP.request_pay({
		        pg: "html5_inicis",
		        pay_method: "card",
		        merchant_uid: "ORD20180131-0000011",   // 주문번호
		        name: vo.gvo.goodsName,
		        amount: vo.count*vo.gvo.price,         // 숫자 타입
		        buyer_email: '',
		        buyer_name: '',
		        buyer_tel: '',
		        buyer_addr: '',
		        buyer_postcode: '' 
		    }, function (rsp) { // callback
		    	
		    	//window.location.href="../mypage/buy_list.do"
		    	//parent.Shadowbox.close()
		    	axios.post('../order/insert.do',{},{
		    		params:{
		    			goods_no:vo.goods_no,
		    			count:vo.count,
		    			price:vo.gvo.price,
		    			goods_name:vo.gvo.goodsName
		    		}
		    	}).then(response=>{
		    		axios.get('../cart/delete.do',{
			    		params:{
			    			cart_id:vo.cart_id
			    		}
			    	}).then(response=>{

			    		alert("구매가 완료되었습니다.\n마이페이지에서 확인하세요")
			    		window.location.href="../mypage/mypage_order.do"
			    	})
		    		
		    	})
		   });
		},
		removeBtn(cart_id){
	    	axios.get('../cart/delete.do',{
	    		params:{
	    			cart_id:cart_id
	    		}
	    	}).then(response=>{
	    		alert("장바구니가 삭제되었습니다")
	    		window.location.href="../mypage/mypage_cart.do"
	    	})
		},
		async dataRecv(){
			await axios.get('../mypage/mypage_cart_vue.do',{
				params:{
					page:this.curPage
				}
			}).then(response=>{
				console.log(response.data)
				this.list=response.data.list
				this.curPage=response.data.curPage
				this.totalPage=response.data.totalPage
				this.count=response.data.count
				this.api=response.data.portoneAPI
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
}).mount('#cart')
</script>
</body>
</html>