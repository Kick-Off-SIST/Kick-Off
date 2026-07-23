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
<main class="mb-4" id="reserve">
    <h4>티켓 예약 정보</h4>
    <div class="mt-4 d-flex flex-column justify-content-between" style="height: 600px">
      <div v-if="count>0">
    	<table class="table table-hover w-100">
    	  <thead>
    		<tr>
    			<th width="10%" class="text-center">예약번호</th>
    			<th width="30%" class="text-center">경기정보</th>
    			<th width="20%" class="text-center">좌석</th>
    			<th width="15%" class="text-center">예매일</th>
    			<th width="15%" class="text-center">가격</th>
    			<th width="10%"></th>
    		</tr>
    	  </thead>
    	  <tbody>
    			<tr class="border-bottom-custom" v-for="(vo,index) in list" key="index">
	    			<td width="10%" class="text-muted small text-center">{{vo.reserve_id }}</td>
	    			<td width="30%" class="text-center">
	    			  <a class="table-link" v-if="vo.isexpired=='NO'" :href="'../ticket/reserve_ticket.do?sid='+vo.rvo.schedule_id">
	    				<img :src="vo.rvo.mmvo.homeVo.emblem" style="height: 20px">
	    				{{vo.rvo.mmvo.homeVo.team_name }} vs
	    				<img :src="vo.rvo.mmvo.awayVo.emblem" style="height: 20px">
	    				{{vo.rvo.mmvo.awayVo.team_name }}
	    				<br>
	    				{{vo.rvo.mmvo.dbday }}&nbsp;
	    				{{vo.rvo.mmvo.game_time }}
	    			  </a>
	    			  <span v-if="vo.isexpired=='YES'">
	    				<img :src="vo.rvo.mmvo.homeVo.emblem" style="height: 20px">
	    				{{vo.rvo.mmvo.homeVo.team_name }} vs
	    				<img :src="vo.rvo.mmvo.awayVo.emblem" style="height: 20px">
	    				{{vo.rvo.mmvo.awayVo.team_name }}
	    				<br>
	    				{{vo.rvo.mmvo.dbday }}&nbsp;
	    				{{vo.rvo.mmvo.game_time }}
	    			  </span>
	    			</td>
	    			<td width="20%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-secondary-subtle text-secondary rounded-pill px-2.5 py-1" style="font-size: 0.7rem; font-weight: 600;">
                                        {{vo.grade_name}}
                                    </span>
                                    <span class="text-dark fw-medium small">
                                        {{vo.seat_row}}열 {{vo.seat_col}}번
                                    </span>
                                </div>
	    			</td>
	    			<td width="15%" class="text-center text-secondary small">{{vo.rvo.dbday }}</td>
	    			<td width="15%" class="text-center">
	    			&#8361; <span class="fw-bold text-primary">{{vo.rvo.total_amount}}</span>
	    			</td>
	    			<td width="10%" class="text-center">
	    			  <%-- <c:if test="${vo.isexpired=='YES' }">
	    				<span class="btn btn-secondary btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				>취소불가</span>
	    			  </c:if>
	    			  <c:if test="${vo.isexpired=='NO' }">
	    				<a class="delBtn btn btn-outline-danger btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				data-mid="${vo.match_seat_id }" data-rid="${vo.reserve_id }"
	    				>예약취소</a>
	    			  </c:if> --%>
	    			  <span v-if="vo.isexpired=='YES'" class="btn btn-secondary btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				>취소불가</span>
	    			  <a v-if="vo.isexpired=='NO'" class="btn btn-outline-danger btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				@click="delBtn(vo)"
	    				>예약취소</a>
	    			</td>
    			</tr>
    		<%-- <c:forEach var="vo" items="${list }">
    			<tr class="border-bottom-custom">
	    			<td width="10%" class="text-muted small text-center">${vo.reserve_id }</td>
	    			<td width="30%" class="text-center">
	    				<img src="${vo.rvo.mmvo.homeVo.emblem }" style="height: 20px">
	    				${vo.rvo.mmvo.homeVo.team_name } vs
	    				<img src="${vo.rvo.mmvo.awayVo.emblem }" style="height: 20px">
	    				${vo.rvo.mmvo.awayVo.team_name }
	    				<br>
	    				${vo.rvo.mmvo.dbday }&nbsp;
	    				${vo.rvo.mmvo.game_time }
	    				${vo.rvo.schedule_id }
	    			</td>
	    			<td width="20%" class="text-center">
	    				<div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-secondary-subtle text-secondary rounded-pill px-2.5 py-1" style="font-size: 0.7rem; font-weight: 600;">
                                        ${vo.grade_name}
                                    </span>
                                    <span class="text-dark fw-medium small">
                                        ${vo.seat_row}열 ${vo.seat_col}번
                                    </span>
                                </div>
	    			</td>
	    			<td width="15%" class="text-center text-secondary small">${vo.rvo.dbday }</td>
	    			<td width="15%" class="text-center">
	    			&#8361; <span class="fw-bold text-primary">${vo.rvo.total_amount}</span>
	    			</td>
	    			<td width="10%" class="text-center">
	    			  <c:if test="${vo.isexpired=='YES' }">
	    				<span class="btn btn-secondary btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				>취소불가</span>
	    			  </c:if>
	    			  <c:if test="${vo.isexpired=='NO' }">
	    				<a class="delBtn btn btn-outline-danger btn-sm rounded-3 px-3 fw-semibold" 
	    				style="font-size: 0.75rem; letter-spacing: -0.5px;"
	    				data-mid="${vo.match_seat_id }" data-rid="${vo.reserve_id }"
	    				>예약취소</a>
	    			  </c:if>
	    			</td>
    			</tr>
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
      	<p class="fs-5">예약된 티켓이 없습니다.</p>
	  </div>
    </div>
</main>
<script>
let reserve=Vue.createApp({
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
			await axios.get('../mypage/mypage_reserve_vue.do',{
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
		},
		delBtn(vo){
			console.log("msid: "+vo.match_seat_id)
			axios.get('../mypage/reserve_delete.do',{
				params:{
					match_seat_id:vo.match_seat_id,
					reserve_id:vo.reserve_id
				}
			}).then(response=>{
				location.href="../mypage/mypage_reserve.do"
			})
		}
	}
}).mount('#reserve')
</script>
</body>
</html>