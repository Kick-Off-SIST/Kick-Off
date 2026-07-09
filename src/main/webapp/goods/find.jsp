<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.goods-thumb{
  width: 100%;
  aspect-ratio: 4 / 3;
  object-fit: cover;
}
.goods-price{
  font-weight: 700;
  color: #212529;
}
.pagination .page-link{
  cursor: pointer;
}
</style>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
</head>
<body>
<%-- View--%>
  <main id="goodsFindApp" class="container main-content flex-grow-1">

    <div class="row mb-4">
        <div class="col-12">
            <h2 class="fw-bold">굿즈 스토어</h2>
            <hr>
        </div>
    </div>

    <div class="row mb-4">
      <div class="col-12">
        <div class="input-group">
          <select class="form-select flex-grow-0 w-auto" v-model="category">
            <option value="">전체 카테고리</option>
            <option value="의류">의류</option>
            <option value="머플러">머플러</option>
            <option value="용품/기념품">용품/기념품</option>
          </select>
          <%--
             @submit.prevent=""
             @blur=""
             @click=""
             @change=""
             @keydown.enter=""
           --%>
          <input type="text" class="form-control" v-model="ss"
           ref="ssInput" @keydown.enter="find()"
           placeholder="상품명을 입력하세요"
          >
          <button type="button" class="btn btn-primary" @click="find()">검색</button>
        </div>
      </div>
    </div>

   <div class="row g-4">
  <div class="col-md-3" v-for="vo in goods_list">
    <a :href="'../goods/detail.do?no='+vo.goodsNo" class="text-decoration-none text-dark">
      <div class="card h-100 shadow-sm border-0">
        <img :src="vo.imageUrl" :alt="vo.goodsName" class="card-img-top goods-thumb">
        <div class="card-body d-flex flex-column">
          <p class="card-title fw-bold mb-1 text-truncate">{{vo.goodsName}}</p>
          <p class="goods-price mb-2" style="color: gray; font-size: 16px" >{{vo.price.toLocaleString()}}원</p>
          <div class="d-flex align-items-center gap-2 mt-auto">
            <img :src="vo.emblem" :alt="vo.teamName"
                 style="width:28px; height:28px; object-fit:contain;">
            <span style="font-size:13px; color:gray;">{{vo.teamName}}</span>
          </div>
        </div>

      </div>
    </a>
  </div>
      <div class="col-12 text-center text-muted py-5" v-if="goods_list.length === 0">
        검색 결과가 없습니다.
      </div>
    </div>

    <div class="row" style="margin-top: 30px">
      <ul class="pagination justify-content-center">
        <li v-if="startPage>1" class="page-item"><a class="page-link" @click="move(startPage-1)">&laquo;</a></li>
        <li v-for="i in range(startPage,endPage)" :key="i" class="page-item" :class="i===curpage?'active':''"><a class="page-link" @click="move(i)">{{i}}</a></li>
        <li v-if="endPage<totalpage" class="page-item"><a class="page-link" @click="move(endPage+1)">&raquo;</a></li>
      </ul>
    </div>

  </main>
  <script>
    let find=Vue.createApp({
    	// 1. 서버에서 읽어오는 데이터 저장 => 변수 : Model
    	data(){
    		return {
    			startPage:0,
    			endPage:0,
    			totalpage:0,
    			curpage:1,
    			category:'',
    			ss:'',
    			goods_list:[]
    		}
    	},
    	// 2. 데이터를 제어 : ViewModel
    	mounted(){
    		this.dataRecv()
    		// => 자동 호출 => 생명주기 함수 
    	},
    	methods:{
    		// 사용자 정의 함수 : 반드시 호출이 필요
    		// axios.post(url,data,config)
    		dataRecv(){
    			
    			axios.post('../goods/find_vue.do',{},{
    				
    				params:{
    					page:this.curpage,
    					category:this.category,
    					ss:this.ss
    				}
    					
    			})
    			.then(response=>{
    				console.log(response.data)
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
    			// 태그를 가지고 오는 경우 => ref속성 사용 
    			// 유효성 검사 => $()=(X)
    			this.curpage=1
    			if(this.ss.trim()==="" && this.category==="")
    			{
    				this.$refs.ssInput.focus()
    				return
    			}
    			
    			this.dataRecv()
    			
    		}
    	},
    	computed:{
    		
    	}
    }).mount("#goodsFindApp")
  </script>
</body>
</html>
