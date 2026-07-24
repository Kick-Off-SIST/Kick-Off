<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<main class="container main-content" id="highlightsApp">
	<div class="mb-4 border-bottom pb-3">
		<div class="eyebrow" style="color: var(--green); font-size: 12.5px; font-weight: 700; letter-spacing: 1px; margin-bottom: 4px;">VIDEO ARCHIVE</div>
		<h2 style="font-family: 'Black Han Sans', sans-serif; font-size: 28px; margin: 0;">K리그 하이라이트</h2>
	</div>
	<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
		<div v-for="video in videos" :key="video.id.videoId" class="col">
			<a :href="'https://www.youtube.com/watch?v='+video.id.videoId" target="_blank" class="text-decoration-none text-dark">
				<div class="card h-100 news-card"> 
					<div class="kickoff-video-thumb" :style="{ backgroundImage:'url('+video.snippet.thumbnails.medium.url+')', backgroundSize: 'cover', backgroundPosition: 'center' }">
						<div class="play-btn"></div>
					</div>
					<div class="card-body p-3 d-flex flex-column justify-content-between">
						<div class="fw-medium text-truncate-2" style="font-size: 14.5px; line-height: 1.4;" :title="video.snippet.title">
							{{ video.snippet.title }}
						</div>
						<!-- <div class="text-muted small mt-2">{{ formatDate(video.snippet.publishedAt) }}</div> -->
					</div>
				</div>
			</a>
		</div>
	</div>
	<div v-if="isLoading" class="text-center py-5 text-muted">
		<div class="spinner-border text-success mb-2" role="status"></div>
		<div>영상을 불러오는 중입니다...</div>
	</div>

	<div v-if="isError" class="text-center py-5 text-danger fw-medium">
		영상을 불러오는 데 실패했습니다. 잠시 후 다시 시도해 주세요.
	</div>

	<div class="d-flex justify-content-center gap-2 mt-5" v-if="!isLoading && !isError">
		<button @click="prevBtn" class="btn btn-outline-secondary px-4 fw-medium" :disabled="!prevPageToken">
			<i class="bi bi-chevron-left me-1"></i> 이전
		</button>
		<button @click="nextBtn" class="btn btn-outline-secondary px-4 fw-medium" :disabled="!nextPageToken">
			다음 <i class="bi bi-chevron-right ms-1"></i>
		</button>
	</div>
</main>
<script>
const highlightsApp=Vue.createApp({
	data(){
		return{
			videos:[],
			isLoading:false,
			isError:false,
			nextPageToken:'',
			prevPageToken:''
		}
	},
	mounted(){
		this.dataRecv()
	},
	methods:{
		async dataRecv(pageToken=''){
			if(this.isLoading){
				return
			}
			this.isLoading=true
			this.isError=false
			let url='../youtubeProxy?keyword='+encodeURIComponent('K리그 하이라이트')+'&max=12'
			if(pageToken){
				url+='&pageToken='+pageToken
			}
			try{
				const response=await axios.get(url)
				const rawData=typeof response.data==='string'?JSON.parse(response.data):response.data
				if(!rawData || !rawData.items){
					this.isError=true
					return
				}
				this.videos=rawData.items
				this.nextPageToken=response.data.nextPageToken||''
                this.prevPageToken=response.data.prevPageToken||''
			}catch(error){
				console.error(error)
				this.isError=true
			}finally{
				this.isLoading=false
			}
		},
		nextBtn(){
			if(this.nextPageToken){
				this.dataRecv(this.nextPageToken)
			}
		},
		prevBtn(){
			if(this.prevPageToken){
				this.dataRecv(this.prevPageToken)
			}
		}
	}
}).mount('#highlightsApp')
</script>