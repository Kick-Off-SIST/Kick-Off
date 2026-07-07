<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container{
   margin-top: 50px;
}
.row {
  margin: 0px auto;
  width: 100%;
}
p {
   overflow: hidden;
   white-space: nowrap;
   text-overflow: ellipsis;
}
.a-link:hover{
  cursor: pointer;
}
</style>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="page_card.js"></script>
</head>
<body>
<%-- View--%>
  <div class="container">
    <div class="row">
     <select class="input-sm" v-model="category">
       <option value="">전체</option>
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
     <input type=text size=20 class="input-sm" v-model="ss"
      ref="ssInput" @keydown.enter="find()"
     >
     <button type=button class="btn-sm btn-primary" @click="find()">검색</button>
    </div>
    <div class="row" style="margin-top: 20px">
      <div class="col-sm-3" v-for="vo in goods_list">
        <a :href="'../goods/detail.do?no='+vo.goodsNo">
          <div class="thumbnail">
            <img :src="vo.imageUrl" :title="vo.price" style="width:250px;height: 150px;object-fit:cover">
            <p>{{vo.goodsName}}</p>
          </div>
        </a>
      </div>
    </div>
    <div class="row text-center" style="margin-top: 20px">
      <pagecard></pagecard>
    </div>
  </div>
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
    	components:{
    		pagecard:page_card
    	},
    	computed:{
    		
    	}
    }).mount(".container")
  </script>
</body>
</html>