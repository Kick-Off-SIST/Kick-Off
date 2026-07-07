<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.grid-img-container {
    width: 100%;
    aspect-ratio: 4 / 3; 
    overflow: hidden;
    background-color: #eaeaea;
}
.grid-card .card-img-top {
    width: 100%;
    height: 100%;
    object-fit: cover; 
    transition: transform 0.3s ease;
}
.grid-card:hover .card-img-top {
    transform: scale(1.05);
}
.grid-card .card-title {
    font-size: 14px;
    font-weight: 700;
    color: #212529;
}
.grid-card .card-text {
    font-size: 12px;
    color: #6c757d;
}
.page-item:hover{
	cursor: pointer;
}
#name-link{
	text-decoration: none;
	color:black
}
#name-link:hover{
	color:gray
}
#team-link{
	text-decoration: none;
	color:black
}
#team-link:hover{
	color:gray
}
</style>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>


	<div class="container my-5" id="playerListApp">
    	<div class="row">
        	<div class="col-12">
            	<h4 class="mb-4 fw-bold text-dark"><i class="bi bi-grid-3x3-gap-fill me-2"></i>선수 리스트</h4>
            	<div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-6 g-3">
                    <div class="col" v-for="vo in list" :key="vo.player_id">
                        <div class="card h-100 shadow-sm border-0 grid-card">
                            
                            <div class="position-relative grid-img-container">
                                <a href="">
                                	<img :src="vo.img_url?vo.img_url:'../player/no_image.png'" class="card-img-top" alt="">
                                </a>
                            </div>
                            
                            <div class="card-body p-2 d-flex justify-content-between align-items-center">
                                <div style="min-width: 0;">
                                    <h6 class="card-title text-truncate mb-1"><a href="" id="name-link">{{vo.name}}</a></h6>
                                    <p class="card-text text-truncate mb-0"><a href="" id="team-link">{{vo.tvo.team_name}}</a></p>
                                    <p class="card-text text-truncate mb-0">{{vo.back_number}}&nbsp;&nbsp;{{vo.position}}</p>
                                </div>
                                <div class="flex-shrink-0 ms-2">
                                	<a href="" id="team-link">
	                                	<img :src="vo.tvo.emblem?vo.tvo.emblem :''"
	                                		alt="" style="width: 35px; height: 35px; object-fit: contain;">
                                	</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>            
        	</div>
    	</div>
    	<div class="row" style="margin-top: 20px">
    		<ul class="pagination justify-content-center">
				<li v-if="startPage>1" class="page-item"><a class="page-link" @click="pageChange(startPage-1)">&laquo;</a></li>
				<li v-for="i in range(startPage,endPage)" :key="i" class="page-item" :class="i===curpage?'active':''"><a class="page-link" @click="pageChange(i)">{{i}}</a></li>
				<li v-if="endPage<totalpage" class="page-item"><a class="page-link" @click="pageChange(endPage+1)">&raquo;</a></li>
			</ul>
    	</div>
	</div>
<script>
	const playerList=Vue.createApp({
		data(){
			return{
				list:[],
				curpage:1,
				totalpage:0,
				startPage:0,
				endPage:0,
				column:'name',
				team_id:'',
				position:''
			}
		},
		mounted(){
			this.dataRecv()
		},
		methods:{
			async dataRecv(){
				await axios.get('../player/list_vue.do',{
					params:{
						page:this.curpage,
						column:this.column,
						team_id:this.team_id,
						position:this.position
					}
				}).then(response=>{
					console.log(response.data)
					this.list=response.data.list
					this.curpage=response.data.curpage
					this.totalpage=response.data.totalpage
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
				})
			},
			range(start,end){
				let arr=[]
				let len=end-start
				for(let i=0;i<=len;i++){
					arr[i]=start
					start++
				}
				return arr
			},
			pageChange(page){
				this.curpage=page
				this.dataRecv()
			}
		}
	}).mount('#playerListApp')
</script>