<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.goods-hero {
    background: #111827;
    border-radius: 18px;
    padding: 45px 50px;
    margin-bottom: 40px;
    color: white;
    background-image: url("../image/banner1.jpg");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    position: relative;
    overflow: hidden;
}
.goods-eyebrow {
    color: #22c55e;
    font-size: 13px;
    font-weight: 800;
    letter-spacing: 2px;
    margin-bottom: 15px;
}
.goods-hero h1 {
    font-size: 42px;
    font-weight: 800;
    line-height: 1.25;
    position: relative;
    z-index: 1;
}
.goods-hero p {
    color: #d1d5db;
    font-size: 16px;
    position: relative;
    z-index: 1;
}
.goods-search {
    border: none;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0,0,0,.08);
    padding: 20px;
}
.goods-card {
    border: none;
    border-radius: 16px;
    overflow: hidden;
    transition: .2s;
    box-shadow: 0 5px 15px rgba(0,0,0,.08);
}
.goods-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0,0,0,.15);
}
.goods-thumb {
    width: 100%;
    aspect-ratio: 4 / 3;
    object-fit: cover;
}
.goods-price {
    font-weight: 800;
    color: #198754;
}
.goods-team {
    font-size: 13px;
    color: #6b7280;
}
.pagination .page-link {
    cursor: pointer;
    color: #198754;
}
.pagination .active .page-link {
    background: #198754;
    border-color: #198754;
    color: white;
}
.team-filter-wrapper {
    display: flex;
    overflow-x: auto;
    padding: 20px 5px;
    gap: 20px;
    scrollbar-width: none; /* Firefox */
    -ms-overflow-style: none; /* IE/Edge */
}

.team-filter-container-simple {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: nowrap; /* 무조건 한 줄 */
    gap: 30px;
    padding: 40px 0;
    overflow-x: auto; /* 화면이 좁아지면 스크롤 발생 */
    scrollbar-width: none;
}
.team-filter-container-simple::-webkit-scrollbar {
    display: none;
}

/* 로고 아이템 기본 스타일 */
.team-logo-only {
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 로고 이미지 크기 */
.team-logo-only img {
    width: 60px;
    height: 60px;
    object-fit: contain;
}

/* '전체(ALL)' 텍스트 스타일 */
.team-logo-only {
    font-size:25px;
    font-weight:800;
    color:#4b5563;

    width:65px;
    height:65px;

    display:flex;
    align-items:center;
    justify-content:center;

    padding:0;
    background:transparent;
    border:none;

    transition:all .2s ease;	
}
.all-text{
	font-size:25px;
    font-weight:800;
    color:#4b5563;

    width:65px;
    height:65px;

    display:flex;
    align-items:center;
    justify-content:center;

    padding:0;
    background:transparent;
    border:none;

    transition:all .2s ease;	
}

/* 마우스 호버 시 */
.team-logo-only:hover {
    opacity: 0.8;
    filter: grayscale(50%);
    transform: scale(1.1);
}

/* ✅ 선택되었을 때 (컬러 복구 + 크기 강조) */
.btn-check:checked + .team-logo-only {

    transform: scale(1.25); /* 선택된 로고는 더 크게 */
}

.btn-check:checked + .team-logo-only.all-text {
    color: #22c55e; /* 전체 선택 시 포인트 컬러 */
}

/* 반응형: 화면이 작아지면 로고 크기 살짝 조절 */
@media (max-width: 768px) {
    .team-filter-container-simple {
        justify-content: flex-start; /* 모바일은 왼쪽부터 스크롤 */
        padding: 20px 10px;
        gap: 12px;
    }
    .team-logo-only img {
        width: 38px;
        height: 38px;
    }
}
</style>

<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

<main id="goodsFindApp" class="container main-content flex-grow-1">
    <!-- Goods Hero -->    
    <div class="goods-hero">
        <div class="goods-eyebrow"style="color:#70c3fe">GOODS SHOP</div>
        <h1 style="color:white;">팬심을 담은<br><span style="color:#70c3fe">KICK-OFF 공식 굿즈</span></h1>
        <p>좋아하는 팀의 유니폼부터 머플러, 응원용품까지<br>K-리그 팬을 위한 다양한 상품을 만나보세요.</p>
    </div>
	<!-- 팀 필터 섹션 -->
	<div class="team-filter-container-simple">
	    <!-- 전체 -->
	    <input type="radio" class="btn-check" name="teamFilter" id="team_all" 
	           v-model="team_id" value="" @change="filterChange">
	    <label class="team-logo-only all-text" for="team_all">ALL</label>
	
	    <!-- 팀 리스트 (한 줄 노출) -->
	    <template v-for="team in teamList" :key="team.team_id">
	        <input type="radio" class="btn-check" name="teamFilter" :id="'team_'+team.team_id" 
	               v-model="team_id" :value="team.team_id" @change="filterChange">
	        <label class="team-logo-only" :for="'team_'+team.team_id">
	            <img :src="team.emblem" :alt="team.team_name" :title="team.team_name">
	        </label>
	    </template>
	</div>
	
	<!-- 검색 바 (기존 유지하되 여백 조정) -->
	<div class="card goods-search mb-4">
	    <div class="input-group">
	        <select class="form-select flex-grow-0 w-auto" v-model="category">
	            <option value="">전체 카테고리</option>
	            <option value="의류">의류</option>
	            <option value="머플러">머플러</option>
	            <option value="용품/기념품">용품/기념품</option>
	        </select>
	        <input type="text" class="form-control" v-model="ss" ref="ssInput"
	               @keydown.enter="find()" placeholder="상품명을 입력하세요">
	        <button class="btn btn-success" @click="find()">검색</button>
	    </div>
	</div>

    <!-- 상품 리스트 -->
    <div class="row g-4">
        <div class="col-md-3" v-for="vo in goods_list">
            <a :href="'../goods/detail.do?no='+vo.goodsNo" class="text-decoration-none text-dark">
                <div class="card goods-card h-100">
                    <img :src="vo.imageUrl" :alt="vo.goodsName" class="card-img-top goods-thumb">
                    <div class="card-body d-flex flex-column">
                        <p class="fw-bold mb-2 text-truncate">{{vo.goodsName}}</p>
                        <p class="goods-price mb-3">{{vo.price.toLocaleString()}}원</p>
                        <div class="d-flex align-items-center gap-2 mt-auto">
                            <img :src="vo.emblem" style="width:28px;height:28px;object-fit:contain;">
                            <span class="goods-team">{{vo.teamName}}</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-12 text-center text-muted py-5" v-if="goods_list.length===0">
            검색 결과가 없습니다.
        </div>
    </div>

    <!-- 페이지 -->
    <nav class="mt-5">
        <ul class="pagination justify-content-center">
            <li v-if="startPage>1" class="page-item">
                <a class="page-link" @click="move(startPage-1)">&laquo;</a>
            </li>
            <li v-for="i in range(startPage,endPage)" :key="i"
                class="page-item" :class="i===curpage?'active':''">
                <a class="page-link" @click="move(i)">{{i}}</a>
            </li>
            <li v-if="endPage<totalpage" class="page-item">
                <a class="page-link" @click="move(endPage+1)">&raquo;</a>
            </li>
        </ul>
    </nav>

</main>

<script>
let find = Vue.createApp({
    data() {
        return {
            startPage: 0,
            endPage: 0,
            totalpage: 0,
            curpage: 1,
            category: '',
            ss: '',
            team_id:'',
            teamList:[],
            goods_list: [],
            showAllTeams:false
        }
    },
    mounted() {
        this.teamRecv()
        this.dataRecv()
    },
    methods: {
    	teamRecv(){
    		axios.get('../goods/team_list.do')
    		.then(response => {
    			this.teamList = response.data
    		})
    	},
        dataRecv() {
            axios.post('../goods/find_vue.do', {}, {
                params: {
                    page: this.curpage,
                    category: this.category,
                    ss: this.ss,
                    team_id:this.team_id
                }
            })
            .then(response => {
                this.goods_list = response.data.goods_list
                this.startPage = response.data.startPage
                this.endPage = response.data.endPage
                this.curpage = response.data.curpage
                this.totalpage = response.data.totalpage
            })
        },
        move(page) {
            this.curpage = page
            this.dataRecv()
        },
        scrollTrack(amount){
        	this.$refs.teamTrack.scrollLeft += amount
        },
        filterChange() {
        	this.curpage=1
        	this.dataRecv()
        },
        range(start, end) {
            let arr = []
            let len = end - start
            for (let i = 0; i <= len; i++) {
                arr[i] = start
                start++
            }
            return arr
        },
        find() {
            this.curpage = 1
            if (this.ss.trim() === "" && this.category === "") {
                this.$refs.ssInput.focus()
                return
            }
            this.dataRecv()
        }
    }
}).mount("#goodsFindApp")
</script>
