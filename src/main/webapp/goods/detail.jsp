<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.goods-thumb-wrap{
  background: #fff;
  border: 1px solid #eee;
  border-radius: 10px;
  overflow: hidden;
  max-width: 320px;
  aspect-ratio: 1 / 1;
  margin: 0 auto;
}
.goods-thumb-wrap img{
  width: 100%;
  height: 100%;
  object-fit: contain;
  display: block;
  padding: 12px;
}
.goods-kicker{
  color: #198754; /* bootstrap success 계열, 홈 화면 브랜드 컬러와 통일 */
  font-weight: 700;
  font-size: 13px;
  letter-spacing: .06em;
  margin-bottom: 6px;
}
.goods-no{
  color: #6c757d;
  font-size: 13px;
  margin-bottom: 18px;
}
.price-value{
  font-size: 26px;
  font-weight: 700;
  color: #212529;
}
.price-unit{
  font-size: 14px;
  color: #6c757d;
  margin-left: 2px;
}
.spec-table{
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0 24px;
}
.spec-table tr{
  border-bottom: 1px solid #eee;
}
.spec-table tr:last-child{
  border-bottom: none;
}
.spec-table th{
  text-align: left;
  padding: 10px 4px;
  width: 30%;
  font-size: 13px;
  font-weight: 600;
  color: #6c757d;
}
.spec-table td{
  padding: 10px 4px;
  font-size: 15px;
  font-weight: 500;
  color: #212529;
}
</style>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
  <main id="detailApp" class="container main-content flex-grow-1">

    <div class="row mb-4">
      <div class="col-12">
        <p class="goods-kicker mb-1">GOODS DETAIL</p>
        <hr>
      </div>
    </div>

    <div class="row g-4 justify-content-center">
      <div class="col-md-4">
        <div class="card h-100 shadow-sm border-0">
          <div class="card-body d-flex align-items-center justify-content-center">
            <div class="goods-thumb-wrap">
              <img :src="vo.imageUrl" :alt="vo.goodsName">
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-6">
        <div class="card h-100 shadow-sm border-0">
          <div class="card-body">
            <h3 class="card-title fw-bold mb-1">{{vo.goodsName}}</h3>
            <p class="goods-no">상품번호 {{vo.goodsNo}}</p>

            <div class="d-flex align-items-baseline mb-3">
              <span class="price-value">{{vo.price ? vo.price.toLocaleString() : 0}}</span>
              <span class="price-unit" style="font-size: 14px;">원</span>
            </div>

            <table class="spec-table">
              <tr>
                <th>카테고리</th>
                <td>{{vo.category}}</td>
              </tr>
              <tr>
                <th>재고</th>
                <td>{{vo.stock}}</td>
              </tr>
            </table>

            <div class="d-flex flex-wrap gap-2">
              <button class="btn btn-outline-dark btn-sm">장바구니</button>
              <button class="btn btn-success btn-sm" @click="buyBtn()">바로구매</button>
              <button class="btn btn-outline-secondary btn-sm ms-auto" @click="go">목록</button>
            </div>
          </div>
        </div>
      </div>
    </div>

  </main>
  <script>
    var IMP = window.IMP;
    IMP.init("");
    let detail=Vue.createApp({
    	data(){
    		return {
    			no:${no},
    			vo:{},
    			loginId:'${sessionScope.id}'
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
    		})

    	},
    	methods:{
    		go(){
    			window.history.back()
    		},
    		buyBtn(){
    			this.requestPay(this.vo.goodsName,this.vo.price)
    		},
    		requestPay(name,price) {
    		   IMP.request_pay({
    		        pg: "html5_inicis",
    		        pay_method: "card",
    		        merchant_uid: "ORD20180131-0000011",   // 주문번호
    		        name: name ,
    		        amount: price,         // 숫자 타입
    		        buyer_email:'',
    		        buyer_name: '',
    		        buyer_tel: '',
    		        buyer_addr: '',
    		        buyer_postcode: ''
    		    }, function (rsp) { // callback

    		    	alert("구매가 완료되었습니다.\n마이페이지에서 확인하세요")
    		    	//window.location.href="../mypage/buy_list.do"
    		    	//parent.Shadowbox.close()
    		   });
    		}
    	}
    }).mount("#detailApp")
  </script>
</body>
</html>
