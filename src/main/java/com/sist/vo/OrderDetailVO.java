package com.sist.vo;

import lombok.Data;

/*
ORDERS_DETAIL_ID NOT NULL NUMBER 
ORDERS_ID                 NUMBER 
GOODS_NO                  NUMBER 
COUNT                     NUMBER 
PRICE                     NUMBER 
TOTAL                     NUMBER
 */
@Data
public class OrderDetailVO {
	private int orders_detail_id, orders_id,goods_no,count,price,total;
	private String goods_name;
	private OrderVO ovo=new OrderVO();
	private GoodsVO gvo=new GoodsVO();
}
