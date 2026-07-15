<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 


<style>


.goods-hero{

	background:#111827;
	border-radius:18px;
	padding:45px 50px;
	margin-bottom:40px;
	color:white;
	position:relative;
	overflow:hidden;

}


.goods-hero:after{

	content:"";
	position:absolute;
	right:-80px;
	top:-80px;
	width:280px;
	height:280px;
	border-radius:50%;
	background:rgba(34,197,94,.15);

}



.goods-eyebrow{

	color:#22c55e;
	font-size:13px;
	font-weight:800;
	letter-spacing:2px;
	margin-bottom:15px;

}



.goods-hero h1{

	font-size:42px;
	font-weight:800;
	line-height:1.25;
	position:relative;
	z-index:1;

}



.goods-hero p{

	color:#d1d5db;
	font-size:16px;
	position:relative;
	z-index:1;

}




.goods-search{

	border:none;
	border-radius:16px;
	box-shadow:0 6px 18px rgba(0,0,0,.08);
	padding:20px;

}




.goods-card{

	border:none;
	border-radius:16px;
	overflow:hidden;
	transition:.2s;
	box-shadow:0 5px 15px rgba(0,0,0,.08);

}



.goods-card:hover{

	transform:translateY(-5px);
	box-shadow:0 10px 25px rgba(0,0,0,.15);

}



.goods-thumb{

	width:100%;
	aspect-ratio:4 / 3;
	object-fit:cover;

}



.goods-price{

	font-weight:800;
	color:#198754;

}



.goods-team{

	font-size:13px;
	color:#6b7280;

}



.pagination .page-link{

	cursor:pointer;
	color:#198754;

}



.pagination .active .page-link{

	background:#198754;
	border-color:#198754;
	color:white;

}


</style>



<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>



<main id="goodsFindApp" class="container main-content flex-grow-1">



<!-- =====================
     Goods Hero
===================== -->


<div class="goods-hero">


	<div class="goods-eyebrow">
		GOODS SHOP
	</div>


	<h1>
		팬심을 담은<br>
		<span style="color:#22c55e">
			KICK-OFF 공식 굿즈
		</span>
	</h1>


	<p>
		좋아하는 팀의 유니폼부터 머플러, 응원용품까지<br>
		K-리그 팬을 위한 다양한 상품을 만나보세요.
	</p>


</div>





<!-- 검색 -->

<div class="card goods-search mb-4">


<div class="input-group">


<select class="form-select flex-grow-0 w-auto"
        v-model="category">


<option value="">
전체 카테고리
</option>


<option value="의류">
의류
</option>


<option value="머플러">
머플러
</option>


<option value="용품/기념품">
용품/기념품
</option>


</select>




<input type="text"
       class="form-control"
       v-model="ss"
       ref="ssInput"
       @keydown.enter="find()"
       placeholder="상품명을 입력하세요">



<button class="btn btn-success"
        @click="find()">

검색

</button>


</div>


</div>






<!-- 상품 리스트 -->


<div class="row g-4">


<div class="col-md-3"
     v-for="vo in goods_list">


<a :href="'../goods/detail.do?no='+vo.goodsNo"
   class="text-decoration-none text-dark">



<div class="card goods-card h-100">


<img :src="vo.imageUrl"
     :alt="vo.goodsName"
     class="card-img-top goods-thumb">



<div class="card-body d-flex flex-column">



<p class="fw-bold mb-2 text-truncate">

{{vo.goodsName}}

</p>




<p class="goods-price mb-3">

{{vo.price.toLocaleString()}}원

</p>




<div class="d-flex align-items-center gap-2 mt-auto">


<img :src="vo.emblem"
     style="width:28px;height:28px;object-fit:contain;">



<span class="goods-team">

{{vo.teamName}}

</span>


</div>



</div>


</div>



</a>


</div>






<div class="col-12 text-center text-muted py-5"
     v-if="goods_list.length===0">


검색 결과가 없습니다.


</div>



</div>






<!-- 페이지 -->


<nav class="mt-5">


<ul class="pagination justify-content-center">



<li v-if="startPage>1"
    class="page-item">


<a class="page-link"
   @click="move(startPage-1)">

&laquo;

</a>


</li>




<li v-for="i in range(startPage,endPage)"
    :key="i"
    class="page-item"
    :class="i===curpage?'active':''">


<a class="page-link"
   @click="move(i)">

{{i}}

</a>


</li>




<li v-if="endPage<totalpage"
    class="page-item">


<a class="page-link"
   @click="move(endPage+1)">

&raquo;

</a>


</li>


</ul>


</nav>



</main>





<script>


let find=Vue.createApp({

data(){

return{

startPage:0,
endPage:0,
totalpage:0,
curpage:1,
category:'',
ss:'',
goods_list:[]

}

},



mounted(){

this.dataRecv()

},



methods:{



dataRecv(){


axios.post('../goods/find_vue.do',{},{

params:{

page:this.curpage,
category:this.category,
ss:this.ss

}

})


.then(response=>{


this.goods_list=response.data.goods_list

this.startPage=response.data.startPage

this.endPage=response.data.endPage

this.curpage=response.data.curpage

this.totalpage=response.data.totalpage


})


},




move(page){

this.curpage=page

this.dataRecv()

},




range(start,end){

let arr=[]

let len=end-start


for(let i=0;i<=len;i++)

{

arr[i]=start

start++

}


return arr

},





find(){


this.curpage=1


if(this.ss.trim()==="" && this.category==="")

{

this.$refs.ssInput.focus()

return

}



this.dataRecv()


}



}


}).mount("#goodsFindApp")


</script>