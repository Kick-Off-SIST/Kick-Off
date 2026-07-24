<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<style type="text/css">
.gd-breadcrumb{
  font-size: 13px;
  color: #6c757d;
  margin-bottom: 20px;
}
.gd-breadcrumb a{
  color: #6c757d;
  text-decoration: none;
}
.gd-breadcrumb .sep{ margin: 0 6px; color: #ced4da; }
.gd-breadcrumb .current{ color: #212529; font-weight: 600; }

.gd-main-img{
  background: #fff;
  border: 1px solid #eee;
  border-radius: 12px;
  overflow: hidden;
  aspect-ratio: 1 / 1;
  width: 100%;
}
.gd-main-img img{
  width: 100%;
  height: 100%;
  object-fit: contain;
  display: block;
  padding: 24px;
}
/* 대표 이미지가 여러 장일 때만(현재는 1장) 보이는 썸네일 - 확장 대비용 */
.gd-thumb-row{
  display: flex;
  gap: 10px;
  margin-top: 12px;
}
.gd-thumb{
  width: 72px;
  height: 72px;
  border-radius: 8px;
  border: 2px solid #eee;
  overflow: hidden;
  cursor: pointer;
  flex-shrink: 0;
  background: #fff;
  transition: border-color .15s ease;
}
.gd-thumb.active{
  border-color: #198754;
}
.gd-thumb img{
  width: 100%;
  height: 100%;
  object-fit: contain;
  padding: 6px;
}

/* 우측 정보 패널: 카드 형태로 감싸서 왼쪽 이미지 높이만큼 꽉 채움 */
.gd-info-card{
  background: #fff;
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 40px;
  height: 100%;
}
.gd-category-tag{
  display: inline-block;
  background: #e9f7f0;
  color: #146c43;
  font-size: 12.5px;
  font-weight: 700;
  padding: 4px 12px;
  border-radius: 20px;
  margin-bottom: 16px;
}
.gd-title{
  font-size: 28px;
  font-weight: 800;
  margin-bottom: 10px;
  line-height: 1.35;
}
.gd-no{
  color: #adb5bd;
  font-size: 13px;
  margin-bottom: 24px;
}
.gd-price-row{
  padding-bottom: 24px;
  margin-bottom: 24px;
  border-bottom: 1px solid #eee;
}
.gd-price-label{
  font-size: 13px;
  color: #6c757d;
  margin-bottom: 6px;
}
.gd-price{
  font-size: 34px;
  font-weight: 800;
  color: #198754;
}

.gd-info-box{
  background: var(--bg, #f8f9fa);
  border-radius: 10px;
  padding: 22px 24px;
  margin-bottom: 28px;
}
.gd-info-table{
  width: 100%;
  font-size: 14.5px;
}
.gd-info-table tr:not(:last-child) th,
.gd-info-table tr:not(:last-child) td{
  padding-bottom: 16px;
}
.gd-info-table th{
  text-align: left;
  color: #6c757d;
  font-weight: 500;
  width: 30%;
  vertical-align: top;
}
.gd-info-table td{
  font-weight: 700;
  color: #212529;
}
.gd-stock-ok{ color: #198754; }
.gd-stock-low{ color: #dc3545; }

.gd-panel-body{
  height: 100%;
  display: flex;
  flex-direction: column;
}
.gd-actions{
  display: flex;
  gap: 10px;
  margin-top: auto;
}
.gd-actions .btn{
  flex: 1;
  padding: 16px 0;
  font-weight: 700;
  font-size: 16px;
  border-radius: 8px;
}
.gd-actions .btn-outline-dark{
  border-width: 1.5px;
}
.gd-back-link{
  margin-top: 14px;
  text-align: center;
}

.detail-card{
  border: none;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,.08);
}
.detail-card .card-header{
  background: #198754;
  color: #fff;
  font-weight: 700;
  border-radius: 12px 12px 0 0;
}
.detail-card .card-body{
  background: var(--bg, #eef1f4);
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.detail-card .card-body img{
  border-radius: 8px;
  width: 100%;
  display: block;
}
.like-btn{
    display:flex;
    align-items:center;
    gap:6px;
    border:1px solid #ddd;
    background:white;
    border-radius:20px;
    padding:8px 14px;
    cursor:pointer;
    font-size:15px;
    transition:.3s;
}
.like-btn .heart{
    font-size:22px;
    color:#aaa;
    transition:.3s;
}
.like-btn.active .heart{
    color:#ff385c;
    transform:scale(1.2);
}
.like-btn:hover{
    transform:translateY(-2px);
}
</style>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<main id="detailApp" class="container main-content">

  <div class="gd-breadcrumb">
    <a href="../main/main.do">홈</a>
    <span class="sep">&gt;</span>
    <a href="../goods/find.do">{{vo.category}}</a>
    <span class="sep">&gt;</span>
    <span class="current">{{vo.goodsName}}</span>
  </div>

  <div class="row g-5 align-items-stretch">

    <!-- 좌측: 대표 상품 사진 (지금은 1장 -> 여러 장 생기면 자동으로 썸네일 노출) -->
    <div class="col-md-6">
      <div class="gd-main-img">
        <img :src="mainImg" :alt="vo.goodsName">
      </div>
      <div class="gd-thumb-row" v-if="images.length > 1">
        <div class="gd-thumb" v-for="img in images" :key="img" :class="{active: mainImg===img}" @click="changeImg(img)">
          <img :src="img" :alt="vo.goodsName">
        </div>
      </div>
    </div>

    <!-- 우측: 정보 + 구매 (카드로 감싸서 왼쪽 이미지 높이만큼 꽉 채움) -->
    <div class="col-md-6">
      <div class="gd-info-card">
        <div class="gd-panel-body">

          <div>
            <div class="gd-category-tag">{{vo.category}}</div>
            <h1 class="gd-title">{{vo.goodsName}}</h1>
            <p class="gd-no">상품번호 {{vo.goodsNo}}</p>

            <div class="gd-price-row">
              <div class="gd-price-label">판매가</div>
              <div class="gd-price">{{vo.price ? vo.price.toLocaleString() : 0}}<span style="font-size:18px;font-weight:600;color:#6c757d;">원</span></div>
            </div>

            <div class="gd-info-box">
              <table class="gd-info-table">
                <tr>
                  <th>카테고리</th>
                  <td>{{vo.category}}</td>
                </tr>
                <tr>
                  <th>재고</th>
                  <td>
                    <span :class="vo.stock > 0 ? 'gd-stock-ok' : 'gd-stock-low'">
                      {{vo.stock > 0 ? vo.stock + '개 남음' : '품절'}}
                    </span>
                  </td>
                </tr>
                <tr>
                  <th>배송</th>
                  <td>택배배송 (2~3일 소요)</td>
                </tr>
                <tr>
	            <td colspan="3" class="text-right">
	            <c:if test="${sessionScope.member_id!=null }">
			  <c:if test="${check==0 }">
		       <button 
				  class="like-btn"
				  :class="{active: check===1}"
				  @click="likeClick"
				>
				  <span class="heart">♥</span>
				  <span>{{count}}</span>
				</button>
				 </c:if>
				 <c:if test="${check==1 }">
		          <button class="like-btn" id="goodslikeOff" data-no="${no}">
					<span class="heart">♥</span>
					<span class="count">${count}</span>
				</button>
				 </c:if>
				 </c:if>
				 </td>
				 </tr>
              </table>
            </div>
          </div>
          
          <div class="gd-actions">
           <c:if test="${sessionScope.user }">
            <button class="btn btn-outline-dark" @click="cart()">장바구니</button>
            <button class="btn btn-success" @click="buyBtn()">바로구매</button>
           </c:if>
           <c:if test="${!sessionScope.user }">
            <button class="btn btn-outline-dark" disabled>장바구니</button>
            <button class="btn btn-success" disabled>바로구매</button>
           </c:if>
          </div>
          <div class="gd-back-link">
            <button class="btn btn-link text-muted p-0" @click="go">&larr; 목록으로</button>
          </div>

        </div>
      </div>
    </div>

  </div>

  <!-- 상세정보 -->
  <div class="card detail-card mt-5">
    <div class="card-header">상품 상세정보</div>
    <div class="card-body">
      <img :src="vo.detailImg1" alt="상세정보1">
      <img :src="vo.detailImg2" alt="상세정보2">
      <img :src="vo.detailImg3" alt="상세정보3">
    </div>
  </div>

</main>

<script>
    var IMP = window.IMP;
    IMP.init("${portoneAPI}");
    let detail=Vue.createApp({
    	data(){
    		return {
    			no:${no},
    			vo:{},
    			mainImg:'',
    			loginId:'${sessionScope.id}',
    			
    			check:${check},
    			count:${count}
    		}
    	},
    	computed:{
    		// 대표 상품 사진 목록. 지금은 imageUrl 한 장뿐이지만,
    		// 나중에 상품에 사진이 여러 장(imageUrl2, imageUrl3 ...) 생기면
    		// 여기에 추가하기만 하면 자동으로 썸네일이 나타남.
    		// (상세정보용 detailImg1~3 은 여기 안 섞음 - 그건 아래 상세정보 섹션 전용)
    		images(){
    			let arr=[]
    			if(this.vo.imageUrl) arr.push(this.vo.imageUrl)
    			return arr
    		}
    	},
    	mounted(){
    		axios.get('../goods/detail_vue.do',{
    			params:{
    				no:this.no
    			}
    		}).then(response=>{
    			console.log(response.data)
    			this.vo=response.data
    			this.mainImg=response.data.imageUrl
    		})

    	},
    	methods:{
    		changeImg(url){
    			this.mainImg=url
    		},
    		go(){
    			window.history.back()
    		},
    		buyBtn(){
    			this.requestPay(this.vo.goodsName,this.no,this.vo.price)
    		},
    		requestPay(gname,goods_no,price) {
    		   IMP.request_pay({
    		        pg: "html5_inicis",
    		        pay_method: "card",
    		        merchant_uid: "ORD20180131-0000011",   // 주문번호
    		        name: gname ,
    		        amount: price,         // 숫자 타입
    		        buyer_email:'',
    		        buyer_name: '',
    		        buyer_tel: '',
    		        buyer_addr: '',
    		        buyer_postcode: ''
    		    }, function (rsp) { // callback
    		    	axios.post('../order/insert.do',{},{
    		    		params:{
    		    			goods_no:goods_no,
    		    			count:1,
    		    			price:price,
    		    			goods_name:gname
    		    		}
    		    	}).then(response=>{
    			    	alert("구매가 완료되었습니다.\n마이페이지에서 확인하세요")
    		    		window.location.href="../mypage/mypage_order.do"
    		    	})
    		   });
    		},
    		   likeClick(){
    			   axios.get('../like/goodslikeOn.do',{
    				   params:{
    					   gno:this.no
    				   }
    			   })
    			   .then(()=>{
    				   if(this.check===0)
    				   {
    					   this.check=1;
    					   this.count++;
    				   }
    				   else
    				   {
    					   this.check=0;
    					   this.count--;
    				   }
    			   })
    		   },
    		   cart(){
       			axios.get('../cart/insert.do',{
           			params:{
           				no:this.no
           			}
           		}).then(response=>{
           			window.location.href="../mypage/mypage_cart.do"
           		})
       		},
       		loginCheck(){
       			if(this.loginId==''){
       				
       			}
       		}
    		
    	}
    }).mount("#detailApp")
</script>
<script type="text/javascript">
$(document).on('click','#goodslikeOn',function(){
	let no=$(this).attr("data-no")
	location.href="../like/goodslikeOn.do?gno="+no
})

$(document).on('click','#goodslikeOff',function(){
	let no=$(this).attr("data-no")
	location.href="../like/goodslikeOff.do?gno="+no
})
</script>
