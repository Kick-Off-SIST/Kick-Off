package com.sist.vo;
/*
 *  GOODS_NO    NOT NULL NUMBER         
	GOODS_ID    NOT NULL VARCHAR2(20)   
	GOODS_NAME  NOT NULL VARCHAR2(300)  
	PRICE                NUMBER(10)     
	IMAGE_URL            VARCHAR2(1000) 
	CATEGORY             VARCHAR2(50)   
	STOCK                NUMBER(1)      
	DETAIL_URL           VARCHAR2(1000) 
	DESCRIPTION          VARCHAR2(2000) 
	TEAM_ID     NOT NULL VARCHAR2(20)   
	REG_DATE             DATE    
 */

import java.util.*;

import lombok.Data;
@Data
public class GoodsVO {
	private int goodsNo,price,stock;
	private String goodsId,goodsName,imageUrl,category,teamId,teamName,emblem,dbday,detailImg1,detailImg2,detailImg3;
	private Date reg_date;
}
