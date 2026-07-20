package com.sist.vo;

import lombok.Data;

/*
CART_ID   NOT NULL NUMBER 
MEMBER_ID          NUMBER 
GOODS_NO           NUMBER 
COUNT              NUMBER
 */
@Data
public class CartVO {
	private int cart_id,member_id,goods_no,count;
	private GoodsVO gvo=new GoodsVO();
}
