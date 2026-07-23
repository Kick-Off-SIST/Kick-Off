<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	background-color: #f8f9fa;
}
</style>
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
	<div class="container my-5" id="res">
		<div class="row">
			<div class="col-11">
        	<h4 class="mb-4 fw-bold text-dark">구단별 예매</h4>
        	</div>
        	<div class="col-1">
        	<select class="form-select w-auto" v-model="column" @change="filterChange">
        		<option value="team_id">기본순</option>
        		<option value="team_name">이름순</option>
        	</select>
        	</div>
		</div>
		<div class="row">
		  <div class="col">
		    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-3">
		      <div class="col" v-for="(vo, index) in list" :key="index">
		        <div class="card h-100">
		          <img :src="vo.emblem" class="rounded mx-auto d-block" style="width: 200px; margin-top: 20px">
		          <div class="card-body d-flex flex-column">
		            <h5 class="card-title fw-bold text-center">{{ vo.team_name }}</h5>
		            <p class="text-center" style="color: gray">{{ vo.svo.name }}</p>
		            <a :href="'../ticket/reserve_list.do?id='+vo.team_id" class="btn btn-lg btn-primary mt-auto">
		              예매하기
		            </a>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
<script>
let res=Vue.createApp({
	data() {
		return {
			//curPage:1,
			//totalPage:0,
            //count:null,
            column:'team_id',
			list:[]
		}
	},
	mounted(){
		this.dataRecv()
	},
	methods:{
		async dataRecv(){
			await axios.get('../ticket/reserve_team_vue.do',{
				params:{
					column:this.column
				}
			}).then(response=>{
				//console.log(response.data)
				this.list=response.data
			})
		},
		filterChange(){
			this.dataRecv()
		}
	}
}).mount('#res')
</script>
</body>
</html>